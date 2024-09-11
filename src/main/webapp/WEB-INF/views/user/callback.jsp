<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"></script>
</head>
<body>
<script type="text/javascript">
	var naverLogin = new naver.LoginWithNaverId({
		clientId: "IV6rbH78ubK2mBUImUaV",
		callbackUrl: "http://localhost:8080/",
		callbackHandle: true,
	});
	
	naverLogin.init();
	
	window.addEventListener('load', function () {
		naverLogin.getLoginStatus(function(status) {
	           if (status) {
	        	   var id = naverLogin.user.id
                   var email = naverLogin.user.email
                   var name = naverLogin.user.name
                   var gender = naverLogin.user.gender
                   var birthday = naverLogin.user.birthday
                   var birthyear = naverLogin.user.birthyear
                   var mobile = naverLogin.user.mobile
	               var reqUrl = '${reqUrl}'
	               var redirect = '${redirect}'
	               $.ajax({
	                   url: '/naver/login',
	                   type: 'POST',
	                   data: {
	                	   "sns_id":id,
	                	   "sns_name": name,
	                	   "email": email,
	                	   "gender": gender,
	                	   "birthday": birthday,
	                	   "birthyear": birthyear,
	                	   "mobile": mobile,
	                   },
	                   success: function(status) {
	                	   if(status === 'ok') {
	                		   location.replace("http://localhost:8080/")
	                	   }
	                	   else if(status === 'no') {
	                		   location.replace("http://localhost:8080/login")
	                	   }
	                	   else if(status === 'conn') {
	                		   location.replace("http://localhost:8080/connection")
	                	   }
	                	   else if(status === 'res') {
	                		   location.replace(reqUrl)
	                	   }
	                	   else if(status === 'redirect') {
	                		   location.replace(redirect)
	                	   }
	                   },
	                   error: function(error) {
	                       console.error("Error:", error);
	                   }
	               });
	           } else {
	               console.log("로그인 실패 또는 로그인 상태가 아닙니다.");
	           }
	       });
	});
</script>
</body>
</html>