<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">
</head>
<body>

<div class="auth-wrapper">
    <div class="row justify-content-center m-0 w-100">
        <div class="col-12" style="max-width: 460px;">
            
            <div class="bg-white p-4 p-sm-5 rounded-4 shadow-lg text-dark border border-light-subtle">
                
                <div class="text-center mb-4">
                    <div class="display-6 mb-2 text-success"><i class="bi bi-person-plus-fill"></i></div>
                    <h2 class="fw-bold mb-1 text-dark fs-3">Đăng ký</h2>
                    <p class="text-secondary small mb-0">Hệ thống hỗ trợ học tập cá nhân</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2 px-3 mb-3 rounded-3 border-0 small fw-semibold text-center" role="alert">
                        ⚠️ ${error}
                    </div>
                </c:if>
                
                <c:if test="${not empty success}">
                    <div class="alert alert-success py-2 px-3 mb-3 rounded-3 border-0 small fw-semibold text-center" role="alert">
                        ✅ ${success}
                    </div>
                </c:if>
                
                <form action="register" method="post">
                    
                    <div class="mb-3 text-start">
                        <label class="form-label text-secondary small fw-bold mb-1.5">Họ tên</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-secondary-subtle text-secondary"><i class="bi bi-card-text"></i></span>
                            <input type="text" name="fullName" value="${param.fullName}" class="form-control border-secondary-subtle bg-white text-dark" placeholder="Nhập họ và tên" />
                        </div>
                    </div>

                    <div class="mb-3 text-start">
                        <label class="form-label text-secondary small fw-bold mb-1.5">Email <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-secondary-subtle text-secondary"><i class="bi bi-envelope-fill"></i></span>
                            <input type="email" name="email" value="${param.email}" class="form-control border-secondary-subtle bg-white text-dark" placeholder="example@gmail.com" required />
                        </div>
                    </div>
                    
                    <div class="mb-3 text-start">
                        <label class="form-label text-secondary small fw-bold mb-1.5">Tên đăng nhập <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-secondary-subtle text-secondary"><i class="bi bi-person-fill"></i></span>
                            <input type="text" name="username" value="${param.username}" class="form-control border-secondary-subtle bg-white text-dark" placeholder="Nhập tên đăng nhập" required />
                        </div>
                    </div>

                    <div class="mb-3 text-start">
                        <label class="form-label text-secondary small fw-bold mb-1.5">Mật khẩu <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-secondary-subtle text-secondary"><i class="bi bi-key-fill"></i></span>
                            <input type="password" name="password" class="form-control border-secondary-subtle bg-white text-dark" placeholder="Nhập mật khẩu" required />
                        </div>
                    </div>

                    <div class="mb-4 text-start">
                        <label class="form-label text-secondary small fw-bold mb-1.5">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-secondary-subtle text-secondary"><i class="bi bi-shield-check"></i></span>
                            <input type="password" name="confirmPassword" class="form-control border-secondary-subtle bg-white text-dark" placeholder="Nhập lại mật khẩu" required />
                        </div>
                    </div>

                    <button type="submit" class="btn btn-success w-100 fw-bold py-2.5 rounded-3 hover-lift shadow-sm mb-2">
                        <i class="bi bi-person-plus-fill me-1"></i> Đăng ký
                    </button>
                </form>

                <div class="text-center mt-3 border-top pt-3 border-light-subtle">
                    <a href="login" class="text-secondary small text-decoration-none fw-medium link-primary">
                        Đã có tài khoản? <span class="text-success fw-bold text-decoration-underline">Đăng nhập ngay</span>
                    </a>
                </div>
                
            </div> </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>