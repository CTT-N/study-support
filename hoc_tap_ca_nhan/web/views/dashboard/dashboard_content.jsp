<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Assignment" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="row g-3">

    
    <div class="col-md-4">
        <div class="card shadow-soft p-3">
            <h2>${totalSubjects}</h2>
            <p class="text-muted">Môn học</p>
            <a href="${pageContext.request.contextPath}/subjects">xem danh sách</a>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card shadow-soft p-3 text-center">
            <h2>${pendingAssignments}</h2>
            <p class="text-warning">Chưa hoàn thành</p>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card shadow-soft p-3 text-center">
            <h2>${overdueAssignments}</h2>
            <p class="text-danger">Quá hạn</p>
        </div>
    </div>

</div>

<div class="section mt-4 shadow-soft">
    <div class="section-header">
        <h5>⏰ Sắp đến hạn</h5>
    </div>
    <ul class="task-list">
        <c:forEach var="a" items="${upcoming}">
            <li class="task-item">
                <div class="task-info">
                    <span class="subject-badge">${a.subjectName}</span>
                    <div class="task-title">${a.title}</div>
                </div>
                <div class="task-date">
                    <span class="date-text">${a.dueDate}</span>
                </div>
            </li>
        </c:forEach>

        <c:if test="${empty upcoming}">
            <li class="text-muted text-center p-4">Không có nhiệm vụ</li>
        </c:if>
    </ul>
</div>                     