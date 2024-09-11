<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="paginationContainer">
    <ul class="pagination justify-content-center">
        <!-- 처음 페이지로 이동 -->
        <c:if test="${startPage > 1}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/farm/pay?page=1&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">《</a>
            </li>
        </c:if>

        <!-- 이전 페이지 그룹으로 이동 -->
        <c:if test="${startPage > 1}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/farm/pay?page=${startPage - 1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">〈</a>
            </li>
        </c:if>

        <!-- 페이지 번호들 -->
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <li class="page-item ${i == page ? 'active' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/farm/pay?page=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">${i}</a>
            </li>
        </c:forEach>

        <!-- 다음 페이지 그룹으로 이동 -->
        <c:if test="${endPage < maxPage}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/farm/pay?page=${endPage + 1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">〉</a>
            </li>
        </c:if>

        <!-- 마지막 페이지로 이동 -->
        <c:if test="${page < maxPage}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/farm/pay?page=${maxPage}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">》</a>
            </li>
        </c:if>
    </ul>
</div>