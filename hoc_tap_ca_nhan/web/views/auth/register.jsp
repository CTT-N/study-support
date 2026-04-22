<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký tài khoản</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">
</head>

<body>

<div class="container">
    <h2>Đăng ký</h2>

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

    <form action="register" method="post">
        <input type="email" name="email" placeholder="Email" required />

        <input type="text" name="username" placeholder="Tên đăng nhập" required />

        <input type="password" name="password" placeholder="Mật khẩu" required />

        <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu" required />

        <button type="submit" class="btn">Đăng ký</button>
    </form>

    <div class="link">
        <a href="login">Đã có tài khoản? Đăng nhập</a>
    </div>
</div>

</body>
</html>