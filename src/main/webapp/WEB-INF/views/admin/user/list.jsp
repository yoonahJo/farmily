<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin :: 회원관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function() {
        var currentPage = 1; // 기본 페이지 번호

        function loadUsers(role, page) {
            $.ajax({
                url: '/admin/getFilteredUserList',
                type: 'GET',
                data: { role: role, page: page },
                success: function(response) {
                    var parts = response.split('|');
                    $('#userTable tbody').html(parts[0]);
                    var pageInfo = parts[1].split('=')[1];
                    var [totalPages, currentPageFromServer] = pageInfo.split(',');
                    currentPage = currentPageFromServer; // 현재 페이지 업데이트
                    updatePagination(totalPages, currentPage, role);
                    
                    document.querySelectorAll('td.clickable-cell').forEach(cell => {
                        cell.addEventListener('click', function(e) {
                            if (e.target.tagName !== 'INPUT' && e.target.tagName !== 'BUTTON') {
                                const href = this.getAttribute('data-href');
                                if (href) {
                                    window.location.href = href;
                                }
                            }
                        });
                    });
                },
                error: function(xhr, status, error) {
                    console.error("AJAX 요청 실패:", status, error);
                }
            });
        }

        function updatePagination(totalPages, currentPage, role) {
            var paginationHtml = '';

            if (currentPage > 1) {
                paginationHtml += '<li class="page-item"><a class="page-link" href="javascript:void(0);" data-role="' + role + '" data-page="1">《</a></li>';
            }

            if (currentPage > 1 && currentPage > 5) {
                paginationHtml += '<li class="page-item"><a class="page-link" href="javascript:void(0);" data-role="' + role + '" data-page="' + (currentPage - 1) + '">〈</a></li>';
            }


            for (var i = 1; i <= totalPages; i++) {
                paginationHtml += '<li class="page-item ' + (i == currentPage ? 'active' : '') + '"><a class="page-link" href="javascript:void(0);" data-role="' + role + '" data-page="' + i + '">' + i + '</a></li>';
            }

            if (currentPage < totalPages && currentPage >= 5) {
                paginationHtml += '<li class="page-item"><a class="page-link" href="javascript:void(0);" data-role="' + role + '" data-page="' + (currentPage + 1) + '">〉</a></li>';
            }

            if (currentPage < totalPages) {
                paginationHtml += '<li class="page-item"><a class="page-link" href="javascript:void(0);" data-role="' + role + '" data-page="' + totalPages + '">》</a></li>';
            }

            $('#pageList ul').html(paginationHtml);
        }

        $('.filter-button').click(function(e) {
            e.preventDefault();
            var role = $(this).data('role');
            loadUsers(role, 1); // 첫 페이지로 로드
        });

        $('#pageList').on('click', '.page-link', function(e) {
            e.preventDefault();
            var role = $(this).data('role');
            var page = $(this).data('page');
            loadUsers(role, page);
        });

        $('#deleteForm').submit(function(e) {
        	e.preventDefault(); 
        	
            var selectedIds = [];
            $('input[name="selectUser"]:checked').each(function() {
                selectedIds.push($(this).val());
            });

            if (selectedIds.length === 0) {
                alert("삭제할 사용자를 선택하세요.");
                e.preventDefault();
                return;
            }

            if (confirm("정말 삭제하시겠습니까?")) {
                $.ajax({
                    url: $(this).attr('action'),
                    type: 'POST',
                    data: {
                        selectedUserIds: selectedIds.join(',')
                    },
                    success: function(response) {
                        alert(response.message); // 서버에서 반환한 메시지를 표시
                        loadUsers('', currentPage); // 현재 페이지 로드
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX 요청 실패:", status, error);
                    }
                });
            }
        });
        $('#selectAll').click(function() {
            var isChecked = $(this).prop('checked');
            $('input[name="selectUser"]').prop('checked', isChecked);
        });

        $('#userTable').on('change', 'input[name="selectUser"]', function() {
            var allChecked = $('input[name="selectUser"]').length === $('input[name="selectUser"]:checked').length;
            $('#selectAll').prop('checked', allChecked);
        });

        $('#userTable').on('submit', 'form', function(e) {
            if (this.action.includes('/admin/deleteUser')) {
                if (!confirm("정말 삭제하시겠습니까?")) {
                    e.preventDefault();
                    return;
                }
                // 삭제가 완료된 후 알림 메시지
                alert("삭제가 완료되었습니다");
            }
        });

        loadUsers('', 1); // 페이지 로드 시 전체 사용자 목록
    });

