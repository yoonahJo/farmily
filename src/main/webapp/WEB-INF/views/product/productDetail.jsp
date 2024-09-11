<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="/resources/css/topAndCart.css" rel="stylesheet">
    <style>
        .product-info {
            padding: 15px;
        }
        .product-info h2 {
            margin-top: 0;
        }
        .img-rounded {
            border-radius: 15px; 
            max-width: 100%; 
            height: auto; 
        }
        .quantity-controls {
            display: flex;
            align-items: center;
        }
        .quantity-controls button {
            width: 40px;
            height: 40px;
        }
        .quantity-controls input {
            width: 60px;
            text-align: center;
        }
        
        .textLengthWrap {
            display: flex;
            justify-content: flex-end;
        }

        .textCount, .textTotal {
            font-size: 14px;
            color: #555;
            margin-left: 5px;
        }
        textarea{
            resize: none;
        }
        /* Modal backdrop transparency */
        .modal-backdrop.show {
            opacity: 0.1; /* 배경 투명도 설정 */
        }
        .thumbnail-images img {
            cursor: pointer;
            width: 70px;
            height: 70px;
            object-fit: cover;
            margin-right: 10px;
        }
        .main-image-container {
            width: 100%;
            max-width: 500px;
            height: 500px;
            display: block;
            margin: 0 auto;
            background-color: #f8f8f8;
            position: relative;
        }
        .main-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            position: absolute;
            top: 0;
            left: 0;
        }
        .btn-custom {
            margin: 0 5px;
        }

        .product-name {
            font-weight: bold;
            font-size: 1.25rem;
        }
        #pay {
 background: #19a26e;
 outline: none;
    border: none; 

}

    </style>
</head>
<body class="nanum-gothic-regular">
<jsp:include page="/modules/header.jsp"></jsp:include>  
    <jsp:include page="/modules/topAndCart.jsp"></jsp:include>
<br>


<div class="container mt-4">
    <h1 class="text-center">상품 상세 정보</h1><br><br>
    
    <div class="row">
         <div class="col-md-5">
            <div class="main-image-container">
                <!-- 메인 이미지 -->
                <img id="mainImage" class="main-image rounded-3" src="${pageContext.request.contextPath}/resources/img/${fn:split(product.pimg, ',')[0]}" alt="${product.pname}">
            </div>
            <!-- 썸네일 이미지들 -->
            <div class="thumbnail-images mt-3 d-flex justify-content-center">
                <c:forEach var="img" items="${fn:split(product.pimg, ',')}">
                    <img src="${pageContext.request.contextPath}/resources/img/${img}" alt="Thumbnail" onclick="changeImage(this.src)">
                </c:forEach>
            </div>
        </div>
        <div class="col-md-6 product-info">
            <p class="fs-1 fw-bold">${product.pname}</p>
            <p class="fs-4">분류: ${product.ptype}</p>
            <p class="fs-4">등급: ${product.quality}</p>
            <p class="fs-4">생산일자: <fmt:formatDate value="${product.creDate}" pattern="yyyy-MM-dd" /><p>
            <div class="py-2">
                <ul style="list-style: none; padding: 0;" class="mb-0 border-bottom border-dark-subtle">
                    <li class="py-1"><p class="fs-4">원산지 : 대한민국(상세페이지 참조)</p></li>
                    <li class="py-1"><p class="fs-4">배송비 : 조건별 무료배송</p></li>
                </ul>
            </div>
           <div class="quantity-controls my-3">
    <button class="btn btn-secondary" onclick="changeQuantity(-1)">-</button>
    <input id="count" type="number" class="form-control text-center mx-2" value="1" min="1" max="20" oninput="validateInput(); updatePrice()" style="width: 70px;">
    <button class="btn btn-secondary" onclick="changeQuantity(1)">+</button>

</div><div><h4>최대 20개까지 구매하실 수 있습니다.</h4></div>

            <span class="d-block pt-3 fs-4" id="price">
                <fmt:formatNumber value="${product.price}" type="currency" />원
            </span>
            <div class="mt-4">
            	<c:choose>
            		<c:when test="${not fn:contains(role, 'A')}">
            			<form action="/reserve/insert" method="post" class="product-buttons">
		                    <input type="hidden" name="pcode" value="${product.pcode}" />
		                    <input type="hidden" name="pcount" id="pcount" value="${product.pcount != null ? product.pcount : 1}" />
		                    <button type="button" class="btn btn-secondary add-to-cart" style="font-size:25px" aria-label="상품을 장바구니에 추가">장바구니</button>
		                    <a id="pay" class="btn btn-success btn_buy" style="font-size:25px" aria-label="상품을 바로구매">바로구매</a>
		                </form>
            		</c:when>
            		<c:otherwise>
            			<form action="/reserve/insert" method="post" class="product-buttons">
		                    <input type="hidden" name="pcode" value="${product.pcode}" />
		                    <input type="hidden" name="pcount" id="pcount" value="${product.pcount != null ? product.pcount : 1}" />
		                </form>
            		</c:otherwise>
            	</c:choose>
            </div>
        </div>
    </div>
