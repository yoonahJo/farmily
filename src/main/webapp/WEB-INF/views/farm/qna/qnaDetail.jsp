<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Farmer :: Q&A 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: white;
            font-family: 'Arial', sans-serif;
        }
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
        .star {
            font-size: 24px;
            cursor: pointer;
            color: #FFD700;
        }
        .button-group {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body class="nanum-gothic-regular">
<jsp:include page="/modules/farmerHeader.jsp" flush="false" />

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
                <c:otherwise></c:otherwise>
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
                </c:when>
                <c:otherwise>
                    <p class="no-response">아직 답변이 등록되지 않았습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 버튼 그룹 컨테이너 밖으로 이동 -->
    <div class="button-group d-flex justify-content-center">
        <!-- 목록으로 이동 -->
        <a href="${pageContext.request.contextPath}/farm/qna?page=${param.page}&searchKeyword=${param.searchKeyword}" class="btn btn-success mx-2">목록</a>
		
		<!-- 수정 (답변이 없는 경우에만 표시) -->
        <c:if test="${qna.rcontent == null}">
            <a href="${pageContext.request.contextPath}/farm/qna/updatePage/${qna.qcode}?page=${param.page}&searchKeyword=${param.searchKeyword}" class="btn btn-success mx-2">수정</a>
        </c:if>
		
        <!-- 삭제 -->
        <form action="${pageContext.request.contextPath}/farm/qna/delete/${qna.qcode}" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');" class="mx-2">
            <input type="hidden" name="qcode" value="${qna.qcode}">
            <input type="hidden" name="page" value="${param.page}">
            <input type="hidden" name="searchKeyword" value="${param.searchKeyword}">
            <button type="submit" class="btn btn-success">삭제</button>
        </form>

         
    </div>

    <!-- 별점 평가 -->
    <c:if test="${qna.rcontent != null && qna.rating == 0}">
        <div class="container mt-4">
            <div class="content-section">
                <h3>답변 만족도 평가</h3>
                <form id="ratingForm" action="${pageContext.request.contextPath}/farm/qna/rate/${qcode}" method="post">
                    <input type="hidden" name="qcode" value="${qna.qcode}" />
                    <input type="hidden" id="ratingValue" name="rating" value="0" />
                    <input type="hidden" name="page" value="${param.page}" />
                    <input type="hidden" name="searchKeyword" value="${param.searchKeyword}" />

                    <div id="starRating">
                        <span class="star" data-value="1">&#9734;</span>
                        <span class="star" data-value="2">&#9734;</span>
                        <span class="star" data-value="3">&#9734;</span>
                        <span class="star" data-value="4">&#9734;</span>
                        <span class="star" data-value="5">&#9734;</span>
                    </div>

                    <button type="submit" class="btn btn-success mt-3">평가 제출</button>
                </form>
            </div>
        </div>
        <br><br>
    </c:if>

    <!-- 별점 평가 결과 표시 -->
    <c:if test="${qna.rating > 0}">
        <div class="container mt-4">
            <div class="content-section">
                <h3>평가 결과</h3>
                <div id="displayRating">
                    <c:forEach begin="1" end="5" var="star">
                        <span class="star">
                            <c:choose>
                                <c:when test="${star <= qna.rating}">
                                    &#9733; <!-- 채워진 별 -->
                                </c:when>
                                <c:otherwise>
                                    &#9734; <!-- 빈 별 -->
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </c:forEach>
                </div>
            </div>
        </div>
        <br><br>
    </c:if>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const stars = document.querySelectorAll('#starRating .star');
            const ratingInput = document.getElementById('ratingValue');

            stars.forEach(function (star) {
                star.addEventListener('click', function () {
                    const rating = this.getAttribute('data-value');
                    ratingInput.value = rating;

                    stars.forEach(function (s) {
                        if (s.getAttribute('data-value') <= rating) {
                            s.innerHTML = '&#9733;'; // 채워진 별
                        } else {
                            s.innerHTML = '&#9734;'; // 빈 별
                        }
                    });
                });
            });
        });
    </script>
    <%@ include file="/modules/footer.jsp"%>
</body>
</html>