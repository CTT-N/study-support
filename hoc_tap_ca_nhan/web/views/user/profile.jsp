<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="d-flex justify-content-center">

    <div class="card p-4 shadow-soft" style="width:400px">

        <h4 class="mb-3">Thông tin người dùng</h4>

        <p><b>Họ tên:</b> ${user.fullName}</p>
        <p><b>Email:</b> ${user.email}</p>

        <a href="user?action=editProfile" class="btn btn-primary">
            Sửa
        </a>

    </div>

</div>