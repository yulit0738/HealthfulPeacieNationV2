<%@page import="dto.UserDTO"%>
<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세 정보</title>
<style>
body {
	background-color: #e6e6e6;
}

.container {
	padding: 50px;
	background-color: #fff;
	width: 450px;
	margin: 15px auto;
}
.btn-back {
	display: block;
	margin-bottom: 20px;
	text-decoration: none;
	font-size: 16px;
	font-weight: bold;
	color: #0077CC;
}

h2 {
	font-weight: bold;
	font-size: 24px;
	color: #0077CC;
	margin-bottom: 20px;
}

table {
	border-collapse: separate;
	border-spacing: 0;
}

th, td {
	padding: 10px 20px;
	font-size: 16px;
}

td {
}

td:first-child {
	font-weight: bold;
	width: 30%;
}

.button-container {
	margin-top: 15px;
	display: flex;
	justify-content: center;
}

.button {
	padding: 7px 15px;
	border: none;
	border-radius: 15px;
	font-size: 14px;
	font-weight: bold;
	color: #ffffff;
	cursor: pointer;
}

.change-pw-button {
	background-color: #0077CC;
	margin-left: 20px;
}

.delete-button {
	background-color: orange;
}

.pw-form {
	display: none;
	margin-top: 5px;
}

.pw-input {
	width: 50%;
	padding: 5px;
	font-size: 12px;
	border: none;
	margin-right: 10px;
}

.save-pw-button {
	background-color: #0077CC;
	color: #ffffff;
	border-radius: 15px;
	padding: 7px 15px;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
}
</style>

</head>

<body>
	<%
	String userId = request.getParameter("id"); // id 파라미터 값을 읽어옴
	UserService userService = new UserServiceImpl();
	UserDTO user = userService.getUser(userId); // userId에 해당하는 회원 정보를 가져옴
	%>

	<header>
		<%@ include file="adminSidebar.jsp"%>
		<%@ include file="loadingModal.jsp"%>
	</header>

	<div class="container">
	<a href="javascript:history.back();" class="btn-back">
		&lt; 뒤로가기
	</a>
		<h2>
			<%=user.getUserId()%>님의 회원 정보
		</h2><hr>
		<table>
			<tr>
				<td>아이디</td>
				<td><%=user.getUserId()%></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=user.getUserName()%></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><%=user.getUserPhoneNumber()%></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><%=user.getUserEmail()%></td>
			</tr>
			<tr>
				<td>가입일시</td>
				<td><%=user.getUserCreatedAt()%></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><span id="pw-blinded">********</span>
					<button class="button change-pw-button" onclick="showPwForm()">변경</button>
					<form class="pw-form" id="pw-form" method="post" onsubmit="return validateForm();" action="adminUserDetailPro.jsp?userId=<%=user.getUserId()%>">
						<input type="password" class="pw-input" name="userPw" placeholder="새 비밀번호 입력" required>
						<input type="password" class="pw-input" name="userPwCheck" placeholder="비밀번호 확인" required>
						<input type="submit" class="button save-pw-button" value="저장">
					</form></td>
			</tr>
		</table><hr>
		<div class="button-container">
			<button class="button delete-button"
				onclick="deleteConfirm('<%=user.getUserId()%>')">회원 정보 삭제</button>
		</div>

	</div>
</body>
<script>

	function showPwForm() {
		document.getElementById("pw-form").style.display = "block";
	}
	function validateForm() {
		// 비밀번호 필드와 비밀번호 확인 필드의 값을 가져옴
		var userPw = document.getElementsByName("userPw")[0].value;
		var userPwCheck = document.getElementsByName("userPwCheck")[0].value;

		// 비밀번호와 비밀번호 확인 필드의 값이 다를 경우 경고 메시지 표시
		if (userPw !== userPwCheck) {
			alert("비밀번호를 다시 확인해주세요");
			return false;
		}

		return true;
	}
	function deleteConfirm(userId) {
	    var result = confirm("정말로 회원 정보를 삭제하시겠습니까?");
	    if (result) {
	        location.href = "adminUserDetailDeletePro.jsp?userId=" + userId;
	    }
	}
</script>
</html>