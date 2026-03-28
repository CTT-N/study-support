<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Assignment" %>

<!-- kiem tra dang nhap? neu chua quay ve trang index.jsp-->
<%
    HttpSession s1 = request.getSession(false);
    if(s1 == null || s1.getAttribute("user")==null){
        response.sendRedirect("index.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>

    <style>
        body {
            font-family: Arial;
            background: #f4f6f9;
            margin: 0;
        }

        .header {
            background: #007bff;
            color: white;
            padding: 15px;
            text-align: center;
        }

        .container {
            padding: 30px;
        }

        .cards {
            display: flex;
            gap: 20px;
        }

        .card {
            flex: 1;
            padding: 20px;
            border-radius: 10px;
            color: white;
        }

        .blue { background: #007bff; }
        .orange { background: #ffc107; }
        .red { background: #dc3545; }

        h2 {
            margin: 0;
        }

        .section {
            margin-top: 30px;
        }

        ul {
            background: white;
            padding: 15px;
            border-radius: 8px;
            list-style: none;
        }

        li {
            padding: 8px 0;
            border-bottom: 1px solid #ddd;
        }

        .nav {
            margin-top: 20px;
        }

        a {
            text-decoration: none;
            margin-right: 15px;
        }
    </style>
</head>

<body>

<div class="header">
    <h1>Dashboard</h1>
</div>

<div class="container">

    <!-- Thống kê -->
    <div class="cards">
        <div class="card blue">
            <h2><%= request.getAttribute("totalSubjects") %></h2>
            <p>Tổng môn học</p>
        </div>

        <div class="card orange">
            <h2><%= request.getAttribute("pendingAssignments") %></h2>
            <p>Chưa hoàn thành</p>
        </div>

        <div class="card red">
            <h2><%= request.getAttribute("overdueAssignments") %></h2>
            <p>Quá hạn</p>
        </div>
    </div>

    <!-- Upcoming -->
    <div class="section">
        <h3>Assignment sắp đến hạn</h3>

        <ul>
        <%
            List<Assignment> upcoming = (List<Assignment>) request.getAttribute("upcoming");

            if (upcoming != null && !upcoming.isEmpty()) {
                for (Assignment a : upcoming) {
        %>
            <li>
                <b><%= a.getTitle() %></b>
                - <%= a.getDueDate() != null ? a.getDueDate() : "Không có hạn" %>
            </li>
        <%
                }
            } else {
        %>
            <li>Không có assignment nào</li>
        <%
            }
        %>
        </ul>
    </div>

    <!-- Navigation -->
    <div class="nav">
        <a href="subjects">Môn học</a>
        <a href="assignments?subjectId=1">Assignment</a>
        <a href="logout">Đăng xuất</a>
    </div>

</div>

</body>
</html>