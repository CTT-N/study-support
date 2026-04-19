<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Subject" %>

<%
    request.setAttribute("activePage", "subjects");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Danh sách môn học</title>

    <style>
        body {
            margin: 0;
            font-family: Arial;
            background-color: #f5f5f5;
        }

        .content {
            margin-left: 240px;
            padding: 20px;
        }

        .form-box {
            background: white;
            padding: 15px;
            border: 2px solid #ccc;
            border-radius: 8px;
            width: 400px;
        }

        .form-box input {
            margin: 5px 0;
            padding: 8px;
            width: 95%;
        }

        .form-box button {
            padding: 8px 15px;
            margin-top: 10px;
        }

        .subject-card {
            background: white;
            border: 2px solid #ccc;
            border-radius: 8px;
            padding: 15px;
            margin-top: 15px;
            width: 400px;
        }

        .actions a {
            margin-right: 10px;
            text-decoration: none;
            color: blue;
        }

        .actions form {
            display: inline;
        }
    </style>
</head>

<body>

<%-- Sidebar dùng chung (tìm đúng vị trí tương đối của thư mục so với file này) --%>
<jsp:include page="../common/sidebar.jsp" />

<div class="content">

    <h2>Danh sách môn học</h2>

    <!-- CREATE -->
    <div class="form-box">
        <form method="post" action="subjects">
            <input type="hidden" name="action" value="create"/>

            <input type="text" name="name" required/>
            <input type="text" name="desc"/>

            <button type="submit">Thêm môn</button>
        </form>
        <form method="get" action="subjects">
            <input type="hidden" name="action" value="search"/>

            <input type="text" name="keyword" value="${keyword}" placeholder="Tìm môn..."/>

            <button type="submit">Tìm</button>
        </form>
    </div>

    <!-- LIST -->
    <%
        List<Subject> ds = (List<Subject>) request.getAttribute("subjects");

        if (ds != null && !ds.isEmpty()) {
            for (Subject s : ds) {
    %>
        <div class="subject-card">
            <h3><%= s.getSubjectName() %></h3>
            <p><%= s.getDescription() %></p>

            <div class="actions">
                <a href="assignments?subjectId=<%= s.getId() %>">Assignment</a>
                <a href="documents?subjectId=<%= s.getId() %>">Tài liệu</a>

                <!-- DELETE -->
                <form action="subjects" method="post">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" value="<%= s.getId() %>"/>

                    <button onclick="return confirm('Xóa môn này?')">Xóa</button>
                </form>
            </div>
        </div>
    <%
            }
        } else {
    %>
        <p>Chưa có môn học nào</p>
    <%
        }
    %>

</div>

</body>
</html>