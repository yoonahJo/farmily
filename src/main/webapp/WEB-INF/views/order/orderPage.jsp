<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문/결제</title>
    <style>
    .payment-radio {
            accent-color: #000;
   	}
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/resources/css/orderPageCSS.css">
    <link href="/resources/css/onlyTop.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="./reserve/address.js"></script>
    
</head>
<body class="nanum-gothic-regular">
    <jsp:include page="/modules/header.jsp"></jsp:include>  
    <jsp:include page="/modules/onlyTop.jsp"></jsp:include>
    <div class="container">
        <div class="stepcontainer">
            <h1 class="h1reserve">주문/결제</h1>
            <ul class="stepul">
                <li class="stepli d-none d-md-table-cell">① 장바구니</li>
                <li class="stepli d-none d-md-table-cell">② 결제서</li>
                <li class="stepli d-none d-md-table-cell">③ 결제완료</li>
            </ul>
        </div>
        <hr/>
        <!-- 주문 정보와 사용자 정보 컨테이너 -->
        <div class="content-container">
            <!-- 주문 정보 테이블 -->
            <div class="table left">
                <h3>상품 정보</h3>
                <hr>
                <c:forEach items="${orderList}" var="order">
                <div class="productlistform">
                    <div class="d-flex align-items-center">
                        <div class="image-container">
                            <a href="${pageContext.request.contextPath}/product/detail/${order.pcode}" class="image-link">
                                <img src="${pageContext.request.contextPath}/resources/img/${order.pimg.split(',')[0]}"
                                     alt="${order.pname}"
                                     class="img-fluid img-rounded"
                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/default.jpg';">
                                <div class="image-overlay">${order.pname}</div>
                            </a>
                        </div>
                        <div class="ms-2 flex-grow-1">
						    <div class="d-flex flex-column">
						        <span style="font-size: 18px;"><strong>[${order.fname}]</strong></span>
						        <a href="${pageContext.request.contextPath}/product/detail/${order.pcode}" class="product-link no-underline black-text" style="font-size: 16px;">
						            <span style="font-size: 18px;">${order.pname}</span>
						        </a>
						        <br class="d-none d-md-table-cell"/>
						        <div class="d-flex justify-content-between" style="color: #6c757d;">
						            <span>수량 : ${order.pcount} 개 · 상품가 : <span class="productprice" data-price="${order.price}"></span> 원</span>
						            <span style="font-size: 18px;" class="text-end">구매예정금액 : <strong><span class="total-price" data-total="${order.totalprice}"></span></strong> 원</span>
						        </div>
						    </div>
						</div>
                    </div>
                </div>
                </c:forEach>
                <c:if test="${not empty user}">
                <br><br>
                <h3>회원 정보</h3>
<hr/>
<div class="productlistform1">
    <div class="d-flex flex-column">
        <span>이름 : ${user.uname}</span>
        <span>휴대폰 : ${user.phone}</span>
        <span>이메일 : ${user.email}</span>
        <div id="newad">
            <!-- 배송 받을 주소 제목 -->
            <div class="row my-3"> 
                <div class="fw-bold">배송 받을 주소</div>
            </div>
            
            <!-- 우편번호 입력 필드 및 찾기 버튼 -->
            <div class="row my-3">
                <div class="col-md-6">
                    <input type="text" class="form-control" name="uzcode" id="floatingUzcode" placeholder="우편번호" value="${user.uzcode}" readonly>
                </div>
                <div class="col-md-6">
                    <input type="button" class="btn btn-outline-success" onclick="execDaumPostcode()" value="우편번호 찾기">
                </div>
            </div>
            
            <!-- 도로명 주소와 상세 주소 분리 -->
            <c:set var="splitAddress" value="${fn:split(user.uaddress, ',')}"/>
            
            <!-- 도로명 주소 필드 -->
            <div class="form-floating my-2">
                <input type="text" class="form-control" name="newAddress" id="floatingNewAddress" value="${splitAddress[0]}" readonly>
                <label for="floatingNewAddress">도로명 주소</label>
            </div>
            
            <!-- 지번 주소 필드 -->
            <div class="form-floating my-2">
                <input type="text" class="form-control" name="oldAddress" id="floatingOldAddress" readonly>
                <label for="floatingOldAddress">지번 주소</label>
            </div>
            
            <!-- 상세 주소 필드 -->
            <div class="form-floating my-2">
                <input type="text" class="form-control" name="detailAddress" id="floatingDetailAddress" value="${splitAddress[1]}">
                <label for="floatingDetailAddress">상세 주소</label>
            </div>
        </div>
    </div>
