<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="form-wrapper">

    <div class="form-box">

        <h2>Sửa thông tin</h2>

        <form action="${pageContext.request.contextPath}/user" method="post">
            <input type="hidden" name="action" value="editProfile">

            <input type="text" name="fullName" value="${user.fullName}" placeholder="Họ tên">
            <input type="email" name="email" value="${user.email}" placeholder="Email">

            <div class="form-actions">
                <button type="submit" class="btn-save">Cập nhật</button>

                <a href="${pageContext.request.contextPath}/user">
                    <button type="button" class="btn-cancel">Hủy</button>
                </a>
            </div>
        </form>

        <p class="success">${success}</p>
        <p class="error">${error}</p>

    </div>
</div>