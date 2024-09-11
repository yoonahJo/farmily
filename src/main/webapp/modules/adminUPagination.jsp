<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="paginationContainer">
    <section id="pageList" class="pagination justify-content-center">
        <ul class="pagination justify-content-center">
            <!-- '처음으로' 링크 -->
            <c:if test="${pageInfo.startPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/list?page=1&role=${role}">《</a>
                </li>
            </c:if>
            
            <!-- 이전 페이지 링크 -->
<c:if test="${pageInfo.page > 1 && pageInfo.page >= 5}">
    <li class="page-item">
        <a class="page-link" href="${pageContext.request.contextPath}/admin/list?page=${pageInfo.page - 1}&role=${role}" aria-label="Previous">
            <span aria-hidden="true">〈</span>
        </a>
    </li>
</c:if>
            
            <!-- 페이지 번호 링크 -->
            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
                <li class="page-item ${i == pageInfo.page ? 'active' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/list?page=${i}&role=${role}">${i}</a>
                </li>
            </c:forEach>

            <!-- 다음 페이지 링크 -->
			<c:if test="${pageInfo.page < pageInfo.maxPage && pageInfo.page >= 5}">
			    <li class="page-item">
			        <a class="page-link" href="${pageContext.request.contextPath}/admin/list?page=${pageInfo.page < 1 ? 2 : pageInfo.page + 1}&role=${role}" aria-label="Next">
			            <span aria-hidden="true">〉</span>
			        </a>
			    </li>
			</c:if>


            
            <!-- '마지막 페이지' 링크 -->
            <c:if test="${pageInfo.page < pageInfo.maxPage}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/list?page=${pageInfo.maxPage}&role=${role}">》</a>
                </li>
            </c:if>
        </ul>
    </section>
</div>
