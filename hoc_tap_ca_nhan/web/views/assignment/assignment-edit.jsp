<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Assignment" %>
<%@ page import="model.Subject" %>

<%
    Assignment a = (Assignment) request.getAttribute("assignment");
    Subject subject = (Subject) request.getAttribute("subject");
%>

<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body p-4">
                    
                    <h4 class="card-title fw-bold text-dark mb-4 d-flex align-items-center">
                        <span class="me-2">✏️</span> Chỉnh sửa nhiệm vụ
                        <% if (subject != null) { %>
                            <span class="mx-2 text-muted fw-light">|</span>
                            <span class="text-success fs-5"><%= subject.getSubjectName() %></span>
                        <% } %>
                    </h4>

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger d-flex align-items-center py-2 px-3 mb-4 rounded-3" role="alert">
                            <span class="me-2">⚠️</span>
                            <div class="fw-semibold small"><%= request.getAttribute("error") %></div>
                        </div>
                    <% } %>

                    <form method="post" action="assignments">
                        <input type="hidden" name="action" value="update"/>
                        <input type="hidden" name="id" value="<%=a.getId()%>"/>
                        <input type="hidden" name="subjectId" value="<%=a.getSubjectId()%>"/>

                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary small">Loại nhiệm vụ</label>
                            <select name="type" class="form-select border-secondary-subtle">
                                <option value="TASK" <%= "TASK".equalsIgnoreCase(a.getType()) ? "selected" : "" %>>
                                    📚 Task
                                </option>
                                <option value="EXAM" <%= "EXAM".equalsIgnoreCase(a.getType()) ? "selected" : "" %>>
                                    📝 Exam
                                </option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary small">Tên nhiệm vụ <span class="text-danger">*</span></label>
                            <input type="text" name="title" class="form-control border-secondary-subtle" value="<%=a.getTitle()%>" required/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary small">Mô tả chi tiết</label>
                            <textarea name="description" class="form-control border-secondary-subtle" rows="3" placeholder="Không có mô tả"><%= a.getDescription() != null ? a.getDescription() : "" %></textarea>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold text-secondary small">Ngày đến hạn (Hạn chót)</label>
                            <input type="date" name="dueDate" class="form-control border-secondary-subtle"
                                   value="<%= a.getDueDate() != null ? a.getDueDate().toLocalDate().toString() : "" %>"/>
                        </div>

                        <hr class="text-muted my-4 opacity-25">

                        <div class="d-flex justify-content-end gap-2">
                            <a href="assignments?subjectId=<%=a.getSubjectId()%>" class="btn btn-outline-secondary px-4 fw-semibold">
                                Hủy
                            </a>
                            <button type="submit" class="btn btn-primary px-4 fw-semibold">
                                Lưu thay đổi
                            </button>
                        </div>
                    </form>

                </div>
            </div> </div>
    </div>
</div>