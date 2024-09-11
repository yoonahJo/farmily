<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Q&A</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="nanum-gothic-regular">
<jsp:include page="/modules/farmerHeader.jsp" flush="false" />
    <div class="container mt-5">
        <h2>문의 작성</h2>
        <form action="${pageContext.request.contextPath}/farm/qna/insertQna" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" class="form-control" id="title" name="title" required>
            </div>
            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
            </div>
            <div class="mb-3">
                <label for="uploadFile" class="form-label">이미지 업로드</label>
                <input type="file" class="form-control" id="uploadFile" name="uploadFile">
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-success">문의 제출</button>
            </div>
        </form>
    </div>
    <%@ include file="/modules/footer.jsp"%>
</body>
</html>