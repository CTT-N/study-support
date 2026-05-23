<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Assignment, java.time.format.DateTimeFormatter" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    // Khai báo bộ định dạng Ngày/Tháng/Năm trực quan
    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    request.setAttribute("dateFormatter", fmt);
%>

<div class="row g-3">
    <div class="col-md-4">
        <div class="card border-0 shadow-sm p-4 text-center rounded-3 bg-white">
            <h2 class="fw-bold text-primary mb-1">${totalSubjects}</h2>
            <p class="text-muted small mb-2 fw-medium">Môn học</p>
            <a href="${pageContext.request.contextPath}/subjects" class="btn btn-sm btn-outline-primary px-3 py-1 rounded-pill fw-semibold fs-7" style="font-size: 0.8rem;">
                Xem danh sách →
            </a>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card border-0 shadow-sm p-4 text-center rounded-3 bg-white">
            <h2 class="fw-bold text-warning mb-1">${pendingAssignments}</h2>
            <p class="text-warning small mb-0 fw-medium">⏳ Chưa hoàn thành</p>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card border-0 shadow-sm p-4 text-center rounded-3 bg-white">
            <h2 class="fw-bold text-danger mb-1">${overdueAssignments}</h2>
            <p class="text-danger small mb-0 fw-medium">🚨 Quá hạn</p>
        </div>
    </div>
</div>

<div class="card border-0 shadow-sm rounded-3 mt-4 bg-white">
    <div class="card-body p-4">
        <h5 class="card-title fw-bold text-dark mb-3 d-flex align-items-center">
            <span class="me-2">⏰</span> Sắp đến hạn
        </h5>
        
        <div class="list-group list-group-flush">
            <c:forEach var="a" items="${upcoming}">
                <div class="list-group-item px-0 py-3 border-light-subtle d-flex justify-content-between align-items-center flex-wrap gap-2">

                    <div class="d-flex align-items-start app-task-row">

                        <div class="me-3" style="width: 160px; flex-shrink: 0;">
                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle w-100 fw-semibold text-truncate d-block text-center" 
                                  style="font-size: 0.75rem; text-transform: none; padding: 4px 8px;" 
                                  title="${a.subjectName}">
                                ${a.subjectName}
                            </span>
                        </div>

                        <div class="fw-semibold text-dark fs-6">${a.title}</div>
                    </div>

                    <div class="text-secondary small fw-medium bg-light px-2.5 py-1 rounded-2 border border-light-subtle ms-auto">
                        <span class="me-1">📅</span>
                        <c:out value="${a.dueDate.format(dateFormatter)}" />
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty upcoming}">
                <div class="text-center py-5 text-muted">
                    <p class="mb-0">🎉 Tuyệt vời! Không có nhiệm vụ nào sắp đến hạn.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>