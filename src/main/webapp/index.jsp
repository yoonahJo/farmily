<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String Message = (String)session.getAttribute("Auth");
session.removeAttribute("Auth");

%>
<% 
    boolean loggedIn = (session.getAttribute("id") != null); 
    request.setAttribute("loggedIn", loggedIn);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Farmily</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<style type="text/css">
.bestproduct{
 color:#dee2e6;
}
.rank{
 color:#81c147;
}

.card img{
width:350px;
height:350px;
border-radius: 10%;
border:1px solid #dee2e6;
}


/*작은 모바일 화면에서 이미지 크기 작게*/
 @media (max-width: 420px) {
      .card img{
		width:300px;
		height:300px;
		border-radius: 10%;
		border:1px solid #dee2e6;
		}
    }
    
 @media (min-width: 421px)and (max-width: 465px) {
      .card img{
		width:350px;
		height:350px;
		border-radius: 10%;
		border:1px solid #dee2e6;
		}
    }
       
 @media (min-width: 466px)and (max-width: 767px) {
      .card img{
		width:400px;
		height:400px;
		border-radius: 10%;
		border:1px solid #dee2e6;
		}
    }    
 @media (min-width: 768px)and (max-width: 991px) {
      .card img{
		width:200px;
		height:200px;
		border-radius: 10%;
		border:1px solid #dee2e6;
		}
    } 
   @media (min-width: 992px)and (max-width: 1200px) {
      .card img{
		width:250px;
		height:250px;
		border-radius: 10%;
		border:1px solid #dee2e6;
		}
    } 
    

