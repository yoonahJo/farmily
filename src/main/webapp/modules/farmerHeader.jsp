<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Playwrite+CU:wght@100..400&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-gothic.css" rel="stylesheet">
<link href="/resources/css/cheader.css" rel="stylesheet">
<link href="/resources/css/font.css" rel="stylesheet">


	<header>
		<nav class="navbar navbar-expand-md navbar-dark">
		  <div class="container-fluid custom-header">
		  	<div class="ms-5 ms-md-0 ms-xl-5">
				<a class="navbar-brand me-0 d-flex align-items-center" href="/farm">
			    	<span class="custom-header-font d-md-none d-xl-inline text-center ms-3">Farmily</span>
		    	</a>
			</div>
		    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
		      <span class="navbar-toggler-icon"></span>
		    </button>
		    <div style="height: 100%" class="collapse navbar-collapse d-md-flex justify-content-md-center" id="collapsibleNavbar">
			<ul  class="navbar-nav mx-lg-auto d-flex justify-content-center">
		        <li class="nav-item btn btn-lg  d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2" >
		          <a class="nav-link text-white fs-3 fw-bold p-0" href="/farm/product">상품관리</a>
		        </li>
		        <li class="nav-item btn btn-lg  d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2" >
		          <a class="nav-link text-white fs-3 fw-bold p-0"  href="/farm/pay">주문관리</a>
		        </li>
		        <li class="nav-item btn btn-lg  d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
		          <a class="nav-link text-white fs-3 fw-bold p-0" href="/farm/user/info">내 정보</a>
		        </li>
				<li class="nav-item btn btn-lg  d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
				  <a class="nav-link text-white fs-3 fw-bold p-0" href="/farm/qna">Q&A</a>
				</li>
				<li class="nav-item btn btn-lg  d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
				     <a class="nav-link text-white fs-3 fw-bold p-0" id="logoutBtn">로그아웃</a>
				</li>
				<li class="nav-item btn btn-lg  d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
				     <a class="nav-link text-white fs-3 fw-bold p-0" href="/">회원 페이지</a>
				</li>
		      </ul>
		    </div>
		  </div>		  
		</nav>
	</header>
	<form action="/user/logout" method="post" id="logout">
		<input type="hidden" value="logout">
	</form>
	
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script>
     $(document).ready(function() { 
        $('#logoutBtn').click(function(event) { 
             $('#logout').submit();
      });
     });   
</script>