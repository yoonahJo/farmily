<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <script>
        $(document).ready(function() {
            var reqBody = '${reqBody}';
            var reqUrl = '${reqUrl}';

            try {
                var parsedReqBody = JSON.parse(reqBody);
            } catch (e) {
                console.error("Invalid JSON:", reqBody);
                return;
            }

            if (reqBody) {
                if (reqUrl === 'http://localhost:8080/reserve/oneInsert') {
                    $.ajax({
                        url: '/reserve/oneInsert',
                        type: 'POST',
                        contentType: 'application/json',
                        data: reqBody,
                        success: function(response) {
                            if (response.redirect) {
                                var orders = response.orders;
                                if (orders && orders.length > 0) {
                                    var firstOrder = orders[0];
                                    var data = {
                                        'pcode': firstOrder.pcode,
                                        'pcount': firstOrder.pcount,
                                        'rcode': firstOrder.rcode
                                    };
                                    getRequest(response.redirect, data);
                                } else {
                                    alert('주문 정보가 없습니다.');
                                }
                            } else {
                                alert('리다이렉트 URL이 없습니다.');
                            }
                        },
                        error: function(xhr) {
                            if (xhr.status === 401) {
                                var response = JSON.parse(xhr.responseText);
                                window.location.href = response.redirect;
                            } else {
                                alert('오류가 발생했습니다.');
                            }
                        }
                    });
                }
            }
         // 동적 HTML 폼을 생성하여 GET 요청을 보내는 함수
            function getRequest(url, data) {
                var queryString = $.param(data); // 데이터를 쿼리 문자열로 변환
                var fullUrl = url + '?' + queryString; // URL과 쿼리 문자열을 결합

                window.location.href = fullUrl; // GET 요청을 보냄
            }
        });
    </script>
</body>
</html>
