<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>Farmer :: 주문관리</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
.custom-order-summary {
	display: flex;
	gap: 1rem;
	padding: 1rem;
	flex-wrap: nowrap;
	overflow-x: auto;
	width: 100%;
	box-sizing: border-box;
}
.card {
    width: 100%;
    max-width: 100%;
    border: 1px solid #dee2e6;
    border-radius: 8px;
}
.summary-card {
	flex: 1;
	min-width: 130px;
	border: 1px solid #dee2e6;
	border-radius: 8px;
	padding: 1rem;
	text-align: center;
	box-sizing: border-box;
	height: 70px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
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

.table th, .table td {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	padding: 8px 10px;
}

/* 각 열에 고정된 너비 설정 */
.table th:first-child, .table td:first-child {
	width: 5%; /* 전체 선택 체크박스 */
}

.table th:nth-child(2), .table td:nth-child(2) {
	width: 8%; /* 결제 코드 */
}

.table th:nth-child(3), .table td:nth-child(3) {
	width: 10%; /* 구매자 ID */
}

.table th:nth-child(4), .table td:nth-child(4) {
	width: 10%; /* 상품 코드 */
}

.table th:nth-child(5), .table td:nth-child(5) {
	width: 28%; /* 상품 이름 */
}

.table th:nth-child(6), .table td:nth-child(6) {
	width: 10%; /* 결제 금액 */
}

.table th:nth-child(7), .table td:nth-child(7) {
	width: 5%; /* 수량 */
}

.table th:nth-child(8), .table td:nth-child(8) {
	width: 10%; /* 결제 상태 */
}

.table th:nth-child(9), .table td:nth-child(9) {
	width: 10%; /* 배송 상태 */
}

.table th:nth-child(10), .table td:nth-child(10) {
	width: 10%; /* 배송 날짜 */
}

.table th:nth-child(11), .table td:nth-child(11) {
	width: 10%; /* 배송 처리 */
}
/* 체크박스 색상 변경 */

/* 모바일 버전 (화면 너비 768px 이하일 때)에서 특정 열 숨기기 */
@media ( max-width : 768px) {
	/* 상품종류, 가격, 등급 열 숨기기 */
	.table th:nth-child(4), .table td:nth-child(4), .table th:nth-child(5),
		.table td:nth-child(5), .table th:nth-child(6), .table td:nth-child(6),
		.table th:nth-child(7), .table td:nth-child(7), .table th:nth-child(8),
		.table td:nth-child(8), .table th:nth-child(10), .table td:nth-child(10), .table th:nth-child(11), .table td:nth-child(11)
		{
		display: none;
	}
}

input[type="checkbox"] {
	width: 20px;
	height: 20px;
	accent-color: #19a26e; /* 체크박스 색상 (체크 시) */
}

.table td:first-child, .table th:first-child {
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

@media ( max-width : 768px) {
	#allBtn {
		display: none;
	}
	
	.custom-order-summary {
        display: flex;
        flex-wrap: wrap;
        gap: 0.5rem;
        width: 100%;
        padding: 0.5rem;
    }

    .summary-card {
        flex: 1 1 calc(50% - 1rem);
        box-sizing: border-box;
        min-width: 0;
        padding: 0.5rem;
        height: 50px;
    }
    
    .summary-card h5 {
        font-size: 0.9rem; /* 제목 글자 크기 줄이기 */
    }

    .summary-card .value {
        font-size: 0.8rem; /* 값 글자 크기 줄이기 */
    }
}
</style>
<script>
        function toggle(source) {
            checkboxes = document.getElementsByName('paycode');
            for (var i = 0; i < checkboxes.length; i++) {
                checkboxes[i].checked = source.checked;
            }
        }
        
        function validateForm() {
            const checkboxes = document.querySelectorAll('input[name="paycode"]:checked');
            const paycodes = Array.from(checkboxes).map(checkbox => checkbox.value);

            if (paycodes.length > 0) {
                if (confirm('선택한 항목의 배송 상태를 변경하시겠습니까?')) {
                    // AJAX로 선택된 항목들 처리
                    $.ajax({
                        type: 'POST',
                        url: '${pageContext.request.contextPath}/farm/pay/updateMultipleDeliveryStates', 
                        data: {
                            paycodes: paycodes.join(','),  // 선택된 paycode들을 콤마로 구분
                            newDstate: '배송중'
                        },
                        success: function(response) {
                            alert('선택한 항목의 배송 상태가 업데이트되었습니다.');
                            location.reload(); // 페이지 새로고침
                            // 선택된 체크박스 항목들의 배송 상태를 업데이트
                            paycodes.forEach(function(paycode) {
                                $('#dstate-' + paycode).text('배송중');
                                $('#button-' + paycode).prop('disabled', true).text('배송중');
                            });
                        },
                        error: function(error) {
                            alert('배송 상태 업데이트 중 오류가 발생했습니다.');
                        }
                    });
                }
            } else {
                alert('항목을 선택해주세요.');
            }
            return false;  // 폼 제출을 막음
        }
    </script>
<script>
    function updateDeliveryStateFromList(paycode, newDstate, page, searchKeyword) {
        if (confirm('해당 상품을 배송중으로 처리하시겠습니까?')) {
            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/farm/pay/updateDeliveryStateFromList', 
                data: {
                    paycode: paycode,
                    newDstate: newDstate,
                    page: page,
                    searchKeyword: searchKeyword
                },
                success: function(response) {
                    alert('배송 상태가 업데이트되었습니다.');
                    location.reload(); // 페이지 새로고침
                    // 해당 행의 배송 상태를 업데이트
                    $('#dstate-' + paycode).text(newDstate);
                    $('#button-' + paycode).prop('disabled', true).text(newDstate);  // 버튼 비활성화 및 상태 표시 변경
                },
                error: function(error) {
                    alert('배송 상태 업데이트 중 오류가 발생했습니다.');
                }
            });
        }
    }
