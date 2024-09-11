<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>페이지를 찾을 수 없음</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
    	.h1error {
    		font-size: 3rem;
    	}
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column; /* 수직 방향으로 정렬 */
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 80%;
            max-width: 600px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            border: 1px solid #ddd;
            text-align: center;
            top: 45%; /* 화면 중앙에서 약간 위쪽으로 위치 */
            transform: translateY(-10%); /* 정확한 중앙 위치 조정 */
            margin: 20px;
        }
        .notfound {
            color: #00c834;
        }
        p {
            color: #333;
            margin: 10px 0;
        }
        .mainpage {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #1dba00;
            text-decoration: none;
            border-radius: 5px;
        }
        .mainpage:hover {
            background-color: #169500;
        }
    </style>
</head>
<body class="nanum-gothic-regular">
	<h1 class="h1error">Farmily</h1>
	<br/>
    <div class="container">
        <h1>페이지를 <span class="notfound">찾을 수 없습니다</span></h1>
        <br/>
        <p>입력하신 정보가 잘못되었거나,</p>
        <p>변경 또는 삭제되어 요청하신 페이지를 찾을 수 없습니다.</p>
        <p>메인 페이지로 이동해 주세요.</p>
        <a href="/" class="mainpage"><strong>메인 페이지로 이동</strong></a>
    </div>

    <jsp:include page="/modules/footer.jsp"></jsp:include>
</body>
</html>
