<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">

<style>

.login-container {
	margin: auto;
	margin-top: 100px;
	width: 400px;
	height: auto;
	border-radius: 25px;
	box-sizing: border-box;
	box-shadow: 0px 0px 20px #666666;
	background-color: #fff;
	padding: 20px;
	text-align: center;
}

.page-title {
	font-size: 24px;
	font-weight: bold;
	color: #444;
}

.input-group {
	margin: 25px 0;
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}

.input-label {
	align-self: flex-start;
	color: #444;
	font-size: 18px;
	font-weight: bold;
}

input[type=text], input[type=password]{
	width: 360px;
	height: 60px;
	box-sizing: border-box;
	border: 1px solid darkgray;
	border-radius: 15px;
	padding-left: 15px;
	font-size: 18px;
}

.submit-button {
	width: 360px;
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

::placeholder {
	font-size: 16px;
}

.join-message{
	font-size: 12px;
	
}
.join-message a{
	text-decoration: none;
	color: blue;
}
</style>

<body>
	<div class="login-container">
	<div class="page-title">로그인</div>
		<div class="login-form">
			<form method="post" action="loginPro.jsp">
				<div class="input-group">
					<label class="input-label">아이디</label><br>
					<input type="text" name="userId" placeholder="아이디를 입력해주세요" required>
				</div>
				<div class="input-group">
					<label class="input-label">비밀번호</label><br>
					<input type="password" name="userPw" placeholder="비밀번호를 입력해주세요" required>
				</div>
				<button type="submit" class="submit-button">로그인</button>
				</form>
				<p class="join-message">헬스로운 평화마을이 처음이신가요? <a href="signup.jsp">가입하기</a></p>
		</div>
	</div>
</body>
</html>