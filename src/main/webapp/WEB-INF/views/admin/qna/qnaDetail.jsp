<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin :: Q&A 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: white;
            font-family: 'Arial', sans-serif;
        }
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
          
            margin-top: 20px;
        }
        h2 {
            font-weight: bold;
            color: #333;
        }
        .meta-data {
            color: #888;
            font-size: 0.9em;
        }
        .content-section {
            margin-top: 20px;
        }
        .content-section img {
            max-width: 100%;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .response {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 10px;
            margin-top: 20px;
          
        }
        .response p {
            margin-bottom: 0;
        }
        .no-response {
            color: #888;
        }
        /* 목록 버튼을 오른쪽에 정렬 */
        .back-button {
            margin-top: 20px;
            text-align: center;
        }
        
   
    </style>
    
    <style>
html, body {height:100%}
#wrapper{
  height: auto;
  min-height: 100%;
  padding-bottom: 209px;
}
footer{
  height: 209px;
  position : relative;
  transform : translateY(-100%);
}
</style>
</head>
<body class="nanum-gothic-regular">
<div id="wrapper">

<%@ include file="/modules/aheader.jsp"%>

    <div class="container">

        <h2>${qna.title}</h2>
        <p class="meta-data">작성자: ${qna.id}</p>
        <p class="meta-data">작성일: <fmt:formatDate value="${qna.postdate}" pattern="yyyy-MM-dd" /></p>
        <hr>
        <div class="content-section">
            <h3>문의 내용</h3>
            <c:choose>
                <c:when test="${qna.image != null}">
                    <img src="${pageContext.request.contextPath}/resources/img/${qna.image}" alt="첨부 이미지" class="img-fluid mt-3" />
                </c:when>
                <c:otherwise>
                </c:otherwise>
            </c:choose>
            <pre>${qna.content}</pre>
        </div>
        <hr>
        <div class="content-section">
            <h3>답변</h3>
            <c:choose>
                <c:when test="${qna.rcontent != null}">
                    <div class="response">
                        <p>${qna.rcontent}</p>
                        <p class="meta-data">답변일: <fmt:formatDate value="${qna.rpostdate}" pattern="yyyy-MM-dd" /></p>
                    </div>
                    
                       <form action="${pageContext.request.contextPath}/admin/qna/deleteReply/${qna.qcode}" method="post" onsubmit="return confirm('정말 답변을 삭제하시겠습니까?');">
    <input type="hidden" name="page" value="${page}" />
    <input type="hidden" name="searchCondition" value="${searchCondition}" />
    <input type="hidden" name="searchKeyword" value="${searchKeyword}" />
    <div class="text-end">
        <button type="submit" class="btn btn-danger">답변 삭제</button>
    </div>
</form>
                   
                    
                </c:when>
                <c:otherwise>
              
                    <p class="no-response">아직 답변이 등록되지 않았습니다.</p>
                  
                </c:otherwise>
            </c:choose>
        </div>
         <!-- 답변이 없을 때만 표시 -->
       
        <c:if test="${qna.rcontent == null}">
            <hr>
            <div class="content-section">
                
             <form action="${pageContext.request.contextPath}/admin/qna/insertReply/${qna.qcode}" method="post">
         
    <input type="hidden" name="qcode" value="${qna.qcode}" />
    <input type="hidden" name="page" value="${page}" />
    <input type="hidden" name="searchCondition" value="${searchCondition}" />
    <input type="hidden" name="searchKeyword" value="${searchKeyword}" />
    <div class="mb-3">
        <label for="rcontent" class="form-label">답변 내용</label>
        <textarea class="form-control" id="rcontent" name="rcontent" rows="5" required></textarea>
    </div>
    <div class="d-flex justify-content-end">
        <button type="submit" class="btn btn-secondary">답변 등록</button>
    </div>
</form>
            </div>
        </c:if>
         <!-- 목록 버튼 -->
        <div class="d-flex justify-content-center">
        <!-- 삭제 -->
        <form action="${pageContext.request.contextPath}/admin/qna/delete/${qna.qcode}" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');" class="mx-2">
            <input type="hidden" name="qcode" value="${qna.qcode}">
            <input type="hidden" name="page" value="${page}">
            <input type="hidden" name="searchCondition" value="${searchCondition}" />
            <input type="hidden" name="searchKeyword" value="${searchKeyword}">
            <button type="submit" class="btn btn-secondary">삭제</button>
        </form>
            <a href="/admin/qna?page=${page}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" class="btn btn-secondary">목록</a>
        </div>
    </div>
 </div>
    <%@ include file="/modules/footer.jsp"%>
</body>
</html>