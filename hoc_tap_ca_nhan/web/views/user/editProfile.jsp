<%-- 
    Document   : editProfile
    Created on : Mar 31, 2026, 5:24:25 PM
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
        
        <div style="margin-left:240px; padding:40px;">
    
            <h2>Sửa thông tin</h2>

            <form action="${pageContext.request.contextPath}/user" method="post">
                <input type="hidden" name="action" value="editProfile">

                <input type="text" name="fullName" value="${user.fullName}">
                <input type="email" name="email" value="${user.email}">

                <button type="submit">Cập nhật</button>
            </form>

            <p style="color:green">${success}</p>
            <p style="color:red">${error}</p>

        </div>
    </body>
</html>
