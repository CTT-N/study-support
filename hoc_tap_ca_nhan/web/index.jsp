<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Study Support System</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            margin: 0;
            padding: 0;
        }

        .container {
            text-align: center;
            margin-top: 120px;
            color: white;
        }

        h1 {
            font-size: 42px;
            margin-bottom: 10px;
        }

        p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .btn {
            text-decoration: none;
            padding: 12px 25px;
            margin: 10px;
            border-radius: 6px;
            font-size: 16px;
            transition: 0.3s;
        }

        .login {
            background-color: #ffffff;
            color: #007bff;
        }

        .register {
            background-color: #28a745;
            color: white;
        }

        .btn:hover {
            opacity: 0.85;
        }

        footer {
            position: fixed;
            bottom: 10px;
            width: 100%;
            text-align: center;
            color: white;
            font-size: 14px;
        }
    </style>
</head>

<body>

<div class="container">
    <h1>Welcome to Study Support System</h1>
    <p>Quản lý việc học, bài tập và tài liệu của bạn một cách hiệu quả.</p>

    <a href="login" class="btn login">Đăng nhập</a>
    <a href="register" class="btn register">Đăng ký</a>
</div>

<footer>
    © 2026 - Study Support Project
</footer>

</body>
</html>