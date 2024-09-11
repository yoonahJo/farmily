<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>연동 확인</title>
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
svg {
	fill: #557722;
}
</style>
</head>
<body class="nanum-gothic-regular">
<svg xmlns="http://www.w3.org/2000/svg" class="d-none"> 
  <symbol id="check2-circle" viewBox="0 0 16 16">
    <path d="M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0z"></path>
    <path d="M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l7-7z"></path>
  </symbol>
</svg>
<div id="wrapper">
		<jsp:include page="/modules/header.jsp"></jsp:include>		
			
		<div class="container my-5">
  <div class="p-5 text-center  text-muted bg-body border border-dashed rounded-5">
  
    <svg class="bi mt-5 mb-3" width="48" height="48"><use xlink:href="#check2-circle"></use></svg>
    <p class="fs-1 fw-bold">연동 확인 페이지</p>
    <p class="col-lg-8 mx-auto text-muted my-3">
      기존에 <strong>farmily</strong>에 가입한 정보가 있습니다. <br>
      소셜 로그인 연동을 통해 기존 계정을 간편하게 이용할 수 있습니다.<br>
      소셜 로그인 연동을 하시겠습니까? 
    </p>
    <div class="d-inline-flex gap-2 mb-5">
    <form action="/connection" method="post">
					<input type="hidden" name="id" value="${user.id}"/>
					<input type="hidden" name="sns_name" value="${user.sns_name}"/>
					<input type="hidden" name="sns_id" value="${user.sns_id}"/>
					<input type="submit" class="d-inline-flex align-items-center btn btn-success btn-lg px-4 rounded-pill" value="소셜 로그인 연동">
	</form>    
    </div>
  </div>
</div>			
	</div>
	<jsp:include page="/modules/footer.jsp"></jsp:include>
</body>
</html>