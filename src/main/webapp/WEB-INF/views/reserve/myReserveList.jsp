<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/myReserveListCSS.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="/resources/css/onlyTop.css" rel="stylesheet">
<script>
$(document).ready(function() {
	// 로컬 스토리지에서 체크박스 상태를 복원하는 함수
    function restoreCheckboxStates() {
        var storedData = JSON.parse(localStorage.getItem('checkedCheckboxes'));

        if (storedData) {
            var now = new Date().getTime();
            // 만료 시간이 지난 경우 로컬 스토리지에서 데이터를 삭제
            if (now > storedData.expiry) {
                localStorage.removeItem('checkedCheckboxes');
            } else {
                var checkedIds = storedData.checkedIds || [];
                $("input[name='reserveAll']").each(function() {
                    var $checkbox = $(this);
                    if (checkedIds.includes($checkbox.val())) {
                        $checkbox.prop("checked", true);
                    } else {
                        $checkbox.prop("checked", false);
                    }
                });
            }
        }

        updateTotals();
        updateSelectDeleteButton();
    }

 // 로컬 스토리지에 체크박스 상태를 저장하는 함수 (30분 후 만료)
    function saveCheckboxStates() {
        var checkedIds = $("input[name='reserveAll']:checked").map(function() {
            return $(this).val();
        }).get();

        // 만료 시간 설정 (현재 시간 + 30분)
        var expiryTime = new Date().getTime() + 30 * 60 * 1000; // 30분 후

        var data = {
            checkedIds: checkedIds,
            expiry: expiryTime
        };

        localStorage.setItem('checkedCheckboxes', JSON.stringify(data));
    }

    // 전체 선택 체크박스 클릭 시
    $("#selectAll").on("click", function() {
        $("input[name='reserveAll']").prop("checked", this.checked);
        saveCheckboxStates();
        updateTotals();
        updateSelectDeleteButton();
    });

    // 수량 변경 버튼 클릭 시 체크박스 체크 및 상태 저장
    $(".quantity_btn").on("click", function() {
        var $row = $(this).closest("tr");
        $row.find("input[name='reserveAll']").prop("checked", true); // 수량 변경 시 체크박스 체크
        saveCheckboxStates(); // 체크박스 상태 저장

        var $input = $(this).siblings(".quantity_input");
        var quantity = parseInt($input.val(), 10);
        if ($(this).hasClass("plus_btn") && quantity < 20) {
            $input.val(quantity + 1);
        } else if ($(this).hasClass("minus_btn") && quantity > 1) {
            $input.val(quantity - 1);
        }
        toggleChangeButton($(this));
        updateTotals();
        updateOrderPrice($(this));
    });

    // 체크박스 클릭 시 상태 저장
    $("input[name='reserveAll']").on("click", function() {
        saveCheckboxStates();
        updateTotals();
        updateSelectDeleteButton();
    });

    // 페이지 로드 시 체크박스 상태 복원
    restoreCheckboxStates();

    // 개별 체크박스 클릭 시 전체 선택 체크박스 상태 및 버튼 상태 업데이트
    $("input[name='reserveAll']").on("click", function() {
        var totalCheckboxes = $("input[name='reserveAll']").length;
        var checkedCheckboxes = $("input[name='reserveAll']:checked").length;

        $("#selectAll").prop("checked", totalCheckboxes === checkedCheckboxes);
        updateTotals();
        updateSelectDeleteButton();
    });

    // "선택상품 삭제" 버튼 상태 업데이트 함수
    function updateSelectDeleteButton() {
        var hasCheckedItems = $("input[name='reserveAll']:checked").length > 0;
        $(".selectdelete_btn").prop("disabled", !hasCheckedItems);
    }

    // 페이지 로드 시 버튼 상태 초기화
    updateSelectDeleteButton();

        $(".quantity_modify_btn").on("click", function(event){
        event.preventDefault(); // 폼 제출 방지

        var $form = $(this).closest("form");
        var RCODE = $form.find("input[name='rcode']").val();
        var PCOUNT = $form.find(".quantity_input").val();
        var RPRICE = $form.find(".individual_rprice_input").val(); // rprice 값 가져오기

        // 플래그 설정
        localStorage.setItem('reloadCheckAll', 'true');

        $.ajax({
            url: '/reserve/update', // 서버에서 수량 업데이트를 처리할 URL
            type: 'POST',
            contentType: 'application/json', // JSON 형식으로 요청
            data: JSON.stringify({
                rcode: RCODE,
                pcount: PCOUNT,
                rprice: RPRICE
            }),
            success: function(response) {
                if (response.status === 'success') {
                    window.location.reload(); // 페이지 새로 고침
                } else {
                    alert('수량 변경 실패: ' + response.message);
                }
            },
            error: function() {
                alert('수량 변경 실패');
            }
        });
    });
    
    // 총 가격과 총 수량 업데이트 함수
    function updateTotals() {
        let TOTALPRICE = 0; // 총 가격
        let TOTALCOUNT = 0; // 총 갯수

        $("input[name='reserveAll']:checked").each(function() {
            var $row = $(this).closest("tr");
            var quantity = parseInt($row.find(".quantity_input").val(), 10);
            var price = parseInt($row.find(".individual_price_input").val(), 10);

            if (!isNaN(quantity) && !isNaN(price)) {
                var itemTotal = price * quantity;
                TOTALPRICE += itemTotal;
                TOTALCOUNT += quantity;
            }
        });

        $(".totalPrice_span").text(formatPrice(TOTALPRICE));
        $(".totalCount_span").text(TOTALCOUNT);
    }

    // 주문 예정 금액 업데이트 함수
    function updateOrderPrice($triggerElement) {
        var $row = $triggerElement.closest("tr");
        var quantity = parseInt($row.find(".quantity_input").val(), 10);
        var price = parseInt($row.find(".individual_price_input").val(), 10);
       
        if (!isNaN(quantity) && !isNaN(price)) {
            var orderPrice = quantity * price;
            $row.find(".individual_rprice_input").val(orderPrice); // hidden input에서 RPRICE를 갱신
            $row.find(".rprice").text(formatPrice(orderPrice)); // 화면에 표시된 RPRICE를 갱신
        }
    }

    // 수량이 변경되었는지 확인하고 "변경" 버튼 보이기/숨기기
    function toggleChangeButton($triggerElement) {
        var $row = $triggerElement.closest("tr");
        var initialQuantity = parseInt($row.find(".individual_pcount_input").val(), 10);
        var currentQuantity = parseInt($row.find(".quantity_input").val(), 10);

        if (initialQuantity !== currentQuantity) {
            $row.find(".quantity_modify_btn").addClass('show');
        } else {
            $row.find(".quantity_modify_btn").removeClass('show');
        }
    }

    function openModal(rcode) {
        $('#modal').data('rcode', rcode);  // rcode 값을 모달에 저장
        $('#modal').show();  // 모달 열기
    }

    // 선택상품 삭제 시 모달 표시
    function openSelectModal() {
        $('#modal1').show();
    }

    // 모달 닫기
    function closeModal() {
        $('#modal, #modal1').hide();
    }

 // 확인 버튼 클릭 시 삭제 요청
    $('#confirmDelete').on('click', function () {
        var rcode = $('#modal').data('rcode');  // 모달에서 rcode 가져오기

        $.ajax({
            url: '/reserve/delete',
            type: 'POST',
            contentType: 'application/json',  // JSON 형식으로 요청 전송
            data: JSON.stringify({ rcode: rcode }),  // JSON 문자열로 변환하여 데이터 전송
            success: function (response) {
                if (response.status === 'success') {
                    window.location.reload();  // 성공 시 페이지를 새로 고침
                } else {
                    alert('삭제 실패: ' + response.message);
                }
            },
            error: function () {
                alert('삭제 실패');  // 실패 시 오류 메시지 출력
            }
        });
    });


    // 선택 상품 삭제 버튼 클릭 시 삭제 요청
    $('#confirmSelectDelete').on('click', function() {
        var selectedItems = $("input[name='reserveAll']:checked").map(function() {
            return parseInt($(this).val(), 10);
        }).get();

        if (selectedItems.length > 0) {
            $.ajax({
                url: '/reserve/deleteAll',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ rcodes: selectedItems }),
                success: function(response) {
                    // 성공 시 페이지를 새로 고치거나 필요한 작업 수행
                    window.location.reload();
                },
                error: function() {
                    alert('삭제 실패');
                }
            });
        } else {
            alert('삭제할 항목을 선택해 주세요.');
        }
    });

    // 모달의 취소 버튼 클릭 시 모달 닫기
    $('#cancelDelete, #cancelSelectDelete').on('click', function() {
        closeModal();
    });

    // 모달 클릭 시 닫기 (모달 외부 클릭 시)
    $(document).on('click', '#modal, #modal1', function(event) {
        if (event.target === this) {
            closeModal();
        }
    });
   
    // 페이지 로드 시 총 가격 및 수량 계산
    updateTotals();
   
    // 초기 상태에서 수량과 버튼의 상태 확인
    $("input.quantity_input").each(function() {
        toggleChangeButton($(this));
        updateOrderPrice($(this));
    });
   
    // 휴지통 버튼 클릭 시 모달 열기
    $(document).on('click', '.close_btn', function() {
        var rcode = $(this).closest('tr').find('input[name="reserveAll"]').val();
        openModal(rcode);
    });
   
    // 선택상품 버튼 클릭 시 모달 열기
    $(document).on('click', '.selectdelete_btn', function() {
        openSelectModal();
    });
   
    // 천 단위로 포맷팅하는 함수
    function formatPrice(price) {
        return price.toLocaleString() + ' 원';
    }

    // 모든 가격을 포맷팅하여 업데이트
    document.querySelectorAll('.productprice').forEach(function(element) {
        var price = parseInt(element.getAttribute('data-price'), 10);
        if (!isNaN(price)) {
            element.textContent = formatPrice(price);
        }
    });
   
    // 수량 입력 필드의 값이 숫자 이외의 문자일 때 1로 설정하고, 20 이상일 때 20으로 설정하는 함수
    $(".quantity_input").on("input", function() {
        var $input = $(this);
        var value = $input.val();

        // 입력값이 숫자가 아닌 경우
        if (isNaN(value) || value.trim() === '') {
            $input.val('1'); // 값을 1로 설정
        } else {
            var numberValue = parseInt(value, 10);
           
            // 값이 1보다 작은 경우
            if (numberValue < 1) {
                $input.val('1'); // 최소값을 1로 설정
            }
            // 값이 20보다 큰 경우
            else if (numberValue > 20) {
                $input.val('20'); // 최대값을 20으로 설정
            }
        }

        // 수량 값이 변경되면 버튼 상태 업데이트 및 총 가격, 수량 업데이트
        toggleChangeButton($input);
        updateTotals();
        updateOrderPrice($input);
    });
   
    // 체크박스 선택 개수 업데이트 함수
    function updateOrderSummary() {
        var checkedCount = $("input[name='reserveAll']:checked").length;
        $('#orderSummary').text('총 ' + checkedCount + '개 주문하기');
    }

    // 페이지 로드 시 체크박스 선택 개수 업데이트
    updateOrderSummary();

    // 체크박스 클릭 시 체크된 항목 개수 업데이트
    $("input[name='reserveAll']").on("click", function() {
        updateOrderSummary();
        updateTotals();
        updateSelectDeleteButton();
    });

    // 전체 선택 체크박스 클릭 시
    $("#selectAll").on("click", function() {
        $("input[name='reserveAll']").prop("checked", this.checked);
        updateOrderSummary();
        updateTotals();
        updateSelectDeleteButton();
    });

    document.addEventListener('DOMContentLoaded', function() {
        // 버튼 클릭 이벤트 리스너
        document.querySelector('.order_btn').addEventListener('click', function(event) {
            // 체크된 상품 개수 확인
            var checkedCheckboxes = document.querySelectorAll("input[name='reserveAll']:checked").length;
            
            if (checkedCheckboxes === 0) {
                event.preventDefault(); // 기본 동작 방지 (페이지 이동)
                document.getElementById('modal2').style.display = 'block'; // 모달 창 표시
            } else {
                // 체크된 상품이 있을 경우 페이지 이동
                window.location.href = '/reserve/orderPage';
            }
        });

        // 모달의 확인 버튼 클릭 시 모달 숨기기
        document.getElementById('cancelSelectDelete').addEventListener('click', function() {
            document.getElementById('modal2').style.display = 'none'; // 모달 창 숨기기
        });

        // 모달 클릭 시 닫기 (모달 외부 클릭 시)
        document.getElementById('modal2').addEventListener('click', function(event) {
            if (event.target === this) {
                document.getElementById('modal2').style.display = 'none'; // 모달 창 숨기기
            }
        });
    });
   
 // 체크된 체크박스가 없을 때 모달 띄우기
    $(".order_btn").on("click", function(event) {
        var checkedCheckboxes = $("input[name='reserveAll']:checked").length;

        if (checkedCheckboxes === 0) {
            event.preventDefault(); // 기본 동작 방지 (페이지 이동)
            $('#modal2').show(); // 모달 창 표시
        } else {
            submitOrderForm(); // 체크된 항목이 있을 경우 폼 제출
        }
    });

    // 모달의 확인 버튼 클릭 시 모달 숨기기
    $('#cancelSelectOrder').on('click', function() {
        $('#modal2').hide(); // 모달 창 숨기기
    });

    // 모달 클릭 시 닫기 (모달 외부 클릭 시)
    $(document).on('click', '#modal2', function(event) {
        if (event.target === this) {
            $('#modal2').hide(); // 모달 창 숨기기
        }
    });

    // 주문 폼 제출 함수
    function submitOrderForm() {
        let form_contents = '';
        let orderNumber = 0;

        $(".cart_info_td").each(function(index, element) {
            if ($(element).find(".individual_cart_checkbox").is(":checked")) { // 체크 여부

                let PCODE = $(element).find(".individual_pcode_input").val();
                let PCOUNT = $(element).find(".individual_pcount_input").val();
                let RCODE = $(element).find(".individual_cart_checkbox").val(); // rcode 값 가져오기

                let PCODE_input = "<input name='orders[" + orderNumber + "].pcode' type='hidden' value='" + PCODE + "'>";
                let PCOUNT_input = "<input name='orders[" + orderNumber + "].pcount' type='hidden' value='" + PCOUNT + "'>";
                let RCODE_input = "<input name='orders[" + orderNumber + "].rcode' type='hidden' value='" + RCODE + "'>"; // rcode 필드 추가

                form_contents += PCODE_input;
                form_contents += PCOUNT_input;
                form_contents += RCODE_input;

                orderNumber += 1;
            }
        });

        $(".order_form").html(form_contents);
        $(".order_form").submit();
    }
});
    
