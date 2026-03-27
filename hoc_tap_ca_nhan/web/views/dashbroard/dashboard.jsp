<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-4">

    <h2>Dashboard</h2>

    <div class="row">

        <div class="col-md-3">
            <div class="card p-3 bg-primary text-white">
                <h4>${totalSubjects}</h4>
                <p>Môn học</p>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-3 bg-warning">
                <h4>${pendingAssignments}</h4>
                <p>Chưa hoàn thành</p>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-3 bg-danger text-white">
                <h4>${overdueAssignments}</h4>
                <p>Quá hạn</p>
            </div>
        </div>

    </div>

</div>

</body>
</html>