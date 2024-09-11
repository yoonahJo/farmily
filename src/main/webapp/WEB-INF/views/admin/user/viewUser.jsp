<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <meta charset="UTF-8">
    <title>Admin :: 회원 정보</title>
    <style>
        .hidden {
            display: none;
        }
        
    </style>
    <script>
    function submitForm() {
        console.log('submitForm called'); // 디버깅 로그
        
     // 수정이 완료되었음을 알리는 알림창
        alert("수정이 완료되었습니다");

        // 기존의 코드는 그대로 유지
        var roadAddress = document.getElementById('sample4_roadAddress').value;
        var detailAddress = document.getElementById('sample4_detailAddress').value;
        var fullAddress = roadAddress + (detailAddress ? ', ' + detailAddress : '');

        document.getElementById('fullAddress').value = fullAddress;

        var farmRoadAddress = document.getElementById('farm_roadAddress').value;
        var farmDetailAddress = document.getElementById('farm_detailAddress').value;
        var farmFullAddress = farmRoadAddress + (farmDetailAddress ? ', ' + farmDetailAddress : '');

        document.getElementById('farmFullAddress').value = farmFullAddress;

        console.log('Full Address:', fullAddress); // 디버깅 로그
        console.log('Farm Full Address:', farmFullAddress); // 디버깅 로그

        document.getElementById('userForm').submit();
    }

    function sample4_execDaumPostcode(prefix) {
        new daum.Postcode({
            oncomplete: function(data) {
                var roadAddr = data.roadAddress; // 도로명 주소
                var extraRoadAddr = ''; // 참고 항목

                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraRoadAddr !== '') {
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 필드 업데이트
                var postcodeField = document.getElementById(prefix ? prefix + '_postcode' : 'sample4_postcode');
                var roadAddressField = document.getElementById(prefix ? prefix + '_roadAddress' : 'sample4_roadAddress');
                var detailAddressField = document.getElementById(prefix ? prefix + '_detailAddress' : 'sample4_detailAddress');
                var guideTextBox = document.getElementById(prefix ? prefix + 'Guide' : 'guide');

                // 도로명 주소와 상세주소 업데이트
                roadAddressField.value = roadAddr;
                detailAddressField.value = extraRoadAddr ? extraRoadAddr : ''; // 참고 항목이 있을 때만 추가

                // 우편번호 업데이트
                postcodeField.value = data.zonecode;

                // 예상 주소 안내
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

    function splitAddress(uaddress) {
        var lastCommaIndex = uaddress.lastIndexOf(',');
        if (lastCommaIndex !== -1) {
            var roadAddress = uaddress.substring(0, lastCommaIndex).trim();
            var detailAddress = uaddress.substring(lastCommaIndex + 1).trim();
            return {
                roadAddress: roadAddress,
                detailAddress: detailAddress
            };
        }
        return {
            roadAddress: uaddress,
            detailAddress: ''
        };
    }

    document.addEventListener('DOMContentLoaded', function() {
        var uaddress = "${user.uaddress}";
        var addresses = splitAddress(uaddress);
        document.getElementById('sample4_roadAddress').value = addresses.roadAddress;
        document.getElementById('sample4_detailAddress').value = addresses.detailAddress;

        var farmAddress = "${user.faddress}";
        if (farmAddress) {
            var farmAddresses = splitAddress(farmAddress);
            document.getElementById('farm_roadAddress').value = farmAddresses.roadAddress;
            document.getElementById('farm_detailAddress').value = farmAddresses.detailAddress;
        }
    });
    document.addEventListener('DOMContentLoaded', function() {
        // 삭제 버튼을 포함한 폼의 submit 이벤트를 처리
        document.querySelectorAll('form[action="/admin/deleteUser"]').forEach(function(form) {
            form.addEventListener('submit', function(e) {
                if (!confirm("정말 삭제하시겠습니까?")) {
                    e.preventDefault();
                    return;
                }
                // 삭제가 완료된 후 알림 메시지
                alert("삭제가 완료되었습니다");
            });
        });
    });
    </script>
</head>
<body class="nanum-gothic-regular">
    <jsp:include page="/modules/aheader.jsp"></jsp:include>
    <div class="container mt-5"> 
    <div class="row justify-content-center">
     <div class="col-md-6">
        <div class="mb-3 text-center" style="margin-top: 2rem;">
		    <span class="fw-bold text-dark" style="font-size: 2rem;">회원 정보</span>
		</div>
        <form id="userForm" action="/admin/editUser" method="post">
            <table class="table table-bordered">
                <!-- 회원 정보 입력 필드들 -->
                <tr>
                    <td>아이디</td>
                    <td><input type="text" name="id" value="${user.id}" readonly class="form-control" /></td>
                </tr>
                <tr>
                    <td>이름</td>
                    <td><input type="text" name="uname" value="${user.uname}" required class="form-control" /></td>
                </tr>
                <tr>
                    <td>회원 구분</td>
                    <td>
                        <select name="role" required class="form-select" disabled>
                            <option value="c" ${fn:trim(user.role) == 'C' ? 'selected' : ''}>일반회원</option>
                            <option value="f" ${fn:trim(user.role) == 'F' ? 'selected' : ''}>판매자회원</option>
                            <option value="a" ${fn:trim(user.role) == 'A' ? 'selected' : ''}>관리자</option>
                        </select>
                        <input type="hidden" name="role" value="${fn:trim(user.role)}" />
                    </td>
                </tr>
                <tr>
                    <td>전화번호</td>
                    <td><input type="text" name="phone" value="${user.phone}" required class="form-control" /></td>
                </tr>
                <tr>
                    <td>가입일자</td>
                    <td><input type="text" name="regdate" value="<fmt:formatDate value='${user.regdate}' pattern='yyyy-MM-dd'/>" readonly class="form-control" /></td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td><input type="email" name="email" value="${user.email}" required class="form-control" /></td>
                </tr>
                <tr>
                    <td>생일</td>
                    <td><input type="text" name="birth" value="${user.birth}" readonly class="form-control" /></td>
                </tr>
                <tr>
                    <td>성별</td>
                    <td>
                        <select name="gender" required class="form-select">
                            <option value="M" ${fn:trim(user.gender) == 'M' ? 'selected' : ''}>남성</option>
                            <option value="F" ${fn:trim(user.gender) == 'F' ? 'selected' : ''}>여성</option>
                        </select>
                    </td>
                </tr>
                <tr>
				    <td>우편번호</td>
				    <td>
				        <div class="input-group">
				            <input type="text" id="sample4_postcode" name="uzcode" value="${user.uzcode}" placeholder="우편번호" readonly class="form-control" />
				            <button type="button" class="btn btn-outline-secondary" onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
				        </div>
				    </td>
				</tr>
                <tr>
                    <td>도로명 주소</td>
                    <td>
                        <input type="text" id="sample4_roadAddress" name="roadAddress" placeholder="도로명주소" required class="form-control" />
                    </td>
                </tr>
                <tr>
                    <td>상세주소</td>
                    <td>
                        <input type="text" id="sample4_detailAddress" name="detailAddress" placeholder="상세주소" class="form-control" />
                    </td>
                </tr>
                <tr class="hidden">
                    <td>지번주소</td>
                    <td><input type="text" id="sample4_jibunAddress" value="${user.uaddress}" placeholder="지번주소" readonly class="form-control" /></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <span id="guide" class="guide"></span>
                    </td>
                </tr>
                <tr class="hidden">
                    <td>참고항목</td>
                    <td>
                        <input type="text" id="sample4_extraAddress" name="EXTRAADDRESS" placeholder="참고항목" class="form-control" />
                    </td>
                </tr>

                <c:if test="${fn:trim(user.role) == 'F'}">
                    <tbody id="farmFields">
                        <tr>
                            <td>농장 이름</td>
                            <td><input type="text" name="fname" value="${user.fname}" class="form-control" /></td>
                        </tr>
                        <tr>
                            <td>농장 코드</td>
                            <td><input type="text" name="fnum" value="${user.fnum}" class="form-control" /></td>
                        </tr>
                        <tr>
		    <td>농장 우편번호</td>
		    <td>
		        <div class="input-group">
		            <input type="text" id="farm_postcode" name="fzcode" value="${user.fzcode}" placeholder="우편번호" readonly class="form-control" />
		            <button type="button" class="btn btn-outline-secondary" onclick="sample4_execDaumPostcode('farm')">우편번호 찾기</button>
		        </div>
		    </td>
		</tr>

                        <tr>
                            <td>도로명 주소</td>
                            <td>
                                <input type="text" id="farm_roadAddress" name="farmRoadAddress" placeholder="도로명주소" class="form-control" />
                            </td>
                        </tr>
                        <tr>
                            <td>상세주소</td>
                            <td>
                                <input type="text" id="farm_detailAddress" name="farmDetailAddress" placeholder="상세주소" class="form-control" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <span id="farmGuide" class="guide"></span>
                            </td>
                        </tr>
                        <tr class="hidden">
                            <td>농장 참고항목</td>
                            <td>
                                <input type="text" id="farm_extraAddress" name="FEXTRAADDRESS" placeholder="참고항목" class="form-control" />
                            </td>
                        </tr>
                        <tr class="hidden">
                            <td>농장 전체 주소</td>
                            <td><input type="hidden" id="farmFullAddress" name="faddress" value="" /></td>
                        </tr>
                    </tbody>
                </c:if>
            </table>
            		<div class="container mt-4" style="margin-bottom: 3rem;">
					    <div class="d-flex justify-content-center gap-2">
					        <form action="/admin/updateUser" method="post" class="d-inline">
					            <input type="hidden" id="fullAddress" name="uaddress" value="" />
					            <button type="submit" class="btn btn-secondary rounded-3" onclick="submitForm()">수정 하기</button>
					        </form>
					        <form id="deleteUserForm" action="/admin/deleteUser" method="post" class="d-inline">
					            <input type="hidden" name="id" value="${user.id}">
					            <button type="submit" class="btn btn-outline-secondary">회원 삭제</button>
					        </form>
					        <a href="list" class="btn btn-secondary rounded-3">회원 목록</a>					        
					    </div>
					</div>
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="/modules/footer.jsp" />
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
    

  
</html>
