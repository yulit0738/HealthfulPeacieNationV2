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
	background-color: #ffeded;
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

.modify-btn {
	margin-top: 5px;
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
				<form method="post" action="myInfoPwcheckPro.jsp">
					<div class="input-group">
						<table>
							<tr>
								<th>비밀번호 확인</th>
								<td><input type="password" name="userPw" placeholder="비밀번호를 입력해주세요" required></td>
							</tr>
						</table>
					</div>
					<div class="modify-btn">
						<button type="submit" class="modify-btn">확인</button>
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

</script>

</html>