</script>
  <style>
   /* 체크박스 관련  */
    input[type="checkbox"] {
    width: 20px;
    height: 20px;
    accent-color: gray; 
}
        /* 각 버튼 위쪽 여백 추가 */
        .filter-buttons .btn:nth-child(1) { /* 첫 번째 버튼: 일반회원 */
            margin-top: 0.5rem;
        }

        .filter-buttons .btn:nth-child(2) { /* 두 번째 버튼: 농부 */
            margin-top: 0.5rem;
        }

        .filter-buttons .btn:nth-child(3) { /* 세 번째 버튼: 전체 */
            margin-top: 0.5rem;
        }


    
    .page-item.active .page-link {
    background-color: #d0d0d0;
    border-color: #d0d0d0;
    color: black; /* 원하는 텍스트 색상 */
	}
	.page-link {
	color: black;
	}
	 .table-hover tbody tr:hover {
    background-color: #f2f2f2; /* 원하는 배경색으로 변경 가능 */
    cursor: pointer; /* 클릭 가능한 느낌을 주기 위해 커서를 포인터로 변경 */
}
    
    .page-title {
            text-align: center;
            font-weight: bold;
            font-size: 2rem;
            margin-bottom: 30px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }
     .table {
    table-layout: fixed;
    width: 100%;
}  
	
	
  html, body {
    height: 100%;
}

#wrapper {
    height: auto;
 	min-height: 100%;
  	padding-bottom: 209px;
}

footer {
    position: relative;
    transform : translateY(-100%);
}

/* 테이블 기본 스타일 */
.table {
    table-layout: fixed; /* 테이블 열 너비 고정 */
    width: 100%; /* 테이블 너비 100% */
}

/* 테이블 헤더와 셀의 여백 설정 */
.table th,
.table td {
    white-space: nowrap; /* 셀의 내용이 줄바꿈되지 않도록 설정 */
    overflow: hidden; /* 셀의 내용이 넘칠 경우 숨기기 */
    padding: 8px 10px; /* 셀 안의 여백 설정 */
    border: 1px solid #dee2e6; /* 셀 경계선 설정 */
}

/* 각 열에 고정된 너비 설정 */
.table th:first-child, 
.table td:first-child {
    width: 2%; /* 전체 선택 체크박스 열 너비 */
}

.table th:nth-child(2), 
.table td:nth-child(2) {
    width: 11%; /* 아이디 열 너비 */
}

.table th:nth-child(3), 
.table td:nth-child(3) {
    width: 9%; /* 이름 열 너비 */
}

.table th:nth-child(4), 
.table td.role-column {
    width: 9%; /* 회원 구분 열 너비 조정 */
}

.table th:nth-child(5), 
.table td:nth-child(5) {
    width: 9%; /* 전화번호 열 너비 */
}

.table th:nth-child(6), 
.table td:nth-child(6) {
    width: 9%; /* 가입일 열 너비 */
}

.table th:nth-child(7), 
.table td:nth-child(7) {
    width: 12%; /* 작업 열 너비 */
}

/* 모바일 화면 조정 */
@media (max-width: 768px) {
    /* 불필요한 열 숨기기 */
    .table th:nth-child(3), 
    .table td:nth-child(3),
    .table th:nth-child(5), 
    .table td:nth-child(5),
    .table th:nth-child(6), 
    .table td:nth-child(6),
    .table th:nth-child(7), 
    .table td:nth-child(7) {
        display: none;
    }
    }
.btn {
        /* 기본 버튼 스타일 */
        overflow: hidden; /* 버튼의 내용이 넘칠 때 숨기기 */
        text-overflow: ellipsis; /* 넘치는 텍스트에 생략 기호(...) 추가 */
        text-align: center; /* 텍스트 중앙 정렬 */
        padding: 0.5rem 1rem; /* 버튼 안의 여백 설정 */
        display: inline-block; /* 버튼을 인라인 블록 요소로 설정 */
    }

   @media (max-width: 400px) {
        .btn {
            white-space: normal; /* 텍스트 자동 줄바꿈 허용 */
            word-wrap: break-word; /* 긴 단어를 줄바꿈하도록 설정 */
            
            
        }
    }
    input[type="checkbox"] {
    width: 20px;
    height: 20px;
    accent-color: gray; 
}
    


