<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-5">
            
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body p-4">
                    
                    <h4 class="card-title fw-bold text-dark mb-4 d-flex align-items-center">
                        <span class="me-2">✏️</span> Sửa thông tin cá nhân
                    </h4>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success d-flex align-items-center py-2 px-3 mb-4 rounded-3" role="alert">
                            <span class="me-2">✅</span>
                            <div class="fw-semibold small">${success}</div>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger d-flex align-items-center py-2 px-3 mb-4 rounded-3" role="alert">
                            <span class="me-2">⚠️</span>
                            <div class="fw-semibold small">${error}</div>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/user" method="post">
                        <input type="hidden" name="action" value="editProfile">

                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary small">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" name="fullName" class="form-control border-secondary-subtle" value="${user.fullName}" placeholder="Nhập họ và tên..." required/>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold text-secondary small">Địa chỉ Email <span class="text-danger">*</span></label>
                            <input type="email" name="email" class="form-control border-secondary-subtle" value="${user.email}" placeholder="Nhập địa chỉ email..." required/>
                        </div>

                        <hr class="text-muted my-4 opacity-25">

                        <div class="d-flex justify-content-end gap-2">
                            <a href="${pageContext.request.contextPath}/user" class="btn btn-outline-secondary px-4 fw-semibold">
                                Hủy
                            </a>
                            <button type="submit" class="btn btn-primary px-4 fw-semibold">
                                Cập nhật
                            </button>
                        </div>
                    </form>

                </div>
            </div> </div>
    </div>
</div>