<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <title>Admin :: 상품 상세</title>
    <style>
        .thumbnail-images img {
            cursor: pointer;
            width: 70px;
            height: 70px; /* 썸네일의 크기를 고정 */
            object-fit: cover; /* 썸네일 이미지가 잘리지 않도록 비율을 유지하며 컨테이너에 맞게 조정 */
            margin-right: 10px;
        }
        .main-image-container {
            width: 100%;
            max-width: 500px;
            height: 500px; /* 메인 이미지 영역의 높이를 고정 */
            display: block;
            margin: 0 auto;
            background-color: #f8f8f8; /* 빈 공간을 위한 배경색 */
            position: relative;
        }
        .main-image {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 이미지의 비율을 유지하며 컨테이너에 맞게 조정 */
            position: absolute;
            top: 0;
            left: 0;
        }
        
        
    </style>
</head>
<body class="nanum-gothic-regular">
<%@ include file="/modules/aheader.jsp"%>


<div class="container mt-5">
    <div class="row">
        <div class="col-md-5">
            <div class="main-image-container">
                <!-- 메인 이미지 -->
                <img id="mainImage" class="main-image" src="${pageContext.request.contextPath}/resources/img/${fn:split(product.pimg, ',')[0]}" alt="${product.pname}">
            </div>
            <!-- 썸네일 이미지들 -->
            <div class="thumbnail-images mt-3 d-flex justify-content-center">
                <c:forEach var="img" items="${fn:split(product.pimg, ',')}">
                    <img src="${pageContext.request.contextPath}/resources/img/${img}" alt="Thumbnail" onclick="changeImage(this.src)">
                </c:forEach>
            </div>
        </div>
    
        <div class="col-md-7">
            <h2 class="fw-bold">${product.pname}</h2>
            <p class="text-muted">상품코드: ${product.pcode}</p>
            <hr>
            
            <h3 class="text-danger"><fmt:formatNumber value="${product.price}" pattern="#,###" />원</h3>
            <p class="text-muted">등급: ${product.quality}</p>
            <hr>

            <p><strong>상품종류:</strong> ${product.ptype}</p>
            <p><strong>생산일자:</strong> <fmt:formatDate value="${product.creDate}" pattern="yyyy-MM-dd" /></p>
            <p><strong>등록일자:</strong> <fmt:formatDate value="${product.pregDate}" pattern="yyyy-MM-dd" /></p>
            <hr>
            
            <div>
                <h5>상품설명</h5>
                <h3 class="lh-lg">${product.des}</h3>
            </div>
            <hr>

            <div>
                <h5>농장 정보</h5>
                <p><strong>농부이름:</strong> ${product.fname}</p>
                <p><strong>농부ID:</strong> ${product.id}</p>
                <p><strong>농장번호:</strong> ${product.fnum}</p>
                <p><strong>농장주소:</strong> ${product.faddress}</p>
                <p><strong>농장우편번호:</strong> ${product.fzcode}</p>
            </div>

            <div class="mt-4">
             <!--    <a href="${pageContext.request.contextPath}/admin/product/updatePage/${product.pcode}?page=${param.page}&searchCondition=${param.searchCondition}&searchKeyword=${param.searchKeyword}" class="btn btn-warning btn-lg">수정하기</a>-->
                <a href="${pageContext.request.contextPath}/admin/product/delete/${product.pcode}?page=${param.page}&searchCondition=${param.searchCondition}&searchKeyword=${param.searchKeyword}" class="btn btn-secondary" onclick="return confirm('정말로 이 상품을 삭제하시겠습니까?');">삭제하기</a>
 				<a href="${pageContext.request.contextPath}/admin/product?page=${param.page}&searchCondition=${param.searchCondition}&searchKeyword=${param.searchKeyword}" class="btn btn-secondary">목록보기</a>
 
 

            </div>
        </div>
    </div>
</div>
<br><br>
<script>
    function changeImage(src) {
        document.getElementById('mainImage').src = src;
    }
</script>
<%@ include file="/modules/footer.jsp"%>
</body>
</html>