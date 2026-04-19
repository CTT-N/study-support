<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Assignment, java.time.format.DateTimeFormatter" %>

<%
    List<Assignment> list = (List<Assignment>) request.getAttribute("assignments");
    int subjectId = Integer.parseInt(request.getParameter("subjectId"));
    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách nhiệm vụ</title>
        <style>
            body {
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                background: #f0f2f5;
            }

            .content {
                margin-left: 240px;
                padding: 30px;
            }

            .card {
                background: white;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                width: 900px;
            }

            h3 {
                margin-bottom: 20px;
            }

            .top-bar input {
                padding: 8px;
                border-radius: 6px;
                border: 1px solid #ccc;
            }

            .top-bar button {
                padding: 8px 15px;
                border-radius: 6px;
                border: none;
                background: #4CAF50;
                color: white;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th {
                background: #f7f7f7;
            }

            th, td {
                padding: 12px;
                text-align: center;
            }

            tr:hover {
                background: #f9f9f9;
            }

            /* STATUS BADGE */
            .badge {
                padding: 5px 10px;
                border-radius: 6px;
                color: white;
                font-size: 13px;
            }

            .pending { background: #f0ad4e; }
            .done { background: #5cb85c; }
            .overdue { background: #d9534f; }

            /* BUTTON */
            .delete-btn {
                border: none;
                background: #ff4d4f;
                color: white;
                padding: 6px 10px;
                border-radius: 6px;
            }

            .delete-btn:hover {
                background: #d9363e;
            }
            </style>
    </head>
    <body>
        <%-- Sidebar dùng chung (tìm đúng vị trí tương đối của thư mục so với file này) --%>
        <jsp:include page="../common/sidebar.jsp" />
        
<div class="content">

<a href="subjects">
    <button style="margin-bottom:15px;">⬅ Quay lại danh sách môn học</button>
</a>
    
    <div class="card">
        <h3>Danh sách nhiệm vụ</h3>

        <% if (request.getAttribute("error") != null) { %>
            <p style="color:red;"><%= request.getAttribute("error") %></p>
        <% } %>
        <form method="post" action="assignments" class="top-bar">
            <input type="hidden" name="action" value="create"/>
            <input type="hidden" name="subjectId" value="<%=subjectId%>"/>

            <input type="text" name="title" placeholder="Nhập tên" required/>
            <input type="date" name="dueDate"/>

            <button type="submit">Thêm</button>
        </form>

        <!-- TABLE -->
        <table>
            <tr>
                <th>Tên</th>
                <th>Ngày tạo</th>
                <th>Hạn nộp</th>
                <th>Trạng thái</th>
                <th></th>
                <th></th>
            </tr>

<%
    if (list != null) {
        for (Assignment a : list) {
%>
            <tr>
                <td><%= a.getTitle() %></td>

                <td>
                    <%= a.getCreatedAt() != null ? a.getCreatedAt().format(fmt) : "" %>
                </td>

                <td>
                    <%= a.getDueDate() != null ? a.getDueDate().format(fmt) : "" %>
                </td>

                <td>
                    <span class="badge <%= a.getStatus() %>">
                        <%= 
                            "pending".equalsIgnoreCase(a.getStatus()) ? "Đang tiến hành" :
                            "done".equalsIgnoreCase(a.getStatus()) ? "Hoàn thành" :
                            "Quá hạn"
                        %>
                    </span>

                    <form method="post" action="assignments">
                        <input type="hidden" name="action" value="updateStatus"/>
                        <input type="hidden" name="id" value="<%= a.getId() %>"/>
                        <input type="hidden" name="subjectId" value="<%=subjectId%>"/>

                        <select name="status" onchange="this.form.submit()">
                            <option value="pending" <%= "pending".equalsIgnoreCase(a.getStatus()) ? "selected" : "" %>>
                                Đang tiến hành
                            </option>
                            <option value="done" <%= "done".equalsIgnoreCase(a.getStatus()) ? "selected" : "" %>>
                                Hoàn thành
                            </option>
                            <option value="overdue" <%= "overdue".equalsIgnoreCase(a.getStatus()) ? "selected" : "" %>>
                                Quá hạn
                            </option>
                        </select>
                    </form>
                </td>

                <td>
                    <form method="post" action="assignments" style="display:inline;">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="id" value="<%= a.getId() %>"/>
                        <input type="hidden" name="subjectId" value="<%=subjectId%>"/>

                        <button onclick="return confirm('Xác nhận xóa nhiệm vụ này?')">
                            Xóa
                        </button>
                    </form>
                </td>
                
                <td>
                    <a href="assignments?action=edit&id=<%=a.getId()%>&subjectId=<%=subjectId%>">
                        Sửa
                    </a>
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
</div>
    
    </body>
</html>
