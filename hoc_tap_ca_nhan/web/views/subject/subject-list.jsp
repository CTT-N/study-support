<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Subject" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="card p-3 shadow-soft mb-3">
    <div class="row g-2">

        <!-- ===== FORM THÊM ===== -->
        <form method="post" action="subjects" class="col-md-7 row g-2">
            <input type="hidden" name="action" value="create"/>

            <div class="col-md-5">
                <input class="form-control" name="name" placeholder="Tên môn" required/>
            </div>

            <div class="col-md-5">
                <input class="form-control" name="desc" placeholder="Mô tả"/>
            </div>

            <div class="col-md-2">
                <button class="btn btn-primary w-100">Thêm</button>
            </div>
        </form>

        <!-- ===== FORM SEARCH ===== -->
        <form method="get" action="subjects" class="col-md-5 row g-2">
            <input type="hidden" name="action" value="search"/>

            <div class="col-md-8">
                <input class="form-control"
                       name="keyword"
                       value="${keyword}"
                       placeholder="Tìm môn học..."/>
            </div>

            <div class="col-md-4">
                <button class="btn btn-outline-secondary w-100">
                    🔍 Tìm
                </button>
            </div>
        </form>

    </div>
</div>

<div class="row g-3">
<c:forEach var="s" items="${subjects}">
    <div class="col-md-4">
        <div class="card shadow-soft p-3">

            <h5>${s.subjectName}</h5>
            <p class="text-muted">${s.description}</p>

            <div class="d-flex justify-content-between">

                <a class="btn btn-outline-primary btn-sm"
                   href="assignments?subjectId=${s.id}">
                    Assignment
                </a>

                <a class="btn btn-outline-success btn-sm"
                   href="documents?subjectId=${s.id}">
                    Tài liệu
                </a>

                <form method="post" action="subjects">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" value="${s.id}"/>

                    <button class="btn btn-danger btn-sm">
                        Xóa
                    </button>
                </form>

            </div>
        </div>
    </div>
</c:forEach>
</div>
<!-- Khi không có dữ liệu -->
<c:if test="${empty subjects}">
    <div class="alert alert-info mt-3">
        Không tìm thấy môn học nào
    </div>
</c:if>