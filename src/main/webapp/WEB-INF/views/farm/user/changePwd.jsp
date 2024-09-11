<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>비밀번호 변경::farmily</title>
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
<div id="wrapper">
<jsp:include page="/modules/farmerHeader.jsp"></jsp:include>
<div class="d-flex justify-content-center">  
   <div class="col col-lg-5 border p-5 my-5 mx-3 bg-body rounded-3">
   		<div class="row mb-3"><p class="fw-bold fs-3 text-center">비밀번호 변경</p></div>
   		<hr/>
   		<div class="row my-3">
       		<form action="changePwd" method="post" id="changePwd">
       			<input type="hidden" class="form-control " name="id" value="${id}">
       	    <div class="row my-3">
          			<label for="password" class="col-lg-3 form-label fw-bold">현재 비밀번호</label>
          		<div class="col-lg-9">
          			<input type="password" class="form-control" id="password" name="password" required>
          		</div>
        	</div>
        	
        	<div class="row my-3">
          		<label for="newpassword" class="col-lg-3 form-label fw-bold">새 비밀번호</label>
          		<div class="col-lg-9">
          			<input type="password" class="form-control" id="newpassword" name="newpassword" 
          			pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$" required>
        		</div>
        	</div>
        	
        	<div class="row my-3">       
          		<label for="confirm_newpassword" class="col-lg-3 form-label fw-bold">새 비밀번호 확인</label>
          		<div class="col-lg-9">
          			<input type="password" class="form-control " id="confirm_newpassword"  
          			oninput="validatePassword()" required>
        		</div>
        	</div>
        	<div class="my-3 text-center">
        		<span>
        		<button type="button" class="btn btn-secondary" onclick="location.href='./info'">취소</button>
        		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        		<input type="submit" class="btn btn-success" value="변경"/>
        		</span>        
        	</div>
        </form>
        </div>
   </div>
</div>
</div>
<%@ include file="/modules/footer.jsp"%>
<script>	
	//비밀번호 체크
	var password = document.getElementById("newpassword")
		,confirm_password = document.getElementById("confirm_newpassword");

	function validatePassword(){
	if(password.value != confirm_password.value) {
 		 confirm_password.setCustomValidity("비밀번호가 일치하지 않습니다."); 
		} 
	else { 	
 		 confirm_password.setCustomValidity(''); //오류 메시지가 비어 있지 않으면 유효성 검사를 통과하지 않는다.
		}
	}
	password.onchange = validatePassword;
	confirm_password.onkeyup = validatePassword;
	
	$(function() {
	    $("#changePwd").submit(function(event) {
	        event.preventDefault(); 			
	        if (confirm('비밀번호를 수정하시겠습니까?')){
	        
	        $.ajax({
	            type: 'post',
	            url: './changePwd',
	            data: $("#changePwd").serialize(),
	            success: function(response) {
	            	console.log('서버에서 받은 데이터:', response);
	                if (response === "wrong") {
	                	alert('기존 비밀번호가 일치하지 않습니다.');
	                	location.replace('./changePwd');
	                	location.reload();
	                } else if (response === "fail") {
	                	alert('비밀번호 수정에 실패했습니다.');
	                	location.replace('./info');
	                } else if (response === "good") {
	                	alert('비밀번호가 수정되었습니다.');
	                	location.replace('./info');
	                } else {
	                	 console.error('예상치 못한 응답:', response);
	                }
	            },
	            error: function(xhr, status, error) {
	            	console.error('AJAX 오류 발생:', status, error);
	            }
	        });
	        }
	    });
	});
</script>	
</body>
</html>