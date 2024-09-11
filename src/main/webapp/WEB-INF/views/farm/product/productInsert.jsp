<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Product</title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
    <script>
    
    function validatePcode(input) {
        var regex = /^[0-9\-]*$/; // 숫자와 '-'만 허용하는 정규식
        if (!regex.test(input.value)) {
            alert("상품 코드는 숫자와 '-'만 입력할 수 있습니다.");
            input.value = input.value.replace(/[^0-9\-]/g, ''); // 허용되지 않는 문자 제거
        }
    }
    
    function checkPcode() {
        var pcode = document.getElementById('pcode').value;  // 변수명 통일

        if (pcode.length > 0) {
            $.ajax({
                url: '/farm/product/checkPcode',
                method: 'GET',
                data: { pcode: pcode },  // 변수명 통일
                success: function(response) {
                    var pcodeMessage = document.getElementById('pcodeMessage');
                    if (response.available) {  
                        pcodeMessage.style.color = 'green';
                        pcodeMessage.textContent = '사용 가능한 상품 코드입니다.';
                    } else {
                        pcodeMessage.style.color = 'red';
                        pcodeMessage.textContent = '이미 사용 중인 상품 코드입니다.';
                    }
                },
                error: function() {
                    alert('중복 체크에 실패했습니다. 다시 시도하세요.');
                }
            });
        } else {
            alert('상품 코드를 입력하세요.');
        }
    }
    function checkPrice() {
        var priceInput = document.getElementById('price');
        var price = parseFloat(priceInput.value);

        if (price < 0) {
            alert('가격은 0 이상의 값만 입력할 수 있습니다.');
            priceInput.value = ''; // 잘못된 값을 초기화
            return false; // 폼 제출 방지
        }

        return true; // 폼 제출 허용
    }
</script>
</head>
<body class="nanum-gothic-regular">
<jsp:include page="/modules/farmerHeader.jsp" flush="false" />
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="mb-4 text-center">${product.fname} 상품등록</h2>
                <form action="/farm/product/insert" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
   					 <label for="pcode" class="form-label">상품코드</label>
   						 <div class="input-group">
   					     <input type="text" class="form-control" id="pcode" name="pcode" maxlength="10" required oninput="validatePcode(this)" />
    				    <button type="button" class="btn btn-secondary" onclick="checkPcode()">중복 체크</button>
 					   </div>
 						   <div id="pcodeMessage" class="form-text"></div>
						</div>
                    <div class="mb-3">
                        <label for="pname" class="form-label">상품명</label>
                        <input type="text" class="form-control" id="pname" name="pname" required />
                    </div>
                    <div class="mb-3 row">
                        <div class="col-md-6">
                            <label for="ptype" class="form-label">종류</label>
                            <select class="form-select" id="ptype" name="ptype">
                                <option value="채소">채소</option>
                                <option value="곡물">곡물</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="quality" class="form-label">상품등급</label>
                            <select class="form-select" id="quality" name="quality">
                                <option value="특상">특상</option>
                                <option value="상">상</option>
                                <option value="중">중</option>
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="price" class="form-label">가격</label>
                        <input type="number" class="form-control" id="price" name="price" min="0" required />
                    </div>
                    <div class="mb-3">
                        <label for="creDate" class="form-label">생산일자</label>
                        <input type="date" class="form-control" id="creDate" name="creDate" required />
                    </div>
                    <div class="mb-3">
                        <label for="uploadFiles" class="form-label">이미지</label>
                        <!-- 다중 파일 업로드 지원 -->
                        <input type="file" class="form-control" id="uploadFiles" name="uploadFiles" accept="image/*" multiple required />
                    </div>
                    <div class="mb-3">
                        <label for="des" class="form-label">상품설명</label>
                        <textarea class="form-control" id="des" name="des" rows="6" required></textarea>
                    </div>
                    
                    <input type="hidden" id="id" name="id" value="user1" />
                    
                    <div class="text-center">
                        <button type="submit" class="btn btn-success">등록</button>
                        <button type="button" class="btn btn-success" onclick="history.back()">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%@ include file="/modules/footer.jsp"%>
</body>
</html>