<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.spring.farmily.reserve.model.admin.PageInfo"%>
<%
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
    String listSearchKeyword = request.getParameter("listSearchKeyword");
    String listSearchCondition = request.getParameter("listSearchCondition");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin :: 예약 상세</title>
<style>
.detailList {
	border-bottom: 1px solid #ddd;
}
input[readonly] {
	background-color: #fafafa;
}
input[readonly]:focus {
	outline: none;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="nanum-gothic-regular">
<%@ include file="/modules/aheader.jsp"%>

<input name="rcode" type="hidden" value="${reserveDetail.rcode}" />

<div class="container">
    <div class="row mt-5 mb-5">
        <div class="col-sm-2"></div>
        <div class="col-sm-8 text-center"><h2>예약상세정보</h2></div>
        <div class="col-sm-2"></div>
    </div>
   
   
<div class="detailList mb-3">
   
    <div class="container" id="productbox">
        <div class="row mt-5 mb-2">
            <div class="col-sm-2"></div>
            <div class="col-sm-8"><h3>상품정보</h3></div>
            <div class="col-sm-2"></div>
        </div>
        <div class="row mb-2">
            <div class="col-sm-2"></div>
            <div class="col-sm-1"><label for="pcode" class="form-label">상품코드</label></div>
            <div class="col-sm-7"><input type="text" class="form-control" id="pcode" name="pcode"
                    value="${reserveDetail.pcode}" readonly></div>
            <div class="col-sm-2"></div>
        </div>
        <div class="row mb-2">
            <div class="col-sm-2"></div>
            <div class="col-sm-1"><label for="pname" class="form-label">상품이름</label></div>
            <div class="col-sm-7"><input type="text" class="form-control" id="pname" name="pname"
                    value="${reserveDetail.pname}" readonly></div>
            <div class="col-sm-2"></div>
        </div>
        <div class="row mb-2">
            <div class="col-sm-2"></div>
            <div class="col-sm-1"><label for="price" class="form-label">개당 가격</label></div>
            <div class="col-sm-7"><input type="text" class="form-control" id="price" name="price"
                    value="<fmt:formatNumber value='${reserveDetail.price}' type='number' pattern='#,###'/>원" readonly></div>
            <div class="col-sm-2"></div>
        </div>
       
        <div class="row mb-2">
            <div class="col-sm-2"></div>
            <div class="col-sm-1"><label for="pcount" class="form-label">수량</label></div>
            <div class="col-sm-7">
            <form id="updateForm" action="<c:choose>
            <c:when test="${not empty listSearchCondition and not empty listSearchKeyword}">
                /admin/reserve/detailUpdate?page=${page}&sc=${listSearchCondition}&word=${listSearchKeyword}
            </c:when>
            <c:otherwise>
                /admin/reserve/detailUpdate?page=${page}
            </c:otherwise></c:choose>" method="post">
            <input name="rcode" type="hidden" value="${reserveDetail.rcode}" />
            <input name="rprice" type="hidden" id="rpriceHidden" value="${reserveDetail.price * reserveDetail.pcount}" />
            <div class="input-group">
                <input type="text" name="pcount" class="form-control" id="pcount" value="${reserveDetail.pcount}" min="1" required>
                <button type="submit" class="btn border-only updateBtn btn-outline-secondary">수정</button>
            </div>
            </form>
            </div>
            <div class="col-sm-2"></div>
        </div>
                                       
        <div class="row mb-2">
            <div class="col-sm-2"></div>
            <div class="col-sm-1"><label for="fname" class="form-label">농장이름</label></div>
            <div class="col-sm-7"><input type="text" class="form-control" id="fname" name="fname"
                    value="${reserveDetail.fname}" readonly></div>
            <div class="col-sm-2"></div>
        </div>    
    </div>
   
    <div class="container" id="userbox">
        <div class="row mt-5 mb-2">
            <div class="col-sm-2"></div>
            <div class="col-sm-8"><h3>회원정보</h3></div>
            <div class="col-sm-2"></div>
        </div>
        <div class="row mb-2">
            <div class="col-sm-2"></div>
            <div class="col-sm-1"><label for="id" class="form-label">회원아이디</label></div>
            <div class="col-sm-7"><input type="text" class="form-control" id="id" name="id"
                    value="${reserveDetail.id}" readonly></div>
            <div class="col-sm-2"></div>
        </div>
        <div class="row mb-2">
            <div class="col-sm-2"></div>
            <div class="col-sm-1"><label for="uname" class="form-label">회원이름</label></div>
            <div class="col-sm-7"><input type="text" class="form-control" id="uname" name="uname"
                    value="${reserveDetail.uname}" readonly></div>
            <div class="col-sm-2"></div>
        </div>
        <div class="row mb-2">
            <div class="col-sm-2"></div>
            <div class="col-sm-1"><label for="phone" class="form-label">전화번호</label></div>
            <div class="col-sm-7"><input type="text" class="form-control" id="phone" name="phone"
                    value="${reserveDetail.phone}" readonly></div>
            <div class="col-sm-2"></div>
        </div>
        <div class="row mb-2">
            <div class="col-sm-2"></div>
            <div class="col-sm-1"><label for="uzcode" class="form-label">우편번호</label></div>
            <div class="col-sm-7"><input type="text" class="form-control" id="uzcode" name="uzcode"
                value="${reserveDetail.uzcode}" readonly></div>
            <div class="col-sm-2"></div>
        </div>
        <div class="row mb-5">
            <div class="col-sm-2"></div>
            <div class="col-sm-1"><label for="uaddress" class="form-label">주소</label></div>
            <div class="col-sm-7"><input type="text" class="form-control" id="uaddress" name="uaddress"
                    value="${reserveDetail.uaddress}" readonly></div>
            <div class="col-sm-2"></div>
        </div>    
    </div>

</div>

    <div class="container">
        <div class="row mt-5">
            <div class="col-sm-2"></div>
            <div class="col-sm-1"><label for="rprice" class="fw-bold fs-4">총가격</label></div>
            <div class="col-sm-7"><input type="text" class="form-control" id="rprice" name="rprice" readonly /></div>
            <div class="col-sm-2"></div>
        </div>

        <div id="changeBtn" class="row mb-5 mt-5">
            <div class="col-sm-10 text-end">
                <button type="button" id="listBtn" class="btn btn-secondary">예약관리</button>
                <button type="button" class="btn btn-secondary" onclick="reserveDelete('${reserveDetail.rcode}')">예약취소</button>
            </div>
            <div class="col-sm-2"></div>
        </div>
    </div>
</div>

<script>   
    function reserveDelete(rcode) {
        if (confirm('예약을 취소하시겠습니까?')) {
            var page = '${page}'; // 현재 페이지 번호
            var listSearchCondition = '${listSearchCondition}'; // 검색 조건
            var listSearchKeyword = '${listSearchKeyword}';

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

    document.getElementById('listBtn').addEventListener('click', function() {
        var page = '${page}';
        var listSearchCondition = '${listSearchCondition}';
        var listSearchKeyword = '${listSearchKeyword}';

        var url = '/admin/reserve?page=' + page;
        var queryParams = $.param({
            sc: listSearchCondition,
            word: listSearchKeyword
        });

        url += '&' + queryParams;
        location.href = url;
    });
    
    
    function updateTotalPrice() {
        var price = parseFloat($("#price").val().replace(/[^0-9]/g, '')) || 0;
        var count = parseInt($("#pcount").val(), 10) || 0;
        var totalPrice = price * count;
        $("#rprice").val(new Intl.NumberFormat().format(totalPrice) + '원');
        $("#rpriceHidden").val(totalPrice);
    }

    $("#pcount").on('input', updateTotalPrice);
    updateTotalPrice();

    $(".updateBtn").on("click", function(event) {
        event.preventDefault(); // 폼 제출 기본 동작 방지

        if (confirm("수정하시겠습니까?")) {
            $("#updateForm").submit();
            alert("수정되었습니다");
        }
    });

</script>
<%@ include file="/modules/footer.jsp"%>
</body>
</html>
