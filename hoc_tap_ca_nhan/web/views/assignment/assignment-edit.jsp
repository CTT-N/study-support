<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Assignment" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%-- Sidebar dùng chung (tìm đúng vị trí tương đối của thư mục so với file này) --%>
        <jsp:include page="../common/sidebar.jsp" />
        
        <div style="margin-left:240px; padding:20px;">
            <%
                Assignment a = (Assignment) request.getAttribute("assignment");
            %>

            <h2>Chỉnh sửa nhiệm vụ</h2>

            <% if (request.getAttribute("error") != null) { %>
                <p style="color:red;"><%= request.getAttribute("error") %></p>
            <% } %>

            <form method="post" action="assignments">
                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="id" value="<%=a.getId()%>"/>
                <input type="hidden" name="subjectId" value="<%=a.getSubjectId()%>"/>

                <input type="text" name="title" value="<%=a.getTitle()%>" required/>

                <input type="date" name="dueDate"
                       value="<%= a.getDueDate() != null ? a.getDueDate().toLocalDate().toString() : "" %>"/>

                <br><br>

                <button type="submit">Lưu</button>
                <a href="assignments?subjectId=<%=a.getSubjectId()%>">
                    <button type="button">Hủy</button>
                </a>
            </form>

        </div>

    </body>
</html>