document.addEventListener('DOMContentLoaded', function() {
    function updateLayout() {
        const width = window.innerWidth;

        const table = document.querySelector('.custom-table');
        if (!table) return;

        if (width <= 768) {
            // 레이아웃 업데이트
            const cartInfoCells = document.querySelectorAll('.cart_info_td');
            const productWrappers = document.querySelectorAll('.product-wrapper');
            const productPriceCellsInTd = document.querySelectorAll('td .productprice');
            const hidden1ProductPrice = document.querySelectorAll('.hidden1.productprice');

            // Flexbox 설정
            cartInfoCells.forEach(cell => {
                cell.style.display = 'flex';
                cell.style.alignItems = 'center';
                cell.style.justifyContent = 'flex-start'; // 왼쪽 정렬
            });

            productWrappers.forEach(wrapper => {
                wrapper.style.display = 'flex';
                wrapper.style.alignItems = 'center';
            });

            // 숨기기 및 보이기 처리
            const hidden1Elements = document.querySelectorAll('.hidden1');
            const hidden2Elements = document.querySelectorAll('.hidden2');

            hidden1Elements.forEach(el => el.style.display = 'inline');
            hidden2Elements.forEach(el => el.style.display = 'none');

            // 화면 크기가 768px 이하일 때 td 안의 productprice 클래스를 가진 <span> 요소 숨기기
            productPriceCellsInTd.forEach(cell => {
                if (cell.closest('td')) {
                    cell.style.display = 'none'; // td 안의 productprice 숨기기
                }
            });

            // 화면 크기가 768px 이하일 때 hidden1 클래스를 가진 productprice 클래스를 가진 <span> 요소 보이기
            hidden1ProductPrice.forEach(cell => {
                cell.style.display = 'inline'; // hidden1 클래스가 붙은 productprice 보이기
            });

            // 테이블 레이아웃 조정
            table.style.tableLayout = 'fixed'; // 테이블 레이아웃을 고정으로 설정
            table.style.overflow = 'hidden'; // 테이블의 오버플로우 숨기기
        } else {
            // 기본 display 값으로 복원
            const cartInfoCells = document.querySelectorAll('.cart_info_td');
            const productWrappers = document.querySelectorAll('.product-wrapper');
            const productPriceCellsInTd = document.querySelectorAll('td .productprice');
            const hidden1ProductPrice = document.querySelectorAll('.hidden1.productprice');
            const hidden2ProductPrice = document.querySelectorAll('.hidden2.productprice');

            cartInfoCells.forEach(cell => {
                cell.style.display = '';
                cell.style.alignItems = '';
                cell.style.justifyContent = '';
            });

            productWrappers.forEach(wrapper => {
                wrapper.style.display = '';
                wrapper.style.alignItems = '';
            });

            // 숨기기 및 보이기 처리
            const hidden1Elements = document.querySelectorAll('.hidden1');
            const hidden2Elements = document.querySelectorAll('.hidden2');

            hidden1Elements.forEach(el => el.style.display = 'none');
            hidden2Elements.forEach(el => el.style.display = 'inline');

            // 화면 크기가 768px 이상일 때 td 안의 productprice 클래스를 가진 <span> 요소 보이기
            productPriceCellsInTd.forEach(cell => {
                if (cell.closest('td')) {
                    cell.style.display = ''; // td 안의 productprice 보이기
                }
            });

            // 화면 크기가 768px 이상일 때 hidden1 클래스를 가진 productprice 클래스를 가진 <span> 요소 숨기기
            hidden1ProductPrice.forEach(cell => {
                cell.style.display = 'none'; // hidden1 클래스가 붙은 productprice 숨기기
            });

            // 테이블 레이아웃 복원
            table.style.tableLayout = ''; // 기본 테이블 레이아웃으로 복원
            table.style.overflow = ''; // 기본 오버플로우 설정으로 복원
        }
    }

    // 페이지 로드 시 레이아웃을 한 번 확인
    updateLayout();

    // 창 크기 조정 시 레이아웃 업데이트
    window.addEventListener('resize', updateLayout);
});
</script>
</head>
<body class="nanum-gothic-regular overflow-x-hidden">
	<div id="wrapper">
    <jsp:include page="/modules/header.jsp"></jsp:include>  
    <jsp:include page="/modules/onlyTop.jsp"></jsp:include>
    <div class="container">
    <div class="stepcontainer">
    <h1 class="h1reserve">장바구니</h1>
    <ul class="stepul">
        <li class="stepli d-none d-md-table-cell">① 장바구니</li>
        <li class="stepli d-none d-md-table-cell">② 결제서</li>
        <li class="stepli d-none d-md-table-cell">③ 결제완료</li>
    </ul>
	</div>
        <hr/>
        <c:if test="${totalCount > 0}">
            <h3 class="d-none d-md-table-cell">${totalCount} <span class="itemCount">개 상품이 장바구니에 등록되었습니다</span></h3>
        </c:if>
        <div class="mb-3">
           
        </div>
        <span>
		  <input type="checkbox" id="selectAll"/>
		  <strong>선택</strong>&nbsp;&nbsp;
		  <button class="btn selectdelete_btn" style="border: none; background-color: #19a26e; color: white;">상품삭제</button>
		</span>
        <c:choose>
            <c:when test="${totalCount le 0}">
                <div class="text-center my-5">
                    <h3>장바구니에 상품이 없습니다</h3>
                    <a href="/product/list?ptype=곡물" class="btn btn-success btn-lg">상품보러 가기</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table">
                    <table class="custom-table">
                        <thead>
                            <tr>
                                <th></th>
					            <th class="wide-cell">상품 정보</th>
					            <th>상품가</th>
					            <th>수량</th>
					            <th>구매 예정 금액</th>
					            <th>선택</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${reserveList}" var="reserve">
                                <tr>
                                    <td class="cart_info_td">
									    <input type="checkbox" class="individual_cart_checkbox" name="reserveAll" value="${reserve.rcode}" />
									    <span class="productname hidden1"><strong>[${reserve.fname}]</strong>&nbsp; ${reserve.pname}</span>
									    <button type="button" class="btn close_btn trash hidden1">🗑️</button>
									    <input type="hidden" class="individual_price_input" value="${reserve.price}">
									    <input type="hidden" class="individual_pcount_input" value="${reserve.pcount}">
									    <input type="hidden" class="individual_rprice_input" value="${reserve.price * reserve.pcount}">
									    <input type="hidden" class="individual_pcode_input" value="${reserve.pcode}">
									</td>

                                    <td>
									    <div class="product-wrapper">
									        <div class="image-container">
									            <a href="${pageContext.request.contextPath}/product/detail/${reserve.pcode}" class="image-link">
									                <img src="${pageContext.request.contextPath}/resources/img/${reserve.pimg.split(',')[0]}"
									                     alt="${reserve.pname}"
									                     class="img-fluid img-rounded"
									                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/default.jpg';">
									                <div class="image-overlay">${reserve.pname}</div>
									            </a>
									        </div>
									        <div class="d-flex flex-column" style="text-align: left;">
											    <div class="ms-2 flex-grow-1 hidden2">
											    <div class="d-flex flex-column">
											        <span style="font-size: 16px;"><strong>[${reserve.fname}]</strong></span>
											        <a href="${pageContext.request.contextPath}/product/detail/${reserve.pcode}" class="product-link no-underline black-text" style="font-size: 16px;">
											            <span style="font-size: 18px;">${reserve.pname}</span>
											        </a>
											        </div>
											        </div>
											    
											    <div class="row">
											        <!-- 상품가와 가격을 4:8로 나누는 첫 번째 행 -->
											        <div class="col-6">
											            <span class="hidden1">상품가</span>
											        </div>
											        <div class="col-6">
											            <span class="productprice hidden1" data-price="${reserve.price}">${reserve.price}</span>
											        </div>
											    </div>
											    
											    <div class="row">
											        <!-- 총 가격과 금액을 4:8로 나누는 두 번째 행 -->
											        <div class="col-6">
											            <span class="hidden1">총 가격</span>
											        </div>
											        <div class="col-6">
											            <span class="rprice hidden1">${reserve.rprice}</span>
											        </div>
											    </div>
											</div>
								</div>
									</td>
									<td><span class="productprice hidden2" data-price="${reserve.price}" style="font-size: 18px;">${reserve.price}</span></td>
                                    <td>
									    <div class="quantity-wrapper">
									        <form action="/reserve/update" method="post">
									            <input name="rcode" type="hidden" value="${reserve.rcode}"/>
									            <input name="rprice" type="hidden" class="individual_rprice_input" value="${reserve.price * reserve.pcount}"/>
									            <div class="d-flex align-items-center">
									                <button type="button" class="btn border-only quantity_btn minus_btn">-</button>
									                <input type="text" name="pcount" value="${reserve.pcount}" class="form-control quantity_input" min="1" max="20" required>
									                <button type="button" class="btn border-only quantity_btn plus_btn">+</button>
									                <button type="submit" class="btn ms-2 quantity_modify_btn">변경</button>
									            </div>
									        </form>
									    </div>
									</td>
                                    <td><span class="rprice hidden2">${reserve.rprice}</span></td>
                                    <td>
									    <form method="get" action="/order/myOrderList">
										    <input type="hidden" name="orders[0].rcode" value="${reserve.rcode}" />
										    <input type="hidden" name="orders[0].pcode" value="${reserve.pcode}" />
										    <input type="hidden" name="orders[0].pcount" value="${reserve.pcount}" />
										    <input type="submit" class="btn btn-success d-none d-md-table-cell" value="바로 구매" />
										</form>
									    <button type="button" class="btn close_btn trash hidden2">🗑️</button>
									</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>       
     			<div class="totalcontainer">
			    <div class="info-container">
			        <p class="totalproduct1 d-none d-md-table-cell">총 주문 상품수&nbsp;&nbsp;
			            <span class="totalCount_span totalproduct2 number"></span><span class="unit">개</span></p>
			        <p class="totalproduct1">총 합계 금액&nbsp;
			            <span class="totalPrice_span totalproduct2 number"></span><span class="unit"></span></p>
			    	<button class="btn btn-success order_btn orderPage confirmDelete">
    					<span id="orderSummary"></span>
					</button>
			    </div>
			</div>
                <a href="/product/list?ptype=곡물" style="background-color: transparent; border: none; color: #333333; text-decoration: underline; font-size: 19px; margin-bottom: 10px;" class="btn me-2">&lt; 쇼핑 계속하기</a>
            </c:otherwise>
        </c:choose>
    </div>
   <jsp:include page="/WEB-INF/views/reserve/reservePagenation.jsp"></jsp:include> 
    <!-- 주문 form -->
			<form action="/order/myOrderList" method="GET" class="order_form">
			</form>
			
    <!-- Modal HTML -->
<div id="modal" class="modal">
    <div class="modal_popup">
        <h4>해당 상품을 삭제하시겠습니까?</h4>
        <div class="button_wrapper">
            <button id="confirmDelete" class="btn btn-primary">예</button>
            <button id="cancelDelete" class="btn btn-secondary">아니오</button>
        </div>
    </div>
</div>
<div id="modal1" class="modal">
    <div class="modal_popup">
        <h4>선택된 상품을 장바구니에서 삭제하시겠습니까?</h4>
        <div class="button_wrapper">
            <button id="confirmSelectDelete" class="btn btn-primary">예</button>
            <button id="cancelSelectDelete" class="btn btn-secondary">아니오</button>
        </div>
    </div>
</div>
<div id="modal2" class="modal">
    <div class="modal_popup">
        <h4>선택된 상품이 없습니다. 상품을 선택해 주세요.</h4>
        <div class="button_wrapper">
            <button id="cancelSelectOrder" class="btn btn-secondary">확인</button>
        </div>
    </div>
</div>
</div>
<jsp:include page="/modules/footer.jsp"></jsp:include>
</body>
</html>