<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ page import="java.util.HashSet, java.util.LinkedHashMap, java.util.Map, java.util.Set" %>
<!DOCTYPE html><html><head>
<meta charset="UTF-8">
<title>배송 상세 내역</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<link href="/resources/css/onlyTop.css" rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
    
    .container {
    	width: 54%;
    	margin: 0 auto;
    }	
	.product-info {
		flex: 1;
	    display: flex;
	    flex-direction: column; /* 세로 정렬 */
	}
	.product-name {
		font-size:19px;
	    font-weight: bold;
    	min-width: 350px; /* 최소 너비를 설정 */
	}
	.product-item {
	    border-bottom: 1px solid #ddd; /* 연한 회색의 선을 추가합니다 */
	    padding-bottom: 15px; /* 구분선과 컨텐츠 사이의 여백 */
	}
	.product-item:last-child {
	    margin-bottom: 0; /* 마지막 상품 아래의 공백을 없애거나 줄입니다 */
	}
	.header-item1 {
		padding-right: 70px;
	}
	.card {
        margin-bottom: 20px;
        padding: 15px; 
        border: 1px solid #ddd; /* 카드 테두리 색상 */
	    border-radius: 8px; /* 카드 모서리 둥글기 */  
    }
    .card-header {
     	background-color: #e0f4e2; /* 옅은 그린색 */
        font-weight: bold;
        font-size: 19px;
        display: flex;	
		justify-content: space-between;
		padding-left: 10px;
    }
	.unique-card1 {
	    border: none; /* 테두리 제거 */
	    box-shadow: none; /* 그림자 효과 제거 */
	    background: transparent;
	}
       .img-fluid {
           max-width: 100%;
           height: auto;
       }
       .h1reserve {
           margin: 20px;
       }
       .card-body p {
           margin: 0;
       }
       .orderbar {
           display: flex;
           align-items: center;
           gap: 50px; 
           font-size: 20px;
       }
       .orderbar1 {
           display: flex;
           align-items: center;
           gap: 5px;
           justify-content: space-between; 
       }
       .orderbar2 {
           display: flex;
           font-size: 16px;
       }
		.me-auto {
		    flex: 1; /* 상품 정보가 가능한 넓이를 차지하도록 설정 */
		}
      .btn-custom {
		  height: 40px; /* 버튼 높이 설정 */
		  justify-content: flex-end;
		  font-size: 18px; 
		  margin-left: auto;
      }
     .delivery-status {
		flex: 1;
	    text-align: center; /* 배송 상태 텍스트를 중앙 정렬 */
	    font-size: 18px;
	}
      .image-container {
         position: relative;
         width: 120px;
         height: auto;
         display: flex;
         flex-direction: column;
         align-items: center;
         justify-content: center;
         margin-right: 15px; /* 이미지와 상품명 사이의 간격 조절 */
     }
     .image-container img {
         width: 120px; /* 이미지의 너비를 맞추세요 */
         height: auto;
         display: block;
     }
	
	.order-number {
	    color: green;
	}

	.buyer-info-card .card-body {
	    padding: 13px; /* 카드 안쪽 여백 */
	    padding-bottom: 0;
	}
	.buyer-info-card .card-body p {
	    padding: 7px 0; /* 항목 사이의 여백 추가 */
	    display: flex;
	}
	.buyer-info-card .card-body .label {
	    width: 150px; /* 제목의 고정 폭 */
	    padding-left: 18px;
	    font-size: 17px;
	    font-weight: bold;
	}
	
	.buyer-info-card .card-body .value-box {
	    display: block;
	    padding: 5px 10px; /* 네모 칸의 여백 */
	    margin-left: 10px; /* 제목과 값 사이의 간격 */
	    border: 1px solid #ddd; /* 네모 칸의 테두리 */
	    border-radius: 7px; /* 네모 칸의 모서리 둥글기 */
	    background-color: #ffffff; /* 네모 칸의 배경색 */
	    word-wrap: break-word; /* 긴 텍스트 줄 바꿈 */
	    width: 500px; /* 네모 칸의 고정 폭 */
	    font-size: 16px;
	    box-sizing: border-box; /* 패딩과 테두리를 포함하여 폭 조정 */
    	white-space: normal; /* 텍스트 줄 바꿈 허용 */
	}
	.amount-highlight {
	    font-size: 1.8em; /* 글씨 크기를 키웁니다. 필요에 따라 조정 */
	    color: green; /* 텍스트 색상을 초록색으로 설정 */
	}
	.amount-detail {
		font-size: 17px;
	}
	.large-text {
   	 	font-size: 1.5em; /* 필요에 따라 크기 조정 */
	}
	.separator {
	    width: 1px; /* 선의 두께 */
	    background-color: #e0e0e0; /* 선의 색상 */
	    height: auto; /* 내용에 따라 자동 높이 조절 */
	}
	
 @media (max-width: 768px) {
 	.buyer-info-card .card-body .label {
	    padding-left: 8px;
	}
     .orderbar {
         flex-direction: column; /* 모바일에서 세로 레이아웃 */
         gap: 10px; /* 간격 줄이기 */
     }
     .orderbar1 {
         flex-direction: column; /* 모바일에서 세로 레이아웃 */
         align-items: flex-start; /* 좌측 정렬 */
     }
     .image-container {
         width: 100%; /* 모바일에서 이미지 너비를 100%로 설정 */
     }
     .image-container img {
         width: 60%; /* 모바일에서 이미지 너비를 100%로 설정 */
     }
    .product-info {
     	width: 100%; /* 모바일에서 상품 정보 컨테이너의 너비를 100%로 설정 */
    }
    .product-name {
        margin-bottom: 5px; /* 상품 이름 아래 여백 추가 */
        text-align: left; /* 모바일에서 좌측 정렬 */
        white-space: nowrap; /* 줄 바꿈 방지 */
    }
    .product-details {
        margin-bottom: 5px; /* 가격과 수량 아래 여백 추가 */
        text-align: left; /* 모바일에서 좌측 정렬 */
        white-space: nowrap; /* 줄 바꿈 방지 */
    }
    .me-auto {
        display: flex;
        flex-direction: column; /* 모바일에서 세로 레이아웃 유지 */
        align-items: flex-start; /* 좌측 정렬 */
    }
	.mobile-btn-container {
        width: 91%; /* 버튼 컨테이너의 너비를 100%로 설정 */
        display: flex; /* Flexbox를 사용하여 버튼을 배치 */
	    justify-content: center;
	    align-items: center; 
    }
    .mobile-btn-container .btn-custom {
        flex: 1; /* 버튼이 가로 방향으로 가능한 공간을 차지하도록 설정 */
        width: 40%; /* 버튼의 최대 너비를 50%로 제한하고 간격을 고려 */
        margin: 0; /* 버튼 사이의 여백 제거 */
        font-size: 16px; /* 버튼 폰트 사이즈 조정 */
    }
       .card-body.orderbar {
        flex-direction: column; /* 모바일에서는 세로 레이아웃 */
        align-items: flex-start; /* 왼쪽 정렬 */
    }
    .btn.btn-link {
    	justify-content: flex-end;
    }
	.buyer-info-card {
        padding-bottom: 0;
    }
    .buyer-info-card .card-body p {
        flex-direction: column; /* 모바일에서 세로 레이아웃 */
        align-items: flex-start; /* 좌측 정렬 */
    }
    .buyer-info-card .card-body .value-box {
        width: 100%; /* 모바일에서 네모 칸의 너비를 100%로 설정 */
        margin-left: 0; /* 제목과 값 사이의 간격 제거 */
        box-sizing: border-box; /* 패딩과 테두리 포함하여 너비 조정 */
        word-wrap: break-word; /* 긴 텍스트 줄 바꿈 */
        display: block; /* 블록 레벨 요소로 변경 */
        white-space: normal; /* 모바일에서 줄 바꿈 허용 */
    }
    .unique-card1 {
	    padding-bottom: 0;
	}
	.container {
    	width: 100%;
    	margin: 0 auto;
    }
}
</style>
</head>
<body class="nanum-gothic-regular">
<jsp:include page="/modules/header.jsp"></jsp:include>  
    <jsp:include page="/modules/onlyTop.jsp"></jsp:include>
