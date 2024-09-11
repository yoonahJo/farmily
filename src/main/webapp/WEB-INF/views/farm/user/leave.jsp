<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>탈퇴::farmily</title>
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	.color{color:#19a26e}
</style>
</head>
<body class="nanum-gothic-regular">
<jsp:include page="/modules/farmerHeader.jsp" flush="false" />
<div class="container-fluid">
	<div class="d-flex justify-content-center">
	<div class="col-lg-5 border p-lg-5 my-5 mx-3 bg-body rounded-3">
      <div class="fw-bold fs-2 p-3">탈퇴 안내</div>
      <div class="px-3">회원탈퇴를 하기 전에 안내 사항을 꼭 확인해주세요.</div>
      <br/>
      <hr>
      <div class="row ">		
      	<div class="row mt-3 ms-2"><p class="fs-5 fw-bold">✔아이디 복구 불가</p>
      	<span>사용하고 계신 아이디(<strong class="color">${id}</strong>)는 <strong>탈퇴할 경우 복구가 불가</strong>하오니 신중하게 선택하시길 바랍니다.</span>
      	</div>
      	<div class="row mt-3 ms-2"><p class="fs-5 fw-bold">✔개인정보 삭제</p>
      	<span><strong>탈퇴 시 모든 개인정보는 즉시 삭제</strong>됩니다. 삭제된 개인정보는 복구할 수 없으니 이 점 유의해 주시기 바랍니다.</span>
     	</div>
     	<div class="row mt-3 ms-2"><p class="fs-5 fw-bold">✔주문 정보 유지</p>
		<span>탈퇴 후에도 기존의 주문 정보는 계속 보관됩니다. 주문 정보를 삭제하고 싶으시면 탈퇴 전에 <strong>직접 삭제해 주셔야 합니다.</strong></span>
		</div>
	</div>
	<div class="row my-3">
		<form action="/farm/user/leave" method="post" id="leave">		
			<input type="hidden" id="id" name="id" value="${id}" >		
			<div class="form-check ms-2">
      		<input class="form-check-input" type="checkbox" id="check"  name="check" required>
      		<label class="form-check-label" for="check">안내 사항을 모두 확인하였으며, 이에 동의합니다.</label>
    		</div>	
			<div class="mb-3 mt-3 ms-2">
          	<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력해주세요." 
          	pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$" required>
       	 </div>
        
		<div class="row my-4 text-center">
        <span>
        <button type="button" class="btn btn-secondary" onclick="location.href='./info'">취소</button>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" class="btn btn-danger" value="탈퇴하기"></span>
        </div>		
	</form>
	</div>
	</div>
	</div>	
</div>
<script>
$(function() {
    $("#leave").submit(function(event) {
        event.preventDefault(); 			
        if (confirm('정말로 탈퇴하시겠습니까?')){
        
        $.ajax({
            type: 'post',
            url: './leave',
            data: $("#leave").serialize(),
            success: function(response) {
            	console.log('서버에서 받은 데이터:', response);
                if (response === "wrong") {
                	alert('비밀번호가 일치하지 않습니다.');
                	location.replace = './leave';
                } else if (response === "fail") {
                	alert('탈퇴에 실패했습니다.');
                	location.replace('./leave');
                } else if (response === "good") {
                	alert('탈퇴가 완료되었습니다.\n[farmily]를 이용해주셔서 감사합니다.');
                	location.replace('/');
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
<%@ include file="/modules/footer.jsp"%>
</body>
</html>