</div>
                </c:if>
                <br/>
                <h3>결제 수단</h3>
                <hr/>
    <div class="payment-options">
    <!-- 카카오페이 -->
    <label class="payment-option">
        <div class="payment-content">
            <input type="radio" name="paymentMethod" value="kakaopay" checked class="payment-radio" />
            <h5 class="fw-bold mt-2 mb-3">카카오페이</h5>
        </div>
    </label>

    <!-- 토스페이 -->
    <label class="payment-option">
        <div class="payment-content">
            <input type="radio" name="paymentMethod" value="tosspay" class="payment-radio" />
            <h5 class="fw-bold mt-2 mb-3">토스페이</h5>
        </div>
    </label>

    <!-- 이니시스 -->
    <label class="payment-option">
        <div class="payment-content">
            <input type="radio" name="paymentMethod" value="inicis" class="payment-radio" />
            <h5 class="fw-bold mt-2 mb-3">KG 이니시스</h5>
        </div>
    </label>
</div></div>
<hr class="d-block d-md-none"/>
         <!-- 사용자 결제 테이블 -->
         <div class="table-responsive right">
             <h3 class="d-none d-md-block">결제 내역</h3>
             <div class="backgroundbar d-none d-md-block">
                 <div class="totalcontainer payment-summary">
                     <div class="info-container">
                         <!-- 총 주문 상품수 계산 -->
				<c:set var="totalCount" value="0" />
				<c:forEach items="${orderList}" var="order">
				    <c:set var="totalCount" value="${totalCount + order.pcount}" />
				</c:forEach>
				
				<!-- 총 합계 금액 -->
				<c:set var="totalAmount" value="0" />
				<c:forEach items="${orderList}" var="order">
				    <c:set var="totalAmount" value="${totalAmount + order.totalprice}" />
				</c:forEach>
				
				<!-- HTML 부분에서 값 출력 -->
				<div class="d-flex justify-content-between">
				    <p class="totalproduct1">총 주문 상품수</p>
				    <span class="finalPrice_span totalproduct2 number">${totalCount} 개</span>
				</div>
				
				<div class="d-flex justify-content-between">
				    <p class="totalproduct1">총 합계 금액</p>
				    <span class="finalPrice_span totalproduct2 number" id="totalAmount">${totalAmount} 원</span>
				</div></div></div>
				
                   <!-- 최종 결제 금액을 추가할 새로운 div -->
                   <div class="final-amount-container payment-summary">
                       <div class="final-amount-inner d-flex justify-content-between">
                           <p class="final-amount-label">총 결제 금액</p>
                           <p class="final-amount-value">
                               <span id="finalAmount" class="finalPrice_span totalproduct2 number">
                               <fmt:formatNumber value="${totalAmount}" pattern="#,###" />${totalAmount}</span>
                           </p>
                       </div></div></div>
                   <!-- 모바일 전용 최종 결제 금액 테이블 -->
				<div class="mobile-final-amount-container d-block d-md-none">
				    <h3>최종 결제 금액</h3>
				    <div class="mobile-final-amount-inner">
				        <p class="mobile-final-amount-value">
				        <span id="mobileFinalAmount" class="mobile-finalPrice_span">
				        <fmt:formatNumber value="${totalAmount}"
									pattern="#,###" /> 원
				           </span>
				        </p>
			    </div></div>
                         
<div class="final-amount-inner">
<button class="btn btn-dark btn-custom" onclick="requestPay()">결제하기</button>
</div></div><br/><br/>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
IMP.init("imp01475804");

