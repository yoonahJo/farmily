<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.spring.farmily.reserve.model.admin.PageInfo"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
@media (max-width: 768px) {
            /* 상품종류, 가격, 등급 열 숨기기 */
            .table th:nth-child(3),
            .table td:nth-child(3),
            .table th:nth-child(5),
            .table td:nth-child(5) {
                display: none;
            }
}
</style>

<script>
	function searchProduct() {
		var searchKeyword = document.getElementById('searchKeyword').value
				.trim().toLowerCase();

		var searchCondition = document.getElementById('searchCondition').value
				.toLowerCase();
		var productList = document.querySelectorAll('#productList tr');

		productList.forEach(function(row) {
			var pcode = row.querySelector('td:nth-child(1)').textContent.trim()
					.toLowerCase();
			var pname = row.querySelector('td:nth-child(2)').textContent.trim()
					.toLowerCase();

			if ((searchCondition === 'pcode' && pcode.includes(searchKeyword))
					|| (searchCondition === 'pname' && pname
							.includes(searchKeyword))) {
				row.style.display = ''; // 검색어가 포함된 항목은 보이기
			} else {
				row.style.display = 'none';
			}
		});
	}
	
	function filterProductsByType(type) {
		var productList = document.querySelectorAll('#productList tr');

		productList.forEach(function(row) {
			var ptype = row.querySelector('td:nth-child(3)').textContent.trim().toLowerCase();

			if (type === '전체' || ptype === type.toLowerCase()) {
				row.style.display = ''; // 선택된 품목에 해당하는 항목은 보이기
			} else {
				row.style.display = 'none';
			}
		});
	}
	
	document.addEventListener('DOMContentLoaded', function() {
		document.getElementById('grainButton').addEventListener('click', function() {
			filterProductsByType('곡물');
		});
		document.getElementById('vegetableButton').addEventListener('click', function() {
			filterProductsByType('채소');
		});
		document.getElementById('allButton').addEventListener('click', function() {
	        filterProductsByType('전체');
	    });
	});
</script>


</head>
<body class="nanum-gothic-regular">
	<div class="modal fade" id="productModal" tabindex="-1"
		aria-labelledby="productModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="productModalLabel">상품 목록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>


				<div class="modal-body">
					<form id="searchForm" action="/admin/reserve/productList"
						method="get">
						<div class="input-group mb-5">
							<select name="searchCondition" class="form-select"
								id="searchCondition">
								<option value="PCODE">상품코드</option>
								<option value="PNAME">상품이름</option>
							</select> <input name="searchKeyword" type="text" class="form-control"
								id="searchKeyword" />
							<button type="button" class="btn btn-secondary"
								onclick="searchProduct()">검색</button>
							<ul id="productSearchResults" class="list-group mt-3">

							</ul>
						</div>
					</form>
					
					<button type="button" id="grainButton" class="btn btn-outline-secondary">곡물</button>
					<button type="button" id="vegetableButton" class="btn btn-outline-secondary">채소</button>
					<button type="button" id="allButton" class="btn btn-outline-secondary">전체</button>
					
					<table class="table">
						<thead>
							<tr>
								<th>상품번호</th>
								<th>상품이름</th>
								<th>상품품목</th>
								<th>가격</th>
								<th>농장이름</th>
								<th>선택</th>
								<th style="display: none;">상품이미지</th>
							</tr>
						</thead>

						<tbody id="productList">
							<c:forEach items="${productList}" var="product">
								<tr>
									<td>${product.pcode}</td>
									<td>${product.pname}</td>
									<td>${product.ptype}</td>
									<td><fmt:formatNumber value="${product.price}"
											pattern="#,###" /></td>
									<td>${product.fname}</td>
									<td><button type="button"
											class="btn btn-secondary select-btn"
											data-product-pcode="${product.pcode}"
											data-product-pname="${product.pname}"
											data-product-price="${product.price}"
											data-product-fname="${product.fname}"
											data-product-pimg="${product.pimg}">선택</button></td>
									<td style="display: none;">${product.pimg}</td>
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