<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin :: 주문 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // Show confirmation modal with form
            window.showConfirmationModal = function(form) {
                $('#confirmationModal').data('form', form).modal('show');
            };
        });
    </script>
    <style>
        .table th, .table td {
            width: 25%; /* 비율 조정 */
            font-size: 1.2rem; /* 테이블 텍스트 크기 */
        }
        .page-title {
            text-align: center;
            font-size: 2.5rem; /* 제목 크기 */
            margin-bottom: 30px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }
        h2 {
            font-size: 2rem; /* 섹션 제목 크기 */
        }

        .btn-container a {
            font-size: 1.2rem; /* 버튼 텍스트 크기 */
        }
    </style>
</head>
<body class="nanum-gothic-regular">
    <jsp:include page="/modules/aheader.jsp"></jsp:include><br><br>
    <div class="container mt-4">
        <h1 class="page-title">주문 상세 정보</h1><!--        -->

        <!-- 결제 정보 섹션 -->
        <h2>결제 정보</h2>
        <table class="table table-bordered">
            <tbody>
                <tr>
                    <th scope="row">결제완료 여부</th>
                    <td><c:out value="${payDetail.rstate}"/></td>
                </tr>
                <tr>
                    <th scope="row">결제코드</th>
                    <td><c:out value="${payDetail.merchant_uid}"/></td>
                </tr>
                <tr>
                    <th scope="row">결제번호</th>
                    <td><c:out value="${payDetail.paycode}"/></td>
                </tr>
                <tr>
                    <th scope="row">주문번호</th>
                    <td><c:out value="${payDetail.imp_uid}"/></td>
                </tr>
                <tr>
                    <th scope="row">결제날짜</th>
                    <td><fmt:formatDate value="${payDetail.paydate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <th scope="row">결제방법</th>
                    <td><c:out value="${payDetail.pay_method}"/></td>
                </tr>
                <tr>
                    <th scope="row">결제가격</th>
                    <td><fmt:formatNumber value="${payDetail.unitPrice}" pattern="#,###" />원</td>
                </tr>
            </tbody>
        </table><br>

        <!-- 상품 정보 섹션 -->
        <h2>상품 정보</h2>
        <table class="table table-bordered">
            <tbody>
                <tr>
                    <th scope="row">판매농장</th>
                    <td><c:out value="${payDetail.fname}"/></td>
                </tr>
                <tr>
                    <th scope="row">농장 사업자 번호</th>
                    <td><c:out value="${payDetail.fnum}"/></td>
                </tr>
                <tr>
                    <th scope="row">상품코드</th>
                    <td><c:out value="${payDetail.code}"/></td>
                </tr>
                <tr>
                    <th scope="row">상품명</th>
                    <td><c:out value="${payDetail.name}"/></td>
                </tr>
                <tr>
                    <th scope="row">구매 개수</th>
                    <td><c:out value="${payDetail.quantity}"/>개</td>
                </tr>
            </tbody>
        </table><br>

        <!-- 회원 정보 섹션 -->
        <h2>회원 정보</h2>
        <table class="table table-bordered">
            <tbody>
                <tr>
                    <th scope="row">회원 ID</th>
                    <td><c:out value="${payDetail.id}"/></td>
                </tr>
                <tr>
                    <th scope="row">회원 이름</th>
                    <td><c:out value="${payDetail.buyer_name}"/></td>
                </tr>
                <tr>
                    <th scope="row">회원 이메일</th>
                    <td><c:out value="${payDetail.buyer_email}"/></td>
                </tr>
                <tr>
                    <th scope="row">회원 연락처</th>
                    <td><c:out value="${payDetail.buyer_tel}"/></td>
                </tr>
                <tr>
                    <th scope="row">회원 주소</th>
                    <td><c:out value="${payDetail.buyer_addr}"/></td>
                </tr>
                <tr>
                    <th scope="row">회원 우편번호</th>
                    <td><c:out value="${payDetail.buyer_postcode}"/></td>
                </tr>
            </tbody>
        </table><br>

        <!-- 배송 및 상태 정보 섹션 -->
        <h2>배송 정보</h2>
        <table class="table table-bordered">
            <tbody>
                <tr>
                    <th scope="row">배송상태</th>
                    <td>
                        <c:choose>
                            <c:when test="${payDetail.dstate == '배송전'}">
                                <span class="text-danger fw-bold"><c:out value="${payDetail.dstate}"/></span>
                            </c:when>
                            <c:when test="${payDetail.dstate == '배송중'}">
                                <span class="text-primary fw-bold"><c:out value="${payDetail.dstate}"/></span>
                            </c:when>
                            <c:when test="${payDetail.dstate == '배송완료'}">
                                <span class="text-success fw-bold"><c:out value="${payDetail.dstate}"/></span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-muted fw-bold"><c:out value="${payDetail.dstate}"/></span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <c:if test="${payDetail.dstate != '배송전'}">
                    <tr>
                        <th scope="row">배송 시작 날짜</th>
                        <td><fmt:formatDate value="${payDetail.baesongdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                </c:if>
            </tbody>
        </table><div style="display: flex; justify-content: center;">
    <a href="${pageContext.request.contextPath}/admin/pay" class="btn btn-secondary">목록</a>
</div>

    </div>
            
<br>
<br>
    <jsp:include page="/modules/footer.jsp"></jsp:include>
</body>
</html>
