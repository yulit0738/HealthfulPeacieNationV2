<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%
request.setCharacterEncoding("UTF-8");
String userId = request.getParameter("userId");
String userPw = request.getParameter("userPw");

UserService userService = new UserServiceImpl();
userService.modifyUserPassword(userId, userPw);

%>
<script>
	alert("회원정보가 수정되었습니다!");
	// userId 파라미터를 전달하여 리다이렉션
	location.href = "adminUserDetail.jsp?id=<%=userId%>";
</script>

</html>