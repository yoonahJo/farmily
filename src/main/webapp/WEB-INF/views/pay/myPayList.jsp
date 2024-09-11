<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="/resources/css/onlyTop.css" rel="stylesheet"> 
<style>
html, body {
    height: 100%;
}

#wrapper {
    height: auto;
 	min-height: 100%;
  	padding-bottom: 185px;
  	
}

footer {
    height: 185px;
    position: relative;
    transform : translateY(-100%);
}

.order-block {
	border: 1px solid #ddd;
	border-radius: 7px;
	max-width: 1000px; 
	margin: 0 auto;
}

.order-header {
	border-bottom: 1px solid #ddd;
	padding-bottom: 10px;
	margin-bottom: 15px;
	width: 100%;
}

.paynum {
	font-size: 16px;
	text-align: right;
}

.pname {
	font-size: 19px;
	font-weight: bold;
}

#paySearchKeyword {
	width: 400px;
	margin-right: 10px;
}

@media (min-width: 320px) {
	#paySearchKeyword {
		max-width: 150px;
		margin-right: 10px;
	}
}

@media (min-width: 425px) {
	#paySearchKeyword {
		max-width: 250px;
		margin-right: 10px;
	}
}

@media (min-width: 768px) {
	#paySearchKeyword {
		max-width:400px;
		margin-right: 10px;
	}
}

.pagination .page-item.active .page-link {
	background-color: #19a26e;
    border-color: #19a26e;
    color: white;
}

