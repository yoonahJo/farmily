<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
response.setHeader( "Pragma", "no-cache" );
response.setDateHeader( "Expires", -1 );
response.setHeader( "Cache-Control", "no-store" );
%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Farmer :: 내 정보</title>
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
    .page-title {
            text-align: center;
            font-weight: bold;
            font-size: 2rem;
            margin-bottom: 30px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }
</style>

</head>
<body class="nanum-gothic-regular">
<jsp:include page="/modules/farmerHeader.jsp" flush="false" />
<div class="d-flex justify-content-center"> 
	<div class="container-xxl my-3 mt-5">
   <h2 class="page-title">내 정보</h2>
   		<div class="row my-5 mx-3">
			<form action="/farm/user/info" method="post" id="update">
			<div class="row">
			<div class="col-lg me-5">
			<div class="row mb-4">
			<h4>농부 정보</h4>
			</div>        	
        	<div class="row my-4">
						<label for="id" class=" col-lg-3 form-label  fw-bold ">아이디</label>         
          	 	 		<div class="col-lg-9">
          	 				<input type="text" class="form-control " value="${user.id}" disabled></div>  
             				<input type="hidden" class="form-control " name="id" value="${user.id}">
       	 			</div>
    	 			<div class="row my-4">    	 				
       					<label for="password" class="col-lg-3 form-label  fw-bold ">비밀번호</label>
       					<div class="col-lg-9">
       					<div class="row px-2">	
       						<input type="password" class="form-control " name="password" required id="password"
       							placeholder="정보수정을 위해 비밀번호를 입력해주세요">
       						</div>      					
       					<div class="row my-3">
       					<span>
          					<button type="button" class="btn btn-success" onclick="location.href='./changePwd'">비밀번호 변경</button>
        				</span>
        				</div>
       					</div>
        			</div>
        			
       	 			
					<div class="row my-4">
          				<label for="uname" class="col-lg-3 form-label  fw-bold ">이름</label>          	
          				<div class="col-lg-9">
          				<input type="text" class="form-control " id="uname" name="uname" value="${user.uname}" required>
        				</div>
        			</div>
        				
        			<div class="row my-4">
        				<c:set var="birthval" value="${user.birth}" />
        				<c:set var="year" value="${fn:substring(birthval,0,4) }" />
        				<c:set var="month" value="${fn:substring(birthval,4,6) }" />
        				<c:set var="day" value="${fn:substring(birthval,6,9) }" />
          				<label for="birth" class="col-lg-3 form-label  fw-bold ">생년월일</label>         
          				<div class="col-lg-7">
          					<input type="text" class="form-control " id="birth" value="${year}년 ${month}월 ${day}일" required disabled>
        				</div>
        			</div>
        					          
        			<div class="row my-4">
          				<label for="phone" class="col-lg-3 form-label  fw-bold ">전화번호</label>
          				<div class="col-lg-9">
          				<input type="text" class="form-control " id="phone" name="phone" value="${user.phone}" 
          				pattern="^01[016789]{1}-?[0-9]{4}-?[0-9]{4}$" placeholder="010-1234-5678" required>
       					</div>
       				</div>
       		
        			<div class="row my-4">
          				<label for="email" class="col-lg-3 form-label  fw-bold ">이메일</label>
          				<div class="col-lg-9">
          				<input type="email" class="form-control " id="email" name="email" value="${user.email}" 
          				placeholder="farmily@gmail.com" required>
        				</div>
        			</div>
 
        			<div class="row my-4">
          				<label for="gender" class="col-lg-3 form-label  fw-bold ">성별</label>
          				<c:choose>
							<c:when test="${fn:contains(user.gender, 'M')}">
								<div class="col-lg-9">
								<input type="text" class="form-control " id="gender1" name="gender" value="남자" disabled>
								</div>
							</c:when>
							<c:otherwise>
								<div class="col-lg-9">
								<input type="text" class="form-control " id="gender2" name="gender" value="여자" disabled>
								</div>
							</c:otherwise>
		  				</c:choose>
       				</div>
       				
       				<c:set var="addressval" value="${user.uaddress}" />
         			<div class="row my-4 mb-5">
         				<div class="col-lg-3  fw-bold ">주소</div>
         				<div class="col-lg-9">
         					<input type="button" class="btn btn-secondary" onclick="execDaumPostcode()" value="주소 변경">	
							<div class="row my-3 mx-1">									
									<input type="text" class="form-control " name="uzcode" id="postcode" value="${user.uzcode}" required>
							</div>				
							<div class="row my-3 mx-1">
								<input type="text" class="form-control " name="uroadAddress" id="roadAddress" value="${fn:split(addressval,',')[0]}" required>
							</div>
							
							<div class="row my-3 mx-1">
								<input type="text" class="form-control " name="udetailAddress" id="detailAddress" 
								placeholder="상세주소" value="${fn:split(addressval,',')[1]}">
							</div>
							<input type="hidden" id="jibunAddress" placeholder="지번주소">
							<span id="guide" style="color:#999; display:none"></span>								
							<input type="hidden" id="extraAddress" placeholder="참고항목">
						</div>							
        	       </div>
        	      </div> 
			
			<div class="col col-lg">
			<div class="row mb-4">
			<h4>농장 정보</h4>
			</div>
			<div class="row my-4">
          		<label for="fname" class="col-lg-3 form-label fw-bold">농장명</label>
          		<div class="col-lg-9">
          			<input type="text" class="form-control " id="fname" name="fname" value="${user.fname}" required>
       			</div>
       		</div>
       		
       		<div class="row my-4">
          		<label for="fnum" class="col-lg-3 form-label fw-bold">농장코드</label>
          		<div class="col-lg-9">
          			<input type="text" class="form-control " id="fnum" name="fnum" value="${user.fnum}" required disabled>
        		</div>
        	</div>
                	
        	<c:set var="faddressval" value="${user.faddress}" />
         	<div class="row my-4">
         		<div class="col-lg-3 fw-bold">농장주소</div>
         		<div class="col-lg-9">
         			<input type="button" class="btn btn-secondary" onclick="execDaumPostcodeFarm()" value="주소 변경">	
					<div class="row my-3 mx-1">							
						<input type="text" class="form-control " name="fzcode" id="fpostcode" value="${user.fzcode}" required>
					</div>
					<div class="row my-3 mx-1">	
						<input type="text" class="form-control " name="froadAddress" id="froadAddress" value="${fn:split(faddressval,',')[0]}" required>
					</div>
					<div class="row my-3 mx-1">
						<input type="text" class="form-control " name="fdetailAddress" id="fdetailAddress" 
						placeholder="상세주소" value="${fn:split(faddressval,',')[1]}">
					</div>	
					<input type="hidden" id="fjibunAddress" placeholder="지번주소">
					<span id="fguide" style="color:#999; display:none"></span>					
					<input type="hidden" id="fextraAddress" placeholder="참고항목">
        		</div>
        	</div>
        	</div>
        	</div>	
        	<div class="row my-4 text-center">
        		<span>       		
        		<button type="button" class="btn btn-secondary" onclick="updtCancle()">취소</button>
        		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        	
        		<input type="submit"  class="btn btn-success" value="수정">
        		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        		<button type="button" class="btn btn-danger" onclick="location.href='./leave'">탈퇴</button>        		
        		</span>
        	</div>
      	</form>
      	</div>
	</div>
