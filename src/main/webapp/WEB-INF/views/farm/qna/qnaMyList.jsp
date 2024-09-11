<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Farmer :: Q&A</title>
<!-- Bootstrap CSS 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
/* 검색창과 문의하기 버튼을 같은 줄에 배치하기 위한 스타일 */
.search-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.search-bar {
	flex-grow: 1;
	margin-right: 10px;
}
/* 중앙에 위치한 제목 스타일 */
.page-title {
	text-align: center;
	font-weight: bold;
	font-size: 2rem;
	margin-bottom: 30px;
	border-bottom: 2px solid #ddd;
	padding-bottom: 10px;
}

.table {
	table-layout: fixed;
	width: 100%;
}

.table th, .table td {
	white-space: nowrap;
	overflow: hidden;
	
	padding: 8px 10px;
	text-overflow: ellipsis;
}

/* 각 열에 고정된 너비 설정 */
.table th:first-child, .table td:first-child {
	width: 10%; /* 전체 선택 체크박스 */
}

.table th:nth-child(2), .table td:nth-child(2) {
	width: 25%; /* 상품코드 */
}

.table th:nth-child(3), .table td:nth-child(3) {
	width: 10%; /* 상품명 */
}

.table th:nth-child(4), .table td:nth-child(4) {
	width: 10%; /* 상품명 */
}
.table th:nth-child(5), .table td:nth-child(5) {
	width: 4%; /* 상품명 */
}

.table-hover tbody tr:hover {
	background-color: #19a26e; /* 원하는 배경색으로 변경 가능 */
	cursor: pointer; /* 클릭 가능한 느낌을 주기 위해 커서를 포인터로 변경 */
}

.table a {
	text-decoration: none; /* 링크의 밑줄 제거 */
	color: inherit; /* 링크 색상 상속 */
}

.page-item.active .page-link {
	background-color: #19a26e; /* 부트스트랩의 success 색상 */
	border-color: #19a26e; /* 부트스트랩의 success 경계선 색상 */
	color: white; /* 텍스트 색상 */
}

.page-link {
	color: black; /* 일반 페이지 버튼의 텍스트 색상 */
}

.page-link:hover {
	color: #19a26e; /* 페이지 링크를 호버할 때 success 색상 적용 */
	text-decoration: none; /* 호버 시 밑줄 제거 */
}

@media ( max-width : 768px) {
	/* 상품종류, 가격, 등급 열 숨기기 */
	.table th:nth-child(3), .table td:nth-child(3),
	.table th:nth-child(4), .table td:nth-child(4),
	.table th:nth-child(5), .table td:nth-child(5) {
		display: none;
	}
}

#wrapper{
  height: auto;
  min-height: 100%;
  padding-bottom: 50px;
}
footer{
  height: 160px;
}
</style>

</head>
<body class="nanum-gothic-regular">
<div id="wrapper">
	<jsp:include page="/modules/farmerHeader.jsp" flush="false" />
	<div class="container mt-5">

		<h2 class="page-title">문의(Q&A)</h2>
		<div class="search-container">
			<form action="${pageContext.request.contextPath}/farm/qna"
				method="get" class="search-bar">
				<div class="input-group">
					<input type="search" name="searchKeyword" value="${searchKeyword}"
						class="form-control" placeholder="제목 검색">
					<button type="submit" class="btn btn-success">검색</button>
				</div>
			</form>
			<button type="button" id="allBtn" class="btn btn-success ms-3"
				style="white-space: nowrap;" onclick="location.href='/farm/qna';">전체보기</button>
		</div>
		<div class="d-flex justify-content-end mb-4">
			<a href="${pageContext.request.contextPath}/farm/qna/insertPage"
				class="btn btn-success">문의하기</a>
		</div>
		<!-- 테이블 -->
		<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th>문의번호</th>
					<th>제목</th>
					<th>작성 날짜</th>
					<th>상태</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
    <c:choose>
        <c:when test="${empty myQnaList}">
            <tr>
                <td colspan="5" class="text-center">문의 내역이 없습니다.</td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach var="qna" items="${myQnaList}">
                <tr>
                    <td><a href="${pageContext.request.contextPath}/farm/qna/detail/${qna.qcode}?page=${page}&searchKeyword=${searchKeyword}">${qna.qcode}</a></td>
                    
                    <td><a href="${pageContext.request.contextPath}/farm/qna/detail/${qna.qcode}?page=${page}&searchKeyword=${searchKeyword}" style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${qna.title}</a></td>
                    
                    <td><a href="${pageContext.request.contextPath}/farm/qna/detail/${qna.qcode}?page=${page}&searchKeyword=${searchKeyword}">
                    <fmt:formatDate value="${qna.postdate}" pattern="yyyy-MM-dd" /></a></td>
                    
                    <td><a href="${pageContext.request.contextPath}/farm/qna/detail/${qna.qcode}?page=${page}&searchKeyword=${searchKeyword}">
                    ${qna.status}</a></td>
                    <td>
                       <form action="${pageContext.request.contextPath}/farm/qna/delete/${qna.qcode}" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');" class="mx-2">
    <input type="hidden" name="qcode" value="${qna.qcode}">
    <input type="hidden" name="page" value="${page != null ? page : 1}">
    <input type="hidden" name="searchKeyword" value="${searchKeyword != null ? searchKeyword : ''}">
    <button type="submit" class="btn btn-danger btn-sm">삭제</button>
</form>
                    </td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</tbody>
		</table>

		<jsp:include page="/modules/qnaPagination.jsp" flush="true" />
	</div>
</div>
	<%@ include file="/modules/footer.jsp"%>
</body>
</html>