<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>회원가입</title>

<header>
<%@ include file="header.jsp"%>
</header>

<style>
body {
	background-color: #17171f;
}
.signup-container{
	margin: auto;
	width: 350px;
	height: auto;
	border-radius: 25px;
	box-sizing: border-box;
	background-color: #17171f;
	padding: 20px;
	text-align: center;
	}
.page-title {
	font-size: 18px;
	font-weight: bold;
	color: #fff;
}
.input-group {
	margin: 15px 0;
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}
input[type=text]:focus, input[type=password]:focus, input[type=email]:focus {
	border-color: #5F32FF;
	border-width: 2px; /* 포커스 상태에서의 border-width를 2px로 설정 */
	outline: none;
}
.input-label {
	align-self: flex-start;
	color: #fff;
	font-size: 14px;
	font-weight: bold;
}
input[type=text], input[type=password], input[type=email]{
	width: 310px;
	height: 45px;
	box-sizing: border-box;
	border: 1px solid #fff;
	border-radius: 15px;
	padding-left: 15px;
	font-size: 18px;
	color: #fff;
	background-color: #17171f;
	transition: border-color 0.3s ease-in-out; /* border-width 속성에도 transition 추가 */
}
.submit-button {
	width: 310px;
	height: 60px;
	cursor: pointer;
	background-color: #5F32FF;
	color: white;
	font-size: 16px;
	font-weight: bold;
	border-radius: 15px;
	border: none;
	margin-bottom: 10px;
}
</style>

<body>
	<div class="signup-container">
	<div class="page-title">회원가입</div>
		<div class="signup-form">
			<form action="signupPro.jsp" method="post" onsubmit="return validateForm();">
				<div class="input-group">
					<label class="input-label">아이디</label><br>
					<input type="text" name="userId" placeholder="아이디를 입력해주세요" required>
				</div>
				<div class="input-group">
					<label class="input-label">비밀번호</label><br>
					<input type="password" id="userPw" name="userPw" placeholder="비밀번호를 입력해주세요" required>
				</div>
				<div class="input-group">
					<label class="input-label">비밀번호 확인</label><br>
					<input type="password" id="userPwCheck" name="userPwCheck" placeholder="비밀번호를 다시 입력해주세요" required>
				</div>
				<div class="input-group">
					<label class="input-label">이름</label><br>
					<input type="text" name="userName" placeholder="이름을 입력해주세요" required>
				</div>
				<div class="input-group">
					<label class="input-label">전화번호</label><br>
					<input type="text" name="userPhoneNumber" placeholder="전화번호를 입력해주세요" required>
				</div>
				<div class="input-group">
					<label class="input-label">이메일</label><br>
					<input type="email" name="userEmail" placeholder="메일주소를 입력해주세요" required>
				</div>
				<button type="submit" class="submit-button">가입하기</button>
			</form>
		</div>
	</div>

</body>

<script>
	function validateForm() {
		// 비밀번호 필드와 비밀번호 확인 필드의 값을 가져옴
		var userPw = document.getElementById("userPw").value;
		var userPwCheck = document.getElementById("userPwCheck").value;
		
		// 비밀번호와 비밀번호 확인 필드의 값이 다를 경우 경고 메시지 표시
		if (userPw !== userPwCheck) {
			alert("비밀번호를 다시 확인해주세요");
			return false;
		}

		return true;
	}
</script>

<footer>
<%@ include file="footer.jsp"%>
</footer>
</html>