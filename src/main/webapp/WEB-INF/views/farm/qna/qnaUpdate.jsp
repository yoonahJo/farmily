<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<jsp:include page="/modules/farmerHeader.jsp" flush="false" />
    <div class="container mt-5">
        <h2>문의 수정</h2>
        <form action="${pageContext.request.contextPath}/farm/qna/updateQna" method="post" enctype="multipart/form-data">
            <input type="hidden" name="qcode" value="${qna.qcode}">
            <input type="hidden" name="page" value="${param.page}">
            <input type="hidden" name="searchKeyword" value="${param.searchKeyword}">
            
            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" class="form-control" id="title" name="title" value="${qna.title}" maxlength="30" required>
            </div>
            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea class="form-control" id="content" name="content" rows="5" maxlength="1000" required>${qna.content}</textarea>
            </div>
            <div class="mb-3">
    <label for="newFile" class="form-label">이미지 업로드</label>
    <input type="file" class="form-control" id="newFile" name="newFile" accept="image/*">
    <c:if test="${qna.image != null}">
        <img src="${pageContext.request.contextPath}/resources/img/${qna.image}" alt="첨부 이미지" class="img-fluid mt-3" />
        <input type="hidden" name="existingFileName" value="${qna.image}">
    </c:if>
</div>
            <div class="text-center">
                <button type="submit" class="btn btn-success">수정하기</button>
            </div>
        </form>
    </div>
    <%@ include file="/modules/footer.jsp"%>
</body>
</html>