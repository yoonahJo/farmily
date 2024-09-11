<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin :: 예약 등록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>




</head>
<body class="nanum-gothic-regular">
<%@ include file="/modules/aheader.jsp"%>
	<form action="/admin/reserve/insert" method="post" class="mt-5 mb-5">
		<div class="container">
			<div class="row">
				<div class="col-sm-2"></div>
				<div class="col-sm-8 text-center"><h2>예약등록</h2></div>
				<div class="col-sm-2"></div>
				<input type="hidden" class="form-control" id="pimg" name="pimg" required/>
			</div>

			<div class="row mt-5">
				<div class="col-sm-3"></div>
				<div class="col-sm-1"><label for="pcode">상품코드</label></div>
				<div class="col-sm-5"><div class="input-group">
					<input type="text" class="form-control" id="pcode" name="pcode" required readonly>
					<button id="selectProduct" type="button" class="btn btn-sm btn-outline-secondary"  data-bs-toggle="modal" data-bs-target="#productModal"  style="width:100px;">상품선택</button></div>
				</div>
				<div class="col-sm-3"></div>
			</div>
	
			<jsp:include page="modalProList.jsp" />
			
			<div class="row mt-3">
				<div class="col-sm-3"></div>
				<div class="col-sm-1"><label for="pname">상품이름</label></div> 
				<div class="col-sm-5"><input type="text" class="form-control" id="pname" name="pname" required readonly/></div>
				<div class="col-sm-3"></div>
			</div>
			
			<div class="row mt-3">
				<div class="col-sm-3"></div>
				<div class="col-sm-1"><label for="price">상품가격</label></div> 
				<div class="col-sm-5"><input type="text" class="form-control" id="price" name="price" required readonly/></div>
				<div class="col-sm-3"></div>
			</div>
			
			<div class="row mt-3">
				<div class="col-sm-3"></div>
				<div class="col-sm-1"><label for="fname">농장이름</label></div> 
				<div class="col-sm-5"><input type="text" class="form-control" id="fname" name="fname" required readonly/></div>
				<div class="col-sm-3"></div>
			</div>
			
			<hr>

			<div class="row mt-3">
				<div class="col-sm-3"></div>
				<div class="col-sm-1"><label for="id">회원아이디</label></div>
				<div class="col-sm-5"><div class="input-group">
					<input type="text" class="form-control" id="id" name="id" required readonly>
					<button id="selectUser" type="button" class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#userModal"  style="width:100px;">회원선택</button></div>
				</div>
				<div class="col-sm-3"></div>
			</div>
	
			<jsp:include page="modalUserList.jsp" />
			
			<div class="row mt-3">
				<div class="col-sm-3"></div>
				<div class="col-sm-1"><label for="uname">회원이름</label></div> 
				<div class="col-sm-5"><input type="text" class="form-control" id="uname" name="uname" required readonly/></div>
				<div class="col-sm-3"></div>
			</div>
			
			<div class="row mt-3">
				<div class="col-sm-3"></div>
				<div class="col-sm-1"><label for="phone">전화번호</label></div> 
				<div class="col-sm-5"><input type="text" class="form-control" id="phone" name="phone" required readonly/></div>
				<div class="col-sm-3"></div>
			</div>
			
			<div class="row mt-3">
				<div class="col-sm-3"></div>
				<div class="col-sm-1"><label for="uzcode">우편번호</label></div> 
				<div class="col-sm-5"><input type="text" class="form-control" id="uzcode" name="uzcode" required readonly/></div>
				<div class="col-sm-3"></div>
			</div>
			
			<div class="row mt-3">
				<div class="col-sm-3"></div>
				<div class="col-sm-1"><label for="uaddress">주소</label></div> 
				<div class="col-sm-5"><input type="text" class="form-control" id="uaddress" name="uaddress" required readonly/></div>
				<div class="col-sm-3"></div>
			</div>
			
			<hr>
			
			<div class="row mt-3">
				<div class="col-sm-3"></div>
				<div class="col-sm-1"><label for="pcount">수량</label></div> 
				<div class="col-sm-5"><input type="text" class="form-control" id="pcount" name="pcount" required/></div>
				<div class="col-sm-3"></div>
			</div>

			<div class="row mt-3">
				<div class="col-sm-3"></div>
				<div class="col-sm-1"><label for="rprice">총가격</label></div> 
				<div class="col-sm-5"><input type="text" class="form-control" id="rprice" name="rprice" required readonly/></div>
				<div class="col-sm-3"></div>
			</div>

			<div id="moveBtn" class="row mt-4 text-end">
				<div class="col-sm-9 text-end">
				<button type="button" onclick="location.href='/admin/reserve';" class="btn btn-secondary">예약관리</button>
				<button type="submit" id="submitBtn" class="btn btn-secondary">예약등록</button></div>
				<div class="col-sm-3"></div>
				
			</div>
	</div>