</style>

</head>
<body class="nanum-gothic-regular">
    <div id="wrapper">
        <jsp:include page="/modules/aheader.jsp"></jsp:include>
        <div class="container mt-5">
         
            <h2 class="page-title">회원 관리</h2>
            
             <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="filter-buttons">
                    <a href="javascript:void(0);" class="btn btn-secondary filter-button" data-role="C">일반회원</a>
                    <a href="javascript:void(0);" class="btn btn-secondary filter-button" data-role="F">농부</a>
                    <a href="javascript:void(0);" class="btn btn-secondary filter-button" data-role="">전체</a>
                </div>

                <div class="d-flex align-items-center gap-2">
                    <!-- 회원 추가 버튼과 일괄 삭제 버튼을 같은 줄에 배치하고 간격 설정 -->
                    <form action="addUser" method="get">
                        <button type="submit" class="btn btn-secondary">회원추가</button>
                    </form>
                    <form action="/admin/deleteSelectedUsers" method="post" id="deleteForm">
                        <input type="hidden" name="selectedUserIds" id="selectedUserIds">
                        <input type="hidden" name="currentPage" id="currentPage">
                        <button type="submit" class="btn btn-outline-secondary">일괄삭제</button>
                    </form>
                </div>
            </div>

            <table id="userTable" class="table table-bordered table-hover">
    <thead>
        <tr>
            <th class="text-center px-0">
    <div class="d-flex justify-content-center align-items-center" style="height: 100%;">
        <input class="custom-checkbox" type="checkbox" id="selectAll">
    </div>
</th>
            <th class="text-center">아이디</th>
            <th class="text-center">이름</th>
            <th class="text-center">회원 구분</th>
            <th class="text-center">전화번호</th>
            <th class="text-center">가입일자</th>
            <th class="text-center">작업</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${userList}" var="user">
            <tr>
                <td class="text-center px-0">
                    <div class="d-flex justify-content-center align-items-bottom" style="height: 100%;">
                        <input class="form-check-input custom-checkbox" type="checkbox" name="selectUser" value="${user.id}">
                    </div>
                </td>
                <td class="text-center clickable-cell" style="width: 280px;" data-href="/admin/viewUser/${user.id}">
                    ${user.id}
                </td>
                <td class="text-center clickable-cell" style="width: 150px;" data-href="/admin/viewUser/${user.id}">
                    ${user.uname}
                </td>
                <td class="text-center clickable-cell" style="width: 180px;" data-href="/admin/viewUser/${user.id}">
                    <c:choose>
                        <c:when test="${fn:trim(user.role) == 'C'}">일반회원</c:when>
                        <c:when test="${fn:trim(user.role) == 'F'}">농부</c:when>
                        <c:when test="${fn:trim(user.role) == 'A'}">관리자</c:when>
                        <c:otherwise>미지정</c:otherwise>
                    </c:choose>
                </td>
                <td class="text-center clickable-cell" style="width: 180px;" data-href="/admin/viewUser/${user.id}">
                    ${user.phone}
                </td>
                <td class="text-center clickable-cell" style="width: 180px;" data-href="/admin/viewUser/${user.id}">
                    <fmt:formatDate value="${user.regdate}" pattern="yyyy-MM-dd" />
                </td>
                <td class="text-center" style="width: 250px;">
                    <div class="d-flex justify-content-center gap-2">
                    <!-- 회원 수정 버튼 -->
                        <a href="/admin/viewUser/${user.id}" class="btn btn-secondary">회원 수정</a>
                        <!-- 회원 삭제 버튼 -->
                        <form action="/admin/deleteUser" method="post" class="d-inline">
                                        <input type="hidden" name="id" value="${user.id}">
                                        <button type="submit" class="btn btn-outline-secondary">회원 삭제</button>
                                    </form>                                             
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>            
        </div>
	        <jsp:include page="/modules/adminUPagination.jsp" flush="true" />
	    </div>
        <jsp:include page="/modules/footer.jsp" />
</body>
</html>
