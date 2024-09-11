<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/css/font.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
</head>
	<body class="nanum-gothic-regular">
		<main>
			<div class="container mt-5">
				<form class="row rounded-3 shadow-lg p-3 mb-5 bg-body-tertiary" action="/resetPw/${code }" method="post" onsubmit="resetPw(event)">
					<div>
						<h1 class="fw-bold mt-4">비밀번호 재설정</h1>
						<br>
						<div class="form-floating my-2">
					      <input type="password" class="form-control"
					      name="password"
					      id="floatingPW"
					      placeholder="비밀번호 특수문자 포함 8자리 이상 입력"
					      pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$"
					      required>
					      <label for="floatingPW">비밀번호 특수문자 포함 8자리 이상 입력</label>
					    </div>
					    <div class="form-floating my-2">
					      <input type="password" class="form-control" id="floatingChkPw" required>
					      <label for="floatingChkPw">비밀번호 확인</label>
					      <span id="passwordMsg" class="d-none mt-2">비밀번호를 확인하세요.</span>
					    </div>
					    <button class="btn btn-success" type="submit" >재설정</button>
					</div>
				</form>
				<!-- The Modal -->
				<div class="modal" id="myModal">
				  <div style="max-width: 550px; top: 20%; right: 0.6%" class="modal-dialog">
				    <div class="modal-content">
				      <!-- Modal body -->
				      <div class="modal-body fw-bold fs-5" id="modalMessage"></div>
				      <!-- Modal footer -->
				      <div class="modal-footer border-top-0">
				        <button type="button" class="btn btn-success" data-bs-dismiss="modal">확인</button>
				      </div>
				    </div>
				  </div>
				</div>
				<script type="text/javascript">
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
				
			  		function resetPw(event) {
			  			event.preventDefault();
			  			
			  			const input_password = $('#floatingPW').val();
					  	
					  	$.ajax({
							url: './${code}',
							type: 'POST',
							data: {
								"password": input_password,
							},
							success: function(data){
								if(data){
									$(document).ready(function (){
										$("#modalMessage").text("비밀번호 재설정이 완료되었습니다. ");
							            $("#myModal").modal("show");
							         });
								}
								else {
									$(document).ready(function (){
										$("#modalMessage").html("만료된 코드입니다. 새롭게 비밀번호 찾기를 시도하세요. <br> 2초후 브라우저가 자동 만료됩니다. ");
							            $("#myModal").modal("show");
							            setTimeout(() => {
							            	window.close();
							            }, 2000);
							         });
								}
							},
							error: function(e){
								alert("error");
							}
						});
			  			
			  		}
				
			  	</script>
			</div>
		</main>
	</body>
	</body>
</html>