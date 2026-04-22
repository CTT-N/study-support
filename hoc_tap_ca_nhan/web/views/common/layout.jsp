<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>${pageTitle}</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Base CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/sidebar.css">

    <!-- Page CSS -->
    <c:if test="${not empty pageCss}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/${pageCss}">
    </c:if>
</head>

<body>

<div class="d-flex">

    <!-- Sidebar -->
    <jsp:include page="/views/common/sidebar.jsp"/>

    <!-- Main -->
    <div class="main-content p-4 w-100">
        <div class="container-fluid">

            <h3 class="mb-4">${pageTitle}</h3>

            <jsp:include page="${contentPage}" />

        </div>
    </div>

</div>

</body>
</html>