<div class="container">
    <h1 class="h1reserve">배송 상세 내역</h1>
        <c:set var="merchantUid" value="${merchant_uid}" />
        <c:if test="${not empty groupedPayList}">
            <c:forEach var="entry" items="${groupedPayList}">
                <c:set var="orderNumber" value="${entry.key}" />
                <c:set var="orders" value="${entry.value}" />

                <!-- 주문 번호가 현재 요청된 merchant_uid와 일치하는 경우만 표시 -->
                <c:if test="${orderNumber == merchantUid}">
                    <!-- 주문일자와 주문번호 카드 (한 번만 표시) -->
                    <div class="row">
                        <div class="card mb-12 unique-card1">
                            <div class="card-body orderbar">
                                <div>
                                    <p>주문일자 <strong><fmt:formatDate value="${orders[0].paydate}" pattern="yyyy-MM-dd" /></strong></p>
                                </div>
                                <div>
                                    <p>주문번호 <strong style="color: #006400;">${orders[0].merchant_uid}</strong></p>
                                </div>
                                <div>
                                <p class="d-none d-md-table-cell"><strong>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${orders[0].rstate}</strong></p>
                                </div>
                            </div>
                        </div>
                    </div>

                   <!-- 상품 정보 카드 (하나의 카드 안에 모든 상품 정보 나열) -->
                <div class="row">
                    <div class="col-md-12 unique-card">
                        <div class="card">
                            <div class="card-header">
                                <div class="header-item">상품 정보</div>
                                <div class="header-item1 d-none d-md-table-cell">배송 상태</div>
                            </div>
                            <div class="card-body">
                                <!-- 상품 정보 리스트 -->
                                <div class="card-column">
                    <c:forEach var="pay" items="${orders}">
                        <div class="orderbar1 a-items-center mb-3 product-item">
                                  <c:if test="${not empty productMap[pay.code]}">
                                    <div class="image-container me-3">
                                        <img src="${pageContext.request.contextPath}/img/${productMap[pay.code].pimg}" 
                                             alt="${pay.name}" 
                                             class="img-fluid img-rounded"
                                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/default.jpg';" />
                                    </div>
                                </c:if>
                                <div class="product-info">
                                     
                                    <p class="product-name"><strong>${pay.name}</strong></p>
                                
                                <p class="product-details">
                                    <fmt:formatNumber value="${pay.unitPrice}" type="number" groupingUsed="true" />원 / 
                                    <fmt:formatNumber value="${pay.quantity}" type="number" groupingUsed="true" />개
                                </p>
                            </div>
                            <div class="me-auto">
                                <p class="delivery-status d-md-none">${pay.dstate}&nbsp
                                <c:choose>
        <c:when test="${pay.dstate == '배송중'}">
    <button id="button-${pay.paycode}" type="button" class="btn btn-success btn" onclick="updateDeliveryState('${pay.paycode}')">
        구매확정
    </button>
