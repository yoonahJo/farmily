<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <meta charset="UTF-8">
    <title>Admin :: 회원 추가</title>
    <style>
        .hidden {
		    display: none;
		}
    </style>
    <script>
        var idAvailable = false; // 전역 변수 선언

        function toggleFarmFields() {
            var role = document.getElementById("role").value;
            var farmFields = document.querySelectorAll(".farmField");
            var farmLink = document.getElementById("farmLink");

            if (role === "F") { // 농부 선택 시
                farmFields.forEach(function(field) {
                    field.classList.remove("hidden");
                });
                farmLink.style.display = "inline"; // 링크 표시
            } else { // 일반회원 선택 시
                farmFields.forEach(function(field) {
                    field.classList.add("hidden");
                });
                farmLink.style.display = "none"; // 링크 숨기기
            }
        }
        function submitForm() {
            if (!idAvailable) {
                showAlertModal("아이디 중복 체크를 완료해야 합니다.");
                return false;
            }

            var passwordValidation = validatePasswords();
            if (!passwordValidation) {
                return false;
            }

            var role = document.getElementById("role").value;
            if (role === "F") { // 농부 선택 시
                var farmName = document.getElementById("fname").value.trim();
                var farmCode = document.getElementById("fnum").value.trim();
                var farmPostcode = document.getElementById("farm_postcode").value.trim();
                var farmRoadAddress = document.getElementById("farm_roadAddress").value.trim();
                
                if (farmName === "" || farmCode === "" || farmPostcode === "" || farmRoadAddress === "") {
                    showAlertModal("농장 관련 모든 필드를 입력해야 합니다.");
                    return false;
                }
            }

            var formData = new FormData(document.getElementById('userForm'));

            fetch('/admin/addUser', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.redirectUrl) {
                    showAlertModal("회원이 성공적으로 추가되었습니다!", "success", data.redirectUrl);
                } else {
                    showAlertModal("회원 추가에 실패했습니다.", "error");
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });

            return false; // 폼 제출을 막습니다.
        }

        function showAlertModal(message, type, redirectUrl) {
            var modalTitle = document.querySelector("#myModal .modal-title");
            var modalBody = document.querySelector("#myModal .modal-body");

            modalTitle.textContent = type === 'error' ? "오류" : "알림";
            modalBody.textContent = message;
            var modal = new bootstrap.Modal(document.getElementById('myModal'));
            modal.show();

            if (redirectUrl) {
                document.querySelector("#myModal").addEventListener('hidden.bs.modal', function () {
                    window.location.href = redirectUrl;
                });
            }
        }
        
        function validateId() {
            var id = document.getElementById('id').value;
            var idCheckResult = document.getElementById('idCheckResult');
            var idPattern = /^[a-zA-Z0-9!@#$%^&*()_+={}\[\]|\\;:'",.<>?/-]*$/;

            if (id.trim() === "") {
                idCheckResult.textContent = "아이디를 입력해 주세요.";
                idCheckResult.style.color = "red";
                return false;
            }

            if (!idPattern.test(id)) {
                idCheckResult.textContent = "아이디는 영문, 숫자, 특수문자만 허용됩니다.";
                idCheckResult.style.color = "red";
                return false;
            }

            idCheckResult.textContent = "";
            return true;
        }

        function checkIdAvailability() {
            if (!validateId()) {
                return;
            }

            var id = document.getElementById('id').value;

            fetch('/admin/checkIdAvailability?id=' + encodeURIComponent(id), {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                var idCheckResult = document.getElementById('idCheckResult');
                if (data.available) {
                    idCheckResult.textContent = "사용 가능한 아이디입니다.";
                    idCheckResult.style.color = "green";
                    idAvailable = true; // 아이디 사용 가능 상태로 설정
                } else {
                    idCheckResult.textContent = "이미 사용 중인 아이디입니다.";
                    idCheckResult.style.color = "red";
                    idAvailable = false; // 아이디 사용 불가능 상태로 설정
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }

        function validatePasswords() {
            var password = document.getElementById("password").value;
            var passwordConfirm = document.getElementById("password_confirm").value;
            var messageElement = document.getElementById("passwordMessage");

            if (password.trim() === "") {
                messageElement.textContent = "비밀번호를 입력해 주세요.";
                messageElement.style.color = "red";
                return false;
            }

            if (passwordConfirm.trim() === "") {
                messageElement.textContent = "비밀번호 확인을 입력해 주세요.";
                messageElement.style.color = "red";
                return false;
            }

            if (password !== passwordConfirm) {
                messageElement.textContent = "비밀번호와 비밀번호 확인이 일치하지 않습니다.";
                messageElement.style.color = "red";
                return false;
            }

            messageElement.textContent = "비밀번호가 일치합니다.";
            messageElement.style.color = "green";
            return true;
        }

        function sample4_execDaumPostcode(prefix) {
            new daum.Postcode({
                oncomplete: function(data) {
                    var roadAddr = data.roadAddress;
                    var extraRoadAddr = '';

                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraRoadAddr !== '') {
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }

                    var postcodeField = document.getElementById(prefix ? prefix + '_postcode' : 'sample4_postcode');
                    var roadAddressField = document.getElementById(prefix ? prefix + '_roadAddress' : 'sample4_roadAddress');
                    var detailAddressField = document.getElementById(prefix ? prefix + '_detailAddress' : 'sample4_detailAddress');
                    var guideTextBox = document.getElementById(prefix ? prefix + 'Guide' : 'guide');

                    if (prefix === 'farm') {
                        document.getElementById('farm_postcode').value = data.zonecode;
                        document.getElementById('farm_roadAddress').value = roadAddr;
                        document.getElementById('farm_jibunAddress').value = data.jibunAddress;
                        document.getElementById('farm_detailAddress').value = detailAddressField.value || '';
                        var faddressField = document.getElementById('faddress');
                        if (faddressField) {
                            faddressField.value = roadAddr + (detailAddressField.value ? ', ' + detailAddressField.value : '');
                        }
                    } else {
                        document.getElementById('sample4_postcode').value = data.zonecode;
                        document.getElementById('sample4_roadAddress').value = roadAddr;
                        document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
                        document.getElementById('sample4_detailAddress').value = detailAddressField.value || '';
                    }

                    if (data.autoRoadAddress) {
                        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                        guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                        guideTextBox.style.display = 'block';
                    } else if (data.autoJibunAddress) {
                        var expJibunAddr = data.autoJibunAddress;
                        guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                        guideTextBox.style.display = 'block';
                    } else {
                        guideTextBox.innerHTML = '';
                        guideTextBox.style.display = 'none';
                    }
                }
            }).open();
        }

        function updateFarmAddress() {
            var roadAddress = document.getElementById('farm_roadAddress') ? document.getElementById('farm_roadAddress').value : '';
            var detailAddress = document.getElementById('farm_detailAddress') ? document.getElementById('farm_detailAddress').value : '';
            document.getElementById('faddress').value = roadAddress + (detailAddress ? ', ' + detailAddress : '');
        }

        window.onload = function() {
            toggleFarmFields(); // 페이지 로드 시 필드 상태 설정

            document.getElementById("role").addEventListener("change", toggleFarmFields);

            // 아이디 입력 필드에서 엔터키를 눌렀을 때 아이디 중복 체크 실행
            document.getElementById("id").addEventListener("keypress", function(event) {
                if (event.key === 'Enter') {
                    event.preventDefault();
                    checkIdAvailability();
                }
            });

            // 비밀번호 확인 버튼 클릭 시 비밀번호 검증
            document.getElementById("password_confirm").addEventListener("keypress", function(event) {
                if (event.key === 'Enter') {
                    event.preventDefault();
                    validatePasswords();
                }
            });

            // 상세 주소 입력 시 농장 주소 업데이트
            document.getElementById("farm_detailAddress").addEventListener("input", updateFarmAddress);
        }
    </script>
</head>
<body class="nanum-gothic-regular">
<jsp:include page="/modules/aheader.jsp"></jsp:include>
    <div class="container mt-5"> 
    <div class="row justify-content-center">
     <div class="col-md-6">
        <div class="mb-3 text-center" style="margin-top: 2rem;">
		    <span class="fw-bold text-dark" style="font-size: 2rem;">회원 추가</span>
		</div>
        <form id="userForm" action="addUser" method="post" onsubmit="return submitForm()">
            <!-- 아이디 -->
            <div class="mb-3">
                <label for="id" class="form-label">아이디</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="id" name="id" onblur="validateId()" />
                    <button type="button" class="btn btn-outline-secondary" onclick="checkIdAvailability()">중복 체크</button>
                </div>
                <div id="idCheckResult" class="form-text"></div>
            </div>
            <!-- 비밀번호 -->
            <div class="mb-3">
			    <label for="password" class="form-label">비밀번호</label>
			    <input 
			        type="password" 
			        class="form-control" 
			        id="password" 
			        name="password" 
			        pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$"
			        title="비밀번호는 특수문자 포함 8자리 이상." 
			        required 
			        placeholder="비밀번호 특수문자 포함 8자리 이상"
			    />
			</div>

            <!-- 비밀번호 확인 -->
            <div class="mb-3">
                <label for="password_confirm" class="form-label">비밀번호 확인</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="password_confirm" name="password_confirm" placeholder="비밀번호 확인" />
                    <button type="button" class="btn btn-outline-secondary" onclick="validatePasswords()">비밀번호 확인</button>
                </div>
                <div id="passwordMessage" class="form-text"></div>
            </div>

            <!-- 이름 -->
            <div class="mb-3">
                <label for="uname" class="form-label">이름</label>
                <input type="text" class="form-control" id="uname" name="uname" required />
            </div>

            <!-- 회원 구분 -->
            <div class="mb-3">
                <label for="role" class="form-label">회원 구분</label>
                <select class="form-select" id="role" name="role" required>
                    <option value="" disabled selected>선택하세요</option>
                    <option value="C">일반회원</option>
                    <option value="F">농부</option>
                </select>
            </div>

            <!-- 전화번호 -->
            <div class="mb-3">
                <label for="phone" class="form-label">전화번호</label>
                <input type="text" class="form-control" id="phone" name="phone" required />
            </div>

            <!-- 이메일 -->
            <div class="mb-3">
                <label for="email" class="form-label">이메일</label>
                <input type="email" class="form-control" id="email" name="email" required />
            </div>

            <!-- 생일 -->
            <div class="mb-3">
                <label for="birth" class="form-label">생일</label>
                <input type="text" class="form-control" id="birth" name="birth" required />
            </div>

            <!-- 성별 -->
            <div class="mb-3">
                <label for="gender" class="form-label">성별</label>
                <select class="form-select" id="gender" name="gender" required>
                    <option value="" disabled selected>선택하세요</option>
                    <option value="M">남성</option>
                    <option value="F">여성</option>
                </select>
            </div>

            <!-- 주소 -->
            <div class="mb-3">
                <label for="sample4_postcode" class="form-label">우편번호</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="sample4_postcode" name="uzcode" placeholder="우편번호" readonly />
                    <button type="button" class="btn btn-outline-secondary" onclick="sample4_execDaumPostcode()">주소 찾기</button>
                </div>
            </div>

            <div class="mb-3">
                <label for="sample4_roadAddress" class="form-label">도로명 주소</label>
                <input type="text" class="form-control" id="sample4_roadAddress" name="uaddress" placeholder="도로명주소" required />
            </div>

            <div class="mb-3 hidden">
                <label for="sample4_jibunAddress" class="form-label">지번주소</label>
                <input type="text" class="form-control" id="sample4_jibunAddress" placeholder="지번주소" readonly />
            </div>

            <div class="mb-3">
                <span id="guide" class="form-text"></span>
            </div>

            <div class="mb-3">
                <label for="sample4_detailAddress" class="form-label">상세 주소</label>
                <input type="text" class="form-control" id="sample4_detailAddress" name="uaddress" placeholder="상세주소" />
            </div>

            <div class="mb-3 hidden">
                <label for="sample4_extraAddress" class="form-label">참고 항목</label>
                <input type="text" class="form-control" id="sample4_extraAddress" name="EXTRAADDRESS" placeholder="참고항목" />
            </div>

			<div class="mb-3 text-center">
			    <span id="farmLink" class="clickable hidden text-dark" style="font-size: 2rem;" onclick="toggleFarmFields()">농장주 작성</span>
			</div>

			
            <!-- 농장 항목들 -->
            <div class="hidden farmField">
                <div class="mb-3">
                    <label for="fname" class="form-label">농장 이름</label>
                    <input type="text" class="form-control" id="fname" name="fname" placeholder="농장 이름" />
                </div>

                <div class="mb-3">
                    <label for="fnum" class="form-label">농장 코드</label>
                    <input type="text" class="form-control" id="fnum" name="fnum" placeholder="농장 코드" />
                </div>

                <div class="mb-3">
                    <label for="farm_postcode" class="form-label">농장 우편번호</label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="farm_postcode" name="fzcode" placeholder="우편번호" readonly />
                        <button type="button" class="btn btn-outline-secondary" onclick="sample4_execDaumPostcode('farm')">주소 찾기</button>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="farm_roadAddress" class="form-label">농장 도로명 주소</label>
                    <input type="text" class="form-control" id="farm_roadAddress" name="farm_roadAddress" placeholder="도로명주소" onchange="updateFarmAddress()" />
                </div>

                <div class="mb-3 hidden hiddenFarmField">
                    <label for="farm_jibunAddress" class="form-label">농장 지번주소</label>
                    <input type="text" class="form-control" id="farm_jibunAddress" placeholder="지번주소" readonly />
                </div>

                <div class="mb-3">
                    <span id="farmGuide" class="form-text"></span>
                </div>

                <div class="mb-3">
                    <label for="farm_detailAddress" class="form-label">농장 상세 주소</label>
                    <input type="text" class="form-control" id="farm_detailAddress" name="farm_detailAddress" placeholder="상세주소" onchange="updateFarmAddress()" />
                </div>

                <div class="mb-3 hidden hiddenFarmField">
                    <label for="farm_extraAddress" class="form-label">농장 참고항목</label>
                    <input type="text" class="form-control" id="farm_extraAddress" name="FEXTRAADDRESS" placeholder="참고항목" />
                </div>

               <div id="farmAddressRow" class="mb-3 hidden">
				    <label for="faddress" class="form-label">농장 전체 주소</label>
				    <input type="text" class="form-control" id="faddress" name="faddress" placeholder="전체주소" readonly />
				</div>
            </div>
	
            <div class="mb-3">
                <button type="submit" class="btn btn-secondary">회원 추가</button>
            </div>
        </form>
        <div id="feedbackMessage" class="text-center text-success" style="display:none;"></div>
    </div>
    </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="myModalLabel">알림</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- 메시지 내용 -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <jsp:include page="/modules/footer.jsp" />
</body>
</html>



