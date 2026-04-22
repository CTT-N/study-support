<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="form-container">
    <div class="form-box">
        <h2>Vui lòng nhập các thông tin dưới đây</h2>

        <form action="changePassword" method="post" accept-charset="UTF-8">
            <input type="password" name="oldPass" placeholder="Mật khẩu cũ"><br>
            <input type="password" name="newPass" placeholder="Mật khẩu mới"><br>
            <input type="password" name="confirm" placeholder="Xác nhận mật khẩu mới"><br>
            <button type="submit">Đổi mật khẩu</button>
        </form>

        <p class="error">${error}</p>
        <p class="success">${success}</p>
    </div>
</div>