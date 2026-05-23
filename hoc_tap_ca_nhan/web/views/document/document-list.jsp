<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="mb-3">
    <a href="subjects" class="btn btn-link text-decoration-none text-secondary p-0 d-inline-flex align-items-center">
        <span class="me-1">←</span> Quay lại danh sách môn học
    </a>
</div>

<div class="card border-0 shadow-sm rounded-3">
    <div class="card-body p-4">
        
        <h4 class="card-title d-flex align-items-center mb-4 fw-bold text-dark">
            <span class="me-2">📁</span> Tài liệu môn học
            <c:if test="${not empty subject}">
                <span class="mx-2 text-muted fw-light">|</span>
                <span class="text-success">${subject.subjectName}</span>
            </c:if>
        </h4>

        <c:if test="${param.msg == 'success'}">
            <div class="alert alert-success py-2 px-3 mb-3 small fw-semibold" role="alert">
                ✅ Tải lên tài liệu thành công!
            </div>
        </c:if>
        <c:if test="${param.msg == 'error'}">
            <div class="alert alert-danger py-2 px-3 mb-3 small fw-semibold" role="alert">
                ⚠️ Tải lên tài liệu thất bại, vui lòng thử lại!
            </div>
        </c:if>
        <c:if test="${param.msg == 'invalid'}">
            <div class="alert alert-warning py-2 px-3 mb-3 small fw-semibold" role="alert">
                🚫 Định dạng không hợp lệ! Hệ thống chỉ nhận file Ảnh hoặc PDF.
            </div>
        </c:if>

        <div class="p-3 bg-light rounded-3 mb-4 border border-light-subtle">
            <form method="post" action="documents" enctype="multipart/form-data" class="row g-2 align-items-center">
                <input type="hidden" name="subjectId" value="${subjectId}"/>

                <div class="col-sm-8 col-md-9">
                    <div class="col-sm-8 col-md-9">
                        <input type="file" name="file" class="form-control form-control-sm border-success-subtle" 
                            style="--bs-form-control-bg: #fff;" required/></div>
                    </div>

                <div class="col-sm-4 col-md-3">
                    <button type="submit" class="btn btn-success btn-sm w-100 fw-semibold shadow-sm d-flex align-items-center justify-content-center gap-1">
                        <span>📤</span> Tải tài liệu lên
                    </button>
                </div>
            </form>
        </div>

        <c:if test="${empty documents}">
            <div class="text-center py-5 text-muted">
                <p class="mb-0 fs-5">Chưa có tài liệu nào được tải lên.</p>
            </div>
        </c:if>

        <c:if test="${not empty documents}">
            <div class="row g-3">
                <c:forEach var="d" items="${documents}">
                    <c:set var="path" value="${pageContext.request.contextPath}/${d.filePath}" />
                    
                    <div class="col-100"> <div class="card border border-light-subtle shadow-none rounded-3 mb-3">
                            <div class="card-body p-3">
                                <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
                                    
                                    <div class="d-flex align-items-center" style="max-width: 75%;">
                                        <c:choose>
                                            <c:when test="${d.fileType.startsWith('image')}">
                                                <span class="fs-3 me-3 text-primary">🖼️</span>
                                            </c:when>
                                            <c:when test="${d.fileType == 'application/pdf'}">
                                                <span class="fs-3 me-3 text-danger">📕</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="fs-3 me-3 text-secondary">📄</span>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <div class="text-truncate">
                                            <h6 class="mb-0 text-dark fw-semibold text-truncate" title="${d.documentName}">
                                                ${d.documentName}
                                            </h6>
                                            <small class="text-muted">Định dạng: ${d.fileType}</small>
                                        </div>
                                    </div>

                                    <div class="d-flex gap-2">
                                        <a href="${path}" target="_blank" class="btn btn-outline-primary btn-sm px-3">
                                            Xem file
                                        </a>
                                        
                                        <form method="post" action="documents" class="d-inline">
                                            <input type="hidden" name="action" value="delete"/>
                                            <input type="hidden" name="id" value="${d.id}"/>
                                            <input type="hidden" name="subjectId" value="${subjectId}"/>
                                            <button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa tài liệu này?')">
                                                ❌ Xóa
                                            </button>
                                        </form>
                                    </div>
                                    
                                </div>

                                <c:if test="${d.fileType.startsWith('image')}">
                                    <div class="mt-3 p-2 bg-light rounded text-start">
                                        <img src="${path}" class="img-thumbnail" style="max-height: 150px; object-fit: contain;" alt="preview"/>
                                    </div>
                                </c:if>
                                
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

    </div>
</div>