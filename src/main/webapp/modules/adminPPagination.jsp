<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


    <div id="paginationContainer">
    <ul class="pagination justify-content-center">
        <c:if test="${startPage > 1}">  <!-- 시작 페이지 1페이지보다 큰경우 ex6,11,16 처음으로 및 이전 링크 생기게하기 -->
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/product?page=1&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">《</a>
            </li>
        </c:if>

        <c:if test="${startPage > 1}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/product?page=${startPage - 1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">〈</a>
            </li>
        </c:if>

        <c:forEach var="i" begin="${startPage}" end="${endPage}"> <!-- 시작페이지부터 끝페이지까지 페이지링크생성  -->
            <li class="page-item ${i == page ? 'active' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/product?page=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">${i}</a>
            </li>
        </c:forEach>

        <c:if test="${endPage < maxPage}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/product?page=${endPage + 1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">〉</a>
            </li>
        </c:if>

        <c:if test="${page < maxPage}">
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/product?page=${maxPage}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">》</a>
            </li>
        </c:if>
    </ul>
</div>