.card{
border:none !important;

}
.price{
 color:#082C0f;
}

 a { text-decoration:none !important; }
 
 
 .product-filter, .product-selection, .product-form {
            margin-bottom: 20px;
        }
        .product-filter select, .product-selection select {
            width: 100%;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .quantity-control {
            display: flex;
            align-items: center;
             padding-top: 7px; 
            gap: 10px;
        }
        .quantity-control button {
            width: 40px;
            height: 40px;
            font-size: 18px;
            border-radius: 8px;
        }
        .quantity-input {
            width: 80px;
            text-align: center;
        }

        .alert {
            display: none;
        }
        .btn-disabled {
            cursor: not-allowed;
            opacity: 0.65;
        }
        .select{style="height:65px;"}
 		
</style>
<script>
    var userLoggedIn = ${loggedIn ? 'true' : 'false'};
</script>
</head>
<body class="nanum-gothic-regular overflow-x-hidden">
	<jsp:include page="/modules/header.jsp"></jsp:include>
	<main>
		<div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-label="Slide 1" aria-current="true"></button>
			    <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2" class=""></button>
			    <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3" class=""></button>
		    </div>
		    <div class="carousel-inner">
		    	<div class="carousel-item active">
		    		<div>
		    			<img style="max-height: 600px;" src="${pageContext.request.contextPath}/img/bg3.jpg" class="d-block vw-100 vh-100 object-fit-cover">
		    		</div>
		      </div>
		      <div class="carousel-item">
		      	<img style="max-height: 600px;" src="${pageContext.request.contextPath}/img/index-image4.jpg" class="d-block vw-100 vh-100 object-fit-cover">
		        <div class="container">
		        </div>
		      </div>
		      
		      <div class="carousel-item">
		        <img style="max-height: 600px;" src="${pageContext.request.contextPath}/img/index-image3.jpg" class="d-block vw-100 vh-100 object-fit-cover">
		        <div class="container">
		        </div>
		      </div>
		    </div>
		    <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
		    	<span style="width: 50%; height: 100px;"  class="carousel-control-prev-icon" aria-hidden="true"></span>
		      	<span class="visually-hidden">Previous</span>
		    </button>
		    <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
		      	<span style="width: 50%; height: 100px;" class="carousel-control-next-icon" aria-hidden="true"></span>
		      	<span class="visually-hidden">Next</span>
		    </button>
		</div>
		<br>
		<jsp:include page="/WEB-INF/views/product/fastList.jsp"></jsp:include>
        <br><br><br>
        <div class="border-1 border-bottom"></div>
        <div class="container mb-5">
            <div class="row mt-5 text-center fw-bold fs-1">
                <p>Best 상품</p>
            </div>
            <div class="row row-cols-1 row-cols-md-3 g-4">
  				<div class="col">
    				<div class="card px-0 px-md-4" id="topItem1">
    					<a id="link1">
     					 	<img class="card-img-top">
     					 </a>
      					<div class="card-body">      					      
        					<a class="card-text name fw-bold text-dark"></a>       				
        					<p class="card-text price fs-3 fw-bold"></p>
      					</div>
    				</div>
  				</div>
  				<div class="col">
    				<div class="card px-0 px-md-4" id="topItem2">
      					<a id="link2">
     					 	<img class="card-img-top">
     					 </a>
      					<div class="card-body">        				
        					<a class="card-text name fw-bold text-dark"></a>
        					<p class="card-text price fs-3 fw-bold"></p>
     					 </div>
    				</div>
  				</div>
  				<div class="col"> 					
    				<div class="card px-0 px-md-4 " id="topItem3">
     				<a id="link3">
     					<img class="card-img-top" >
     				</a>
      				<div class="card-body">      
        				<a class="card-text name fw-bold text-dark"></a>
        				<p class="card-text price fs-3 fw-bold"></p>
      				</div>
    			</div>
  			</div>
		</div>
        </div>
    </main>
    <jsp:include page="/modules/footer.jsp"></jsp:include>


    <!-- Modal -->
    <div class="modal" tabindex="-1" id="roleModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">해당 페이지에 권한이 없습니다.</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="modalMessage">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal">확인</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            var auth = "<%=Message%>";
            if(auth !== "null") {
                console.log("has no auth");
                $("#modalMessage").html(auth);
                $("#roleModal").modal("show");
            }
        });

        document.addEventListener('DOMContentLoaded', function() {
            fetch('/product/top')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json(); // Convert to JSON
                })
                .then(data => {
                    console.log('Received Data:', data); // Log the data
                    if (data.length >= 1) {
                        document.querySelector('#topItem1 img').setAttribute('src', '${pageContext.request.contextPath}/img/' + data[0].pimg);
                        document.querySelector('#topItem1 .name').setAttribute('href', '${pageContext.request.contextPath}/img/' + data[0].pimg);
                        document.querySelector('#topItem1 img').setAttribute('alt', data[0].pname);
                        document.querySelector('#topItem1 img').setAttribute('title', data[0].pname);
                        document.querySelector('#topItem1 .name').textContent = data[0].pname;
                        document.querySelector('#topItem1 .price').textContent = Number(data[0].price).toLocaleString() + '원';

                        document.querySelector('#link1').setAttribute('href', '${pageContext.request.contextPath}/product/detail/' + data[0].pcode);
                    }

                    if (data.length >= 2) {
                        document.querySelector('#topItem2 img').setAttribute('src', '${pageContext.request.contextPath}/img/' + data[1].pimg);
                        document.querySelector('#topItem2 .name').setAttribute('href', '${pageContext.request.contextPath}/img/' + data[1].pimg);
                        document.querySelector('#topItem2 img').setAttribute('alt', data[1].pname);
                        document.querySelector('#topItem2 img').setAttribute('title', data[1].pname);
                        document.querySelector('#topItem2 .name').textContent = data[1].pname;
                        document.querySelector('#topItem2 .price').textContent = Number(data[1].price).toLocaleString() + '원';

                        document.querySelector('#link2').setAttribute('href', '${pageContext.request.contextPath}/product/detail/' + data[1].pcode);
                    }

                    if (data.length >= 3) {
                        document.querySelector('#topItem3 img').setAttribute('src', '${pageContext.request.contextPath}/img/' + data[2].pimg);
                        document.querySelector('#topItem3 .name').setAttribute('href', '${pageContext.request.contextPath}/img/' + data[2].pimg);
                        document.querySelector('#topItem3 img').setAttribute('alt', data[2].pname);
                        document.querySelector('#topItem3 img').setAttribute('title', data[2].pname);
                        document.querySelector('#topItem3 .name').textContent = data[2].pname;
                        document.querySelector('#topItem3 .price').textContent = Number(data[2].price).toLocaleString() + '원';

                        document.querySelector('#link3').setAttribute('href', '${pageContext.request.contextPath}/product/detail/' + data[2].pcode);
                    }
                })
                .catch(error => {
                    console.error('Fetch error: ', error);
                    const container = document.getElementById('topProductsContainer');
                    if (container) {
                        container.innerHTML = '<p>상품을 불러오는 데 실패했습니다. 나중에 다시 시도해 주세요.</p>';
                    }
                });
        });
    </script>
</body>
</html>