</div>
<jsp:include page="/modules/footer.jsp"/>
<script>	
	
	//주소 입력
	function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {

                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

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
                document.getElementById("detailAddress").value = "";
                
                if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }
				
                var guideTextBox = document.getElementById("guide");
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
	
	//농장 주소 입력
	function execDaumPostcodeFarm() {
        new daum.Postcode({
            oncomplete: function(data) {

                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

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
                document.getElementById("froadAddress").value = roadAddr;
                document.getElementById("fjibunAddress").value = data.jibunAddress;
                
                if(roadAddr !== ''){
                    document.getElementById("fextraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("fextraAddress").value = '';
                }
				
                var guideTextBox = document.getElementById("fguide");
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
	
		  	
	function updtCancle() {
	  if(confirm('수정 취소 시 변경사항은 저장되지 않습니다.')){	  	  
	  	location.href='./info';
		}
	}
	
	$(function() {
	    $("#update").submit(function(event) {
	        event.preventDefault(); 			
	        if(confirm('정보를 수정하시겠습니까?')){
	        
	        $.ajax({
	            type: 'post',
	            url: './info',
	            data: $("#update").serialize(),
	            success: function(response) {
	            	console.log('서버에서 받은 데이터:', response);
	                if (response === "wrong") {
	                	alert('비밀번호가 일치하지 않습니다.');
	                	location.replace = './info';
	                	location.reload();
	                } else if (response === "fail") {
	                	alert('회원 정보 수정에 실패했습니다.');
	                	location.replace = './info';
	                } else if (response === "good") {
	                	alert('회원 정보가 수정되었습니다.');
	                	location.replace = './info';
	                	location.reload();
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