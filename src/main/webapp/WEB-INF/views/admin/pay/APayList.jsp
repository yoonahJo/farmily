<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin :: 주문관리</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #dee2e6;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #343a40;
            color: white;
        }
        .cancelled {
            background-color: #dc3545;
            color: white;
            pointer-events: none; 
            cursor: not-allowed; 
        }
        .form-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            font-size: 1.2rem; /* 버튼 텍스트 크기 */
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-danger {
            background-color: #dc3545;
            border: none;
            font-size: 1.2rem; /* 버튼 텍스트 크기 */
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-link {
            color: #007bff;
            text-decoration: none;
            font-size: 1.2rem; /* 링크 텍스트 크기 */
        }
        .btn-link:hover {
            color: #0056b3;
            text-decoration: underline;
        }
        .search-form .form-control, .search-form .form-select {
            border-radius: 8px;
            font-size: 1.2rem; /* 검색 폼 입력 크기 */
        }
        .search-form .btn {
            border-radius: 8px;
            font-size: 1.2rem; /* 검색 버튼 크기 */
        }
        .page-title {
            text-align: center;
            font-size: 2.5rem; /* 페이지 제목 크기 */
            margin-bottom: 30px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }
        .table th,
        .table td {
            white-space: nowrap; 
            overflow: hidden; 
            text-overflow: ellipsis; 
            padding: 8px 10px;
        }

        /* 각 열에 적절한 최소 너비 설정 */
        .table th:first-child, 
        .table td:first-child {
            width: 10%; /* 문의접수번호 */
        }

        .table th:nth-child(2), 
        .table td:nth-child(2) {
            width: 10%; /* 작성자 ID */
        }

        .table th:nth-child(3), 
        .table td:nth-child(3) {
            width: 40%; /* 제목 */
        }

        .table th:nth-child(4), 
        .table td:nth-child(4) {
            width: 10%; /* 작성 날짜 */
        }

        .table th:nth-child(5), 
        .table td:nth-child(5) {
            width: 15%; /* 상태 */
        }

        .table th:nth-child(6), 
        .table td:nth-child(6) {
            width: 10%; /* 만족도 */
        }
        
        @media (max-width: 768px) {
            .table th, .table td {
                display: none;
            }

            .table th:nth-child(1),
            .table td:nth-child(1),
            .table th:nth-child(2),
            .table td:nth-child(2),
            .table th:nth-child(4),
            .table td:nth-child(4),
            .table th:nth-child(6),
            .table td:nth-child(6) {
                display: table-cell;
            }
        }
         .page-item.active .page-link {
    background-color: #d0d0d0;
    border-color: #d0d0d0;
    color: black; /* 원하는 텍스트 색상 */
	}
	.page-link {
	color: black;
	}
	    .allBtn {
    	display: none;
    }  
    </style>
    <script>
    $(document).ready(function() {
        // Show confirmation modal with form
        window.showConfirmationModal = function(form) {
            $('#confirmationModal').data('form', form).modal('show');
        };

        // Handle form submission after confirmation
        $('#confirmButton').click(function() {
            var form = $('#confirmationModal').data('form');
            var actionUrl = $(form).attr('action');
            $.ajax({
                type: 'POST',
                url: actionUrl,
                data: $(form).serialize(),
                success: function(response) {
                    $('#confirmationModal').modal('hide');
                    location.reload(); // Refresh the page or handle the response as needed
                },
                error: function() {
                    alert('결제 취소 중 오류가 발생했습니다.');
                }
            });
        });

        // Check if the result is empty and show the modal
        if ($('#emptyResult').val() === 'true') {
            $('#emptyResultModal').modal('show');
        }
    });
    </script>
</head>
<body class="nanum-gothic-regular">
    <jsp:include page="/modules/aheader.jsp"></jsp:include>
    <br><br>
    <div class="container">
        <h2 class="page-title">주문관리</h2>
        
        <form id="searchForm" action="${pageContext.request.contextPath}/admin/pay" method="get">
            <div class="d-flex justify-content-between align-items-center">
                <div class="input-group" style="flex-wrap: nowrap;">
                    <select name="searchType" class="form-select" style="max-width: 150px;">
                        <option value="paycode" ${param.searchType == 'paycode' ? 'selected' : ''}>결제번호</option>
                        <option value="id" ${param.searchType == 'id' ? 'selected' : ''}>회원 ID</option>
                        <option value="fname" ${param.searchType == 'fname' ? 'selected' : ''}>농장명</option>
                    </select>
                    <input type="text" class="form-control" name="searchField" value="${param.searchField}" placeholder="검색어를 입력하세요">
                    <button type="submit" class="btn btn-secondary">검색</button>
                </div>
                <button type="button" class="btn btn-secondary allbtn" style="white-space: nowrap; margin-left: 10px;" onclick="location.href='${pageContext.request.contextPath}/admin/pay';">전체보기</button>
            </div>
        </form>
        
        <br><br>
        <div class="table-responsive">
        <c:if test="${empty payList}">
            <input type="hidden" id="emptyResult" value="true"/>
        </c:if>
        <c:if test="${not empty payList}">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th class="highlight">주문번호</th>
                        <th class="highlight">회원ID</th>
                        <th class="highlight">상품명</th>
                        <th class="highlight">결제금액</th>
                        <th class="highlight">결제날짜</th>
                        <th class="highlight">농장명</th>  
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${payList}" var="pay">
 <tr style="cursor: pointer" onclick="location.href='${pageContext.request.contextPath}/admin/pay/payDetail/${pay.paycode}'">
                            <td><c:out value="${pay.paycode}"/></td>
                            <td><c:out value="${pay.id}"/></td>
                            <td><c:out value="${pay.name}"/></td>
                            <td><fmt:formatNumber value="${pay.unitPrice}" pattern="#,###" />원</td>
                            <td>
                                <fmt:formatDate value="${pay.paydate}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                            <td><c:out value="${pay.fname}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</div>
    <!-- 검색 결과 없음 모달 -->
    <div class="modal fade" id="emptyResultModal" tabindex="-1" aria-labelledby="emptyResultModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="emptyResultModalLabel">검색 결과 없음</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    검색 결과가 없습니다.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
<br>
    <nav aria-label="페이지 네비게이션">
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 1}">
                <!-- 첫 페이지 링크 -->
                <li class="page-item">
                    <a class="page-link" href="/admin/pay?searchType=${param.searchType}&searchField=${param.searchField}&page=1&size=${pageSize}">《</a>
                </li>
                <!-- 이전 페이지 링크 -->
                <li class="page-item">
                    <a class="page-link" href="/admin/pay?searchType=${param.searchType}&searchField=${param.searchField}&page=${currentPage - 1}&size=${pageSize}">〈</a>
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
                            <a class="page-link" href="/admin/pay?searchType=${param.searchType}&searchField=${param.searchField}&page=${i}&size=${pageSize}">${i}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <!-- 다음 페이지 링크 -->
                <li class="page-item">
                    <a class="page-link" href="/admin/pay?searchType=${param.searchType}&searchField=${param.searchField}&page=${currentPage + 1}&size=${pageSize}">〉</a>
                </li>
                <!-- 마지막 페이지 링크 -->
                <li class="page-item">
                    <a class="page-link" href="/admin/pay?searchType=${param.searchType}&searchField=${param.searchField}&page=${totalPages}&size=${pageSize}">》</a>
                </li>
            </c:if>
        </ul>
    </nav><br><br>
    <jsp:include page="/modules/footer.jsp"></jsp:include>
</body>
</html>