.pagination .page-link {
	color: black;
}
</style>
</head>
<body class="nanum-gothic-regular" id="payList">
<div id="wrapper">
	<jsp:include page="/modules/header.jsp"></jsp:include>
    <jsp:include page="/modules/onlyTop.jsp"></jsp:include>
    
	<h1 class="mt-5 mb-5 text-center">주문내역</h1>
	<div class="container">

		<form id="searchForm" action="pay/myPayList" method="get">
			<div class="d-flex align-items-center justify-content-center mb-5">
				<input name="paySearchKeyword" type="search" class="form-control"
					id="paySearchKeyword" value="${paySearchKeyword}" />
				<button type="button" id="searchBtn" class="btn btn-secondary me-2" style="white-space: nowrap;">검색</button>
				<button type="button" id="allBtn" class="btn btn-secondary" style="white-space: nowrap;">전체</button>
			</div>
		</form>

		<c:set var="currentOrderNumber" value="" />
		<c:set var="orderStates" value="${orderStates}" />


		<c:choose>
			<c:when test="${empty payList}">
				<div class="text-center">
					<h3 class="mb-3">주문내역이 없습니다</h3>
					<a href="/product/list?ptype=곡물" class="btn btn-success btn-lg">상품보러 가기</a>
				</div>
			</c:when>
			<c:otherwise>

				<c:forEach var="pay" items="${payList}"> 
					<c:choose>
						<c:when test="${pay.merchant_uid ne currentOrderNumber}">
							<!-- 이전 주문 블록 닫기 -->
							<c:if test="${not empty currentOrderNumber}">
								</tbody>
								</table>
								<c:if test="${orderStates[currentOrderNumber] eq true}">
									<button type="button" class="btn btn-danger deleteBtn"
										data-merchant-uid="${currentOrderNumber}">주문내역삭제</button>
								</c:if>
	</div>
	<!-- 이전 order-block 닫기 -->
	</c:if>

	<!-- 새로운 주문 시작 -->
	<c:set var="currentOrderNumber" value="${pay.merchant_uid}" />
	<div class="order-block p-3 mb-3">
		<div class="order-header">
			<div class="d-flex justify-content-between align-items-center">
				<div class="fw-bold fs-5">
					<fmt:formatDate value="${pay.paydate}" pattern="yyyy.MM.dd"
						var="formattedDate" />
					${formattedDate} 주문
				</div>
				<div class="paynum d-none d-sm-block">주문번호: ${pay.merchant_uid}</div>
			</div>
			<a href="<c:choose>
                        <c:when test="${not empty paySearchKeyword}">${pageContext.request.contextPath}/pay/payDetail/${pay.merchant_uid}?page=${page}&word=${paySearchKeyword}</c:when>
                        <c:otherwise>${pageContext.request.contextPath}/pay/payDetail/${pay.merchant_uid}?page=${page}</c:otherwise></c:choose>"
            class="d-block mt-2 text-end text-decoration-none fs-5 fw-bold">배송정보확인</a>
		</div>
		<table class="w-100">
			<tbody>
				</c:when>
				</c:choose>

				<!-- 주문 아이템 -->
				<tr class="row m-3 p-2 bordr-1 border-bottom">
					<td class="col-12 col-sm-3 d-flex align-items-center justify-content-center"><img
						class="object-fit-cover w-75"
						src="${pageContext.request.contextPath}/resources/img/${pay.pimg}"
						alt="${pay.name}" /></td>
					<td class="col-12 col-sm-6 mt-2 mt-sm-0 d-flex align-items-center">
						<div class="product-details">
							<div class="pname">${pay.name}</div>
							<div class="fs-5">
								<fmt:formatNumber value="${pay.unitPrice * pay.quantity}"
									pattern="#,###" />
								원 - ${pay.quantity}개
							</div>
							<button type="button" class="btn text-dark border-0 p-0 mt-2 mb-2 fs-6 btn_rebuy" data-pcode="${pay.code}" data-pcount="${pay.quantity}">재구매 하기</button>
						</div>
					</td>
					<td class="col-12 col-sm-3 d-flex align-items-center">
							<div class="mb-3 fw-bold fs-5">
								<c:choose>
									<c:when test="${pay.dstate ne '배송완료'}">${pay.rstate}</c:when>
									<c:otherwise>${pay.dstate}</c:otherwise>
								</c:choose>
							</div>
							
							
							
						
					</td>
					
				</tr>
				
				</c:forEach>

				<!-- 마지막 주문 블록 닫기 -->
				<c:if test="${not empty currentOrderNumber}">
			</tbody>
		</table>
		<c:if test="${orderStates[currentOrderNumber] eq true}">
			<button type="button" class="btn btn-danger deleteBtn"
				data-merchant-uid="${currentOrderNumber}">주문내역삭제</button>
		</c:if>
	</div>
	<!-- 마지막 order-block 닫기 -->

	</c:if>


	
	<div class="container mt-5 mb-5">
			<section id="pageList" class="pagination justify-content-center">
				<ul class="pagination pagination">
					<!-- 이전 페이지 링크 -->
					<c:if test="${pageInfo.startPage > 5}">
						<li class="page-item">
						<a class="page-link" href="<c:choose>
                        <c:when test="${not empty paySearchKeyword}">/pay/myPayList?page=1&word=${paySearchKeyword}</c:when>
                        <c:otherwise>/pay/myPayList?page=1</c:otherwise></c:choose>" aria-label="Previous"> <span aria-hidden="true">《</span>
						</a></li>
						
						<li class="page-item">
						<a class="page-link" href="<c:choose>
                        <c:when test="${not empty paySearchKeyword}">/pay/myPayList?page=${pageInfo.startPage - 1}&word=${paySearchKeyword}</c:when>
                        <c:otherwise>/pay/myPayList?page=${pageInfo.startPage - 1}</c:otherwise></c:choose>" aria-label="Previous"> <span aria-hidden="true">〈</span>
						</a>
						</li>
					</c:if>
					
					<!-- 페이지 번호 링크 -->
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<li class="page-item ${i == pageInfo.page ? 'active' : ''}">
						<a class="page-link"href="<c:choose>
                        <c:when test="${not empty paySearchKeyword}">/pay/myPayList?page=${i}&word=${paySearchKeyword}</c:when>
                        <c:otherwise>/pay/myPayList?page=${i}</c:otherwise></c:choose>">${i}</a>
						</li>
					</c:forEach>
					
					<!-- 다음 페이지 링크 -->
					<c:if test="${pageInfo.endPage < pageInfo.maxPage}">
						<li class="page-item"><a class="page-link" href="<c:choose>
                        	<c:when test="${not empty paySearchKeyword}">/pay/myPayList?page=${pageInfo.endPage + 1}&word=${paySearchKeyword}</c:when>
                        	<c:otherwise>/pay/myPayList?page=${pageInfo.endPage + 1}</c:otherwise>
                    	</c:choose>"aria-label="Next"> <span aria-hidden="true">〉</span></a>
                    	</li>
                    	
                    	<li class="page-item"><a class="page-link" href="<c:choose>
                        	<c:when test="${not empty paySearchKeyword}">/pay/myPayList?page=${pageInfo.maxPage}&word=${paySearchKeyword}</c:when>
                        	<c:otherwise>/pay/myPayList?page=${pageInfo.maxPage}</c:otherwise>
                    	</c:choose>"aria-label="Next"> <span aria-hidden="true">》</span></a>
                    	</li>
					</c:if>
				</ul>
			</section>
			
			</c:otherwise>
			</c:choose>
		</div>
	</div>
	
		
	<!-- 삭제 확인 모달 -->
	<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="deleteConfirmModalLabel">주문내역 삭제</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>주문번호: <span id="deleteOrderNumber"></span></p>
					<p>주문내역을 삭제하시겠습니까?</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#finalDeleteConfirmModal">삭제</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 최종 삭제 확인 모달 -->
	<div class="modal fade" id="finalDeleteConfirmModal" tabindex="-1" aria-labelledby="finalDeleteConfirmModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="finalDeleteConfirmModalLabel">주문내역 삭제</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>함께 결제된 상품은 전체 삭제되며 복구할 수 없습니다.</p>
					<p>정말 삭제하시겠습니까?</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-danger" id="confirmDeleteBtn">삭제</button>
				</div>
			</div>
		</div>
	</div>
		</div>
