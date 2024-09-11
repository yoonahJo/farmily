<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product</title>
 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<jsp:include page="/modules/farmerHeader.jsp" flush="false" />
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="mb-4 text-center">상품수정</h2>
                
                <form action="${pageContext.request.contextPath}/farm/product/update" method="post" enctype="multipart/form-data">
                 <input type="hidden" name="page" value="${param.page}" />
 				   <input type="hidden" name="searchKeyword" value="${param.searchKeyword}" />
 				   <input type="hidden" name="existingFileName" value="${product.pimg != null ? product.pimg : ''}" />
                    <div class="mb-3">
                        <label for="pcode" class="form-label">상품코드</label>
                        <input type="text" class="form-control" id="pcode" name="pcode" value="${product.pcode}" readonly />
                    </div>
                    <div class="mb-3">
                        <label for="pname" class="form-label">상품명</label>
                        <input type="text" class="form-control" id="pname" name="pname" value="${product.pname}" required />
                    </div>
                    <div class="mb-3 row">
                        <div class="col-md-6">
                            <label for="ptype" class="form-label">종류</label>
                            <select class="form-select" id="ptype" name="ptype">
                                <option value="채소" ${product.ptype == '채소' ? 'selected' : ''}>채소</option>
                                <option value="곡물" ${product.ptype == '곡물' ? 'selected' : ''}>곡물</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="quality" class="form-label">상품등급</label>
                            <select class="form-select" id="quality" name="quality">
                                <option value="특상" ${product.quality == '특상' ? 'selected' : ''}>특상</option>
                                <option value="상" ${product.quality == '상' ? 'selected' : ''}>상</option>
                                <option value="중" ${product.quality == '중' ? 'selected' : ''}>중</option>
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="price" class="form-label">가격</label>
                        <input type="text" class="form-control" id="price" name="price" value="${product.price}" required />
                    </div>
                    <div class="mb-3">
                        <label for="creDate" class="form-label">생산일자</label>
                        <input type="date" class="form-control" id="creDate" name="creDate" 
                               value="<fmt:formatDate value='${product.creDate}' pattern='yyyy-MM-dd' />" required />
                    </div>
                    <div class="mb-3">
      					  <label for="uploadFiles" class="form-label">이미지</label>
      					  <input type="file" class="form-control" id="uploadFiles" name="uploadFiles" accept="image/*" multiple />
     					   <c:if test="${not empty product.pimg}">
    				        <!-- 기존 이미지 표시 -->
     			       <img src="${pageContext.request.contextPath}/resources/img/${fn:split(product.pimg, ',')[0]}" class="img-thumbnail mt-2" alt="${product.pname}" width="100" />
     					   </c:if>
   					 </div>
                    <div class="mb-3">
                        <label for="des" class="form-label">상품설명</label>
                        <textarea class="form-control" id="des" name="des" required>${product.des}</textarea>
                    </div>
                    <div class="mb-3">
                        <label for="id" class="form-label">농부아디</label>
                        <input type="text" class="form-control" id="id" name="id" value="${product.id}" readonly />
                    </div>
                    <div class="mb-3">
                        <label for="fname" class="form-label">농부이름</label>
                        <input type="text" class="form-control" id="fname" name="fname" value="${product.fname}" required />
                    </div>
                    <div class="mb-3">
                        <label for="fnum" class="form-label">농부전번</label>
                        <input type="text" class="form-control" id="fnum" name="fnum" value="${product.fnum}" />
                    </div>
                    <div class="mb-3">
                        <label for="faddress" class="form-label">농장주소</label>
                        <input type="text" class="form-control" id="faddress" name="faddress" value="${product.faddress}" />
                    </div>
                    <div class="mb-3">
                        <label for="fzcode" class="form-label">농장우편번호</label>
                        <input type="text" class="form-control" id="fzcode" name="fzcode" value="${product.fzcode}" />
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-success">수정</button>
                         <button type="button" class="btn btn-success" onclick="history.back()">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%@ include file="/modules/footer.jsp"%>
</body>
</html>