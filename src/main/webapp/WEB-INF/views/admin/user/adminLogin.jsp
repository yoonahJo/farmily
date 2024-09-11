<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Playwrite+CU:wght@100..400&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <title>Admin :: 로그인</title>
    <script>
    function send(ff) {
        if (ff.id.value === "") {
            alert("아이디 입력 필수");
            ff.id.focus(); 
            return;
        }
        if (ff.password.value === "") {  
            alert("비밀번호 입력 필수");
            ff.password.focus(); 
            return;
        }
        ff.submit();
    }

    document.addEventListener('DOMContentLoaded', function () {
        const errorMessage = '<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>';

        if (errorMessage) {
            const modal = new bootstrap.Modal(document.getElementById('myModal'));
            document.getElementById('modal-body').textContent = errorMessage;
            modal.show();
        }
    });
    </script>  
    <style>
    .custom-header-font {
        font-family: "Playwrite CU", cursive;
        font-optical-sizing: auto;
        font-weight: 400;
        font-style: normal;
    }
    .centered-text {
        text-align: center;
        margin-top: 2rem; /* 필요에 따라 조정 */
        margin-bottom: 2rem; /* 필요에 따라 조정 */
    }
    </style>
</head>
<body class="nanum-gothic-regular d-flex flex-column min-vh-100">
    <div class="d-flex flex-column justify-content-center align-items-center flex-grow-1">
        <main class="p-4 rounded" style="max-width: 500px; width: 100%;">
            <!-- 가운데 정렬 -->
            <div class="centered-text">
                <h1 class="custom-header-font text-center fs-1 fw-bold">Farmily</h1>
            </div>
            <h2 class="h3 mb-4 text-center mt-5">관리자 로그인</h2>

            <form action="./Login" method="post" onsubmit="send(this);">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control form-control-lg" id="floatingInput" name="id" placeholder="아이디 입력" required>
                    <label for="floatingInput">아이디</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="password" class="form-control form-control-lg" id="floatingPassword" name="password" placeholder="비밀번호 입력" required>
                    <label for="floatingPassword">비밀번호</label>
                </div>

                <button class="w-100 btn btn-lg btn-secondary" type="submit">로그인</button>
                <div class="mt-3">
                    <a href="/" class="btn btn-outline-secondary w-100">홈으로 가기</a>
                </div>
            </form>
        </main>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">오류</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <!-- Modal body -->
                <div class="modal-body" id="modal-body">
                    <!-- Error message will be inserted here -->
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">확인</button>
                </div>
            </div>
        </div>
    </div>
        <jsp:include page="/modules/footer.jsp" />
</body>
</html>
