<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid py-4">
    <div class="row">
        <div class="col-md-8 col-lg-5 mx-auto">
            
            <div class="card border-0 shadow-sm rounded-3 overflow-hidden">
                
                <div class="bg-primary bg-gradient" style="height: 100px;"></div>
                
                <div class="card-body p-4 pt-0 text-center position-relative">
                    
                    <div class="d-flex align-items-center justify-content-center bg-white rounded-circle shadow-sm mx-auto" 
                         style="width: 90px; height: 90px; margin-top: -45px; border: 4px solid #fff;">
                        <span class="fs-2 fw-bold text-primary text-uppercase">
                            <c:out value="${not empty user.fullName ? user.fullName.substring(0,1) : 'U'}" />
                        </span>
                    </div>

                    <h5 class="fw-bold text-dark mt-3 mb-1">${user.fullName}</h5>
                    <p class="text-muted small mb-4">🎯 Thành viên Study App</p>
                    
                    <hr class="text-muted opacity-25 my-3">

                    <div class="text-start mb-4 bg-light p-3 rounded-3 border border-light-subtle">
                        <div class="mb-2.5 d-flex align-items-center">
                            <span class="me-2.5 text-secondary">👤</span>
                            <div>
                                <small class="text-muted d-block" style="font-size: 0.75rem;">Họ và tên</small>
                                <span class="fw-semibold text-dark">${user.fullName}</span>
                            </div>
                        </div>
                        <div class="d-flex align-items-center">
                            <span class="me-2.5 text-secondary">✉️</span>
                            <div>
                                <small class="text-muted d-block" style="font-size: 0.75rem;">Địa chỉ Email</small>
                                <span class="fw-semibold text-dark text-break">${user.email}</span>
                            </div>
                        </div>
                    </div>

                    <a href="user?action=editProfile" class="btn btn-primary w-100 fw-semibold py-2 rounded-3 shadow-sm">
                        ✏️ Chỉnh sửa thông tin
                    </a>

                </div>
            </div> </div>
    </div>
</div>