</form>
	
	
	

<script>
	document.addEventListener('DOMContentLoaded', function () {
    var selectProductButton = document.getElementById('selectProduct');
    var productModal = new bootstrap.Modal(document.getElementById('productModal'));
    var productList = document.getElementById('productList');
    
    selectProductButton.addEventListener('click', function () {
        fetch('/admin/reserve/productList')
            .then(response => response.text())
            .then(html => {
            	var parser = new DOMParser();
                var doc = parser.parseFromString(html, 'text/html');

                var newTbody = doc.querySelector('tbody');
                if (newTbody) {
                    productList.innerHTML = newTbody.innerHTML;
                }

                productModal.show(); // 모달 열기
            })
            .catch(error => console.error('Error loading product list:', error));
    });
     
    productList.addEventListener('click', function (event) {
    	if (event.target.tagName === 'BUTTON' && event.target.classList.contains('select-btn')) {
    		var productPcode = event.target.getAttribute('data-product-pcode');
    		var productPname = event.target.getAttribute('data-product-pname');
    		var productPrice = event.target.getAttribute('data-product-price');
    		var productFname = event.target.getAttribute('data-product-fname');
    		var productPimg = event.target.getAttribute('data-product-pimg');
         	document.getElementById('pcode').value = productPcode;
         	document.getElementById('pname').value = productPname;
         	document.getElementById('price').value = productPrice;
         	document.getElementById('fname').value = productFname;
         	document.getElementById('pimg').value = productPimg;
        	productModal.hide(); // 모달 닫기
        	}
    	});
    });
	
	
	
	document.addEventListener('DOMContentLoaded', function () {
	    var selectUserButton = document.getElementById('selectUser');
	    var userModal = new bootstrap.Modal(document.getElementById('userModal'));
	    var userList = document.getElementById('userList');
	    
	    selectUserButton.addEventListener('click', function () {
	        fetch('/admin/reserve/userList')
	            .then(response => response.text())
	            .then(html => {
	            	var parser = new DOMParser();
	                var doc = parser.parseFromString(html, 'text/html');

	                var newTbody = doc.querySelector('tbody');
	                if (newTbody) {
	                    userList.innerHTML = newTbody.innerHTML;
	                }
	            	
	                userModal.show(); // 모달 열기
	            })
	            .catch(error => console.error('Error loading user list:', error));
	    });
	    
	    userList.addEventListener('click', function (event) {
	    	if (event.target.tagName === 'BUTTON' && event.target.classList.contains('select-btn')) {
	    		var userId = event.target.getAttribute('data-user-uid');
	    		var userUname = event.target.getAttribute('data-user-uname');
	    		var userPhone = event.target.getAttribute('data-user-phone');
	    		var userUzcode = event.target.getAttribute('data-user-uzcode');
	    		var userUaddress = event.target.getAttribute('data-user-uaddress');
	         	document.getElementById('id').value = userId;
	         	document.getElementById('uname').value = userUname;
	         	document.getElementById('phone').value = userPhone;
	         	document.getElementById('uzcode').value = userUzcode;
	         	document.getElementById('uaddress').value = userUaddress;
	        	userModal.hide(); // 모달 닫기
	        	}
	    	});
	    });
	

	
	 document.addEventListener('DOMContentLoaded', function () {
	        var priceInput = document.getElementById('price');
	        var countInput = document.getElementById('pcount');
	        var totalPriceInput = document.getElementById('rprice');
	        
	        function updateTotalPrice() {
	            var price = parseFloat(priceInput.value.replace(/,/g, '')) || 0;
	            var count = parseInt(countInput.value, 10) || 0;
	            var totalPrice = price * count;
	            totalPriceInput.value = totalPrice
	        }

	        priceInput.addEventListener('input', updateTotalPrice);
	        countInput.addEventListener('input', updateTotalPrice);
	    });
</script>
<%@ include file="/modules/footer.jsp"%>
</body>

</html>