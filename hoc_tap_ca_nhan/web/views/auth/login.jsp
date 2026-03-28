<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang đăng nhập</title>

    <style>
        body {
            font-family: Arial;
            background: linear-gradient(to right, #36d1dc, #5b86e5);
        }

        .container {
            width: 350px;
            margin: 80px auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 10px gray;
        }

        h2 {
            text-align: center;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
        }

        .btn {
            width: 100%;
            padding: 10px;
            background: #28a745;
            color: white;
            border: none;
            cursor: pointer;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .error {
            color: red;
            text-align: center;
        }

        .success {
            color: green;
            text-align: center;
        }

        .link {
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Đăng nhập</h2>
    <!-- Hiển thị lỗi -->
    <%
        String error = (String) request.getAttribute("error");
        String success = (String) request.getAttribute("success");
    %>

    <% if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } %>

    <% if (success != null) { %>
        <p class="success"><%= success %></p>
    <% } %>
    
    <form action="login" method="post">
        <input type="text" name="username" placeholder="Tên đăng nhập" required />
        <input type="password" name="password" placeholder="Mật khẩu" required />
    <button type="submit" class="btn">Đăng nhập</button>
    </form>

    <div class="link">
        <a href="register">Chưa có tài khoản? Đăng ký</a>
    </div>
</div>

</body>
</html>