<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang đăng nhập</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">
</head>
<body>

<div class="auth-wrapper">
    <div class="row justify-content-center m-0 w-100">
        <div class="col-12" style="max-width: 420px;">
            
            <div class="bg-white p-4 p-sm-5 rounded-4 shadow-lg text-dark border border-light-subtle">
                
                <div class="text-center mb-4">
                    <div class="display-6 mb-2 text-primary"><i class="bi bi-shield-lock-fill"></i></div>
                    <h2 class="fw-bold mb-1 text-dark fs-3">Đăng nhập</h2>
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
                
                <form action="login" method="post">
                    
                    <div class="mb-3 text-start">
                        <label class="form-label text-secondary small fw-bold mb-1.5">Tên đăng nhập</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-secondary-subtle text-secondary"><i class="bi bi-person-fill"></i></span>
                            <input type="text" name="username" class="form-control border-secondary-subtle bg-white text-dark" placeholder="Nhập tên đăng nhập..." required />
                        </div>
                    </div>

                    <div class="mb-4 text-start">
                        <label class="form-label text-secondary small fw-bold mb-1.5">Mật khẩu</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-secondary-subtle text-secondary"><i class="bi bi-key-fill"></i></span>
                            <input type="password" name="password" class="form-control border-secondary-subtle bg-white text-dark" placeholder="Nhập mật khẩu..." required />
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 fw-bold py-2.5 rounded-3 hover-lift shadow-sm mb-2">
                        <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                    </button>
                </form>

                <div class="text-center mt-3 border-top pt-3 border-light-subtle">
                    <a href="register" class="text-secondary small text-decoration-none fw-medium link-primary">
                        Chưa có tài khoản? <span class="text-primary fw-bold text-decoration-underline">Đăng ký ngay</span>
                    </a>
                </div>
                
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>