</c:when>
    </c:choose>
                                </p>
                            </div>
                            
                            <div class="d-none d-md-block delivery-status">
                                <p class="kk">${pay.dstate}</p>
                                <c:choose>
        <c:when test="${pay.dstate == '배송중'}">
    <button id="button-${pay.paycode}" type="button" class="btn btn-success btn mt-2" onclick="updateDeliveryState('${pay.paycode}')">
        구매확정
    </button>
</c:when>
    </c:choose>
                            </div>
                            
                            	
							
                            
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
                    <!-- 구매자 정보 카드 (한 번만 표시) -->
				<div class="row">
				    <div class="col-md-12 buyer-info-card">
				        <div class="card">
				            <div class="card-header">구매자 정보</div>
				            <div class="card-body">
				                <p><span class="label">주문자</span> <span class="value-box">${orders[0].buyer_name}</span></p>
				                <p><span class="label">연락처</span> <span class="value-box">${orders[0].buyer_tel}</span></p>
				                <p><span class="label">이메일</span> <span class="value-box">${orders[0].buyer_email}</span></p>
				                <p><span class="label">주소</span> <span class="value-box">${orders[0].buyer_postcode} ${orders[0].buyer_addr}</span></p>
				            </div>
				        </div>
				    </div>
				</div>
                    <!-- 주문 금액 상세 카드 (한 번만 표시) -->
                   <div class="row">
                        <div class="col-md-12 amount-detail">
                            <div class="card">
                                <div class="card-header">주문 금액 상세</div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <p>주문금액 <strong class="amount-highlight"><fmt:formatNumber value="${orders[0].amount}" type="number" groupingUsed="true" />원</strong></p>
                                            <p>결제 상품 수 <strong><span id="total-items" class="large-text">${totalItemCount}</span>개</strong></p>
                                        </div>
                                        <div class="col-md-6">
                                        	<p><strong >총 결제 금액 <span class="amount-highlight"><fmt:formatNumber value="${orders[0].amount}" type="number" groupingUsed="true" />원</span></strong></p>
                                            <p style="margin-top: 12px;">결제수단 <span id="payment-method">${orders[0].pay_method}</span></p> 
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="ms-3 orderbar2 flex-column a-items-end mobile-btn-container">
                  <a href="<c:choose>
                        <c:when test="${not empty paySearchKeyword}">${pageContext.request.contextPath}/pay/myPayList?page=${page}&word=${paySearchKeyword}</c:when>
                        <c:otherwise>${pageContext.request.contextPath}/pay/myPayList?page=${page}</c:otherwise></c:choose>" class="btn btn-success btn-custom">목록으로 가기</a>
              </div>
            </c:if>  
        </c:forEach>
    </c:if>
</div><br/><br/>
<jsp:include page="/modules/footer.jsp"></jsp:include>
<script>
    // JavaScript에서 totalItemCount 값을 직접 설정
    document.addEventListener("DOMContentLoaded", function() {
        const totalItemsElement = document.getElementById("total-items");
        if (totalItemsElement) {
            // 서버에서 전달한 총 결제 상품 수를 동적으로 삽입
            totalItemsElement.textContent = "${totalItemCount}";
        }
    });
    
    document.addEventListener("DOMContentLoaded", function() {
        var payMethodElement = document.getElementById('payment-method');
        var payMethod = payMethodElement.textContent.trim();

        var paymentNames = {
            'point': '카카오페이',
            'trans': '토스페이',
            'card': 'KG이니시스'
        };

        if (paymentNames[payMethod]) {
            payMethodElement.textContent = paymentNames[payMethod];
        }
    });
    
    
</script>

<script>
    function updateDeliveryState(paycode) {
        if (confirm("정말로 구매를 확정하시겠습니까?")) {
            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/pay/updateDeliveryState',
                data: {
                    paycode: paycode
                },
                success: function(response) {
                    // 구매 확정 후 UI 업데이트
                    alert('구매 확정이 완료되었습니다.');
                    location.reload(); // 페이지 새로고침

                },
                error: function(xhr, status, error) {
                    alert('구매 확정 중 오류가 발생했습니다.');
                }
            });
        }
    }
</script>
</body></html>