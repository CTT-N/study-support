<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Assignment" %>

<!-- kiểm tra đăng nhập -->
<%
    HttpSession s1 = request.getSession(false);
    if (s1 == null || s1.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    request.setAttribute("activePage", "home");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ</title>

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

        .cards {
            display: flex;
            gap: 20px;
        }

        .card {
            padding: 20px;
            border-radius: 8px;
            border: 2px solid;
            min-width: 150px;
            text-align: center;
            background: white;
        }

        .blue { border-color: #4da6ff; }
        .orange { border-color: orange; }
        .gray { border-color: gray; }

        .section {
            margin-top: 30px;
            padding: 15px;
            border: 2px solid #ccc;
            border-radius: 8px;
            background: white;
            width: 400px;
        }

        ul {
            padding-left: 20px;
        }
    </style>
</head>

<body>

<%-- Sidebar dùng chung (tìm đúng vị trí tương đối của thư mục so với file này) --%>
<jsp:include page="../common/sidebar.jsp" />

<div class="content">
    <h2>Trang chủ</h2>

    <!-- Thống kê -->
    <div class="cards">
        <div class="card blue">
            <h2><%= request.getAttribute("totalSubjects") %></h2>
            <p>Số môn học</p>
        </div>

        <div class="card orange">
            <h2><%= request.getAttribute("pendingAssignments") %></h2>
            <p>Chưa hoàn thành</p>
        </div>

        <div class="card gray">
            <h2><%= request.getAttribute("overdueAssignments") %></h2>
            <p>Quá hạn</p>
        </div>
    </div>

    <!-- Upcoming -->
    <div class="section">
        <h3>Nhiệm vụ sắp đến hạn</h3>

        <ul>
        <%
            List<Assignment> upcoming = (List<Assignment>) request.getAttribute("upcoming");

            if (upcoming != null && !upcoming.isEmpty()) {
                for (Assignment a : upcoming) {
        %>
            <li>
                <b><%= a.getTitle() %></b> -
                <%= a.getDueDate() != null ? a.getDueDate() : "Không có hạn" %>
            </li>
        <%
                }
            } else {
        %>
            <li>Không có nhiệm vụ nào</li>
        <%
            }
        %>
        </ul>
    </div>

</div>

</body>
</html>