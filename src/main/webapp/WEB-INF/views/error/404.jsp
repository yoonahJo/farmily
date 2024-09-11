<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Not Found</title>
<style>
html, body {height:100%}
#wrapper{
  height: auto;
  min-height: 100%;
  padding-bottom: 209px;
}
footer{
  height: 209px;
  position : relative;
  transform : translateY(-100%);
}
#des{
  	font-size:14px;
  	color:#777777;
  	margin: 40px 0 0 0; 	
  	}
.code{
	font-size:160px;
  	color:#8BD94B;
} 	  
</style>
</head>
<body>
<div id="wrapper" class="d-flex justify-content-center">

  	<div class="text-center my-auto align-items-center">
  		<div class="fw-bold code">404</div>
  		<div class="fw-bold fs-3">다시 한번 확인해주세요!</div>
 		<div id="des">
 			찾으려는 페이지의 주소가 잘못 입력되었거나,<br/>
 			주소의 변경 혹은 삭제로 인해 사용하실 수 없습니다.<br/>
 			입력하신 페이지의 주소가 정확한지 확인해주세요. 		
 		</div> 
 		<div class="my-3">
 			<button class="btn btn-success btn-sm fs-6" onClick="history.back()">이전 페이지</button>
 			<button class="btn btn-success btn-sm fs-6" onClick="location.href='/'">Farmily 홈</button>
 		</div>	
  	</div>


</div>
<jsp:include page="/modules/footer.jsp"/>
</body>
</html>