</div><br><br>

<div class="container">
    <ul class="nav nav-tabs" id="productTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="product-info-tab" data-bs-toggle="tab" data-bs-target="#product-info" type="button" role="tab" aria-controls="product-info" aria-selected="true">상품 정보</button>
        </li>
       <li class="nav-item" role="presentation">
            <button class="nav-link" id="shipping-info-tab" data-bs-toggle="tab" data-bs-target="#shipping-info" type="button" role="tab" aria-controls="shipping-info" aria-selected="false">배송 및 환불 정보</button>
        </li>
    </ul>
    <div class="tab-content" id="productTabContent">
        <!-- 상품 정보 탭 -->
        <div class="tab-pane fade show active" id="product-info" role="tabpanel" aria-labelledby="product-info-tab">
            <div class="container mt-5">
                <h2 class="section-header">상품 상세 정보</h2><br>
                <h3 class="lh-lg">${product.des}</h3><br><br>
                <table class="table table-bordered">
                    <tbody>
                        <tr>
                            <th scope="row">농장 정보</th>
                            <td>
                                <p><strong>농장상호:</strong> ${product.fname}</p>
                                <p><strong>농장주소:</strong> ${product.faddress}</p>
                                <p><strong>농장우편번호:</strong> ${product.fzcode}</p>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">상품코드</th>
                            <td>${product.pcode}</td>
                        </tr>
                        <tr>
                            <th scope="row">품목 또는 명칭</th>
                            <td>${product.pname}</td>
                        </tr>
                        <tr>
                            <th scope="row">[농수산물의 원산지 표시 등에 관한 법률]에 따른 원산지</th>
                            <td>국산</td>
                        </tr>
                        <tr>
                            <th scope="row">제조연월일, 소비기한 또는 품질유지기한</th>
                            <td>본 상품은 점포별로 제조, 소비기한이 상이하여 제조연월일 정보 제공이 어렵습니다. 점포상품과 동일한 품질을 유지한 상품이 배송되나, 받으신 후 가급적 빨리 드시길 권장 드립니다.</td>
                        </tr>
                        <tr>
                            <th scope="row">유통기한</th>
                            <td>상품에 표기된 유통기한에 따라 확인 후 구매해 주시기 바랍니다.</td>
                        </tr>
                        <tr>
                            <th scope="row">보관방법</th>
                            <td>냉장보관</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        

        <!-- 배송 및 환불 정보 탭 -->
        <div class="tab-pane fade" id="shipping-info" role="tabpanel" aria-labelledby="shipping-info-tab">
            <div class="container mt-5">
                <h2 class="section-header">Family 배송안내</h2>
                <div style="max-width: 650px;" class="container-lg p-0 bg-white">
                    <div class="d-flex justify-content-center py-4">
                        <div class="d-flex justify-content-center align-items-center border-end border-dark-subtle border-3 p-1 p-sm-3">
                            <h2 class="mb-0 fs-3 fw-bold text-center">배송</h2>
                        </div>
                        <div class="ms-3">
                            <h2 class="mb-0 fw-bold">주문마감 시간 밤 12시</h2>
                            <ul style="list-style: none; padding: 0;" class="mb-0">
                                <li class="p-2"><strong>전국</strong> / 제주도 및 섬 지역은 배송 불가</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <br><br>
                <h2 class="mb-0 py-5 fw-bold text-center">Family 배송 및 환불 안내</h2>
                <div style="max-width: 650px;" class="container-lg bg-white p-1 p-md-3">
                    <div class="d-flex justify-content-center p-1 flex-column flex-sm-row p-lg-2">
                        <div style="min-width: 120px; min-height: 112px;" class="bg-success rounded-5 d-flex justify-content-center align-items-center p-3">
                            <h2 class="mb-0 fs-4 fw-bold">배송<span class="d-inline d-sm-block">정보</span></h2>
                        </div>
                        <div class="ms-1 ms-lg-2 d-flex">
                            <ul style="list-style: none; padding: 0" class="mb-0 d-flex justify-content-center flex-column mt-4 mt-sm-0">
                                <li class="p-1">제품은 주문 후, 고객님께서 <strong class="text-info">지정한 배송 희망일에 수령 가능합니다.</strong></li>
                                <li class="p-1">주말과 공휴일은 사업장 휴무로 인해 제품이 생산 및 발송되지 않습니다.</li>
                            </ul>
                        </div>
                    </div>
                    <div class="d-flex justify-content-center p-1 flex-column flex-sm-row p-lg-2 mt-4 mt-sm-0">
                        <div style="min-width: 120px; min-height: 112px;" class="bg-success rounded-5 d-flex justify-content-center align-items-center p-3">
                            <h2 class="mb-0 fs-4 fw-bold">주의<span class="d-inline d-sm-block">사항</span></h2>
                        </div>
                        <div class="ms-1 ms-lg-2 d-flex">
                            <ul style="list-style: none; padding: 0" class="mb-0 d-flex justify-content-center flex-column mt-4 mt-sm-0">
                                <li class="p-1">지정한 배송 희망일의 <strong class="text-info">전 일 밤 12시 이후에는 취소/환불이 불가합니다.</strong></li>
                                <li class="p-1">제품 수령 후 보관 중 발생한 변질 및 파손은 교환 및 환불이 불가합니다.</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div><br><br>

