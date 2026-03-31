<%-- 
    Document   : newjsp
    Created on : Mar 31, 2026, 5:11:58 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%-- Sidebar dùng chung (tìm đúng vị trí tương đối của thư mục so với file này) --%>
        <jsp:include page="../common/sidebar.jsp" />
        
        <div style="margin-left:240px; padding:40px; display:flex; justify-content:center;">
    
            <div style="
                width:350px;
                background:#fff;
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,0.1);
                padding:30px;
                text-align:center;
            ">

                <h2>Thông tin người dùng</h2>

                <div style="text-align:left; line-height:1.8;">
                    <p><b>Họ tên:</b> ${user.fullName}</p>
                    <p><b>Tên đăng nhập:</b> ${user.username}</p>
                    <p><b>Email:</b> ${user.email}</p>
                </div>

                <!-- NÚT SỬA -->
                <form action="${pageContext.request.contextPath}/user" method="get">
                    <input type="hidden" name="action" value="editProfile">
                    <button>Sửa thông tin</button>
                </form>

            </div>
        </div>
    </body>
</html>
