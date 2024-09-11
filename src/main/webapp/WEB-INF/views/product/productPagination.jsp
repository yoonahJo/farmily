<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav aria-label="페이지 네비게이션">
    <ul class="pagination justify-content-center">
        <c:if test="${currentPage > 1}">
            <!-- 첫 페이지 링크 --> 
            <li class="page-item">
                <a class="page-link" href="?page=1<c:if test='${ptype != null && !ptype.isEmpty()}'>&ptype=${ptype}</c:if><c:if test='${keyword != null && !keyword.isEmpty()}'>&keyword=${keyword}</c:if>">《</a>
            </li>
            <!-- 이전 페이지 링크 -->
            <li class="page-item">
                <a class="page-link" href="?page=${currentPage - 1}<c:if test='${ptype != null && !ptype.isEmpty()}'>&ptype=${ptype}</c:if><c:if test='${keyword != null && !keyword.isEmpty()}'>&keyword=${keyword}</c:if>">〈</a>
            </li>
        </c:if>
        
        <!-- 페이지 번호 링크들 -->
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <li class="page-item active">
                        <span class="page-link">${i}</span>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link" href="?page=${i}<c:if test='${ptype != null && !ptype.isEmpty()}'>&ptype=${ptype}</c:if><c:if test='${keyword != null && !keyword.isEmpty()}'>&keyword=${keyword}</c:if>">${i}</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        
        <c:if test="${currentPage < totalPages}">
            <!-- 다음 페이지 링크 -->
            <li class="page-item">
                <a class="page-link" href="?page=${currentPage + 1}<c:if test='${ptype != null && !ptype.isEmpty()}'>&ptype=${ptype}</c:if><c:if test='${keyword != null && !keyword.isEmpty()}'>&keyword=${keyword}</c:if>">〉</a>
            </li>
            <!-- 마지막 페이지 링크 -->
            <li class="page-item">
                <a class="page-link" href="?page=${totalPages}<c:if test='${ptype != null && !ptype.isEmpty()}'>&ptype=${ptype}</c:if><c:if test='${keyword != null && !keyword.isEmpty()}'>&keyword=${keyword}</c:if>">》</a>
            </li>
        </c:if>
    </ul>
</nav>
