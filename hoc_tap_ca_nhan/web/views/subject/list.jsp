<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Subject" %>

<!DOCTYPE html>
<html>
<head>
    <title>Danh sách môn học</title>
</head>
<body>

<h2>Môn học</h2>

<!-- CREATE -->
<form method="post" action="subjects">
    <input type="hidden" name="action" value="create"/>

    <input type="text" name="name" placeholder="Tên môn" required/>
    <input type="text" name="desc" placeholder="Mô tả"/>

    <button type="submit">Thêm</button>
</form>

<hr>

<ul>
<%
    List<Subject> ds = (List<Subject>) request.getAttribute("subjects");

    if (ds != null) {
        for (Subject s : ds) {
%>
    <li>
        <b><%= s.getSubjectName() %></b>
        - <%= s.getDescription() %>

        <a href="assignments?subjectId=<%= s.getId() %>">Assignment</a>

        <!-- DELETE -->
        <form action="subjects" method="post" style="display:inline;">
            <input type="hidden" name="action" value="delete"/>
            <input type="hidden" name="id" value="<%= s.getId() %>"/>

            <button onclick="return confirm('Xóa môn này?')">Xóa</button>
        </form>
    </li>
<%
        }
    }
%>
</ul>

</body>
</html>