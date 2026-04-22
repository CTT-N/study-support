<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Assignment" %>
<div class="row g-3">

    <div class="col-md-4">
        <div class="card shadow-soft p-3 text-center">
            <h2>${totalSubjects}</h2>
            <p class="text-muted">Môn học</p>
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

<div class="card mt-4 p-3 shadow-soft">
    <h5>⏰ Sắp đến hạn</h5>

    <ul class="list-group list-group-flush">
        <c:forEach var="a" items="${upcoming}">
            <li class="list-group-item">
                <strong class="text-success">${a.subjectName}</strong><br>
                ${a.title}<br>
                <small class="text-muted">⏰ ${a.dueDate}</small>
            </li>
        </c:forEach>

        <c:if test="${empty upcoming}">
            <li class="list-group-item text-muted">Không có nhiệm vụ</li>
        </c:if>
    </ul>
</div>