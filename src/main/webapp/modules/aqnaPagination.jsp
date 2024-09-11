<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<div id="paginationContainer">
    <ul class="pagination justify-content-center">
        <c:if test="${startPage > 1}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/qna?page=1&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">《</a>
            </li>
        </c:if>

        <c:if test="${startPage > 1}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/qna?page=${startPage - 1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">〈</a>
            </li>
        </c:if>

        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <li class="page-item ${i == page ? 'active' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/qna?page=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">${i}</a>
            </li>
        </c:forEach>

        <c:if test="${endPage < maxPage}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/qna?page=${endPage + 1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">〉</a>
            </li>
        </c:if>

        <c:if test="${page < maxPage}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/qna?page=${maxPage}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">》</a>
            </li>
        </c:if>
    </ul>
</div>