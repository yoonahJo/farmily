<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
response.setHeader("Pragma", "No-Cache");
response.setHeader("Cache-Control", "No-Store");
response.setDateHeader("Expires", 0);
%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Playwrite+CU:wght@100..400&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-gothic.css" rel="stylesheet">
<link href="/resources/css/font.css" rel="stylesheet">
<link href="/resources/css/aheader.css" rel="stylesheet">
    <header>
        <nav class="navbar navbar-expand-md bg-secondary navbar-dark">
            <div class="container-fluid custom-header">
                <div class="ms-5 ms-md-0 ms-xl-5">
					<a class=" navbar-brand me-0 d-flex align-items-center" href="/admin">
				    	<span class="d-md-none d-xl-inline custom-header-font text-center ms-3 ">Farmily</span>
			    	</a>
				</div>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
			      <span class="navbar-toggler-icon"></span>
			    </button>
                <div class="collapse navbar-collapse d-md-flex justify-content-md-center" id="collapsibleNavbar">
                    <ul class="navbar-nav mx-lg-auto d-flex justify-content-center">
                        <li class="nav-item btn btn-lg btn-secondary d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
                            <a class="d-block nav-link fs-3 fw-bold text-white p-0" href="/admin/list">회원관리</a>
                        </li>
                        <li class="nav-item btn btn-lg btn-secondary d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
                            <a class="d-block nav-link fs-3 fw-bold text-white p-0" href="/admin/product">상품관리</a>
                        </li> 
                        <li class="nav-item btn btn-lg btn-secondary d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
                            <a class="d-block nav-link fs-3 fw-bold text-white p-0" href="/admin/reserve">예약관리</a>
                        </li>                            
                        <li class="nav-item btn btn-lg btn-secondary d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
                            <a class="d-block nav-link fs-3 fw-bold text-white p-0" href="/admin/pay">주문관리</a>
                        </li>
                        <li class="nav-item btn btn-lg btn-secondary d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
                            <a class="d-block nav-link fs-3 fw-bold text-white p-0" href="/admin/qna">Q&A</a>
                        </li>
                        <c:choose>
                            <c:when test="${not empty sessionScope.id}">
                                <li class="nav-item btn btn-lg btn-secondary d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
                                    <a class="d-block nav-link fs-3 fw-bold text-white p-0" href="/">클라이언트</a>
                                </li>
                                <li class="nav-item btn btn-lg btn-secondary d-flex justify-content-center align-items-center m-2 m-md-0 m-lg-2">
                                    <form action="${pageContext.request.contextPath}/admin/logout" method="post" style="display: inline;">
                                        <button type="submit" class="d-block nav-link fs-3 fw-bold text-white p-0">로그아웃</button>
                                    </form>
                                </li>
                            </c:when>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

