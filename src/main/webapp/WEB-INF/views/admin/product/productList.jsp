<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>   
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <title>Admin :: 상품관리</title>
    <script>
        // 전체 선택/해제 스크립트
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
    <style>
    
     /* 체크박스 관련  */
    input[type="checkbox"] {
    width: 20px;
    height: 20px;
    accent-color: gray; 
}

.table td:first-child,
.table th:first-child  {
    text-align: center; /
    vertical-align: middle; 
}
    
    
    .page-item.active .page-link {
    background-color: #d0d0d0;
    border-color: #d0d0d0;
    color: black; /* 원하는 텍스트 색상 */
	}
	.page-link {
	color: black;
	}


    
  
    
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
     .table {
    table-layout: fixed;
    width: 100%;
}  


.table th,
.table td {
    white-space: nowrap;
    overflow: hidden;
  
    padding: 8px 10px;
}

/* 각 열에 고정된 너비 설정 */
.table th:first-child, 
.table td:first-child {
    width: 4%; /* 전체 선택 체크박스 */
}

.table th:nth-child(2), 
.table td:nth-child(2) {
    width: 11%; /* 상품코드 */
}

.table th:nth-child(3), 
.table td:nth-child(3) {
    width: 9%; /* 농장이름 */
}

.table th:nth-child(4), 
.table td:nth-child(4) {
    width: 23%; /* 상품명 */
}

.table th:nth-child(5), 
.table td:nth-child(5) {
    width: 9%; /* 품종 */
}

.table th:nth-child(6), 
.table td:nth-child(6) {
    width: 9%; /* 가격 */
}

.table th:nth-child(7), 
.table td:nth-child(7) {
    width: 9%; /* 품질 */
}   
.table th:nth-child(8), 
.table td:nth-child(8) {
    width: 5%; /* 품질 */
}   


@media (max-width: 768px) {
            /* 상품종류, 가격, 등급 열 숨기기 */
            .table th:nth-child(3), 
            .table td:nth-child(3),
            .table th:nth-child(5), 
            .table td:nth-child(5),
            .table th:nth-child(6), 
            .table td:nth-child(6),
            .table th:nth-child(7), 
            .table td:nth-child(7),
            .table th:nth-child(8), 
            .table td:nth-child(8) {
                display: none;
            }
        }
        
        @media (max-width: 768px) {
           #allBtn {
                display: none;
            }
        }
    </style>
    
</head>
<body class="nanum-gothic-regular">
<%@ include file="/modules/aheader.jsp"%>
<div class="container mt-5">
    <h2 class="page-title">상품관리</h2>
    
   
    <form id="searchForm" action="/admin/product" method="get">
    <div class="d-flex align-items-center">
        <div class="input-group" style="flex-wrap: nowrap;">
            <select name="searchCondition" class="form-select" id="searchCondition" style="max-width: 150px;">
                  <option value="pname" ${searchCondition == 'pname' ? 'selected' : ''}>상품명</option>
                    <option value="fname" ${searchCondition == 'fname' ? 'selected' : ''}>농장이름</option>
                    <option value="id" ${searchCondition == 'id' ? 'selected' : ''}>아이디</option>
            </select>
            <input type="search" class="form-control" id="searchKeyword" name="searchKeyword" value="${searchKeyword}" placeholder="검색어를 입력하세요">
            <button type="submit" id="searchBtn" class="btn btn-secondary">검색</button>
        </div>

        <button type="button" id="allBtn" class="btn btn-secondary ms-3" style="white-space: nowrap;" onclick="location.href='/admin/product';">전체</button>
    </div>
</form>
   
    <div class="d-flex justify-content-between mb-4 mt-4">
        
        <form id="deleteForm" action="${pageContext.request.contextPath}/admin/product/deleteMultiple" method="post" onsubmit="return validateForm();">
            <input type="hidden" name="page" value="${page}" />
            <input type="hidden" name="searchCondition" value="${searchCondition}" />
            <input type="hidden" name="searchKeyword" value="${searchKeyword}" />
            <button type="submit" class="btn btn-secondary">일괄 삭제</button>
        </form>
        
        
      <!--   <a href="${pageContext.request.contextPath}/admin/product/insertPage" class="btn btn-secondary">상품등록</a>-->
    </div>
    
   <table class="table table-bordered table-hover">
    <thead>
        <tr>
            <th><input type="checkbox" onClick="toggle(this)" /></th>
            <th>상품코드</th>   
            <th>농장이름</th>            
            <th>상품명</th>
            <th>품종</th>
            <th>가격</th>
            <th>품질</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="product" items="${allProducts}">
         
            <tr>
            
                <td>
                
                <input type="checkbox" name="pcode" value="${product.pcode}" form="deleteForm" /></td>
                <td>
                <a href="/admin/product/detail/${product.pcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" style="display: block; color: inherit; text-decoration: none;">
                ${product.pcode}</a></td>
                <td><a href="/admin/product/detail/${product.pcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" style="display: block; color: inherit; text-decoration: none;">
                ${product.fname}</a></td>
                <td>
                  
                    <a href="/admin/product/detail/${product.pcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" style="display: block; color: inherit; text-decoration: none; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                        ${product.pname}
                    </a>
                </td>
                <td><a href="/admin/product/detail/${product.pcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" style="display: block; color: inherit; text-decoration: none;">
                ${product.ptype}</a></td>
                <td><a href="/admin/product/detail/${product.pcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" style="display: block; color: inherit; text-decoration: none;">
                <fmt:formatNumber value="${product.price}" pattern="#,###" />원</a></td>
                <td><a href="/admin/product/detail/${product.pcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" style="display: block; color: inherit; text-decoration: none;">
                ${product.quality}</a></td>
                <td>
                 <!--  <a href="${pageContext.request.contextPath}/admin/product/updatePage/${product.pcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" class="btn btn-outline-secondary btn-sm">수정</a>-->
   				 <a href="${pageContext.request.contextPath}/admin/product/delete/${product.pcode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" class="btn btn-outline-secondary" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
    <jsp:include page="/modules/adminPPagination.jsp" flush="true" />
</div>
<%@ include file="/modules/footer.jsp"%>
</body>
</html>
</html>