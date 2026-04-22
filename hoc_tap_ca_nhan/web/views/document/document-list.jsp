<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<a href="subjects">
    <button>⬅ Quay lại</button>
</a>

<h2>
    Tài liệu môn học
    <c:if test="${not empty subject}">
        <span style="color:#888;">|</span>
        <span style="color:#4CAF50;">${subject.subjectName}</span>
    </c:if>
</h2>

<!-- UPLOAD -->
<div class="upload-box">
    <form method="post" action="documents" enctype="multipart/form-data">
        <input type="hidden" name="subjectId" value="${subjectId}"/>
        <input type="file" name="file" required/>
        <button type="submit">Upload</button>
    </form>
</div>

<!-- MESSAGE -->
<c:if test="${param.msg == 'success'}">
    <p class="msg-success">Upload thành công!</p>
</c:if>

<c:if test="${param.msg == 'error'}">
    <p class="msg-error">Upload thất bại!</p>
</c:if>

<c:if test="${param.msg == 'invalid'}">
    <p class="msg-error">Chỉ cho phép ảnh hoặc PDF!</p>
</c:if>

<!-- LIST -->
<c:forEach var="d" items="${documents}">
    <div class="doc-card">
        <h3>${d.documentName}</h3>

        <c:set var="path" value="${pageContext.request.contextPath}/${d.filePath}" />

        <!-- IMAGE -->
        <c:if test="${d.fileType.startsWith('image')}">
            <img src="${path}" width="200"/>
        </c:if>

        <!-- PDF -->
        <c:if test="${d.fileType == 'application/pdf'}">
            <iframe src="${path}" width="90%" height="400px"></iframe>
        </c:if>

        <!-- OTHER -->
        <c:if test="${!d.fileType.startsWith('image') && d.fileType != 'application/pdf'}">
            <a href="${path}" target="_blank">Xem file</a>
        </c:if>

        <!-- DELETE -->
        <form method="post" action="documents">
            <input type="hidden" name="action" value="delete"/>
            <input type="hidden" name="id" value="${d.id}"/>
            <input type="hidden" name="subjectId" value="${subjectId}"/>
            <button>❌ Xóa</button>
        </form>
    </div>
</c:forEach>

<c:if test="${empty documents}">
    <p>Chưa có tài liệu</p>
</c:if>