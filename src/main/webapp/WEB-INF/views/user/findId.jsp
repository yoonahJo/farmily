<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디 찾기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
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
<div id='wrapper'>
<jsp:include page="/modules/header.jsp" flush="false" />

<div class="container-fluid">
<div class="d-flex justify-content-center">		
	<div class="container mt-5 col-lg-5 p-0" >
  		<ul class="nav nav-tabs nav-justified ">
    		<li class="nav-item">
      			<a class="nav-link active text-success" href="./findId">아이디 찾기</a>
    		</li>
    		<li class="nav-item">
      			<a class="nav-link text-secondary" href="./findPw">비밀번호 찾기</a>
    		</li>
  		</ul>
					
			<div id="findbody" >
			<p class="fw-bold fs-3 my-4 text-center">아이디 찾기</p>
			<form action="/findId" method="post" onsubmit="findId(event)">									
				
				<div class="form-floating my-3">
					<input type="text" class="form-control" name="uname" id="floatingUname" required>
					<label for="floatingUname">이름</label>
				</div>
				<div class="form-floating my-3">
					 <input type="email" class="form-control" name="email" id="floatingEmail">
					 <label for="floatingEmail">이메일</label>
				</div>

				<div class="text-center my-3">
					 <button class="btn btn-success" type="submit" >아이디 찾기</button>
				</div>					
				</form>
			</div>
		</div>	
	</div>
</div>	
</div>
<jsp:include page="/modules/footer.jsp"></jsp:include>
		<script type="text/javascript">
			  		function findId(event) {
			  			event.preventDefault();
			  			
			  			const input_uname = $('#floatingUname').val();
					  	const input_email = $('#floatingEmail').val();
					  	
					  	$.ajax({
							url: '/findId',
							type: 'POST',
							data: {
								"uname": input_uname,
								"email": input_email,
							},
							success: function(data){
								console.log(data);
								if(data){
									$(document).ready(function (){
										$("#modalMessage").text("이메일 전송을 완료했습니다. 이메일을 확인해주세요.");
							            $("#myModal").modal("show");
							         });
								}
								else {
									$(document).ready(function (){
										$("#modalMessage").text("입력한 이메일과 일치하는 회원이 없습니다.");
							            $("#myModal").modal("show");
							        });
								}
							},
							error: function(e){
								alert("error");
							}
						});
			  			
			  		}
				
			  	</script>
			  	
	<!-- The Modal -->
				<div class="modal" id="myModal">
				  <div style="max-width: 550px; top: 20%; right: 0.6%" class="modal-dialog">
				    <div class="modal-content">
				      <!-- Modal body -->
				      <div class="modal-body fw-bold fs-5" id="modalMessage"></div>
				      <button style="top: 5%; right: 1%" type="button" class="btn-close position-absolute shadow-none" data-bs-dismiss="modal"></button>
				      <!-- Modal footer -->
				      <div class="modal-footer border-top-0">
				        <button type="button" class="btn btn-success" data-bs-dismiss="modal">확인</button>
				      </div>
				    </div>
				  </div>
				</div>			  	
	</body>
</html>