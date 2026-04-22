<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/sidebar.css">

<div class="sidebar bg-dark text-white">

    <h4 class="p-3 border-bottom">📚 Study App</h4>

    <a class="nav-link ${activePage == 'home' ? 'active' : ''}" href="dashboard">🏠 Trang chủ</a>
    <a class="nav-link ${activePage == 'profile' ? 'active' : ''}" href="user">👤 Cá nhân</a>
    <a class="nav-link ${activePage == 'subjects' ? 'active' : ''}" href="subjects">📖 Môn học</a>
    <a class="nav-link ${activePage == 'password' ? 'active' : ''}" href="changePassword">🔒 Đổi mật khẩu</a>
    <a class="nav-link text-danger" href="logout">🚪 Đăng xuất</a>

</div>