<%@ include file="/modules/footer.jsp"%>
	<script>
	$(document).ready(function() {
		var merchantUidDelete = null;
		
		// 삭제 버튼 클릭 시 첫 번째 모달 표시
		function payDelete(merchant_uid) {
			merchantUidDelete = merchant_uid;
			$('#deleteOrderNumber').text(merchant_uid); // 주문번호 표시
			$('#deleteConfirmModal').modal('show');
		}

		// 주문내역 삭제 버튼 클릭
		$(document).on('click', '.deleteBtn', function() {
			var merchantUid = $(this).data('merchantUid'); // 버튼에서 merchantUid 가져오기
			payDelete(merchantUid);
		});

		// 최종 삭제 확인 모달의 삭제 버튼 클릭
		$('#confirmDeleteBtn').on('click', function() {
			if (merchantUidDelete) {
				var page = ${page};
	            var paySearchKeyword = $('#paySearchKeyword').val().trim();
	            var queryParams = $.param({word: paySearchKeyword});
	            var url = '/pay/delete/' + merchantUidDelete + '?page=' + page;
	            if (paySearchKeyword) {
	                url += '&' + queryParams;
	            }
	            window.location.href = url;
	        }
	    });
	
		// 검색 기능
			$('#searchBtn').click(function(event) {
            	event.preventDefault();
				var paySearchKeyword = $('#paySearchKeyword').val().trim();
				var queryParams = $.param({
					word : paySearchKeyword
				});
				var url = '/pay/myPayList?' + queryParams;

				history.pushState(null, '', url);

				$.ajax({
					url : url,
					type : 'get',
					dataType : 'html',
					success : function(response) {
						$('#payList').html(response);
					},
					error : function(xhr, status, error) {
						console.error('AJAX Error:', status, error);
					}
				});
			});

			$('#paySearchKeyword').keypress(function(event) {
				if (event.which === 13) {
					event.preventDefault();
					$('#searchBtn').click();
				}
			});
			// 전체보기 버튼 클릭 시
			$('#allBtn').on('click', function() {
				var url = '/pay/myPayList';
				history.pushState(null, '', url);
				location.href = url;
			});
		});
	
	
	// 재구매 시 이전 구매 수량 가지고 장바구니로
	$(document).ready(function() {
    // 재구매 버튼 클릭 시
    $(document).on('click', '.btn_rebuy', function() {
        var productCode = $(this).data('pcode');
        var productCount = $(this).data('pcount');

        $.ajax({
            type: 'POST',
            url: '/reserve/insert',
            contentType: 'application/json',
            data: JSON.stringify({
                pcode: productCode,
                pcount: productCount
            }),
            success: function(response) {
                location.href = "/reserve/list";
            },
            error: function(xhr, status, error) {
                // 에러 처리
                alert('장바구니에 추가하는 도중 오류가 발생했습니다.');
            }
        });
    });
});

	
	</script>

	
</body>
</html>