function requestPay() {
	var paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
    var pg; 

 // 결제 수단에 따라 PG사 다르게
    if (paymentMethod === 'kakaopay') {
        pg = 'kakaopay.TC0ONETIME';  // 카카오페이
    } else if (paymentMethod === 'tosspay') {
        pg = 'tosspay.tosstest';  // 토스페이
    } else if (paymentMethod === 'inicis') {
        pg = 'html5_inicis.INIpayTest';  // 이니시스 
    }
	
    var totalPrice = 0;
    var productInfo = [];  
    var code = [];         
    var quantity = [];     
    var unitPrice = [];

    <c:forEach var="order" items="${orderList}">
        totalPrice += ${order.totalprice};
        productInfo.push("${order.pname}");
        code.push("${order.pcode}");
        quantity.push(${order.pcount});
        unitPrice.push(${order.price});
    </c:forEach>

    var nameField = productInfo.join(" -- ");
    var codeField = JSON.stringify(code);
    var quantityField = JSON.stringify(quantity);
    var unitPriceField = JSON.stringify(unitPrice);

    var merchantUid = 'farmily_' + Date.now(); 
    
 	// 도로명 주소와 상세 주소를 가져오기
    var newAddress = document.getElementById('floatingNewAddress').value;  // 도로명 주소
    var detailAddress = document.getElementById('floatingDetailAddress').value; // 상세 주소
    var postalCode = document.getElementById('floatingUzcode').value; // 우편번호

    // 유효성 검사: 주소지에 입력되지 않은 부분이 있는지 확인
    if (!postalCode || !newAddress) {
        alert('주소지에 입력되지 않은 부분이 있습니다.');
        return;  // 결제를 진행하지 않음
    }
    
    // 상세 주소가 비어 있으면 도로명 주소만 사용하고, 그렇지 않으면 도로명 주소와 상세 주소를 결합
    var fullAddress = detailAddress ? newAddress + ", " + detailAddress : newAddress;
    
    IMP.request_pay({
    	pg: pg,
    	pay_method: paymentMethod,
        merchant_uid: merchantUid, 
        name: nameField,  
        amount: totalPrice,
        buyer_name: "${user.uname}",
        buyer_tel: "${user.phone}",
        buyer_email: "${user.email}",
        buyer_addr: fullAddress,
        buyer_postcode: postalCode,
        code: codeField,
        quantity: quantityField,
        unitPrice: unitPriceField
    }, function(rsp) {
        if (rsp.success) {
            // 결제가 성공했을 경우 추가 데이터와 함께 서버로 rcode 전송
            sendRcodeToServer(rsp, codeField, quantityField, unitPriceField, nameField);
        } else {
            var msg = '결제에 실패하였습니다.';
            msg += '\n에러내용 : ' + rsp.error_msg;
            alert(msg);
        }
    });
}

