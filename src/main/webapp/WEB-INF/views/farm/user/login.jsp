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
<title>로그인::farmily</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"></script>
<style>
html, body {height:100%}
#wrapper{
  height: auto;
  min-height: 100%;
  padding-bottom: 160px;
}
footer{
  height: 160px;
  position : relative;
  transform : translateY(-100%);
}
</style>
</head>
	<body class="nanum-gothic-regular">
	<div id="wrapper">
		<jsp:include page="/modules/header.jsp"></jsp:include>
		<main>
			<br><br><br>
			<div style="max-width: 800px;" class="container">
				<nav class="mx-1 border-bottom-0">
					<div class="nav nav-tabs border-bottom-0" id="nav-tab" role="tablist">
					    <button style="max-width: 242px; height: 60px;" class="w-50 nav-link border-bottom-0 text-black" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="false">일반 로그인</button>
					    <button style="max-width: 242px; height: 60px;" class="w-50 nav-link active border-bottom-0 text-black" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="true">농부 로그인</button>
					</div>
				</nav>	
				<div class="tab-content" id="nav-tabContent">
				  <div class="tab-pane fade" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="1">
				 	<form class="p-3 mx-1 rounded-1 shadow-lg mb-5 border border-1" method="post" action="/login" id="loginform">
						<div class="mt-3 mt-sm-0 p-0">
							<h1 class="h3 mb-3 fw-bold">로그인</h1>
							<div class="form-floating my-4">
								<input type="text" class="form-control" name="id" id="floatingId-normal">
								<label for="floatingId-normal">아이디</label>
							</div>
							<div class="form-floating my-4 position-relative">
								<input type="password" class="form-control" name="password" id="floatingPw-normal">
								<div style="top: 28%; right: 1%;" class="position-absolute">
									<img id="hidePassword-normal" style="width: 30px; height: 30px; cursor: pointer;" src="${pageContext.request.contextPath}/img/eye-hide.svg" title="logo" alt="logo"/>
								</div>
								<label for="floatingPw-normal">비밀번호</label>
							</div>
							<button style="height: 58px;" class="btn btn-success w-100 py-2 my-4" type="submit">로그인</button>
							<button style="height: 58px;" class="btn btn-success w-100 mt-2 py-2 my-4" type="button" onclick="location.href='join'">회원가입</button>
							<div class="d-flex justify-content-between">
								<button style="width: 49%; height: 58px;" class="btn btn-success py-2 px-0" type="button" onclick="location.href='/findId'">
									<span class="">아이디 찾기</span>
								</button>
								<button style="width: 49%; height: 58px;" class="btn btn-success py-2 px-0" type="button" onclick="location.href='/findPw'">
									<span class="">비밀번호 찾기</span>
								</button>
							</div>
							<div class="d-block d-sm-flex  justify-content-sm-between mt-4 mb-2">
								<div>
									<a class="btn d-flex justify-content-center p-0" href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=f6a352809611dcbedb271d56ff68d255&redirect_uri=http://localhost:8080/kakao/login">
										<img style="max-width: 400px; max-height: 62px;" class="rounded-3 w-100 h-100" src="${pageContext.request.contextPath}/img/kakao-login.png" title="logo" alt="logo"/>
									</a>
								</div>
								<div class="mt-2 mt-sm-0">
									<a href="#" id="naverLogin" class="btn d-flex justify-content-center p-0">
										<img style="max-width: 400px; max-height: 62px;" class="rounded-3 w-100 h-100" src="${pageContext.request.contextPath}/img/naver-login.png" title="logo" alt="logo"/>
									</a>
								</div>
							</div>
							<div class="d-none" id="naverIdLogin"></div>
						</div>
					</form>
				  </div>
				  <div class="tab-pane fade show active" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">
				  	<form class="p-3 pt-5 mx-1 rounded-1 shadow-lg mb-5 border border-1" method="post" action="/farm/user/login">
						<div class="mt-3 mt-sm-0 p-0">
							<h1 class="h3 mb-3 fw-bold">농부 로그인</h1>
						    <div class="form-floating my-4">
						      <input type="text" class="form-control" name="id" id="floatingId-farmer">
						      <label for="floatingId-farmer">아이디</label>
						    </div>
						    <div class="form-floating my-4 position-relative">
						      <input type="password" class="form-control" name="password" id="floatingPw-farmer"/>
						      <div style="top: 28%; right: 1%;" class="position-absolute">
									<img id="hidePassword-farmer" style="width: 30px; height: 30px; cursor: pointer;" src="${pageContext.request.contextPath}/img/eye-hide.svg" title="logo" alt="logo"/>
								</div>
						      <label for="floatingPw-farmer">비밀번호</label>
						    </div>
					    	<button style="height: 58px;" class="btn btn-success w-100 py-2 my-3" type="submit">로그인</button>
							<button style="height: 58px;" class="btn btn-success w-100 py-2 my-3" type="button" onclick="location.href='/join'">회원가입</button>
							<div class="d-flex justify-content-between">
								<button style="width: 49%; height: 58px;" class="btn btn-success py-2 px-0 my-4" type="button" onclick="location.href='/findId'">
									<span class="">아이디 찾기</span>
								</button>
								<button style="width: 49%; height: 58px;" class="btn btn-success py-2 px-0 my-4" type="button" onclick="location.href='/findPw'">
									<span class="">비밀번호 찾기</span>
								</button>
							</div>			          			      
						</div>														
				  </form>
				 </div>
				</div>
			</div>	
			  <!-- The Modal -->
				<div class="modal" id="myModal">
				  <div style="max-width: 483px; top: 20%; right: 0.6%" class="modal-dialog">
				    <div class="modal-content">
				      <!-- Modal body -->
				      <div class="modal-body fw-bold fs-5" id="modalMessage">
				      </div>
				      <button style="top: 5%; right: 1%" type="button" class="btn-close position-absolute shadow-none" data-bs-dismiss="modal"></button>
				      <!-- Modal footer -->
				      <div class="modal-footer border-top-0">
				        <button type="button" class="btn btn-success" data-bs-dismiss="modal">확인</button>
				      </div>
				    </div>
				  </div>
				</div>
			  <script type="text/javascript">
			  	<c:if test="${not empty loginFailed }">
			  		 $(document).ready(function (){
			  			$("#modalMessage").text("${loginFailed}");
			  			$("#myModal").modal("show");
			         });
			  	</c:if>
			  	
			  	$('#loginform').submit(function(e) {
			        var id = $('#floatingId').val().trim();
			        var pw = $('#floatingPw').val().trim();
			        
			        if (id === '' || pw === '') {
			            e.preventDefault();
			            var message = id === '' ? '아이디를 입력해주세요.' : '비밀번호를 입력해주세요.';
			            $("#modalMessage").text(message);
			            $("#myModal").modal("show");
			        }
			    });
			  	
				
				var naverLogin = new naver.LoginWithNaverId({
					clientId: "IV6rbH78ubK2mBUImUaV",
					callbackUrl: "http://localhost:8080/oauth/login",
					isPopup: false,
					loginButton: {color: "green", type: 3, height: 80}
				});

				naverLogin.init();
				
				$(document).on("click", "#naverLogin", function(){ 
					var btnNaverLogin = document.getElementById("naverIdLogin").firstChild;
					btnNaverLogin.click();
				});
		
			    $(document).ready(function() {
			        $('#myButton').on('click', function() {
			            $(this).css('border-bottom', '2px solid #007bff'); // 원하는 색상으로 변경
			        });
			    });
			  </script>
			</div>
		</main>
		<jsp:include page="/modules/footer.jsp"></jsp:include>
	</body>
</html>