</script>
</head>
<body class="nanum-gothic-regular">
	<jsp:include page="/modules/farmerHeader.jsp" flush="false" />

	<div class="container mt-5">
		<h2 class="page-title">주문관리</h2>

		<div class="d-flex justify-content-between align-items-center mb-4">
			<div class="custom-order-summary">
				<div class="card">
					<div class="card-body">
						<strong>주문 현황 <c:if test="${preparingCount > 0}">
								<span class="text-danger">(미발송상품이 있습니다.)</span>
							</c:if>
						</strong>
						<div class="custom-order-summary">
							<div class="summary-card">
								<h5 style="font-weight: bold;">배송준비중</h5>
								<div class="value">${preparingCount}건</div>
							</div>
							<div class="summary-card">
								<h5 style="font-weight: bold;">배송중</h5>
								<div class="value">${shippingCount}건</div>
							</div>
							<div class="summary-card">
								<h5 style="font-weight: bold;">배송완료</h5>
								<div class="value">${completedCount}건</div>
							</div>
							<div class="summary-card">
								<h5 style="font-weight: bold;">결제완료</h5>
								<div class="value">${preparingCount+shippingCount+completedCount}건</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
		<!-- 검색 폼 -->
		<form action="${pageContext.request.contextPath}/farm/pay"
			method="get" class="mb-4">
			<div class="d-flex align-items-center">
				<div class="input-group" style="flex-wrap: nowrap;">
					<select name="searchCondition" class="form-select"
						style="max-width: 150px;">
						<option value="name"
							${searchCondition == 'name' ? 'selected' : ''}>상품명</option>
						<option value="id" ${searchCondition == 'id' ? 'selected' : ''}>구매자ID</option>
						<option value="code"
							${searchCondition == 'code' ? 'selected' : ''}>상품코드</option>
					</select> <input type="text" name="searchKeyword" value="${searchKeyword}"
						class="form-control" placeholder="검색어를 입력하세요.">
					<button type="submit" class="btn btn-success">검색</button>
				</div>
				<button type="button" id="allBtn" class="btn btn-success ms-3"
					style="white-space: nowrap;" onclick="location.href='/farm/pay';">전체보기</button>
			</div>
		</form>

		<!-- 배송 상태 변경 폼 -->
		<div class="d-flex justify-content-between mb-4">
			<button type="button" class="btn btn-success btn-sm"
				onclick="validateForm()">일괄배송처리</button>
		</div>

		<!-- 결제 내역 리스트 테이블 -->
		<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th><input type="checkbox" onClick="toggle(this)" /></th>
					<th>주문코드</th>
					<th>구매자ID</th>
					<th>상품코드</th>
					<th>상품이름</th>
					<th>결제금액</th>
					<th>수량</th>
					<th>결제상태</th>
					<th>배송상태</th>
					<th>배송날짜</th>
					<th>배송처리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="pay" items="${farmPayList}">
					<tr>
						<td><c:if test="${pay.dstate == '배송준비중'}">
								<input type="checkbox" name="paycode" value="${pay.paycode}"
									onclick="event.stopPropagation();" />
							</c:if></td>
						<td><a
							href="${pageContext.request.contextPath}/farm/pay/farmPayDetail/${pay.paycode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}"
							style="display: block; color: inherit; text-decoration: none;"
							onclick="event.stopPropagation();"> ${pay.paycode}</a></td>
						<td><a
							href="${pageContext.request.contextPath}/farm/pay/farmPayDetail/${pay.paycode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}"
							style="display: block; color: inherit; text-decoration: none; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"
							onclick="event.stopPropagation();"> ${pay.id}</a></td>
						<td><a
							href="${pageContext.request.contextPath}/farm/pay/farmPayDetail/${pay.paycode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}"
							style="display: block; color: inherit; text-decoration: none;"
							onclick="event.stopPropagation();"> ${pay.code}</a></td>
						<td><a
							href="${pageContext.request.contextPath}/farm/pay/farmPayDetail/${pay.paycode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}"
							style="display: block; color: inherit; text-decoration: none; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"
							onclick="event.stopPropagation();"> ${pay.name}</a></td>
						<td><a
							href="${pageContext.request.contextPath}/farm/pay/farmPayDetail/${pay.paycode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}"
							style="display: block; color: inherit; text-decoration: none;"
							onclick="event.stopPropagation();"> <fmt:formatNumber
									value="${pay.amount}" pattern="#,###" /></a></td>
						<td><a
							href="${pageContext.request.contextPath}/farm/pay/farmPayDetail/${pay.paycode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}"
							style="display: block; color: inherit; text-decoration: none;"
							onclick="event.stopPropagation();"> ${pay.quantity}</a></td>
						<td><a
							href="${pageContext.request.contextPath}/farm/pay/farmPayDetail/${pay.paycode}?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}"
							style="display: block; color: inherit; text-decoration: none;"
							onclick="event.stopPropagation();"> ${pay.rstate}</a></td>
							<td>${pay.dstate}</td>



					

						<td><c:choose>
								<c:when test="${not empty pay.baesongdate}">
									<fmt:formatDate value="${pay.baesongdate}" pattern="yyyy-MM-dd" />
								</c:when>
								<c:otherwise>
                                    -
                                </c:otherwise>
							</c:choose></td>
								<!-- 배송 처리 버튼 -->
						<td><c:choose>
								<c:when test="${pay.dstate == '배송준비중'}">
									<button id="button-${pay.paycode}" type="button"
										class="btn btn-success btn-sm"
										onclick="updateDeliveryStateFromList('${pay.paycode}', '배송중', '${param.page}', '${param.searchKeyword}')">
										배송처리</button>
								</c:when>
								<c:when test="${pay.dstate == '배송중'}">
									<button id="button-${pay.paycode}"
										class="btn btn-success btn-sm" disabled>처리완료</button>
								</c:when>
								<c:when test="${pay.dstate == '배송완료'}">
									<button id="button-${pay.paycode}"
										class="btn btn-success btn-sm" disabled>처리완료</button>
								</c:when>
								<c:otherwise>
									<button class="btn btn-light btn-sm" disabled>${pay.dstate}</button>
								</c:otherwise>
							</c:choose></td>
					</tr>
				</c:forEach>

				<!-- 결제 내역이 없을 경우 -->
				<c:if test="${empty farmPayList}">
					<tr>
						<td colspan="10">결제 내역이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		</form>

		<!-- 페이징 처리 -->
		<jsp:include page="/modules/farmpayPagination.jsp" flush="true" />
	</div>

</body>
<%@ include file="/modules/footer.jsp"%>
</html>