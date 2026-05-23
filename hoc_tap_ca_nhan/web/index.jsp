<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Study Support System</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/index.css">
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6 text-center">
            
            <div class="glass-card p-5 rounded-4">
                
                <div class="display-3 mb-3 app-icon">
                    <i class="bi bi-mortarboard-fill"></i>
                </div>
                
                <h1 class="mb-2 tracking-tight app-title" style="letter-spacing: -1px;">
                    Study Support System
                </h1>
                
                <p class="fs-6 mb-4 px-3 app-subtitle">
                    Hệ thống quản lý việc học, tối ưu bài tập và lưu trữ tài liệu cá nhân một cách thông minh, hiệu quả.
                </p>

                <hr class="border-white opacity-25 my-4">

                <div class="d-flex flex-column flex-sm-row justify-content-center gap-3 px-4">
                    <a href="login" class="btn btn-login-custom btn-lg px-4 py-2.5 fw-semibold hover-lift d-flex align-items-center justify-content-center gap-2">
                        <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
                    </a>

                    <a href="register" class="btn btn-primary btn-lg px-4 py-2.5 fw-bold hover-lift d-flex align-items-center justify-content-center gap-2">
                        <i class="bi bi-person-plus-fill"></i> Đăng ký tài khoản
                    </a>
                </div>

            </div> </div>
    </div>
</div>

<footer class="small mt-5 position-absolute bottom-0 mb-3 text-center w-100" style="color: #4a5568;">
    &copy; 2026 — <span class="fw-medium" style="color: #718096;">Study Support Project</span>. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>