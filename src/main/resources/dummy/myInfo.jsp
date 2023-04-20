<%@page import="dto.UserDTO"%>
<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
if ((String) session.getAttribute("loginId") == null) { // id 값이 null이면 비로그인 상태로 간주
	response.sendRedirect("login.jsp"); // login.jsp 페이지로 이동
%>
<script>
	alert("로그인 후 이용할 수 있습니다!");
	history.back();
</script>
<%
}
%>

<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>

<style>
body {
	background-color: #e6e6e6;
	height: 100%;
}

.side-bar {
	width: 150px;
}

.body-container {
	display: flex;
	max-width: 1000px;
	min-height: 800px;
	background-color: #fff;
	margin: 0 auto;
	height: 100%;
	border-left: 1px solid #ddd;
	border-right: 1px solid #ddd;
}

.body-content {
	border-left: 1px solid #ddd;
	padding: 20px;
}

.content-head {
	font-weight: bold;
}

.menu-modify-information {
	color: #5F32FF;
	font-weight: bold;
}

.input-group {
	font-size: 14px;
}

.disable-input {
	background-color: rgb(0, 0, 0, 0.04);
}

th {
	min-width: 150px;
	height: 60px;
	background-color: #f1f8ff;
	font-weight: bold;
	text-align: left;
	padding-left: 15px;
}

td {
	padding-left: 15px;
	width: 550px;
	background-color: rgb(0, 0, 0, 0.02);
}

input {
	border:none;
	outline:none;
	background-color:transparent;
	box-shadow:none;
}

.withdraw-group {
	margin-top: 5px;
	font-size: 12px;
	color: gray;
	text-align: right;
}

.withdraw-btn {
	padding: 3px 6px;
	border-radius: 5px;
	background-color: darkgray;
	text-decoration: none;
	color: #fff;
	cursor: pointer;
}

.modify-btn {
	margin-top: 15px;
	text-align: center;
	padding: 5px 10px;
	cursor: pointer;
}
</style>

<header>
	<%@ include file="header.jsp"%>
</header>

<%
if ((String) session.getAttribute("loginId") != null) {
	UserService userService = new UserServiceImpl();
	UserDTO user = userService.getUser((String) session.getAttribute("loginId"));
%>

<body>
	<div class="body-container">
		<div class="side-bar">
			<%@ include file="myPageSidebar.jsp"%>
		</div>
		<div class="body-content">
			<p class="content-head">회원정보 수정</p>
			<hr>
			<div class="information-container">
				<form method="post" action="myInfoModifyPro.jsp" onsubmit="return validateForm();">
					<div class="input-group">
						<table>
							<tr>
								<th>아이디</th>
								<td class="disable-input">
								<input type="text" name="userId" value="<%=user.getUserId()%>" readonly>
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td class="disable-input">
								<input type="text" name="userName" value="<%=user.getUserName()%>"  readonly>
								</td>
							</tr>
							<tr>
								<th>수정할 비밀번호</th>
								<td>
								<input type="password" name="userPw" required>
								</td>
							</tr>
							<tr>
								<th>비밀번호 다시 입력</th>
								<td>
								<input type="password" name="userPwCheck" required>
								</td>
							</tr>
							<tr>
								<th>휴대폰 번호</th>
								<td>
								<input type="text" name="userPhoneNumber" value="<%=user.getUserPhoneNumber()%>" required>
								</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td>
								<input type="text" name="userEmail" value="<%=user.getUserEmail()%>" required>
								</td>
							</tr>
						</table>
					</div>
					<div class="withdraw-group">
						<span>탈퇴를 원하시면 우측의 회원탈퇴 버튼을 눌러주세요.</span>
						<a class="withdraw-btn" onclick="deleteConfirm('<%=user.getUserId()%>')">회원탈퇴</a>
					</div>
					<div class="modify-btn">
						<button type="submit" class="modify-btn">수정 완료</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

<%
}
%>

<footer>
	<%@ include file="footer.jsp"%>
</footer>

<script>
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
		console.log("deleteConfirm 함수 호출됨");
	    var result = confirm("삭제된 정보는 복구할 수 없습니다. 정말로 탈퇴하시겠습니까?");
	    if (result) {
	        location.href = "myWithdrawPro.jsp?userId=" + userId;
	    }
	}
</script>

</html>