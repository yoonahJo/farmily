<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.spring.farmily.reserve.model.admin.PageInfo"%>
<% 
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
    String searchWord = request.getParameter("listSearchKeyword");
    String searchCondition = request.getParameter("listSearchCondition");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin :: 예약관리</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
html, body {
    height: 100%;
}

#wrapper {
    height: auto;
 	min-height: 100%;
  	padding-bottom: 209px;
}

footer {
    height: 209px;
    position: relative;
    transform : translateY(-100%);
}


.quantity_div {
    display: flex;
    align-items: center;
    justify-content: center;
}

.quantity_input {
    width: 50px;
    height: 30px;
    text-align: center;
    border: 0.5px solid rgba(0, 0, 0, 0.5);
    border-radius: 0;
    box-sizing: border-box;
    border-right: none;
    border-left: none;
}

.quantity_btn {
    width: 30px;
    height: 30px;
    border: 0.5px solid rgba(0, 0, 0, 0.5);
    background-color: #ffffff;
    cursor: pointer;
    text-align: center;
    line-height: 30px;
    font-size: 23px;
    border-radius: 0;
    box-sizing: border-box;
}

/* 버튼과 입력 필드 사이에 경계가 겹치지 않도록 */
.quantity_btn:first-child {
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
}

.quantity_btn:last-child {
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
}

.quantity_btn:hover {
	border-color: black;
}

