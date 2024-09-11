<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% 

response.setHeader("Pragma", "No-Cache");
response.setHeader("Cache-Control", "No-Store");
response.setDateHeader("Expires", 0);

%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Playwrite+CU:wght@100..400&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<link href="/resources/css/cheader.css" rel="stylesheet">
<link href="/resources/css/font.css" rel="stylesheet">
	<c:choose>
		<c:when test="${fn:contains(role, 'F')}">
			<header>
				<nav  class="navbar navbar-expand-md navbar-dark">
					<div class="container-fluid custom-header">
						<div class="ms-5 ms-md-0 ms-xl-5">
							<a class="navbar-brand me-0 d-flex align-items-center" href="/">
						    	<span class="custom-header-font d-md-none d-xl-inline text-center">Farmily</span>
					    	</a>
						</div>
					    <button style="width: 55px; height: 55px;" class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
					    	<span class="navbar-toggler-icon"></span>
					    </button>
					    <div class="collapse navbar-collapse d-md-flex justify-content-md-center" id="collapsibleNavbar">
					    	<ul class="navbar-nav mx-lg-auto d-flex justify-content-center">
						        <li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
						          <a class="nav-link  fw-bold fs-3 text-white p-0" href="/product/list?ptype=곡물">곡물</a>
						        </li>
						        <li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
						          <a class="nav-link  fw-bold fs-3 text-white p-0" href="/product/list?ptype=채소">채소</a>
						        </li>
						        <li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
						          <a class="nav-link  fw-bold fs-3 text-white p-0" href="/reserve/list">장바구니</a>
						        </li>
						         <li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
						          <a class="nav-link  fw-bold fs-3 text-white p-0" href="/pay/myPayList">주문내역</a>
						        </li>
								<li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
								    <a class="nav-link  fw-bold fs-3 text-white p-0"  href="/user/logout" id="logoutBtn">로그아웃</a>
								</li>
								<li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
								    <a class="nav-link  fw-bold fs-3 text-white p-0" href="/farm">농부페이지</a>
								</li>
					      	</ul>
					    </div>
				  </div>
				</nav>
		</header>	
	</c:when>
	<c:when test="${fn:contains(role, 'A')}">
			<header>
				<nav class="navbar navbar-expand-md navbar-dark">
					<div class="container-fluid custom-header">
						<div class="ms-5 ms-md-0 ms-lg-5">
							<a class="navbar-brand me-0 d-flex align-items-center" href="/">
						    	<span class="custom-header-font text-center">Farmily</span>
					    	</a>
						</div>
					    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
					    	<span class="navbar-toggler-icon"></span>
					    </button>
					    <div class="collapse navbar-collapse d-md-flex justify-content-md-center" id="collapsibleNavbar">
					    	<ul class="navbar-nav mx-lg-auto d-flex justify-content-center">
						        <li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
						          <a class="nav-link fs-3 fw-bold text-white p-0" href="/product/list?ptype=곡물">곡물</a>
						        </li>
						        <li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
						          <a class="nav-link fs-3 fw-bold text-white p-0" href="/product/list?ptype=채소">채소</a>
						        </li>
								<li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
								    <a class="nav-link fs-3 fw-bold text-white p-0"  href="/user/logout" id="logoutBtn">로그아웃</a>
								</li>
								<li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
								    <a class="nav-link fs-3 fw-bold text-white p-0" href="/admin">관리자 페이지</a>
								</li>
					      	</ul>
					    </div>
				  </div>
				</nav>
		</header>	
	</c:when>
	<c:otherwise>
		<header>
			<nav class="navbar navbar-expand-md  navbar-dark ">
				<div class="container-fluid custom-header">
					<div class="ms-5 ms-md-0 ms-lg-5">
						<a class="navbar-brand me-0 d-flex align-items-center " href="/">
					    	<span class="d-md-none d-xl-inline custom-header-font text-center">Farmily</span>
				    	</a>
					</div>
				    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
				      <span class="navbar-toggler-icon"></span>
				    </button>
				    <div class="collapse navbar-collapse d-md-flex justify-content-md-center" id="collapsibleNavbar">
				    	<ul  class="navbar-nav mx-lg-auto d-flex justify-content-center">
					        <li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
					        	<a class="d-block nav-link fs-3 fw-bold text-white p-0" href="/product/list?ptype=곡물">곡물</a>
					        </li>
					        <li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
					          <a class="nav-link fs-3 fw-bold text-white p-0" href="/product/list?ptype=채소">채소</a>
					        </li>
					        <c:choose>
				      			<c:when test="${ snsName != null }">
				      				<li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
							          <a class="nav-link fs-3 fw-bold text-white p-0" href="/reserve/list">장바구니</a>
							        </li>
							        <li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
							          <a class="nav-link fs-3 fw-bold text-white p-0" href="/pay/myPayList">주문내역</a>
							        </li>
				      				<li class="nav-item d-flex btn btn-lg justify-content-center align-items-center m-2 m-md-0 m-lg-2">
				      					<div class="d-flex justify-content-center align-items-center">
								          	<a class="nav-link fs-3 fw-bold text-white p-0" href="/user/info">내정보</a>
								        </div>
							        </li>
									<li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
										<a class="nav-link fs-3 fw-bold text-white"  href="#" id="logoutBtn">로그아웃</a>
									</li>
								</c:when>
								<c:when test="${snsName == null && id!=null}">
									<li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
							          <a class="nav-link fs-3 fw-bold text-white p-0" href="/reserve/list">장바구니</a>
							        </li>
							        <li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
							          <a class="nav-link fs-3 fw-bold text-white p-0" href="/pay/myPayList">주문내역</a>
							        </li>
									<li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
								          <a class="nav-link fs-3 fw-bold text-white p-0" href="/user/info">내정보</a>
								    </li>
									<li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
										<a class="nav-link fs-3 fw-bold text-white p-0"  href="#" id="logoutBtn">로그아웃</a>
							        </li>
								</c:when>
								<c:otherwise>
									<li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
										<a class="nav-link fs-3 fw-bold text-white p-0" href="/login">로그인</a>
							        </li>
							        <li class="nav-item btn btn-lg d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
							          	<a class="nav-link fs-3 fw-bold text-white p-0" href="/join">회원가입</a>
							        </li>
								</c:otherwise>
						</c:choose>
				      	</ul>
				    </div>
			  </div>
			</nav>
		</header>
	</c:otherwise>
	</c:choose>	
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script>
      $(document).ready(function() { 
         $('#logoutBtn').click(function(event) {
             event.preventDefault(); 
            
              $.ajax({
                  url: '/user/logout', 
                  type: 'POST', 
                 success: function(response) {
                      window.location.href = '/'; 
                  },
                  error: function(xhr, status, error) {
                     
                      console.error('로그아웃 요청에 실패했습니다:', status, error);
                  } 
              }); 
          }); 
      });
</script> 