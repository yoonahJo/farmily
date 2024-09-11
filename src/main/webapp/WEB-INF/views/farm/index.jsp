<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

response.setHeader("Pragma", "No-Cache");
response.setHeader("Cache-Control", "No-Store");
response.setDateHeader("Expires", 0);

%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>farmily</title>
<style>
html, body {height:100%}
#wrapper {
  height: auto;
  min-height: 100%;
  padding-bottom: 185px;
}
footer{
  height: 160px;
  position : relative;
  transform : translateY(-100%);
}

</style>
</head>
<body>
<jsp:include page="/modules/farmerHeader.jsp" flush="false" />
<h1>농부 인덱스 페이지</h1>
</body>
</html>