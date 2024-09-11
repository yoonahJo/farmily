<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>상품 리스트</title>
    <style>
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



/* 각 열에 고정된 너비 설정 */
.table th:first-child, 
.table td:first-child {
    width: 3%; /* 전체 선택 체크박스 */
}

.table th:nth-child(2), 
.table td:nth-child(2) {
    width: 12%; /* 상품코드 */
}

.table th:nth-child(3), 
.table td:nth-child(3) {
    width: 25%; /* 상품명 */
}

.table th:nth-child(4), 
.table td:nth-child(4) {
    width: 12%; /* 상품명 */
}

.table th:nth-child(5), 
.table td:nth-child(5) {
    width: 12%; /* 품종 */
}

.table th:nth-child(6), 
.table td:nth-child(6) {
    width: 12%; /* 가격 */
}
.table th:nth-child(7), 
.table td:nth-child(7) {
    width: 8%; /* 가격 */
}

         /* 체크박스 관련  */
    input[type="checkbox"] {
    width: 20px;
    height: 20px;
    accent-color: #19a26e; 
}

.table td:first-child,
.table th:first-child  {
    text-align: center; /
    vertical-align: middle; 
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

 /* 모바일 버전 (화면 너비 768px 이하일 때)에서 특정 열 숨기기 */
        @media (max-width: 768px) {
            /* 상품종류, 가격, 등급 열 숨기기 */
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
	.table th,
        .table td {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            padding: 8px 10px;
        }
        @media (max-width: 768px) {
           #allBtn {
                display: none;
            }
        }
   
    </style>
  
    
    <script>
     
        function toggle(source) {
            checkboxes = document.getElementsByName('pcode');
            for(var i=0, n=checkboxes.length;i<n;i++) {
                checkboxes[i].checked = source.checked;
            }
        }
    
        function validateForm() {          
            const checkboxes = document.querySelectorAll('input[name="pcode"]:checked');
       
            if (checkboxes.length > 0) {            
                return confirm('정말로 삭제하시겠습니까?');
            } else {
              
                alert('삭제할 항목을 선택해주세요.');
                return false; 
            }
        }
    </script>
</head>
<body class="nanum-gothic-regular">
<jsp:include page="/modules/farmerHeader.jsp" flush="false" />

<div class="container-xxl mt-5">

   
    <h2 class="page-title">상품관리</h2>
    
    
    
    <div>
 
<form action="${pageContext.request.contextPath}/farm/product" method="get">
 <div class="d-flex align-items-center">
        <div class="input-group" style="flex-wrap: nowrap;">
            <input type="search" name="searchKeyword" value="${vo.searchKeyword}" class="form-control" placeholder="상품명 입력">
            <button type="submit" class="btn btn-success">검색</button>              
        </div>
       	
   <button type="button" id="allBtn" class="btn btn-success ms-3" style="white-space: nowrap;" onclick="location.href='/farm/product';">전체보기</button>
  
		 </div>
</form>
    </div>
    
    
    <form action="${pageContext.request.contextPath}/farm/product/deleteMultiple" method="post" onsubmit="return validateForm();">
    <input type="hidden" name="page" value="${page}">
    <input type="hidden" name="searchKeyword" value="${param.searchKeyword}">
    <div class="d-flex justify-content-between mb-4 mt-4">
        <button type="submit" class="btn btn-danger">일괄삭제</button>
        <a href="${pageContext.request.contextPath}/farm/product/insertPage" class="btn btn-success">상품등록</a>
    </div>
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th><input type="checkbox" onClick="toggle(this)" /></th>
                <th>상품코드</th>
                <th>상품명</th>
                <th>상품종류</th>
                <th>가격</th>
                <th>등급</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="fproduct" items="${myProducts}">
                <tr>
                    <td><input type="checkbox" name="pcode" value="${fproduct.pcode}" onclick="event.stopPropagation();" /></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/farm/product/detail/${fproduct.pcode}?page=${page}&searchKeyword=${param.searchKeyword}" style="display: block; color: inherit; text-decoration: none;" onclick="event.stopPropagation();">${fproduct.pcode}</a>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/farm/product/detail/${fproduct.pcode}?page=${page}&searchKeyword=${param.searchKeyword}" style="display: block; color: inherit; text-decoration: none;">${fproduct.pname}</a>
                    </td>
                    <td><a href="${pageContext.request.contextPath}/farm/product/detail/${fproduct.pcode}?page=${page}&searchKeyword=${param.searchKeyword}" style="display: block; color: inherit; text-decoration: none;">${fproduct.ptype}</a></td>
                    <td><a href="${pageContext.request.contextPath}/farm/product/detail/${fproduct.pcode}?page=${page}&searchKeyword=${param.searchKeyword}" style="display: block; color: inherit; text-decoration: none;"><fmt:formatNumber value="${fproduct.price}" pattern="#,###" /></a></td>
                    <td><a href="${pageContext.request.contextPath}/farm/product/detail/${fproduct.pcode}?page=${page}&searchKeyword=${param.searchKeyword}" style="display: block; color: inherit; text-decoration: none;">${fproduct.quality}</a></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/farm/product/updatePage/${fproduct.pcode}?page=${page}&searchKeyword=${param.searchKeyword}" class="btn btn-success btn-sm">수정</a>
                        <a href="${pageContext.request.contextPath}/farm/product/delete?pcode=${fproduct.pcode}&page=${page}&searchKeyword=${param.searchKeyword}" class="btn btn-danger btn-sm" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</form>
    <jsp:include page="/modules/productPagination.jsp" flush="true" />
</div>
<%@ include file="/modules/footer.jsp"%>
</body>

</html>