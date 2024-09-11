<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%

response.setHeader("Pragma", "No-Cache");
response.setHeader("Cache-Control", "No-Store");
response.setDateHeader("Expires", 0);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
.essential{
	color : #e65d91;
}
</style>
</head>
<jsp:include page="/modules/header.jsp"></jsp:include>
<body class="nanum-gothic-regular">
<div class="d-flex justify-content-center">
	<div class="col col-lg-6 p-3 mt-4 bg-body">
   	<div class="row "><p class="fw-bold fs-1 text-center">회원가입</p></div>
   	<div class="row my-3 mx-3"><span class="text-secondary"><strong class="essential">*</strong> 표시된 항목은 필수 입력 항목입니다.</span></div>
   		<div class="row mb-5 mx-3">
			<form action="/join" method="post" onsubmit="return validateForm(event)">
			<div class="row my-4 mt-5">
				<label for = "uname" class=" col-lg-3  form-label fw-bold "><span><strong class="essential">*</strong> 이름</span></label>
				<div class="col-lg-8">
					<input type="text" class="form-control " name="uname" id="uname" required>
				</div>
			</div>
			<div class="row my-4">
				<label for = "id" class=" col-lg-3 form-label  fw-bold "><span><strong class="essential">*</strong> 아이디</span></label>
				<div class="col-lg-6 mb-3">
					<input type="text" class="form-control " name="id" id="id" required>
				</div>
				<div class="col-lg-3">
					<button type="button" class="btn btn-success" onclick="checkId()">중복 체크</button>
				</div>				
			</div>		
			<div class="row my-4">
				<label for = "floatingPW" class=" col-lg-3 form-label   fw-bold "><span><strong class="essential">*</strong> 비밀번호</span></label>
				<div class="col-lg-8">
					<input type="password" name="password" id="floatingPW" class="form-control"
					pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$" required>
				</div>	
			</div>
			
			<div class="row my-4">
				<label for = "floatingChkPw" class=" col-lg-3 form-label   fw-bold "><span><strong class="essential">*</strong> 비밀번호 확인</span></label>
				<div class="col-lg-8">
					<input type="password" class="form-control" id="floatingChkPw" required>
					<span id="passwordMsg" class="d-none mt-2 text-secondary">비밀번호를 확인하세요.</span>
				</div>
				
			</div>
			
			<div class="row my-4">
				<label for = "birth" class=" col-lg-3 form-label   fw-bold "><span><strong class="essential">*</strong> 생년월일</span></label>
				<div class="col-lg-8">
					<input type="text" name="birth" id="birth" placeholder="19901003" class="form-control"
						required pattern="^(19[0-9][0-9]|20\d{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1])$">
				</div>		
			</div>
			
			<div class="row my-4">
				<div class=" col-lg-3  fw-bold "><span><strong class="essential">*</strong> 성별</span></div>
				<div class="col-lg-8 mt-2">
					<div class="form-check form-check-inline" >
						<label><input name="gender" class="form-check-input" type="radio" value="M" checked>남성</label>
					</div>			
					<div class="form-check form-check-inline">
						<label><input name="gender" class="form-check-input" type="radio" value="F">여성</label>
					</div>
				</div>
			</div>
					
			<div class="row my-4">
				<label for = "email" class=" col-lg-3 form-label   fw-bold "><span><strong class="essential">*</strong> 이메일</span></label>
				<div class="col-lg-8">
					<input type="email" id="email" name="email" class="form-control"
					required placeholder="farmily@gmail.com">
				</div>
			</div>
			
			<div class="row my-4">
				<label for = "phone" class=" col-lg-3 form-label   fw-bold "><span><strong class="essential">*</strong> 전화번호</span></label>
				<div class="col-lg-8">
					<input type="text" id="phone" name="phone" required placeholder="010-1234-5678"
						pattern="^01[016789]{1}-?[0-9]{4}-?[0-9]{4}$" class="form-control">
				</div>
			</div>
			
			<div class="row my-4">
				<div class=" col-lg-3   fw-bold "><span><strong class="essential">*</strong> 주소</span></div>
				<div class="col-lg-8">
					<div class="row my-2">
						<div class="col-sm-4 mb-2">		
							<input type="text" name="uzcode" id="postcode" placeholder="우편번호" class="form-control" required>
						</div>
						<div class="col-sm-4">	
							<input type="button" class="btn btn-secondary" onclick="execDaumPostcode()" value="우편번호 찾기">
						</div>
					</div>						
					<div class="my-2 row">
						<div class="col-lg mb-2">
							<input type="text" name="newAddress" id="roadAddress" placeholder="도로명주소"
							class="form-control"required>
						</div>
						<div class="col-lg">
							<input type="text" id="jibunAddress" placeholder="지번주소" class="form-control">
						</div>
					</div>
					<span id="guide" style="color:#999; display:none"></span>
					<div class="row my-2">
						<div class="col-lg mb-2">
							<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" class="form-control">
						</div>
						<div class="col-lg">
							<input type="text" id="extraAddress" placeholder="참고항목" class="form-control">
						</div>
					</div>
				</div>
			</div>	
			<hr>
			<div class="row p-3">
			 <div class="form-check my-4 ">
				<input class="form-check-input" type="checkbox" value="" id="toggleCheckbox">
					<label class="form-check-label fw-bold" for="toggleCheckbox">&nbsp;&nbsp;농부이신가요?</label>
			</div>
			</div>
			<div id="additionalFields" style="display: none;">
			<div class="row my-2">
				<label for = "fname" class=" col-lg-3 form-label   fw-bold "><span><strong class="essential">*</strong> 농장 이름</span></label>
				<div class="col-lg-8">
					<input type="text" id="fname" name="fname" class="form-control">
				</div>	
			</div>			
			<div class="row my-4">
				<label for = "fnum" class=" col-lg-3 form-label   fw-bold "><span><strong class="essential">*</strong> 농장 번호</span></label>
				<div class="col-lg-8">
					<input type="text" id="fnum" name="fnum" placeholder="123-45-67890"
					pattern="^[0-9]{3}-[0-9]{2}-[0-9]{5}$" class="form-control">
				</div>
			</div>			
			<div class="row my-4">
				<div class=" col-lg-3 fw-bold "><span><strong class="essential">*</strong> 농장 주소</span></div>
				<div class="col-lg-8">
					<div class="row my-2">
						<div class="col-sm-4 mb-2">
							<input type="text" name="fzcode" id="fpostcode" placeholder="우편번호" class="form-control" >
						</div>
						<div class="col-sm-4">
							<input type="button"  class="btn btn-secondary" onclick="farmerDaumPostcode()" value="우편번호 찾기">
						</div>
					</div>		
					<div class="row my-2">
						<div class="col-lg mb-2">
							<input type="text" name="fNewAddress" id="fNewAddress" placeholder="도로명주소" class="form-control">
						</div>
						<div class="col-lg">
							<input type="text" id="fjibunAddress" placeholder="지번주소" class="form-control">
						</div>
					</div>	
					<span id="fguide" style="color:#999; display:none"></span>
					<div class="row my-2">
						<div class="col-lg mb-2">
							<input type="text" name="fdetailAddress" id="fdetailAddress" placeholder="상세주소" class="form-control">
						</div>
						<div class="col-lg">	
							<input type="text" id="fextraAddress" placeholder="참고항목" class="form-control">
						</div>
					</div>
				</div>					
			</div>
			</div>
			<div class="text-center"><input type="submit" class="btn btn-success" value="회원가입"></div>		
			</form>
			</div>
			</div>
			</div>			
				<div class="modal" id="myModal">
				  <div style="max-width: 483px; top: 20%; right: 0.6%" class="modal-dialog">
				    <div class="modal-content">
				      <!-- Modal body -->
				      <div class="modal-body fw-bold fs-5" id="modalMessage"></div>
				      <button style='top: 5%; right: 1%' type='button' class='btn-close position-absolute shadow-none' data-bs-dismiss='modal'></button>
				      <!-- Modal footer -->
				      <div class="modal-footer border-top-0">
				        <button type="button" class="btn btn-success" data-bs-dismiss="modal">확인</button>
				      </div>
				    </div>
				  </div>
				</div>


		
	<script>
		$(document).ready(function() {
	        $("#joinform").on("keypress", function(event) {
	            if (event.keyCode === 13) {
	                event.preventDefault();
	            }
	        });
	    });
		
		document.getElementById('toggleCheckbox').addEventListener('change', function () {
            var additionalFields = document.getElementById('additionalFields');
            var farmerInputs = additionalFields.querySelectorAll('input');
            if (this.checked) {
                additionalFields.style.display = 'block';
                farmerInputs.forEach(function(input) {
                	if(input.name !== 'fjibunAddress' && input.name !== 'fdetailAddress' && input.id !== 'fextraAddress' ) {
                		input.required = true;  
                	}
                   
                });
            } else {
            	 additionalFields.style.display = 'none';
                 farmerInputs.forEach(function(input) {
                     input.required = false;
                 });
            }
        });
		
		var idChecked = false;
		function checkId() {
			const input = $('#id').val();
			
		
			if(input == "") {
				$(document).ready(function (){
					$("#modalMessage").text("아이디를 입력해주세요.");
		            $("#myModal").modal("show");
		         });
				return
			}
		
			$.ajax({
				url: '/checkId',
				type: 'POST',
				async: true,
				data: {
					"id": input
				},
				success: function(data){
					if(data) {
						$("#modalMessage").text("존재하는 아이디입니다.");
						idChecked = false;
					}
					else {
						$("#modalMessage").text("사용 가능한 아이디입니다.");
						idChecked = true;
					}
					$("#myModal").modal("show")
				},
				error: function(e){
					alert("error");
				}
			});
		}
		var pwd = document.getElementById("floatingPW");
		var chckPwd = document.getElementById("floatingChkPw");	
		var pwdMsg = document.getElementById("passwordMsg");
		function checkPass() {
			if(pwd.value !== chckPwd.value) {
				pwdMsg.classList.remove("d-none");
				pwdMsg.classList.add("d-block")
			}
			else { 	
				pwdMsg.classList.remove("d-block");
				pwdMsg.classList.add("d-none")
			}
		}
		
		pwd.onchange = checkPass;
		chckPwd.onkeyup = checkPass;
		
		function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	
	                var roadAddr = data.roadAddress;
	                var extraRoadAddr = '';
	
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("roadAddress").value = roadAddr;
	                document.getElementById("jibunAddress").value = data.jibunAddress;
	                
					
	            }
	        }).open();
	    }
		
		function farmerDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	
	                var roadAddr = data.roadAddress;
	                var extraRoadAddr = '';
	
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                document.getElementById('fpostcode').value = data.zonecode;
	                document.getElementById("fNewAddress").value = roadAddr;
	                document.getElementById("fjibunAddress").value = data.jibunAddress;
	                
					
	            }
	        }).open();
	    }
		
		function validateForm(event) {
	        if (!idChecked) {
	            event.preventDefault();
	            $("#modalMessage").text("ID 중복 체크를 해주세요.");
	            $("#myModal").modal("show")
	            return false;
	        }
	        return true;
	    }
		
	</script>
	<jsp:include page="/modules/footer.jsp"></jsp:include>
</body>
</html>