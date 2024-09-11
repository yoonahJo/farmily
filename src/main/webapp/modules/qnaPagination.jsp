<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<div id="paginationContainer">
    <ul class="pagination justify-content-center">
        <c:if test="${startPage > 1}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/farm/qna?page=1&searchKeyword=${searchKeyword}">《</a>
            </li>
        </c:if>

        <c:if test="${startPage > 1}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/farm/qna?page=${startPage - 1}&searchKeyword=${searchKeyword}">〈</a>
            </li>
        </c:if>

        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <li class="page-item ${i == page ? 'active' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/farm/qna?page=${i}&searchKeyword=${searchKeyword}">${i}</a>
            </li>
        </c:forEach>

        <c:if test="${endPage < maxPage}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/farm/qna?page=${endPage + 1}&searchKeyword=${searchKeyword}">〉</a>
            </li>
        </c:if>

        <c:if test="${page < maxPage}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/farm/qna?page=${maxPage}&searchKeyword=${searchKeyword}">》</a>
            </li>
        </c:if>
    </ul>
</div>