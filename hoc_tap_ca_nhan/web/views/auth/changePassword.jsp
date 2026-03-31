<%-- 
    Document   : changePassword
    Created on : Mar 31, 2026, 3:52:19 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    request.setAttribute("activePage","password");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đổi mật khẩu</title>
    </head>
    <body>
        <%-- Sidebar dùng chung (tìm đúng vị trí tương đối của thư mục so với file này) --%>
        <jsp:include page="../common/sidebar.jsp" />
        
        <div style="margin-left:240px; padding:20px;">
            <h2>Vui lòng nhập các thông tin dưới đây</h2>
            
            <form action="changePassword" method="post">
                <input type="password" name="oldPass" placeholder="Mật khẩu cũ"><br>
                <input type="password" name="newPass" placeholder="Mật khẩu mới"><br>
                <input type="password" name="confirm" placeholder="Xác nhận mật khẩu mới"><br>
                <button type="submit">Đổi mật khẩu</button>
            </form>
            
            <%-- thông báo --%>
            <p style="color: red;">${error}</p>
            <p style="color: green">${success}</p>
        </div>
        
    </body>
</html>
