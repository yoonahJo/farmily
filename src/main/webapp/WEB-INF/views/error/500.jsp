<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Internal Error</title>
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
  		<div class="fw-bold code">500</div>
  		<div class="fw-bold fs-3">잠시후 다시 확인해주세요!</div>
 		<div id="des">
 			기술적인 문제로 서비스를 이용할 수 없습니다.<br/>
 			서둘러 문제를 해결하도록 하겠습니다.<br/>
 			잠시 후 다시 확인해주세요. 		
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