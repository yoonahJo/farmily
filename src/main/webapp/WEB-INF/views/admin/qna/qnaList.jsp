<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html> 
<html>
<head>
    <title>Admin :: Q&A</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .table-hover tbody tr:hover {
            background-color: #f2f2f2; /* 원하는 배경색으로 변경 가능 */
            cursor: pointer; /* 클릭 가능한 느낌을 주기 위해 커서를 포인터로 변경 */
        }

        .page-title {
            text-align: center;
            font-weight: bold;
            font-size: 2rem;
            margin-bottom: 30px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }

       
        .search-bar {
            margin-bottom: 20px;
        }

    
        .input-group select {
            max-width: 150px;
        }

        .table th,
        .table td {
            white-space: nowrap; 
            overflow: hidden; 
            text-overflow: ellipsis; 
            padding: 8px 10px; 
        }
        .table {
	table-layout: auto;
	width: 100%;
}
        

        /* 각 열에 적절한 최소 너비 설정 */
        .table th:first-child, 
        .table td:first-child {
            width: 10%; /* 문의접수번호 */
        }

        .table th:nth-child(2), 
        .table td:nth-child(2) {
            width: 15%; /* 작성자 ID */
        }

        .table th:nth-child(3), 
        .table td:nth-child(3) {
            width: 40%; /* 제목 */
        }

        .table th:nth-child(4), 
        .table td:nth-child(4) {
            width: 15%; /* 작성 날짜 */
        }

        .table th:nth-child(5), 
        .table td:nth-child(5) {
            width: 10%; /* 상태 */
        }

        .table th:nth-child(6), 
        .table td:nth-child(6) {
            width: 10%; /* 만족도 */
        }
        .table th:nth-child(7), 
        .table td:nth-child(7) {
            width: 4%; /* 만족도 */
        }

        /* 행 전체를 클릭할 수 있게 스타일 추가 */
        .clickable-row {
            display: block;
            color: inherit;
            text-decoration: none;
        }
        
        @media (max-width: 768px) {
            /* 상품종류, 가격, 등급 열 숨기기 */
            .table th:nth-child(2), 
            .table td:nth-child(2),
            .table th:nth-child(4), 
            .table td:nth-child(4),
            .table th:nth-child(5), 
            .table td:nth-child(5),
            .table th:nth-child(6), 
            .table td:nth-child(6),
            .table th:nth-child(7), 
            .table td:nth-child(7) {
                display: none;
            }
        }
              .page-item.active .page-link {
    background-color: #d0d0d0;
    border-color: #d0d0d0;
    color: black; /* 원하는 텍스트 색상 */
	}
	.page-link {
	color: black;
	}

	@media (max-width: 768px) {
           #allBtn {
                display: none;
            }
        }
        
    </style>
    <style>
html, body {height:100%}
#wrapper{
  height: auto;
  min-height: 100%;
  padding-bottom: 209px;
}
footer{
  height: 209px;
  position : relative;
  transform : translateY(-100%);
}
</style>
</head>
<body class="nanum-gothic-regular">

<div id="wrapper">
<%@ include file="/modules/aheader.jsp"%>


    <div class="container mt-5">
        <h2 class="page-title">문의(Q&A)</h2>
        
        <form id="searchForm" action="/admin/qna" method="get" class="search-bar">
            <div class="d-flex justify-content-between align-items-center">
                <div class="input-group" style="flex-wrap: nowrap;">
                    <select name="searchCondition" class="form-select" style="max-width: 150px;">
                        <option value="title" ${searchCondition == 'title' ? 'selected' : ''}>제목</option>
                        <option value="content" ${searchCondition == 'content' ? 'selected' : ''}>내용</option>
                        <option value="id" ${searchCondition == 'id' ? 'selected' : ''}>작성자ID</option>
                    </select>
                    <input type="search" name="searchKeyword" value="${searchKeyword}" class="form-control" placeholder="검색어 입력">
                    <button type="submit" class="btn btn-secondary">검색</button>
                </div>

                <button type="button" id="allBtn" class="btn btn-secondary" style="white-space: nowrap; margin-left: 10px;" onclick="location.href='/admin/qna';">전체</button>
            </div>
        </form>
        
        <table style="" class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>문의번호</th>
                    <th>작성자 ID</th>
                    <th>제목</th>
                    <th>작성 날짜</th>
                    <th>상태</th>
                    <th>만족도</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="qna" items="${qnaList}">
                    <tr>
                        <td><a href="${pageContext.request.contextPath}/admin/qna/detail/${qna.qcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" class="clickable-row">
                        ${qna.qcode}</a></td>
                        <td><a href="${pageContext.request.contextPath}/admin/qna/detail/${qna.qcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" class="clickable-row">
                        ${qna.id}</a></td>                   
                        <td>
    <a href="${pageContext.request.contextPath}/admin/qna/detail/${qna.qcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" style=" white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" class="clickable-row">
        ${qna.title}
    </a>
</td>
                        <td><a href="${pageContext.request.contextPath}/admin/qna/detail/${qna.qcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" class="clickable-row">
                        <fmt:formatDate value="${qna.postdate}" pattern="yyyy-MM-dd" /></a></td>
                        <td><a href="${pageContext.request.contextPath}/admin/qna/detail/${qna.qcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" class="clickable-row">
                        ${qna.status}</a></td>
                        <td><a href="${pageContext.request.contextPath}/admin/qna/detail/${qna.qcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" class="clickable-row">
                        ${qna.rating}</a></td>
                        <td> 
                        <form action="${pageContext.request.contextPath}/admin/qna/delete/${qna.qcode}" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');" class="mx-2">
            <input type="hidden" name="qcode" value="${qna.qcode}">
            <input type="hidden" name="page" value="${page}">
            <input type="hidden" name="searchCondition" value="${searchCondition}" />
            <input type="hidden" name="searchKeyword" value="${searchKeyword}">
            <button type="submit" class="btn btn-outline-secondary">삭제</button>
        </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 페이지네이션 포함 -->
        <jsp:include page="/modules/aqnaPagination.jsp" flush="true" />
    </div>
 </div>
 <br>
    <%@ include file="/modules/footer.jsp"%>
</body>
</html>