function sendRcodeToServer(rsp, codeField, quantityField, unitPriceField, nameField, totalPrice) {
    var rcodeList = [];

    <c:forEach var="rcode" items="${rcodeList}">
        rcodeList.push("${rcode.rcode}" === "" || "${rcode.rcode}" === null ? 0 : "${rcode.rcode}");
    </c:forEach>

    var rcodeField = JSON.stringify(rcodeList);

    console.log("Sending data to server:", {
        imp_uid: rsp.imp_uid,
        merchant_uid: rsp.merchant_uid,
        pay_method: rsp.pay_method,
        name: nameField,
        amount: rsp.paid_amount,
        buyer_name: rsp.buyer_name,
        buyer_tel: rsp.buyer_tel,
        buyer_email: rsp.buyer_email,
        buyer_addr: rsp.buyer_addr,
        buyer_postcode: rsp.buyer_postcode,
        code: codeField,
        quantity: quantityField,
        unitPrice: unitPriceField,
        rcode: rcodeField
    });

    jQuery.ajax({
        url: "/pay/complete/" + rsp.imp_uid,
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        data: JSON.stringify({
            imp_uid: rsp.imp_uid,
            merchant_uid: rsp.merchant_uid,
            pay_method: rsp.pay_method,
            name: nameField,
            amount: rsp.paid_amount,
            buyer_name: rsp.buyer_name,
            buyer_tel: rsp.buyer_tel,
            buyer_email: rsp.buyer_email,
            buyer_addr: rsp.buyer_addr,
            buyer_postcode: rsp.buyer_postcode,
            code: codeField,
            quantity: quantityField,
            unitPrice: unitPriceField,
            rcode: rcodeField
        }),
        success: function(data) {
            console.log("Server response:", data);
            if (rsp.paid_amount == data.amount) {
                alert('결제가 완료되었습니다. 주문 내역 페이지로 이동합니다.');
                deleteRecords(rcodeField);
            } else {
                alert('결제 처리 중 문제가 발생하였습니다.77');
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error("Error occurred:", textStatus, errorThrown);
            alert('결제 정보를 확인하는 중 오류가 발생하였습니다.');
        }
    });
}

function deleteRecords(rcodeField) {

    // 2단계: /pay/afterPayDelete 호출
    jQuery.ajax({
        url: "/pay/afterPayDelete",
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        data: JSON.stringify({
            rcode: rcodeField // JSON 문자열로 전송
        }),
        success: function(data) {
            if (data.success) {
                // 3단계: /pay/rstateupdate 호출
                updateRState(rcodeField);
            } else {
                alert('삭제 처리 중 문제가 발생하였습니다.');
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert('삭제 정보를 확인하는 중 오류가 발생하였습니다.');
        }
    });
}

function updateRState(rcodeField) {

    // 3단계: /pay/rstateupdate 호출
    jQuery.ajax({
        url: "/pay/rstateupdate",
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        data: JSON.stringify({
            rcode: rcodeField // JSON 문자열로 전송
        }),
        success: function(data) {
            if (data.success) {
                // 4단계: /pay/myRecentList로 리디렉션
                window.location.href = '/pay/myRecentList'; 
            } else {
                alert('상태 업데이트 처리 중 문제가 발생하였습니다.');
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert('상태 업데이트 정보를 확인하는 중 오류가 발생하였습니다.');
        }
    });
}
</script>
<script>
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {

            var roadAddr = data.roadAddress;
            var extraRoadAddr = '';

            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }

            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }

            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            document.getElementById('floatingUzcode').value = data.zonecode;
            document.getElementById("floatingNewAddress").value = roadAddr;
            document.getElementById("floatingOldAddress").value = data.jibunAddress;
            document.getElementById("floatingDetailAddress").value = '';
            
			
        }
    }).open();
}
</script>
						<script>
					    function formatPrice() {
					        // 상품 가격 포맷팅
					        document.querySelectorAll('.productprice').forEach(function(element) {
					            const price = parseFloat(element.dataset.price);
					            if (!isNaN(price)) {
					                element.textContent = price.toLocaleString();
					            }
					        });

					        // 총 금액 포맷팅
					        document.querySelectorAll('.total-price').forEach(function(element) {
					            const totalPrice = parseFloat(element.dataset.total);
					            if (!isNaN(totalPrice)) {
					                element.textContent = totalPrice.toLocaleString();
					            }
					        });

					        // 총 합계 금액 포맷팅
					        const totalAmountElement = document.getElementById('totalAmount');
					        if (totalAmountElement) {
					            const totalAmountText = totalAmountElement.textContent.replace(/[^0-9]/g, ''); // "원" 제거
					            const totalAmount = parseFloat(totalAmountText);
					            if (!isNaN(totalAmount)) {
					                totalAmountElement.textContent = totalAmount.toLocaleString() + ' 원'; // "원" 추가
					            }
					        }

					        // 최종 결제 금액 포맷팅
					        const finalAmountElement = document.getElementById('finalAmount');
					        if (finalAmountElement) {
					            finalAmountElement.textContent = document.getElementById('totalAmount').textContent;
					        }
					    }

					    // 페이지 로드 시 실행
					    document.addEventListener("DOMContentLoaded", formatPrice);
                        </script>
                    </div>
                </div>
            </div>
        </div>
<jsp:include page="/modules/footer.jsp"></jsp:include>

</body>
</html>