<!-- 주문 form -->
<form action="/reserve/oneInsert" method="post" class="order_form">
    <input type="hidden" name="pcode" value="" id="orderPcode">
    <input type="hidden" name="pcount" value="1" id="orderPcount">
</form>

<!-- Modal -->
<div class="modal fade" id="cartModal" tabindex="-1" aria-labelledby="cartModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="cartModalLabel">장바구니</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                해당 상품이 장바구니에 추가되었습니다.
            </div>
            <div class="modal-footer">
                <a href="${pageContext.request.contextPath}/reserve/list" class="btn btn-primary">장바구니 가기</a>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<script>
$(document).ready(function() {
    var reqBody = '${reqBody}';
    var reqUrl = '${reqUrl}';

    if (reqBody) {
        if (reqUrl === 'http://localhost:8080/reserve/insert') {
            $.ajax({
                url: '/reserve/insert',
                type: 'POST',
                contentType: 'application/json',
                data: reqBody,
                success: function(response) {
                    var cartModal = new bootstrap.Modal(document.getElementById('cartModal'));
                    if (response) {
                        $('#cartModalLabel').text('장바구니');
                        $('.modal-body').text('이미 장바구니에 존재하는 상품에 수량을 추가하였습니다.<br/>장바구니로 이동하시겠습니까?');
                        $('.modal-footer .btn-primary').attr('href', '${pageContext.request.contextPath}/reserve/list');
                    } else {
                        $('#cartModalLabel').text('장바구니');
                        $('.modal-body').text('해당 상품이 장바구니에 추가되었습니다.');
                        $('.modal-footer .btn-primary').attr('href', '${pageContext.request.contextPath}/reserve/list');
                    }
                    cartModal.show();
                },
                error: function(xhr) {
                    if (xhr.status === 401) {
                        var response = JSON.parse(xhr.responseText);
                        window.location.href = response.redirect;
                    } else {
                        alert('장바구니 추가에 실패했습니다.');
                    }
                }
            });
        }
    }
});

