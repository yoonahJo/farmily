<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head> 
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${not empty keyword}">
                '${keyword}'의 상품 검색결과
            </c:when>
            <c:otherwise>
                상품 목록
            </c:otherwise>
        </c:choose>
    </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="/resources/css/topAndCart.css" rel="stylesheet">
    <style>
        .row {
            justify-content: flex-start;
        }
       
        a { text-decoration: none; }
       
        .modal-backdrop.show {
            opacity: 0.1;
        }
        #pay {
            background: #19a26e;
            outline: none;
            border: none; 
        }
        .pagination .page-item.active .page-link {
            background-color: #19a26e;
            border-color: #19a26e;
            color: white;
        }
        .pagination .page-link {
            color: black;
        }
        .product-card {
            height: 100%;
            overflow: hidden;
            text-align: center;
        }
        .product-card img {
            width: 70%;
            height: auto;
        }
        .product-card .product-buttons {
            margin-top: 10px;
        }
        @media (max-width: 576px) {
            .product-card {
                margin-bottom: 20px;
            }
        }
        
        
    </style>
</head>
<body class="nanum-gothic-regular">
    <jsp:include page="/modules/header.jsp"></jsp:include>  
    <jsp:include page="/modules/topAndCart.jsp"></jsp:include>
    <br><br><h1 class="text-center fw-bold">
       <c:choose>
            <c:when test="${not empty keyword}">
                '${keyword}'의 상품 검색결과
            </c:when>
            <c:when test="${ptype == '곡물'}">
                곡물 상품
            </c:when>
            <c:when test="${ptype == '채소'}">
                채소 상품
            </c:when>
            <c:otherwise>
                전체 상품
            </c:otherwise>
        </c:choose>
    </h1>
    <!-- 검색 폼 추가 -->
    <div class="container mt-4">
        <form id="searchForm" class="d-flex position-relative" action="${pageContext.request.contextPath}/product/list" method="get">
            <input style="height: 52px;" id="searchInput" class="form-control me-2" type="search" placeholder="검색어를 입력해 주세요" aria-label="Search" name="keyword" value="${keyword}" required>
            <button style="right: 0.5%" id="pay" class="position-absolute btn btn-secondary rounded-end-2" type="submit">
                <img style="width: 40px; height: 40px;" src="${pageContext.request.contextPath}/img/search.svg" alt="search" title="search"/>
            </button>
        </form>
        <div id="error-message" class="text-danger mt-2" style="display: none;">검색어를 입력하세요.</div>
    </div>
    <div class="container my-5">
        <div class="row">
            <c:forEach var="product" items="${products}">
                <div class="col-12 col-sm-6 col-lg-4 mb-4">
                    <div class="product-card">
                        <a href="${pageContext.request.contextPath}/product/detail/${product.pcode}">
                            <img style="border-radius: 15px" src="${pageContext.request.contextPath}/img/${product.pimg}" alt="${product.pname}" title="${product.pname}" />
                        </a>
                        <div class="text-center px-1 pt-3">
                            <a href="${pageContext.request.contextPath}/product/detail/${product.pcode}">
                                <span class="d-block fs-5 text-dark" title="${product.pname}">${product.pname}</span>
                                <span class="d-block pt-3 fs-4 text-dark" title="${product.price}원">
                                    <fmt:formatNumber value="${product.price}" type="currency"/> 원
                                </span>
                            </a>
                        </div>
                        <div class="product-buttons">
                            <c:choose>
                                <c:when test="${fn:contains(role, 'A')}">
                                    <form action="/reserve/insert" method="post">
                                        <input type="hidden" name="pcode" value="${product.pcode}" />
                                        <input type="hidden" name="ptype" value="${product.ptype}" />
                                        <input type="hidden" name="pcount" value="1" />
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <form action="/reserve/insert" method="post">
                                        <input type="hidden" name="pcode" value="${product.pcode}" />
                                        <input type="hidden" name="ptype" value="${product.ptype}" />
                                        <input type="hidden" name="pcount" value="1" />
                                        <button type="button" class="btn btn-secondary add-to-cart" style="font-size:23px" title="장바구니" aria-label="상품을 장바구니에 추가">장바구니</button>
                                        <button id="pay" type="button" class="btn btn-success btn_buy" title="바로구매" style="font-size:23px" aria-label="상품을 바로구매">바로구매</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <jsp:include page="/WEB-INF/views/product/productPagination.jsp"></jsp:include>
    </div>

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
    	var reqUrl = '${reqUrl}'
    	if(reqBody){
    		if(reqUrl==='http://localhost:8080/reserve/insert'){
    			$.ajax({
    	            url: '/reserve/insert',
    	            type: 'POST',
    	            contentType: 'application/json',
    	            data: reqBody,
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
    		}		
    	}	
    	 // 현재 페이지를 가져오는 방법
        var currentPage = new URLSearchParams(window.location.search).get('page') || '';

        $('.add-to-cart').on('click', function(event) {
            event.preventDefault();
            var $form = $(this).closest('form');
            var pcode = $form.find('input[name="pcode"]').val();
            var pcount = $form.find('input[name="pcount"]').val();
            var ptype = $form.find('input[name="ptype"]').val();

            var data = JSON.stringify({
                pcode: pcode,
                pcount: pcount,
                ptype: ptype,
                page: currentPage // 페이지 정보 추가
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
                        $('.modal-body').text('이미 장바구니에 존재하는 상품에 수량을 추가하였습니다.');
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

        // 바로구매 버튼 클릭 이벤트 처리
        $(".btn_buy").on("click", function() {
            var $form = $(this).closest('form');
            var pcode = $form.find('input[name="pcode"]').val();
            var pcount = $form.find('input[name="pcount"]').val();
            var ptype = $form.find('input[name="ptype"]').val();

            $.ajax({
                url: '/reserve/oneInsert',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    pcode: pcode,
                    pcount: pcount,
                    ptype: ptype,
                    page: currentPage // 페이지 정보 추가
                }),
                success: function(response) {
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
                error: function(xhr) {
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