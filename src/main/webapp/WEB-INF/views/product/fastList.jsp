<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<div class="mt-5 text-center fw-bold fs-1">
    <p class="p-0">간편 구매</p>
</div>    
    <br><br><br>
    <div class="container-lg">
        <div class="row mb-3">
            <div class="col-md-4">
                <!-- 상품 타입 필터 -->
                <div class="product-filter">
                    <label for="ptype" class="h3">상품 분류</label>
                    <select id="ptype" class="form-select" style="height:65px;" >
                        <option value="">상품 분류를 선택하세요</option>
                        <option value="곡물" ${ptype eq '곡물' ? 'selected' : ''}>곡물</option>
                        <option value="채소" ${ptype eq '채소' ? 'selected' : ''}>채소</option>
                    </select>
                </div>
            </div>
            <div class="col-md-4">
                <!-- 상품 리스트 선택 -->
                <div class="product-selection">
                    <label for="product-select" class="h3">상품 선택</label>
                    <select id="product-select" class="form-select" style="height:65px;">
                        <option value="">상품을 선택하세요</option>
                        <c:forEach var="product" items="${products}">
                            <option value="${product.pcode}" data-price="${product.price}">${product.pname}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="col-md-4">
                <!-- 선택한 상품의 세부 정보 폼 -->
                <div id="product-form" class="product-form">
                    <form>
                        <div class="form-group">
                            <label for="product-quantity" class="h3">수량</label>
                            <div class="quantity-control">
                                <button type="button" id="decrease-btn" class="btn btn-secondary" style="height:50px; width:50px;" >-</button>
                                <input type="text" id="product-quantity" class="form-control quantity-input" value="1" min="1" max="100" style="height:50px; width:80px;">
                                <button type="button" id="increase-btn" class="btn btn-secondary "style="height:50px; width:50px;" >+</button>
                                <c:choose>
                                    <c:when test="${not fn:contains(role, 'A')}">
                                        <!-- role에 'A'가 포함되지 않을 때 버튼을 표시합니다. -->
                                        <button type="button" id="buy-button" class="btn btn-success" style="height:50px; width:80px;" >구매</button>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- role에 'A'가 포함될 때 버튼을 숨깁니다. -->
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- 오류 메시지 표시 -->
        <div id="error-message" class="alert alert-danger"></div>
    </div>
    <!-- JavaScript 코드 -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
    $(document).ready(function() {
        // 상품 타입 필터 변경 시
        $('#ptype').change(function() {
            var selectedType = $(this).val();
            $.ajax({
                url: "${pageContext.request.contextPath}/product/fast",
                type: "GET",
                data: { ptype: selectedType },
                success: function(response) {
                    var options = $(response).find('#product-select').html();
                    $('#product-select').html(options);
                    $('#error-message').hide();
                },
                error: function(xhr, status, error) {
                    $('#error-message').text('상품 목록을 불러오는 중 오류가 발생했습니다.').show();
                }
            });
        });

        // 상품 선택 시 세부 정보 로드
        $('#product-select').change(function() {
            var selectedPcode = $(this).val();
            var selectedOption = $(this).find('option:selected');
            var price = selectedOption.data('price');
            var name = selectedOption.text();

            if (selectedPcode) {
                $('#product-price').val(price);
                $('#product-quantity').val(1);
                $('#total-price').val(price);
                $('#product-form').show();
            }
        });

        // 수량 감소 버튼 클릭 시
        $('#decrease-btn').click(function() {
            var quantityInput = $('#product-quantity');
            var currentQuantity = parseInt(quantityInput.val());

            if (currentQuantity > 1) {
                quantityInput.val(currentQuantity - 1);
                updateTotalPrice();
            }
        });

        // 수량 증가 버튼 클릭 시
        $('#increase-btn').click(function() {
            var quantityInput = $('#product-quantity');
            var currentQuantity = parseInt(quantityInput.val());

            quantityInput.val(currentQuantity + 1);
            updateTotalPrice();
        });

        // 수량 직접 입력 시 총 가격 업데이트
        $('#product-quantity').on('input', function() {
            var quantityInput = $(this);
            var price = parseInt($('#product-price').val());
            var currentQuantity = parseInt(quantityInput.val());

            if (isNaN(currentQuantity) || currentQuantity < 1) {
                quantityInput.val(1);
                currentQuantity = 1;
            }
            updateTotalPrice();
        });
        //수량 직접 입력 시 min/max
        $('#product-quantity').on('input', function() {
            var quantityInput = $(this);
            var currentQuantity = parseInt(quantityInput.val());
            console.log(${id})
            if (isNaN(currentQuantity) || currentQuantity < 1) {
                quantityInput.val(1); // 최소 수량은 1
            } else if (currentQuantity > 100) {
                quantityInput.val(100); // 최대 수량은 100
            }
            
            updateTotalPrice();
        });

        // 총 가격 업데이트 함수
        function updateTotalPrice() {
            var quantity = parseInt($('#product-quantity').val());
            var price = parseInt($('#product-price').val());
            var totalPrice = quantity * price;

            $('#total-price').val(formatPrice(totalPrice) + ' 원');
        }

        // 가격 포맷 함수
        function formatPrice(price) {
            return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        }

        // 바로 구매 버튼 클릭 시
	$('#buy-button').click(function() {
    var ptype = $('#ptype').val();
    var pcode = $('#product-select').val();
    var pcount = parseInt($('#product-quantity').val());
//     console.log('User logged in:', userLoggedIn);

    // 로그인 상태에서 상품 타입과 상품명 선택 여부 확인
    if (userLoggedIn) {
        if (!ptype) {
            alert('상품 분류를 선택해주세요.');
            return;
        }

        if (!pcode) {
            alert('상품을 선택해주세요.');
            return;
        }
    } else {
        // 로그인 상태가 아닌 경우, 상품 타입과 상품명을 선택하지 않으면 로그인 페이지로 리다이렉트
        if (!ptype || !pcode) {
        	alert('로그인 후 시도해주세요.');
            window.location.href = '/login'; // 로그인 페이지로 리다이렉트
            return;
        }
    }

    // 유효성 검사를 통과한 경우, 서버에 AJAX 요청을 보냄
    $.ajax({
        url: '/reserve/oneInsert',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            pcode: pcode,
            pcount: pcount
        }),
        success: function(response) {
            if (response.redirect) {
                var orders = response.orders;
                if (orders && orders.length > 0) {
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
        error: function(xhr) {
            if (xhr.status === 401) {
                // 401 에러 발생 시 로그인 페이지로 리디렉트
                var response = JSON.parse(xhr.responseText);
                window.location.href = response.redirect;
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
