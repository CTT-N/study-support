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

<div class="mb-3">
    <a href="subjects" class="btn btn-link text-decoration-none text-secondary p-0 d-inline-flex align-items-center">
        <span class="me-1">←</span> Quay lại danh sách môn học
    </a>
</div>
    
<div class="card border-0 shadow-sm rounded-3">
    <div class="card-body p-4">
        
        <h4 class="card-title d-flex align-items-center mb-4 fw-bold text-dark">
            <span class="me-2">📋</span> Danh sách nhiệm vụ 
            <% if (subject != null) { %>
                <span class="mx-2 text-muted fw-light">|</span>
                <span class="text-success"><%= subject.getSubjectName() %></span>
            <% } %>
        </h4>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger py-2 px-3 mb-3 fs-6" role="alert">
                ⚠️ <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form method="post" action="assignments" class="row g-2 align-items-center mb-4 p-3 bg-light rounded-3">
            <input type="hidden" name="action" value="create"/>
            <input type="hidden" name="subjectId" value="<%=subjectId%>"/>

            <div class="col-md-2">
                <select name="type" class="form-select form-select-sm border-secondary-subtle">
                    <option value="TASK" selected>📚 Task</option>
                    <option value="EXAM">📝 Exam</option>
                </select>
            </div>

            <div class="col-md-3">
                <input type="text" name="title" class="form-control form-control-sm border-secondary-subtle" placeholder="Nhập tên nhiệm vụ *" required/>
            </div>

            <div class="col-md-4">
                <input type="text" name="description" class="form-control form-control-sm border-secondary-subtle" placeholder="Mô tả (không bắt buộc)"/>
            </div>

            <div class="col-md-2">
                <input type="date" name="dueDate" class="form-control form-control-sm border-secondary-subtle" required/>
            </div>

            <div class="col-md-1">
                <button type="submit" class="btn btn-primary btn-sm w-100 fw-semibold">Thêm</button>
            </div>
        </form>

        <% if (list == null || list.isEmpty()) { %>
            <div class="text-center py-5 text-muted">
                <p class="mb-0 fs-5">Chưa có nhiệm vụ nào được tạo cho môn học này.</p>
            </div>
        <% } else { %>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light text-secondary">
                        <tr>
                            <th scope="col" style="width: 12%">Loại</th>
                            <th scope="col" style="width: 38%">Tên & Mô tả</th>
                            <th scope="col" style="width: 13%">Ngày tạo</th>
                            <th scope="col" style="width: 13%">Hạn chót</th>
                            <th scope="col" style="width: 14%">Trạng thái</th>
                            <th scope="col" style="width: 10%" class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Assignment a : list) {
                            boolean isOverdue = false;
                            java.time.LocalDate today = java.time.LocalDate.now();
                            
                            if (a.getDueDate() != null && "PENDING".equalsIgnoreCase(a.getStatus())) {
                                java.time.LocalDate due = a.getDueDate().toLocalDate(); 
                                // Nếu ngày hạn TRƯỚC hoặc BẰNG ngày hôm nay thì tính là đến hạn/quá hạn để cảnh báo dữ dội
                                isOverdue = due.isBefore(today) || due.isEqual(today);
                            }
                            
                            // Thiết lập màu nền hàng nếu là Exam để phân biệt trực quan
                            String rowClass = "EXAM".equalsIgnoreCase(a.getType()) ? "table-warning-subtle" : "";
                    %>
                        <tr class="<%= rowClass %>">
                            <td>
                                <% String type = (a.getType() != null) ? a.getType() : "TASK"; %>
                                <% if ("EXAM".equalsIgnoreCase(type)) { %>
                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1.5">📝 Exam</span>
                                <% } else { %>
                                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1.5">📚 Task</span>
                                <% } %>
                            </td>

                            <td class="text-start">
                                <div class="fw-semibold text-dark"><%= a.getTitle() %></div>
                                <% if (a.getDescription() != null && !a.getDescription().isEmpty()) { %>
                                    <div class="text-muted small mt-1"><%= a.getDescription() %></div>
                                <% } %>
                            </td>

                            <td class="text-secondary small">
                                <%= a.getCreatedAt() != null ? a.getCreatedAt().format(fmt) : "" %>
                            </td>

                            <td>
                                <% if (isOverdue) { %>
                                    <span class="text-danger fw-bold small">⚠️ <%= a.getDueDate() != null ? a.getDueDate().format(fmt) : "" %></span>
                                <% } else { %>
                                    <span class="text-dark small"><%= a.getDueDate() != null ? a.getDueDate().format(fmt) : "" %></span>
                                <% } %>
                            </td>

                            <td>
                                <form method="post" action="assignments" class="d-inline">
                                    <input type="hidden" name="action" value="updateStatus"/>
                                    <input type="hidden" name="id" value="<%= a.getId() %>"/>
                                    <input type="hidden" name="subjectId" value="<%=subjectId%>"/>

                                    <% 
                                        String selectColorClass = "";
                                        if ("DONE".equalsIgnoreCase(a.getStatus())) {
                                            selectColorClass = "bg-success-subtle text-success border-success-subtle fw-semibold";
                                        } else if (isOverdue) {
                                            // Ép buộc select box chuyển thành màu đỏ báo động khi quá hạn
                                            selectColorClass = "bg-danger text-white border-danger fw-semibold";
                                        } else {
                                            selectColorClass = "bg-warning-subtle text-warning-emphasis border-warning-subtle fw-semibold";
                                        }
                                    %>
                                    <select name="status" onchange="this.form.submit()" class="form-select form-select-sm <%= selectColorClass %>" style="max-width: 145px;">
                                        <option value="PENDING" <%= "PENDING".equalsIgnoreCase(a.getStatus()) ? "selected" : "" %>>
                                            <%= isOverdue ? "🚨 Quá hạn!" : "⏳ Tiến hành" %>
                                        </option>
                                        <option value="DONE" <%= "DONE".equalsIgnoreCase(a.getStatus()) ? "selected" : "" %>>
                                            ✅ Hoàn thành
                                        </option>
                                    </select>
                                </form>
                            </td>

                            <td>
                                <div class="d-flex gap-1 justify-content-center">
                                    <a href="assignments?action=edit&id=<%=a.getId()%>&subjectId=<%=subjectId%>" class="btn btn-outline-secondary btn-sm py-1 px-2" title="Sửa">
                                        Sửa
                                    </a>
                                    
                                    <form method="post" action="assignments" class="d-inline">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="id" value="<%= a.getId() %>"/>
                                        <input type="hidden" name="subjectId" value="<%=subjectId%>"/>

                                        <button class="btn btn-outline-danger btn-sm py-1 px-2" onclick="return confirm('Xác nhận xóa?')">
                                            Xóa
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        <% } %>

    </div>
</div>