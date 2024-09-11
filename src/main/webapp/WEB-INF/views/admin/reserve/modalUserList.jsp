<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@media (max-width: 768px) {
            /* 상품종류, 가격, 등급 열 숨기기 */
            .table th:nth-child(4),
            .table td:nth-child(4) {
                display: none;
            }
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function searchUser() {
    var searchKeyword = document.getElementById('UserSearchKeyword').value.trim().toLowerCase(); 

    var searchCondition = document.getElementById('userSearchCondition').value.toLowerCase();
    var userList = document.querySelectorAll('#userList tr');
    
    userList.forEach(function(row) {
        var id = row.querySelector('td:nth-child(1)').textContent.trim().toLowerCase(); 
        var uname = row.querySelector('td:nth-child(2)').textContent.trim().toLowerCase(); 
        
        if ((searchCondition === 'id' && id.includes(searchKeyword)) || 
            (searchCondition === 'uname' && uname.includes(searchKeyword))) {
            row.style.display = ''; // 검색어가 포함된 항목은 보이기
        } else {
            row.style.display = 'none'; 
        }
    });
}

function filterUserByType(type) {
    var userList = document.querySelectorAll('#userList tr');

    userList.forEach(function(row) {
        var ptype = row.querySelector('td:nth-child(5)').textContent.trim();

        if (type === '전체' || ptype === type) {
            row.style.display = ''; // 선택된 품목에 해당하는 항목은 보이기
        } else {
            row.style.display = 'none';
        }
    });
}

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('clientBtn').addEventListener('click', function() {
        filterUserByType('고객');
    });
    document.getElementById('farmerBtn').addEventListener('click', function() {
        filterUserByType('농부');
    });
    document.getElementById('allBtn').addEventListener('click', function() {
        filterUserByType('전체');
    });
});
</script>
</head>
<body class="nanum-gothic-regular">
	<div class="modal fade" id="userModal" tabindex="-1"
		aria-labelledby="userModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="productModalLabel">회원 목록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">

					<form id="searchForm" action="/admin/reserve/userList"
						method="get">
						<div class="input-group mb-5">
							<select name="userSearchCondition" class="form-select"
								id="userSearchCondition">
								<option value="ID">회원아이디</option>
								<option value="UNAME">회원이름</option>
							</select> <input name="UserSearchKeyword" type="text" class="form-control"
								id="UserSearchKeyword" />
							<button type="button" class="btn btn-secondary" onclick="searchUser()">검색</button>
						</div>
					</form>
					
					<button type="button" id="clientBtn" class="btn btn-outline-secondary">고객</button>
					<button type="button" id="farmerBtn" class="btn btn-outline-secondary">농부</button>
					<button type="button" id="allBtn" class="btn btn-outline-secondary">전체</button>
					
					<table class="table">
						<thead>
							<tr>
								<th>아이디</th>
								<th>이름</th>
								<th>전화번호</th>
								<th>주소</th>
								<th>분류</th>
								<th>선택</th>
							</tr>
						</thead>
						<tbody id="userList">
							<c:forEach items="${userList}" var="user">
								<tr>
									<td>${user.id}</td>
									<td>${user.uname}</td>
									<td>${user.phone}</td>
									<td>(${user.uzcode}) ${user.uaddress}</td>
									<td>
										<c:choose>
                            			<c:when test="${fn:trim(fn:substring(String.valueOf(user.role), 0, 1)) == 'C'}">고객</c:when>
        								<c:when test="${fn:trim(fn:substring(String.valueOf(user.role), 0, 1)) == 'F'}">농부</c:when>
        								<c:when test="${fn:trim(fn:substring(String.valueOf(user.role), 0, 1)) == 'A'}">admin</c:when>
                            			<c:otherwise>알 수 없음</c:otherwise>
                        				</c:choose>
									</td>
									<td><button type="button"
											class="btn btn-secondary select-btn" data-user-uid="${user.id}"
											data-user-uname="${user.uname}"
											data-user-phone="${user.phone}"
											data-user-uzcode="${user.uzcode}"
											data-user-uaddress="${user.uaddress}">선택</button></td>
								</tr>

							</c:forEach>
						</tbody>
					</table>


				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>