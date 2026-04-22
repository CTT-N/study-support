<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Assignment, java.time.format.DateTimeFormatter" %>
<%@ page import="model.Subject" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    List<Assignment> list = (List<Assignment>) request.getAttribute("assignments");
    int subjectId = Integer.parseInt(request.getParameter("subjectId"));
    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    Subject subject = (Subject) request.getAttribute("subject");
%>

<a href="subjects">
    <button style="margin-bottom:15px;">⬅ Quay lại danh sách môn học</button>
</a>
    
    <div class="card">
        <h3>
            📋 Danh sách nhiệm vụ 
            <% if (subject != null) { %>
                <span style="color:#888;">|</span>
                <span style="color:#4CAF50;"><%= subject.getSubjectName() %></span>
            <% } %>
        </h3>

        <% if (request.getAttribute("error") != null) { %>
            <p style="color:red;"><%= request.getAttribute("error") %></p>
        <% } %>
        <form method="post" action="assignments" class="top-bar">
            <input type="hidden" name="action" value="create"/>
            <input type="hidden" name="subjectId" value="<%=subjectId%>"/>

            <select name="type">
                <option value="ASSIGNMENT" selected>📚 Task</option>
                <option value="EXAM">📝 Exam</option>
            </select>

            <input type="text" name="title" placeholder="Nhập tên" required/>

            <input type="text" name="description" placeholder="Mô tả (không bắt buộc)"/>

            <input type="date" name="dueDate"/>

            <button type="submit">Thêm</button>
        </form>

        <!-- TABLE -->
        <table class="table table-hover align-middle">
            <tr>
                <th>Loại</th>
                <th>Tên</th>
                <th>Ngày tạo</th>
                <th>Hạn</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>

<%
    if (list != null) {
        for (Assignment a : list) {
%>
<%
    boolean isOverdue = false;
    if (a.getDueDate() != null && "PENDING".equalsIgnoreCase(a.getStatus())) {
        isOverdue = a.getDueDate().isBefore(java.time.LocalDateTime.now());
    }
    String displayStatus = isOverdue ? "overdue" : a.getStatus();
%>

    <tr class="<%= "EXAM".equalsIgnoreCase(a.getType()) ? "exam-row" : "" %>">

        <!-- LOẠI -->
        <td>
            <%
                String type = (a.getType() != null) ? a.getType() : "ASSIGNMENT";
            %>

            <span class="type-badge <%= type.toLowerCase() %>">
                <%= "EXAM".equalsIgnoreCase(type) ? "📝 Exam" : "📚 Task" %>
            </span>
        </td>

        <!-- TÊN -->
        <td style="text-align:left;">
            <strong><%= a.getTitle() %></strong>
            <% if (a.getDescription() != null && !a.getDescription().isEmpty()) { %>
                <div style="font-size:12px; color:#777;">
                    <%= a.getDescription() %>
                </div>
            <% } %>
        </td>

        <!-- NGÀY TẠO -->
        <td>
            <%= a.getCreatedAt() != null ? a.getCreatedAt().format(fmt) : "" %>
        </td>

        <!-- HẠN -->
        <td>
            <%= a.getDueDate() != null ? a.getDueDate().format(fmt) : "" %>
        </td>

        <!-- TRẠNG THÁI -->
        <td>
            <span class="badge <%= displayStatus.toLowerCase() %>">
                <%= 
                    "done".equalsIgnoreCase(displayStatus) ? "Hoàn thành" :
                    "overdue".equalsIgnoreCase(displayStatus) ? "Quá hạn" :
                    "Đang tiến hành"
                %>
            </span>

            <br/>

            <form method="post" action="assignments">
                <input type="hidden" name="action" value="updateStatus"/>
                <input type="hidden" name="id" value="<%= a.getId() %>"/>
                <input type="hidden" name="subjectId" value="<%=subjectId%>"/>

                <select name="status" onchange="this.form.submit()">
                    <option value="PENDING" <%= "PENDING".equalsIgnoreCase(a.getStatus()) ? "selected" : "" %>>
                        Đang tiến hành
                    </option>
                    <option value="DONE" <%= "DONE".equalsIgnoreCase(a.getStatus()) ? "selected" : "" %>>
                        Hoàn thành
                    </option>
                </select>
            </form>
        </td>

        <!-- HÀNH ĐỘNG -->
        <td>
            <div style="display:flex; gap:5px; justify-content:center;">
                <form method="post" action="assignments">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" value="<%= a.getId() %>"/>
                    <input type="hidden" name="subjectId" value="<%=subjectId%>"/>

                    <button class="delete-btn" onclick="return confirm('Xác nhận xóa?')">
                        Xóa
                    </button>
                </form>

                <a href="assignments?action=edit&id=<%=a.getId()%>&subjectId=<%=subjectId%>">
                    <button type="button">Sửa</button>
                </a>
            </div>
        </td>

    </tr>
<%
        }
    }
%>
<% if (list == null || list.isEmpty()) { %>
    <p>Chưa có nhiệm vụ nào</p>
<% } %>
        </table>
    </div>