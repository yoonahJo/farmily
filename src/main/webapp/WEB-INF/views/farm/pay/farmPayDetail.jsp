<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <title>Farmer :: 결제상세</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .order-header {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .order-section {
            margin-bottom: 30px;
        }
        .order-section h2 {
            font-size: 1.5rem;
            border-bottom: 2px solid #28a745;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .order-summary img {
            border: 1px solid #dee2e6;
            padding: 5px;
            background-color: #ffffff;
            border-radius: 5px;
        }
    </style>
</head>
<body class="nanum-gothic-regular">
<jsp:include page="/modules/farmerHeader.jsp" flush="false" />
<div class="container my-5">
    <!-- 헤더 -->
    <div class="order-header d-flex justify-content-between align-items-center">
        <h2 class="mb-0">주문 상세 정보</h2>
        <!-- 발송 처리 버튼 -->
        <c:choose>
            <c:when test="${payDetail.dstate == '배송준비중'}">
                <form action="${pageContext.request.contextPath}/farm/pay/updateDeliveryState" method="post" style="display:inline;">
                    <input type="hidden" name="paycode" value="${payDetail.paycode}" />
                    <input type="hidden" name="newDstate" value="배송중" />
                    <input type="hidden" name="page" value="${param.page}" />
   					 <input type="hidden" name="searchKeyword" value="${param.searchKeyword}" />
                    <button type="submit" class="btn btn-success" onclick="return confirm('해당 상품을 배송중으로 처리하시겠습니까?');">
                        배송 처리
                    </button>
                </form>
            </c:when>
            <c:when test="${payDetail.dstate == '배송중'}">
                <button class="btn btn-secondary" disabled>배송중</button>
            </c:when>
            <c:otherwise>
                <button class="btn btn-secondary" disabled>배송 상태: ${payDetail.dstate}</button>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 주문 정보 섹션 -->
    <div class="order-section">
        <h2>주문 정보</h2>
        <table class="table table-bordered">
            <tr>
                <th>상품 주문번호</th>
                <td>${payDetail.merchant_uid}</td>
            </tr>
            <tr>
                <th>주문번호</th>
                <td>${payDetail.imp_uid}</td>
            </tr>
            <tr>
                <th>주문일자</th>
                <td><fmt:formatDate value="${payDetail.paydate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
            </tr>
            <tr>
                <th>구매자 아이디</th>
                <td>${payDetail.id}</td>
            </tr>
            <tr>
                <th>구매자 이름</th>
                <td>${payDetail.buyer_name}</td>
            </tr>
            <tr>
                <th>구매자 연락처</th>
                <td>${payDetail.buyer_tel}</td>
            </tr>
            <tr>
                <th>상품 주문상태</th>
                <td>${payDetail.rstate}</td>
            </tr>
        </table>
    </div>

    <!-- 상품 정보 섹션 -->
    <div class="order-section">
        <h2>상품 정보</h2>
        <div class="row">
            <div class="col-md-4 text-center">
                <c:if test="${not empty payDetail.pimg}">
                    <img src="${pageContext.request.contextPath}/resources/img/${payDetail.pimg}" class="img-fluid" alt="상품 이미지">
                </c:if>
            </div>
            <div class="col-md-8">
                <table class="table table-bordered">
                    <tr>
                        <th>상품 이름</th>
                        <td>${payDetail.name}</td>
                    </tr>
                    <tr>
                        <th>주문 수량</th>
                        <td>${payDetail.quantity}</td>
                    </tr>
                    <tr>
                        <th>총 주문 금액</th>
                        <td><fmt:formatNumber value="${payDetail.amount}" pattern="#,###" /> 원</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!-- 배송 정보 섹션 -->
    <div class="order-section">
        <h2>배송 정보</h2>
        <table class="table table-bordered">
            <tr>
                <th>수취인명</th>
                <td>${payDetail.buyer_name}</td>
            </tr>
            <tr>
                <th>배송지 주소</th>
                <td>${payDetail.buyer_addr}</td>
            </tr>
            <tr>
                <th>배송 기한</th>
                <td><fmt:formatDate value="${shippingDeadline}" pattern="yyyy-MM-dd" />(주문일로부터 3일이내)</td>
            </tr>
            <tr>
                <th>배송 상태</th>
                <td>${payDetail.dstate}</td>
            </tr>
            <tr>
                <th>배송 날짜</th>
                <td><fmt:formatDate value="${payDetail.baesongdate}" pattern="yyyy-MM-dd" /></td>
            </tr>
        </table>
    </div>

    
    <div class="order-actions d-flex justify-content-end">
        <a href="${pageContext.request.contextPath}/farm/pay?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" class="btn btn-success">목록</a>
    </div>
</div>
<%@ include file="/modules/footer.jsp"%>
</body>
</html>