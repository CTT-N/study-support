<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Document" %>
<%@ page import="model.Subject" %>

<%
    request.setAttribute("activePage", "subjects");
    Subject subject = (Subject) request.getAttribute("subject");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Tài liệu</title>

    <script>
        setTimeout(() => {
            const msg = document.getElementById("msgBox");
            if (msg) msg.style.display = "none";
        }, 3000);
    </script>

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

        .upload-box {
            background: white;
            padding: 15px;
            border: 2px solid #ccc;
            border-radius: 8px;
            width: 400px;
        }

        .doc-card {
            background: white;
            border: 2px solid #ccc;
            border-radius: 8px;
            padding: 15px;
            margin-top: 15px;
            width: 400px;
        }

        img {
            margin-top: 10px;
            border-radius: 6px;
        }

        .msg-success {
            color: green;
        }

        .msg-error {
            color: red;
        }
    </style>
</head>

<body>

<%-- Sidebar dùng chung (tìm đúng vị trí tương đối của thư mục so với file này) --%>
<jsp:include page="../common/sidebar.jsp" />

<div class="content">
<a href="subjects">
    <button style="margin-bottom:15px;">⬅ Quay lại danh sách môn học</button>
</a>

    <h2>Tài liệu môn học
        <% if (subject != null) { %>
            <span style="color:#888;">|</span>
            <span style="color:#4CAF50;"><%= subject.getSubjectName() %></span>
        <% } %>
    </h2>

    <!-- UPLOAD -->
    <div class="upload-box">
        <form method="post" action="documents" enctype="multipart/form-data">
            <input type="hidden" name="subjectId" value="<%= request.getAttribute("subjectId") %>"/>

            <input type="file" name="file" required/>
            <br><br>
            <button type="submit">Upload</button>
        </form>
    </div>

    <!-- MESSAGE -->
    <%
        String msg = request.getParameter("msg");

        if ("success".equals(msg)) {
    %>
        <p id="msgBox" class="msg-success">Upload thành công!</p>
    <%
        } else if ("error".equals(msg)) {
    %>
        <p id="msgBox" class="msg-error">Upload thất bại!</p>
    <%
        } else if ("invalid".equals(msg)) {
    %>
        <p id="msgBox" class="msg-error">Chỉ cho phép ảnh hoặc PDF!</p>
    <%
        }
    %>

    <!-- LIST DOCUMENT -->
    <%
        List<Document> list = (List<Document>) request.getAttribute("documents");

        if (list != null && !list.isEmpty()) {
            for (Document d : list) {
                String type = d.getFileType();
                String path = request.getContextPath() + "/" + d.getFilePath();
    %>

        <div class="doc-card">
            <h3><%= d.getDocumentName() %></h3>

            <!-- Hiển thị phần file -->
            <%
                if (type != null && type.startsWith("image")) {
            %>
                <!-- Ảnh -->
                <img src="<%= path %>" width="200"/>

            <%
                } else if (type != null && type.equals("application/pdf")) {
            %>
                <!-- PDF hiển thị trực tiếp -->
                <iframe src="<%= path %>" width="90%" height="400px"></iframe>

            <%
                } else {
            %>
                <!-- File khác -->
                <p>📄 File: <%= d.getDocumentName() %></p>
                <a href="<%= path %>" target="_blank">Xem file</a>

            <%
                }
            %>

            <br><br>

            <!-- DELETE -->
            <form action="documents" method="post">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" name="id" value="<%= d.getId() %>"/>
                <input type="hidden" name="subjectId" value="<%= request.getAttribute("subjectId") %>"/>

                <button onclick="return confirm('Xóa file này?')">❌ Xóa</button>
            </form>
        </div>

    <%
            }
        } else {
    %>
        <p>Chưa có tài liệu nào</p>
    <%
        }
    %>

</div>

</body>
</html>