/* 수량 변경 시 버튼이 보이게 함 */
.quantity_btn.plus_btn, .quantity_btn.minus_btn {
	cursor: pointer;
	padding: 0.1rem 0.2rem;
	line-height: 1.2rem;
	
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

th, td {
	padding: 10px;
	border: 1px solid #ddd;
}

     /* 체크박스 관련  */
    input[type="checkbox"] {
    width: 20px;
    height: 20px;
    accent-color: gray; 
}

.table td:first-child,
.table th:first-child  {
    text-align: center; /
    vertical-align: middle; 
}

.clickDetail {
	text-decoration: none;
	font-weight: bold;
	font-size: 18px;
	color: #000;
}

.clickDetail:hover {
	text-decoration: underline;
}

.summary-container {
	display: flex;
	justify-content: space-around;
	margin-bottom: 20px;
}

.summary-box {
	flex: 1;
	margin: 0 10px;
	padding: 15px;
	border: 1px solid #ddd;
	border-radius: 5px;
	text-align: center;
	background-color: #f8f9fa;
	font-size: 18px;
}

.summary-box span {
	font-weight: bold;
}

.button-container {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
}

.selection-controls {
    display: flex;
    align-items: center;
    gap: 2px;
}
.page-title {
            text-align: center;
            font-weight: bold;
            font-size: 2rem;
            margin-bottom: 30px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
}
.table th,
.table td {
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
    overflow: hidden; /* 텍스트 넘침 숨기기 */
    text-overflow: ellipsis; /* 넘치는 텍스트에 말줄임표(...) 추가 */
    padding: 8px 10px; /* 기본적인 패딩 */
}

/* 각 열에 적절한 최소 너비 설정 */
.table th:first-child, 
.table td:first-child {
    width: 3%;
}

.table th:nth-child(2), 
.table td:nth-child(2) {
    width: 15%;
}

.table th:nth-child(3), 
.table td:nth-child(3) {
    width: 20%;
}

.table th:nth-child(4), 
.table td:nth-child(4) {
    width: 40%;
}

.table th:nth-child(5), 
.table td:nth-child(5) {
    width: 20%;
}

.table th:nth-child(6), 
.table td:nth-child(6) {
    width: 30%;
}
.table th:nth-child(7), 
.table td:nth-child(7) {
    width: 10%;
}
.table th:nth-child(8), 
.table td:nth-child(8) {
    width: 10%;
}
.table th:nth-child(9), 
.table td:nth-child(9) {
    width: 10%;
}

.detailRow {
	cursor: pointer;
}

.pagination .page-item.active .page-link {
	background-color: #d0d0d0;
    border-color: #d0d0d0;
}

.pagination .page-link {
	color: black;
}
@media (max-width: 768px) {
/* 상품종류, 가격, 등급 열 숨기기 */
	.table th:nth-child(3),
	.table td:nth-child(3),
	.table th:nth-child(5),
	.table td:nth-child(5),
	.table th:nth-child(6),
	.table td:nth-child(6),
	.table th:nth-child(8),
	.table td:nth-child(8),
	.table th:nth-child(9),
	.table td:nth-child(9),
	.table th:nth-child(10),
	.table td:nth-child(10) {
		display: none;
	}
	           
    .allBtn {
    	display: none;
    }        
}
</style>

</head>
<body class="nanum-gothic-regular" id="reserveTableBody">
<div id="wrapper">
<%@ include file="/modules/aheader.jsp"%>
	<div class="container mt-5 mb-5">

		<h2 class="page-title">예약관리</h2>

		<form id="searchForm" action="/admin/reserve" method="get">
    		<div class="d-flex justify-content-between align-items-center">
        		<div class="input-group" style="flex-wrap: nowrap;">
            		<select name="listSearchCondition" class="form-select" id="listSearchCondition" style="max-width: 150px;">
                		<option value="PCODE" ${listSearchCondition == 'PCODE' ? 'selected' : '' }>상품번호</option>
                		<option value="PNAME" ${listSearchCondition == 'PNAME' ? 'selected' : '' }>상품이름</option>
                		<option value="ID" ${listSearchCondition == 'ID' ? 'selected' : '' }>회원아이디</option>
                		<option value="UNAME" ${listSearchCondition == 'UNAME' ? 'selected' : '' }>회원이름</option>
            		</select>
            		<input type="search" class="form-control" id="listSearchKeyword" name="listSearchKeyword" value="${listSearchKeyword}" placeholder="검색어를 입력하세요">
            		<button type="button" id="searchBtn" class="btn btn-secondary">검색</button>
        		</div>
        		<button type="button" class="btn btn-secondary allBtn" style="white-space: nowrap; margin-left: 10px;" onclick="location.href='/admin/reserve';">전체</button>
    		</div>
		</form>

		<div class="selection-controls d-flex mb-2 mt-3 justify-content-between">
        	<button class="btn selectdelete_btn btn-secondary">일괄 삭제</button>
			<button type="button" onclick="location.href='/admin/reserve/reserveForm';" class="btn btn-secondary">예약등록</button>
    	</div>
		<div class="table-responsive mt-3 tableList">
			
			<table class="table table-bordered table-hover">
				<thead class="text-center">
					<tr>
						<th><input type="checkbox" id="selectAll"/></th>
						<th>번호</th>
						<th>상품 번호</th>
						<th>상품 이름</th>
						<th>아이디</th>
						<th>이름</th>
						<th>수량</th>
						<th>구매 예정 금액</th>
						<th>예약 상태</th>
						<th>선택</th>
					</tr>
				</thead>

				<tbody class="text-center">
					<c:forEach items="${reserveList}" var="reserve">
						<tr>
							<td>
							<c:choose>
							<c:when test="${reserve.rstate ne '결제완료'}">
							<input type="checkbox" name="rcode" class="reserveAll" value="${reserve.rcode}"/> 
							<input type="hidden" class="individual_PRICE_input" value="${reserve.price}">
							<input type="hidden" class="individual_RCOUNT_input" value="${reserve.pcount}"> 
							<input type="hidden" class="individual_RPRICE_input" value="${reserve.price * reserve.pcount}">
							</c:when>
							</c:choose>
							</td>
							<td class="detailRow" data-rcode="${reserve.rcode}">${reserve.rcode}</td>
							<td class="detailRow" data-rcode="${reserve.rcode}">${reserve.pcode}</td>
							<td class="detailRow" data-rcode="${reserve.rcode}">${reserve.pname}</td>
							<td class="detailRow" data-rcode="${reserve.rcode}">${reserve.id}</td>
							<td class="detailRow" data-rcode="${reserve.rcode}">${reserve.uname}</td>
		<!-- 수량 -->			<td>
					
						
								<c:choose>
									<c:when test="${reserve.rstate eq '결제전'}">
									
										<form action="<c:choose>
        									<c:when test="${not empty listSearchCondition and not empty listSearchKeyword}">
            								/admin/reserve/update?page=${page}&sc=${listSearchCondition}&word=${listSearchKeyword}
        									</c:when>
        									<c:otherwise>
            								/admin/reserve/update?page=${page}
        									</c:otherwise></c:choose>" method="post">
											<input name="rcode" type="hidden" value="${reserve.rcode}" />
											<input name="rprice" type="hidden" class="individual_RPRICE_input" value="${reserve.price * reserve.pcount}" />
											<div class="d-flex align-items-center">
												<button type="button" class="btn border-only quantity_btn minus_btn">-</button>
												<input type="text" name="pcount" value="${reserve.pcount}" class="form-control quantity_input" min="1" max="20" required>
												<button type="button" class="btn border-only quantity_btn plus_btn">+</button>
												<button type="submit" class="btn border-only ms-2 quantity_modify_btn btn-outline-secondary"
												data-rcode="${reserve.rcode}" data-uname="${reserve.uname}" data-pname="${reserve.pname}" data-pcount="${reserve.pcount}">수정</button>
											</div>
										</form>
									
									</c:when>
					
									<c:otherwise>${reserve.pcount}</c:otherwise>
									</c:choose>
									
							</td>
					
						
							<td class="detailRow" data-rcode="${reserve.rcode}"><span class="rprice"><fmt:formatNumber value="${reserve.rprice}" pattern="#,###" /></span></td>
							<td class="detailRow" data-rcode="${reserve.rcode}">${reserve.rstate}</td>
							<td><c:choose>
									<c:when test="${reserve.rstate ne '결제완료'}">
										<button type="button" class="btn btn-outline-secondary"
											onclick="reserveDelete('${reserve.rcode}')">삭제</button>
									</c:when>
									<c:otherwise></c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		
	<div class="container mt-3 mb-3">
			<section id="pageList" class="pagination justify-content-center">
				<ul class="pagination pagination">
					<!-- 이전 페이지 링크 -->
					<c:if test="${pageInfo.startPage > 5}">
						<li class="page-item">
						<a class="page-link" href="#" data-page="1" data-sc="${listSearchCondition}" data-word="${listSearchKeyword}">《</a>
                        </li>
						
						<li class="page-item">
						<a class="page-link" href="#" data-page="${pageInfo.startPage - 1}" data-sc="${listSearchCondition}" data-word="${listSearchKeyword}">〈</a>
						</li>
					</c:if>
					
					<!-- 페이지 번호 링크 -->
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<li class="page-item ${i == pageInfo.page ? 'active' : ''}">
                    	<a class="page-link" href="#" data-page="${i}" data-sc="${listSearchCondition}" data-word="${listSearchKeyword}">${i}</a>
                		</li>
					</c:forEach>
					
					<!-- 다음 페이지 링크 -->
					<c:if test="${pageInfo.endPage < pageInfo.maxPage}">
						<li class="page-item">
						<a class="page-link" href="#" data-page="${pageInfo.endPage + 1}" data-sc="${listSearchCondition}" data-word="${listSearchKeyword}">〉</a>
                    	</li>
                    	
                    	<li class="page-item">
                    	<a class="page-link" href="$" data-page="${pageInfo.maxPage}" data-sc="${listSearchCondition}" data-word="${listSearchKeyword}">》</a>
                    	</li>
					</c:if>
				</ul>
			</section>
		</div>

		
		<div class="summary-container">
			<div class="summary-box">
				예약 상품수: <span class="totalCount_span"></span>개
			</div>
			<div class="summary-box">
				상품 가격: <span class="totalPrice_span"></span> 원
			</div>
		</div>
		
	</div>
	</div>
	<%@ include file="/modules/footer.jsp"%>
	
	
	
<script>
        $(document).ready(function() {
            // 전체 선택 체크박스 기능
            $("#selectAll").on("click", function() {
                $("input[name='rcode']").prop("checked", this.checked);
                updateTotals();
            });

            // 개별 체크박스 선택 시 전체 선택 체크박스 상태 업데이트
            $("input[name='rcode']").on("click", function() {
                if ($("input[name='rcode']:not(:checked)").length === 0) {
                    $("#selectAll").prop("checked", true);
                } else {
                    $("#selectAll").prop("checked", false);
                }
                updateTotals();
            });

            // 수량 변경 버튼 클릭 시
            $(".quantity_btn").on("click", function() {
                var $input = $(this).siblings(".quantity_input");
                var quantity = parseInt($input.val(), 10);
                if ($(this).hasClass("plus_btn")) {
                    $input.val(quantity + 1);
                } else if ($(this).hasClass("minus_btn") && quantity > 1) {
                    $input.val(quantity - 1);
                }
                updateTotals();
                updateOrderPrice($(this));
            });

            // 수량 수정 버튼 클릭 시
            $(".quantity_modify_btn").on("click", function() {
            	event.preventDefault(); // 폼 제출 기본 동작 방지

                // 버튼의 data-* 속성에서 정보 추출
                var rcode = $(this).data("rcode");
                var uname = $(this).data("uname");
                var pname = $(this).data("pname");
                var newPcount = $(this).closest("form").find("input[name='pcount']").val();

                if (confirm("예약번호: " + rcode + "\n" +
                        	"회원이름: " + uname + "\n" +
                        	"상품이름: " + pname + "\n" +
                        	"바뀐 수량: " + newPcount + "\n수정하시겠습니까?")) {
                    var $form = $(this).closest("form");
                    $form.submit();

                    alert("수정되었습니다");
                }
            });

            // 총 가격과 총 수량 업데이트 함수
            function updateTotals() {
                let TOTALPRICE = 0; // 총 가격
                let TOTALCOUNT = 0; // 총 갯수

                $("input[name='rcode']:checked").each(function() {
                    var $row = $(this).closest("tr");
                    var quantity = parseInt($row.find(".quantity_input").val(), 10);
                    var price = parseInt($row.find(".individual_PRICE_input").val(), 10);

                    if (!isNaN(quantity) && !isNaN(price)) {
                        var itemTotal = price * quantity;
                        TOTALPRICE += itemTotal;
                        TOTALCOUNT += quantity;
                    }
                });

                $(".totalPrice_span").text(TOTALPRICE.toLocaleString());
                $(".totalCount_span").text(TOTALCOUNT);
            }

            // 주문 예정 금액 업데이트 함수
            function updateOrderPrice($triggerElement) {
                var $row = $triggerElement.closest("tr");
                var quantity = parseInt($row.find(".quantity_input").val(), 10);
                var price = parseInt($row.find(".individual_PRICE_input").val(), 10);

                if (!isNaN(quantity) && !isNaN(price)) {
                    var orderPrice = quantity * price;
                    $row.find(".individual_RPRICE_input").val(orderPrice); // hidden input에서 RPRICE를 갱신
                    $row.find(".rprice").text(orderPrice.toLocaleString()); // 화면에 표시된 RPRICE를 갱신
                }
            }

            
            // 페이지 로드 시 총 가격 및 수량 계산
            updateTotals();
        });

        // 검색 기능
        $(document).ready(function() {
            function search() {
                var listSearchKeyword = $('#listSearchKeyword').val().trim();
                var listSearchCondition = $('#listSearchCondition').val();

                var queryParams = $.param({
                    sc: listSearchCondition,
                    word: listSearchKeyword
                });
                
                var url = '/admin/reserve?' + queryParams;
                
                history.pushState(null, '', url);

                $.ajax({
                    url: url,
                    type: 'get',
                    dataType: 'html',
                    success: function(response) {
                        $('#reserveTableBody').html(response);
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error:', status, error);
                    }
                });
            }

            $('#searchBtn').click(function(event) {
                event.preventDefault();
                search();
            });

            $('#listSearchKeyword').keypress(function(event) {
                if (event.which === 13) { // Enter 키 코드
                    event.preventDefault(); // 기본 폼 제출 방지
                    search(); // 검색 함수 호출
                }
            });
        });

        
        
        // 삭제 버튼 클릭 시
        function reserveDelete(rcode) {
            if (confirm('예약을 삭제하시겠습니까?')) {
            	
            	var page = ${page}; // 현재 페이지 번호
                var listSearchCondition = "${listSearchCondition}"; // 검색 조건
                var listSearchKeyword = "${listSearchKeyword}";
                
                var queryParams = $.param({
                    sc: listSearchCondition,
                    word: listSearchKeyword
                });
                
                var url = '/admin/reserve/delete/' + rcode + '?page=' + page;

                if (listSearchCondition && listSearchKeyword) {

                    url += '&' + queryParams;
                }
                
                location.href = url;
                
                alert("예약이 삭제되었습니다.");
            }
        }
        
        
        
        $(document).ready(function() {
            // 선택 상품 삭제 버튼 클릭 시 삭제 요청
            $('.selectdelete_btn').on('click', function() {
                var selectedItems = $("input[name='rcode']:checked").map(function() {
                    return parseInt($(this).val(), 10);
                }).get();

                if (selectedItems.length > 0) {
                	if(confirm("예약을 삭제하시겠습니까?")) {                  		
                    	$.ajax({                   		
                        	url: '/admin/reserve/selectDelete',
                        	type: 'POST',
                        	contentType: 'application/json',
                        	data: JSON.stringify({ rcodes: selectedItems }),
                        	success: function(response) {
                        		alert("예약이 삭제되었습니다.");
                            	window.location.reload();
                        	},
                        	error: function() {
                            	alert('삭제 실패');
                        	}
                    	});
                	} 
                }else {
                	alert('삭제할 항목을 선택해 주세요.');
            	} 
            });
        });
        
        $(document).ready(function() {
            $('#pageList').on('click', '.page-link', function(e) {
                e.preventDefault();

                var page = $(this).data('page');
                var searchCondition = $(this).data('sc');
                var searchKeyword = $(this).data('word');

                $.ajax({
                    url: '/admin/reserve',
                    type: 'GET',
                    data: {
                        page: page,
                        sc: searchCondition,
                        word: searchKeyword
                    },
                    success: function(response) {
                    	$('#reserveTableBody').html(response);
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error:', status, error);
                    }
                });
            });
        });
        
        
        $(document).ready(function() {
            $('.detailRow').on('click', function() {
                var rcode = $(this).data('rcode');
                var listSearchCondition = '${listSearchCondition}';
                var listSearchKeyword = '${listSearchKeyword}';
                var page = '${page}';

                var url = '/admin/reserve/detail/' + rcode;
                if (listSearchCondition && listSearchKeyword) {
                    url += '?page=' + page + '&sc=' + listSearchCondition + '&word=' + listSearchKeyword;
                } else {
                    url += '?page=' + page;
                }
                window.location.href = url;
            });
        });
</script>
</body>
</html>