<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>결제 완료</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
		html, body {
		    height: 100%; /* 전체 페이지 높이 100%로 설정 */
		}
		body {
		    display: flex;
		    flex-direction: column;
		}
		#wrapper {
		    flex: 1; /* 래퍼가 화면을 가득 채우도록 설정 */
		    display: flex;
		    flex-direction: column;
		}
		#content {
		    flex: 1; /* 내용이 남는 공간을 차지하도록 설정 */
		}
		.container {
		    width: 60%; /* 원하는 너비로 조정, 예: 80% */
		    max-width: 1000px; /* 최대 너비를 설정하여 화면 크기에 따라 너비가 너무 커지지 않도록 함 */
		    margin: 0 auto; /* 중앙 정렬 */
		}
		
        .stepcontainer {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .h1reserve {
            margin-top: 50px;
            padding: 0;
        }
        ul.stepul {
            display: table;
            border-collapse: collapse;
            margin-top: 70px;
            padding: 10px;
            list-style: none;
        }
        ul.stepul li.stepli {
            display: table-cell;
            padding: 10px 20px;
            border: 1px solid #ddd;
            text-align: center;
            vertical-align: middle;
        }
        ul.stepul li.stepli:not(:last-child) {
            border-right: none;
        }
        ul.stepul li:nth-child(3) {
            background-color: #444444;
            font-weight: bold;
            color: white;
        }
        .order-info {
            text-align: center; /* 가운데 정렬 */
            margin-top: 3px;
            font-size: 22px;
        }
        .order-info .order-number {
            color: green; /* 주문번호 글자 색상 초록색 */
            font-weight: bold; /* 주문번호 굵은 글씨 */
            font-size: 25px;
        }
        .info-con {
   			justify-content: space-between; /* 좌우 정렬 */
        	display: flex;
        	flex-direction: column; /* 세로 레이아웃 */
            margin-top: 70px;
            background-color: #e9f5e9; /* 테이블 배경색 옅은 그린색 */
            border: 1px solid #d0e2d0; /* 테두리 색상 */
            border-radius: 5px;
            padding: 7px;
            max-width: 700px;
            margin: 0 auto;
            width: 100%; /* 전체 너비를 100%로 설정하여 부모 컨테이너에 맞춤 */
    		box-sizing: border-box;\
		}
		
		.info-table {
		    border-collapse: collapse;
		    width:100%;
		    table-layout: auto;
    		margin: 0 auto; /* 테이블을 가운데 정렬 */
    		min-height: 140px; /* 테이블의 최소 높이 설정 */
    		max-height: 300px;
		}
		.info-table tr {
			font-size: 20px;
		}
		
		.info-table td, .info-table th {
		    border: 1px solid #ffffff; /* 셀 내부 테두리 색상 설정 (흰색) */
		    background-color: #ffffff; /* 셀 배경색을 흰색으로 설정 */
		     min-width: 100px;
		}
		.info-table th {
		    text-align: left;
		    background-color: #e0f4e2;
		    padding: 10px;
		    border-bottom: none; /* 아래쪽 테두리 없애기 */
		}
		.info-table td {
			text-align: left;
		    padding: 3px;
		    border-bottom: none; /* 아래쪽 테두리 없애기 */
		    word-break: break-word;
		}
		.info-section {
   			flex: 1; /* 각 섹션이 동일한 비율로 공간을 차지하도록 설정 */
		}
		.info-table td.align-right {
		    font-size: 17px;
		}
		.info-table td.align-right1 {
		    font-size: 17px;
		    width: 200px; /* 셀의 폭 조정 */
		}
		
		.info-table .label {
		    font-weight: bold;
		    font-size: 17px;
		    padding-left: 15px;
		}
		
		.align-right,
		.align-right1 {
		    text-align: right !important; /* 강제 오른쪽 정렬 */
		}
		
		.align-right {
		    font-size: 16px;
		    padding-right: 0;
		}
        .highlight-red {
            color: red;
            font-size: 20px;
            font-weight: bold;
        }
        .btn-container {
            text-align: center; /* 버튼 가운데 정렬 */
            margin-top: 30px;
            margin-top: 40px;
        }
        .btn-md {
            margin: 0 10px;
            font-size: 17px;
    		height: 40px; 
	    }
/* 모바일 화면용 테이블 스타일 */
.mobile-infomation {
    width: 100%;
    table-layout: auto;
    border-collapse: collapse;
    margin: 0;
    border: 1px solid #ddd; /* 카드 테두리 색상 */
}

.mobile-infomation th, .mobile-infomation td {
 border: none;
    padding: 10px;
    text-align: left;
    word-break: break-word; 
}
.mobile-infomation th {
    background-color: #e0f4e2;
    font-size: 20px; /* 제목 글자 크기 조정 */
    font-weight: bold;
}

.mobile-infomation td {
    background-color: #ffffff;
    font-size: 16px;
}
/* 각 항목의 너비를 다르게 설정하고 싶다면 */
.mobile-infomation td:first-child {
    width: 12 0px; /* '받는 분', '배송지'의 너비 */
}

/* 텍스트 오른쪽 정렬 스타일 */
.mobile-infomation td:last-child {
    text-align: right; /* 오른쪽 정렬 적용 */
}
.mobile-infomation .label {
    font-weight: bold;
}     
.container {
    width: 90% !important;
    margin: 0 auto;
}
.btn-md {
    margin: 0 10px;
    font-size: 17px;
	height: 40px; 
}

/* 모바일 화면에서 기존 테이블 숨기기 */
@media (max-width: 768px) {
    .info-container.d-md-flex {
        display: none; /* 모바일에서 숨기기 */
    }
    
    .info-container.d-md-none {
        display: block; /* 모바일에서 표시하기 */
        margin: 0;
    }
    .info-con {
        flex-direction: column; /* 모바일 화면에서 세로 레이아웃 */
    }
}
</style>
</head>
<body class="nanum-gothic-regular">
<jsp:include page="/modules/header.jsp"></jsp:include>  
    <div id="wrapper"><div id="content">
    <div class="container">
        <div class="stepcontainer">
            <h1 class="h1reserve">결제 완료</h1>
            <ul class="stepul">
				<li class="stepli d-none d-md-table-cell">① 장바구니</li>
                <li class="stepli d-none d-md-table-cell">② 결제서</li>
                <li class="stepli d-none d-md-table-cell">③ 결제완료</li>
            </ul>
        </div><br/><br class="d-none d-md-table-cell"/>
        <hr/>
        <h3 style="text-align: center;">결제가 정상적으로 완료되었습니다!</h3>
        <hr/><br class="d-none d-md-table-cell"/>
        
	<!-- 주문 목록이 비어 있지 않은 경우 -->
      <c:if test="${not empty myRecentList}">
    <c:set var="firstItem" value="${myRecentList[0]}" />

    <div class="order-info">
        <p>고객님의 주문번호는 <span class="order-number">${firstItem.merchant_uid}</span> 입니다.</p>
    </div><br class="d-none d-md-table-cell"/>

    <!-- 데스크톱 및 태블릿 화면용 정보 -->
<div class="info-con d-none d-md-flex">
    <div class="info-section">
        <table class="info-table">
            <thead>
                <tr><th colspan="2">배송 정보</th></tr>
            </thead>
            <tbody>
                <tr>
                    <td class="label">받는 분:</td>
                    <td class="align-right">${firstItem.buyer_name} / ${firstItem.buyer_tel}</td>
                </tr>
                <tr>                    
                	<td class="label">배송지:</td>
                    <td class="align-right">${firstItem.buyer_postcode} ${firstItem.buyer_addr}</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="info-section">
        <table class="info-table">
            <thead>
                <tr><th colspan="2">결제 정보</th></tr>
            </thead>
            <tbody>
                <tr>
                    <td class="label">주문금액:</td>
                    <td class="align-right1">
                        <fmt:formatNumber value="${firstItem.amount}" type="currency" currencySymbol="" /> 원
                    </td>
                </tr>
                <tr>
                    <td class="label">총 결제금액:</td>
                    <td class="align-right1">
                        <span class="highlight-red">
                            <fmt:formatNumber value="${firstItem.amount}" type="currency" currencySymbol="" />
                        </span> 원
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>  
             <!-- 모바일 화면용 정보 테이블 -->
    <div class="info-container1 d-md-none">
        <table class="mobile-infomation">
            <tbody>
                <tr>
                    <th colspan="2">배송 정보</th>
                </tr>
                <tr>
                    <td class="label">받는 분:</td>
                    <td>${firstItem.buyer_name} / ${firstItem.buyer_tel}</td>
                </tr>
                <tr>
                    <td class="label">배송지:</td>
                    <td>${firstItem.buyer_postcode} ${firstItem.buyer_addr}</td>
                </tr>
                <tr>
                    <th colspan="2">결제 정보</th>
                </tr>
                <tr>
                    <td class="label">주문금액:</td>
                    <td class="align-right">
                        <fmt:formatNumber value="${firstItem.amount}" type="currency" currencySymbol="" /> 원
                    </td>
                </tr>
                <tr>
                    <td class="label">총 결제금액:</td>
                    <td class="align-right">
                        <span class="highlight-red">
                            <fmt:formatNumber value="${firstItem.amount}" type="currency" currencySymbol="" />
                        </span> 원
                    </td>
                </tr>
            </tbody>
        </table>
    </div></c:if>
            <!-- 버튼 추가 -->
        <div class="btn-container">
            <a href="${pageContext.request.contextPath}/pay/payDetail/${firstItem.merchant_uid}" class="btn btn-success btn-md">배송 상세 보기</a>
            <a href="${pageContext.request.contextPath}/product/list?ptype=채소" class="btn btn-secondary btn-md">쇼핑 계속하기</a>
        </div></div></div><br/><br/>
    <jsp:include page="/modules/footer.jsp"></jsp:include>
    </div>
</body></html>