// 동적 HTML 폼을 생성하여 POST 요청을 보내는 함수
function postForm(url, data) {
    var form = $('<form></form>').attr('method', 'POST').attr('action', url);
    $.each(data, function(key, value) {
        var input = $('<input>').attr('type', 'hidden').attr('name', key).val(value);
        form.append(input);
    });
    $('body').append(form);
    form.submit();
}
</script>
<script>
    // 단위 가격
    const pricePerUnit = ${product.price}; // 템플릿 리터럴에서 ${product.price}는 올바르게 설정되어야 합니다.

    function changeQuantity(amount) {
        const countInput = document.getElementById('count');
        let quantity = parseInt(countInput.value, 10) || 1;

        quantity += amount;

        // 수량 범위 확인
        if (quantity < 1) quantity = 1;
        if (quantity > 20) quantity = 20;

        countInput.value = quantity;
        updatePrice(); // 가격 업데이트 함수 호출
    }

    // 수량 입력 검증 함수
    function validateInput() {
        const countInput = document.getElementById('count');
        let quantity = parseInt(countInput.value, 10);

        // 입력값이 유효하지 않은 경우
        if (isNaN(quantity)) {
            countInput.value = 1;
        } else {
            // 입력값을 범위 내로 조정
            if (quantity < 1) {
                countInput.value = 1;
            } else if (quantity > 20) {
                countInput.value = 20;
            }
        }

        updatePrice(); // 가격 업데이트 함수 호출
    }

    // 가격 업데이트 함수
    function updatePrice() {
        const quantity = parseInt(document.getElementById('count').value, 10);
        const totalPrice = pricePerUnit * quantity; // 총 가격 계산

        // 총 가격을 한국 원화 형식으로 포맷
        const formattedPrice = new Intl.NumberFormat('ko-KR', {
            style: 'currency',
            currency: 'KRW'
        }).format(totalPrice);

        document.getElementById('price').textContent = formattedPrice + '원'; // 가격 업데이트
    }

    // 페이지 로드 시 초기 가격 설정
    window.onload = updatePrice;

    $(document).ready(function () {
        // 바로구매 버튼 클릭 이벤트 처리
        $(".btn_buy").on("click", function () {
            var $form = $(this).closest('form');
            var pcode = $form.find('input[name="pcode"]').val();
            var pcount = $('#count').val(); // 동적으로 선택된 수량 사용

            $.ajax({
                url: '/reserve/oneInsert',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    pcode: pcode,
                    pcount: pcount
                }),
                success: function (response) {
                    console.log("응답 데이터:", response);
                    if (response.redirect) {
                        var orders = response.orders;
                        console.log("Orders 배열:", orders);
                        if (orders && orders.length > 0) {
                            // 첫 번째 주문의 세부 정보를 추출
                            var firstOrder = orders[0];
                            var data = {
                                [`orders[0].pcode`]: firstOrder.pcode,
                                [`orders[0].pcount`]: firstOrder.pcount,
                                [`orders[0].rcode`]: firstOrder.rcode
                            };
                            getRequest(response.redirect, data);
                        } else {
                            alert('주문 정보가 없습니다.');
                        }
                    } else {
                        alert('리다이렉트 URL이 없습니다.');
                    }
                },
                error: function (xhr) {
                    if (xhr.status === 401) {
                        // 401 에러 발생 시 로그인 페이지로 리디렉트
                        var response = JSON.parse(xhr.responseText);
                        window.location.href = response.redirect;
                    } else {
                        alert('오류가 발생했습니다.');
                    }
                }
            });
        });
		//장바구니
        $('.add-to-cart').on('click', function(event) {
            event.preventDefault();
            var $form = $(this).closest('form');
            var pcode = $form.find('input[name="pcode"]').val();
            var pcount = $('#count').val();

            var data = JSON.stringify({
                pcode: pcode,
                pcount: pcount,
            });

            $.ajax({
                url: $form.attr('action'),
                type: 'POST',
                contentType: 'application/json',
                data: data,
                success: function(response) {
                    var cartModal = new bootstrap.Modal(document.getElementById('cartModal'));
                    if (response) {
                        $('#cartModalLabel').text('장바구니');
                        $('.modal-body').text('이미 장바구니에 존재하는 상품에 수량을 추가하였습니다. 장바구니로 이동하시겠습니까?');
                        $('.modal-footer .btn-primary').attr('href', '${pageContext.request.contextPath}/reserve/list');
                    } else {
                        $('#cartModalLabel').text('장바구니');
                        $('.modal-body').text('해당 상품이 장바구니에 추가되었습니다.');
                        $('.modal-footer .btn-primary').attr('href', '${pageContext.request.contextPath}/reserve/list');
                    }
                    cartModal.show();
                },
                error: function(xhr) {
                    if (xhr.status === 401) {
                        // 서버에서 401 응답이 오면 리디렉션 처리
                        var response = JSON.parse(xhr.responseText);
                        window.location.href = response.redirect;
                    } else {
                        alert('장바구니 추가에 실패했습니다.');
                    }
                }
            });
        });

     	// 동적 HTML 폼을 생성하여 GET 요청을 보내는 함수
        function getRequest(url, data) {
            var queryString = $.param(data); // 데이터를 쿼리 문자열로 변환
            var fullUrl = url + '?' + queryString; // URL과 쿼리 문자열을 결합

            window.location.href = fullUrl; // GET 요청을 보냄
        }
    });
</script>
    <jsp:include page="/modules/footer.jsp"></jsp:include>
</body>
</html>