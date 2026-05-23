<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-5">
            
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body p-4">
                    
                    <h5 class="card-title fw-bold text-dark mb-2 d-flex align-items-center">
                        <span class="me-2">🔑</span> Đổi mật khẩu
                    </h5>
                    <p class="text-muted small mb-4">Vui lòng nhập đầy đủ các thông tin bảo mật dưới đây</p>

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

                    <form action="changePassword" method="post" accept-charset="UTF-8">
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary small">Mật khẩu hiện tại</label>
                            <input type="password" name="oldPass" class="form-control border-secondary-subtle" placeholder="Nhập mật khẩu cũ..." required/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary small">Mật khẩu mới</label>
                            <input type="password" name="newPass" class="form-control border-secondary-subtle" placeholder="Nhập mật khẩu mới..." required/>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold text-secondary small">Xác nhận mật khẩu mới</label>
                            <input type="password" name="confirm" class="form-control border-secondary-subtle" placeholder="Nhập lại mật khẩu mới..." required/>
                        </div>

                        <hr class="text-muted my-4 opacity-25">

                        <button type="submit" class="btn btn-primary w-100 fw-semibold py-2 rounded-3 shadow-sm">
                            🔒 Xác nhận đổi mật khẩu
                        </button>
                    </form>

                </div>
            </div> </div>
    </div>
</div>