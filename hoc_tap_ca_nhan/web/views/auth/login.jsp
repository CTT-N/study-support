<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Trang đăng nhập</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">
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