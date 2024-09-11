<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 

response.setHeader("Pragma", "No-Cache");
response.setHeader("Cache-Control", "No-Store");
response.setDateHeader("Expires", 0);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 정보</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
@media (min-width:768px) {
		.buttonCUD {width:96px;}
	}

</style>
</head>
<body class="nanum-gothic-regular overflow-x-hidden">
	<jsp:include page="/modules/header.jsp"></jsp:include>
			<div class="d-flex justify-content-center">
			<div class="col col-lg-8 p-3 mt-4 bg-body rounded">
			<div class="row mb-5"><p class="fw-bold fs-1 text-center">내 정보</p></div>
			<c:choose>					    
				<c:when test="${fn:contains(user.id, '@')}">
				<div class="row my-5 mx-3">
				<form action="/user/socialupdate" method="post" id="updateform">
					<div class="row my-4">
						<label for="id" class=" col-lg-3 form-label  fs-5 fw-bold text-lg-end ">아이디</label>         
          	 	 		<div class="col-lg-7">
          	 				<input type="text" class="form-control form-control-lg" value="${user.id}" disabled></div>  
             				<input type="hidden" class="form-control " name="id" value="${user.id}">
       	 			</div>
    	 			       	 			
					<div class="row my-4">
          				<label for="uname" class="col-lg-3 form-label  fs-5 fw-bold text-lg-end ">이름</label>          	
          				<div class="col-lg-7">
          				<input type="text" class="form-control form-control-lg" id="uname" name="uname" value="${user.uname}" required>
        				</div>
        			</div>
        				
        			<div class="row my-4">
        				<c:set var="birthval" value="${user.birth}" />
        				<c:set var="year" value="${fn:substring(birthval,0,4) }" />
        				<c:set var="month" value="${fn:substring(birthval,4,6) }" />
        				<c:set var="day" value="${fn:substring(birthval,6,9) }" />
          				<label for="birth" class="col-lg-3 form-label  fs-5 fw-bold text-lg-end ">생년월일</label>         
          				<div class="col-lg-7">
          					<input type="text" class="form-control form-control-lg" id="birth" value="${year}년 ${month}월 ${day}일" required disabled>
        				</div>
        			</div>
        					          
        			<div class="row my-4">
          				<label for="phone" class="col-lg-3 form-label  fs-5 fw-bold text-lg-end ">전화번호</label>
          				<div class="col-lg-7">
          				<input type="text" class="form-control form-control-lg" id="phone" name="phone" value="${user.phone}" 
          				pattern="^01[016789]{1}-?[0-9]{4}-?[0-9]{4}$" placeholder="010-1234-5678" required>
       					</div>
       				</div>
       		
        			<div class="row my-4">
          				<label for="email" class="col-lg-3 form-label  fs-5 fw-bold text-lg-end ">이메일</label>
          				<div class="col-lg-7">
          				<input type="email" class="form-control form-control-lg" id="email" name="email" value="${user.email}" 
          				placeholder="farmily@gmail.com" required>
        				</div>
        			</div>
 
        			<div class="row my-4">
          				<label for="gender" class="col-lg-3 form-label  fs-5 fw-bold text-lg-end ">성별</label>
          				<c:choose>
							<c:when test="${fn:contains(user.gender, 'M')}">
								<div class="col-lg-7">
								<input type="text" class="form-control form-control-lg" id="gender1" name="gender" value="남자" disabled>
								</div>
							</c:when>
							<c:otherwise>
								<div class="col-lg-7">
								<input type="text" class="form-control form-control-lg" id="gender2" name="gender" value="여자" disabled>
								</div>
							</c:otherwise>
		  				</c:choose>
       				</div>
       				
       				<c:set var="addressval" value="${user.uaddress}" />
         			<div class="row my-4 mb-5">
         				<div class="col-lg-3 fs-5 fw-bold text-lg-end">주소</div>
         				<div class="col-lg-7">
         					<input type="button" class="btn btn-secondary" onclick="execDaumPostcode()" value="주소 변경">	
							<div class="row my-3 mx-1">									
									<input type="text" class="form-control form-control-lg" name="uzcode" id="postcode" value="${user.uzcode}" required>
							</div>				
							<div class="row my-3 mx-1">
								<input type="text" class="form-control form-control-lg" name="newAddress" id="roadAddress" value="${fn:split(addressval,',')[0]}" required>
							</div>
							
							<div class="row my-3 mx-1">
								<input type="text" class="form-control form-control-lg" name="detailAddress" id="detailAddress" 
								placeholder="상세주소" value="${fn:split(addressval,',')[1]}">
							</div>
							<input type="hidden" id="jibunAddress" placeholder="지번주소">
							<span id="guide" style="color:#999; display:none"></span>								
							<input type="hidden" id="extraAddress" placeholder="참고항목">
						</div>							
        	       </div>        							
					<div class="my-4">
        				<span class=" d-flex justify-content-center  mx-md-5 ">
        					<button type="button" class="buttonCUD btn btn-secondary m-0 m-md-2" onclick="updtCancle()">취소</button>
        					<input  type="submit"  class="buttonCUD btn btn-success m-0 m-md-2" value="수정">
        					<button type="button" class="buttonCUD btn btn-danger m-0 m-md-2" onclick="dropModal()">탈퇴</button>
        				</span>
        			</div>     
      			</form>			
				</div>
				</c:when>
				<c:otherwise>
				<div class="row my-5 mx-3">
				<form action="/user/update" method="post" id="updateform">
					<div class="row my-4">
						<label for="id" class=" col-lg-3 form-label fs-5 fw-bold text-lg-end">아이디</label>         
          	 	 		<div class="col-lg-7">
          	 				<input type="text" class="form-control form-control-lg" value="${user.id}" disabled></div>  
             				<input type="hidden" class="form-control " name="id" value="${user.id}">
       	 			</div>
    	 			<div class="row my-4">    	 				
       					<label for="password" class="col-lg-3 form-label fs-5 fw-bold text-lg-end">비밀번호</label>
       					<div class="col-lg-7">
       					<div class="row px-2">	
       						<input type="password" class="form-control form-control-lg" name="password" required id="password"
       							placeholder="정보수정을 위해 비밀번호를 입력해주세요">
       						</div>      					
       					<div class="row my-3">
       					<span>
          					<button type="button" class="btn btn-success" onclick="resetPasswordModal()">비밀번호 변경</button>
        				</span>
        				</div>
       					</div>
        			</div>
        			
       	 			
					<div class="row my-4">
          				<label for="uname" class="col-lg-3 form-label fs-5 fw-bold text-lg-end">이름</label>          	
          				<div class="col-lg-7">
          				<input type="text" class="form-control form-control-lg" id="uname" name="uname" value="${user.uname}" required>
        				</div>
        			</div>
        				
        			<div class="row my-4">
        				<c:set var="birthval" value="${user.birth}" />
        				<c:set var="year" value="${fn:substring(birthval,0,4) }" />
        				<c:set var="month" value="${fn:substring(birthval,4,6) }" />
        				<c:set var="day" value="${fn:substring(birthval,6,9) }" />
          				<label for="birth" class="col-lg-3 form-label fs-5 fw-bold text-lg-end">생년월일</label>         
          				<div class="col-lg-7">
          					<input type="text" class="form-control form-control-lg" id="birth" value="${year}년 ${month}월 ${day}일" required disabled>
        				</div>
        			</div>
        					          
        			<div class="row my-4">
          				<label for="phone" class="col-lg-3 form-label fs-5 fw-bold text-lg-end">전화번호</label>
          				<div class="col-lg-7">
          				<input type="text" class="form-control form-control-lg" id="phone" name="phone" value="${user.phone}" 
          				pattern="^01[016789]{1}-?[0-9]{4}-?[0-9]{4}$" placeholder="010-1234-5678" required>
       					</div>
       				</div>
       		
        			<div class="row my-4">
          				<label for="email" class="col-lg-3 form-label fs-5 fw-bold text-lg-end">이메일</label>
          				<div class="col-lg-7">
          				<input type="email" class="form-control form-control-lg" id="email" name="email" value="${user.email}" 
          				placeholder="farmily@gmail.com" required>
        				</div>
        			</div>
 
        			<div class="row my-4">
          				<label for="gender" class="col-lg-3 form-label fs-5 fw-bold text-lg-end">성별</label>
          				<c:choose>
							<c:when test="${fn:contains(user.gender, 'M')}">
								<div class="col-lg-7">
								<input type="text" class="form-control form-control-lg" id="gender1" name="gender" value="남자" disabled>
								</div>
							</c:when>
							<c:otherwise>
								<div class="col-lg-7">
								<input type="text" class="form-control form-control-lg" id="gender2" name="gender" value="여자" disabled>
								</div>
							</c:otherwise>
		  				</c:choose>
       				</div>
       				
       				<c:set var="addressval" value="${user.uaddress}" />
         			<div class="row my-4 mb-5">
         				<div class="col-lg-3 fs-5 fw-bold text-lg-end">주소</div>
         				<div class="col-lg-7">
         					<input type="button" class="btn btn-secondary" onclick="execDaumPostcode()" value="주소 변경">	
							<div class="row my-3 mx-1">									
									<input type="text" class="form-control form-control-lg" name="uzcode" id="postcode" value="${user.uzcode}" required>
							</div>				
							<div class="row my-3 mx-1">
								<input type="text" class="form-control form-control-lg" name="newAddress" id="roadAddress" value="${fn:split(addressval,',')[0]}" required>
							</div>
							
							<div class="row my-3 mx-1">
								<input type="text" class="form-control form-control-lg" name="detailAddress" id="detailAddress" 
								placeholder="상세주소" value="${fn:split(addressval,',')[1]}">
							</div>
							<input type="hidden" id="jibunAddress" placeholder="지번주소">
							<span id="guide" style="color:#999; display:none"></span>								
							<input type="hidden" id="extraAddress" placeholder="참고항목">
						</div>							
        	       </div>       							
					<div class="my-4">
        				<span class=" d-flex justify-content-center  mx-md-5 ">
        					<button type="button" class="buttonCUD btn btn-secondary m-0 m-md-2" onclick="updtCancle()">취소</button>
        					<input  type="submit"  class="buttonCUD btn btn-success m-0 m-md-2" value="수정">
        					<button type="button" class="buttonCUD btn btn-danger m-0 m-md-2" onclick="dropModal()">탈퇴</button>
        				</span>
        			</div>     
      			</form>			
				</div>
				</c:otherwise>
       	 	</c:choose>
		</div>
	</div>
								
																  					   			
			<div class="modal" id="updateModal">
				  <div style="max-width: 483px; top: 20%; right: 0.6%" class="modal-dialog">
				    <div class="modal-content">
				      <!-- Modal body -->
				      <div class="modal-body fw-bold fs-5" id="modalMessage">
				      	${updateSuccess }
				      </div>
				      <button style="top: 5%; right: 1%" type="button" class="btn-close position-absolute shadow-none" data-bs-dismiss="modal"></button>
				      <!-- Modal footer -->
				      <div class="modal-footer border-top-0">
				        <button type="button" class="btn btn-success" data-bs-dismiss="modal">확인</button>
				      </div>
				    </div>
				  </div>
			</div>
			<div class="modal" id="updateCancleModal">
				  <div style="max-width: 483px; top: 20%; right: 0.6%" class="modal-dialog">
				    <div class="modal-content">
				      <!-- Modal body -->
				      <div class="modal-body fw-bold fs-5 mt-5" id="modalMessage">
				      	수정 취소 시 변경사항은 저장되지 않습니다.
				      </div>
				      <button style="top: 5%; right: 1%" type="button" class="btn-close position-absolute shadow-none" data-bs-dismiss="modal"></button>
				      <!-- Modal footer -->
				      <div class="text-center my-3">
				      	<button type="button" class="btn btn-success" data-bs-dismiss="modal">계속하기</button>&nbsp;&nbsp;&nbsp;
				        <button type="button" class="btn btn-danger" onclick="location.href='./info'">수정취소</button>				        
				      </div>
				    </div>
				  </div>
			</div>
			
			<div class="modal" id="dropModal">
				<div style="max-width: 700px; right: 0.6%" class="modal-dialog">
					<div class="modal-content">
						<!-- Modal body -->
					      <div class="modal-body fw-bold fs-5" id="modalMessage">
					      	<div class="fw-bold fs-2">탈퇴 안내</div>
					      	<span class="mt-4">회원탈퇴를 하기 전에 안내 사항을 꼭 확인해주세요.</span>
							<br/>
							<hr>
							<div class="row">		
								<div class="row ms-2"><p class="fs-5 fw-bold"><span class="me-2">✔</span>아이디 복구 불가</p>
								<span class="fw-normal">사용하고 계신 아이디<strong>(${user.id})</strong>는 탈퇴할 경우 복구가 불가하오니 신중하게 선택하시길 바랍니다.</span>
								</div>
								<div class="row mt-3 ms-2"><p class="fs-5 fw-bold"><span class="me-2">✔</span>개인정보 삭제</p>
								<span class="fw-normal">탈퇴 시 모든 개인정보는 즉시 삭제됩니다. <strong>삭제된 개인정보는 복구할 수 없으므로</strong> 이 점 유의해 주시기 바랍니다.</span>
								</div>
								<div class="row mt-3 ms-2"><p class="fs-5 fw-bold"><span class="me-2">✔</span>소셜 로그인 내역 삭제</p>
								<span class="fw-normal">farmily와 연동한 소셜 로그인 정보 역시 즉시 삭제되나 <strong>네이버 연동은 해제되지는 않습니다.</strong> 정보를 제공하고 싶지 않다면 직접 연동을 해제해주셔야 합니다. </span>
								</div>
								<div class="row mt-3 ms-2"><p class="fs-5 fw-bold"><span class="me-2">✔</span>주문 정보 유지</p>
								<span class="fw-normal">탈퇴 후에도 기존의 주문 정보는 계속 보관됩니다. 주문 정보를 삭제하고 싶으시면 탈퇴 전에 <strong>직접 삭제</strong>해 주셔야 합니다.</span>
								<div class="row my-3">
									<form action="/user/drop" method="post" id="dropform">		
										<input type="hidden" id="id" name="id" value="${user.id}" >		
										<div class="form-check ms-2">
											<input class="form-check-input" type="checkbox" id="check"  name="check" required>
											<label class="form-check-label" for="check">안내 사항을 모두 확인하였으며, 이에 동의합니다.</label>
										</div>
										<c:if test="${not fn:contains(user.id, '@') }">
											<div class="mb-3 mt-3 ms-2">
												<input type="password" class="form-control" id="delpassword" placeholder="비밀번호를 입력해주세요." 
												pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$" required>
												<span style="width: 100%; height: 30px;" id="dropMsg" class="d-inline-block"></span>
							       	 		</div>
										</c:if>
										<div class="row my-4 text-center">
											<span>
												<input id="dropBtn" type="submit" class="btn btn-danger" value="탈퇴하기">
											</span>
										</div>		
									</form>
								</div>
							</div>
					      </div>
					      <button style="top: 1%; right: 1%" type="button" class="btn-close position-absolute shadow-none" data-bs-dismiss="modal"></button>
					    </div>
				  	</div>
				</div>
			</div>
			<div class="modal" id="resetPasswordModal">
				<div style="max-width: 700px; top: 20%; right: 0.6%" class="modal-dialog">
					<div class="modal-content">
						<!-- Modal body -->
					    <div class="modal-body fw-bold fs-5" id="modalMessage">
					    	<span class="fs-3">비밀번호 변경</span>
					    	<ul class="mt-2">
					    		<li><span class="text-danger">다른 아이디/사이트에서 사용한 적 없는 비밀번호</span></li>
					    		<li><span class="text-danger">이전에 사용한 적 없는 비밀번호</span>가 안전합니다.</li>
					    		<li><span class="text-danger">비밀번호 변경 완료 시 로그인이 만료됩니다.</span></li>
					    	</ul>
					    	<form class=" p-3 rounded-3 shadow-lg p-3 mb-5 bg-body-tertiary" action="/user/updatePw" method="post" id="updatePwForm">
					    		<div class="form-floating my-3">
								      <input type="password" class="form-control"								     
								      id="updateModalPW"
								      placeholder="비밀번호"
								      value=""
								      pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$"
								      required>
						      	<label for="floatingPW">현재 비밀번호</label>
								</div>
								<div class="form-floating my-3">
								      <input type="password" class="form-control"
								      id="newPassword"
								      placeholder="비밀번호"
								      value=""
								      pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$"
								      required>
								      <label for="floatingPW">새 비밀번호 (특수문자 포함 8자리 이상 입력)</label>
							    </div>
							    <div class="form-floating my-3">
							      <input type="password" class="form-control" id="newPasswordChk" required>
							      <label for="floatingChkPw">새 비밀번호 확인</label>
							      <span style="width: 100%; height: 30px;" id="updateMsg" class="d-inline-block mt-2"></span>
							    </div>
							    <button class="btn btn-success py-2" type="submit">비밀번호 변경</button>
					    	</form>
					    	<button style="top: 1%; right: 1%" type="button" class="btn-close position-absolute shadow-none" data-bs-dismiss="modal"></button>
					    </div>
				  	</div>
				</div>
			</div>
		<jsp:include page="/modules/footer.jsp"></jsp:include>
		<script>
		$(document).ready(function() {
	        $("#updateform").on("keypress", function(event) {
	            if (event.keyCode === 13) {
	                event.preventDefault();
	            }
	        });
	    });
		
		<c:if test="${not empty updateSuccess }">
	 		 $(document).ready(function (){
	            $("#updateModal").modal("show");
	        });
 		</c:if>
 		function updtCancle() {
			$(document).ready(function (){
	            $("#updateCancleModal").modal("show");
	        });
		}
 		
 		function resetPasswordModal() {
 			$(document).ready(function (){
	            $("#resetPasswordModal").modal("show");
	        });
 		}
 		
 		function dropModal() {
 			$(document).ready(function (){
	            $("#dropModal").modal("show");
	        });
 		}
 		
 		$(document).ready(function() {
 		    $('#updatePwForm').submit(function(e) {
 		        e.preventDefault();
 		        
 		        var current_password = $('#updateModalPW').val();
				var new_password = $('#newPassword').val();
				var id = $('#id').val();
				console.log(id);
 		        $.ajax({
 		            url: '/user/updatePw',
 		            type: 'POST',
 		            data: {
 		                password: current_password,
 		                newPassword: new_password,
 		                id,
 		            },
 		            success: function(data) {
 		                if (data) {
 		                    window.location.href = "/login";
 		                }
 		                else {
 		                	$('#updateMsg').text('현재 비밀번호와 일치 하지 않습니다.');
 	 		              
 		                	setTimeout(() => {
 		                		$('#updateMsg').text('');
 		                	}, 1000);
 		                }
 		            },
 		            error: function() {
 		                alert('비밀번호 변경 요청 중 오류가 발생했습니다.');
 		            }
 		        });
 		    });
 		});
 		
 		
 		$(document).ready(function() {
 		    $('#dropform').submit(function(e) {
 		        e.preventDefault();
 		        var password = $('#delpassword').val();
				
 		       var confirmDrop = confirm('정말로 탈퇴하시겠습니까? \n동의를 하였기 때문에 모든 책임은 사용자 본인에게 있습니다.');
 		        if (!confirmDrop) {
 		            return;
 		        }
 		        
 		        $.ajax({
 		            url: '/user/drop',
 		            type: 'POST',
 		            data: {
 		                password: password,
 		                id: '${user.id}'
 		            },
 		            success: function(data) {
 		            	console.log(data)
 		                if (data) {
 		                    window.location.href = "/";
 		                } else if (data === false) {
 		                    $('#dropMsg').text('비밀번호를 확인하세요.');
 		                   
 		                  setTimeout(function() {
 		                	 $('#dropMsg').text('');
 		                    }, 1000);
 		                }
 		            },
 		            error: function() {
 		                alert('탈퇴 요청 중 오류가 발생했습니다.');
 		            }
 		        });
 		    });
 		});
	
		

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
		
		
		</script>
</body>
</html>