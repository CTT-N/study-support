<%@ page contentType="text/html;charset=UTF-8" %>

<style>
    body {
        margin: 0;
        font-family: Arial;
        background-color: #f5f5f5;
    }

    .sidebar {
        width: 220px;
        height: 100vh;
        background-color: #e6e6e6;
        border-right: 2px solid #999;
        float: left;
        padding-top: 10px;
    }

    .menu-item {
        display: block;
        margin: 8px 10px;
        padding: 12px;
        background-color: #d9d9d9;
        border: 2px solid #888;
        border-radius: 6px;
        text-align: center;
        text-decoration: none;
        color: black;
        font-weight: 500;
    }

    .menu-item:hover {
        background-color: #cccccc;
    }

    .active {
        background-color: #f4b6b6; /* đỏ nhạt giống hình */
        border: 2px solid #ff4d4d;
    }
</style>

<div class="sidebar">
    <a class="menu-item ${activePage == 'home' ? 'active' : ''}" href="dashboard">
        Trang chủ
    </a>

    <a class="menu-item ${activePage == 'profile' ? 'active' : ''}" href="user">
        Thông tin người dùng
    </a>

    <a class="menu-item ${activePage == 'subjects' ? 'active' : ''}" href="subjects">
        Danh sách môn học
    </a>

    <a class="menu-item ${activePage == 'password' ? 'active' : ''}" href="changePassword">
        Đổi mật khẩu
    </a>

    <a class="menu-item" href="logout">
        Đăng xuất
    </a>
</div>