<%@page import="service.LoginResult"%>
<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<meta charset="UTF-8">

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


<%
request.setCharacterEncoding("UTF-8");
String userId = (String) session.getAttribute("loginId");
String userPw = request.getParameter("userPw");

//로그인 유효성 검사
UserService userService = new UserServiceImpl();
LoginResult loginResult = userService.loginCheck(userId, userPw);

//검사 결과에 따른 로직 실행
if (loginResult == LoginResult.SUCCESS){
	response.sendRedirect("myInfo.jsp");
} else if(loginResult == LoginResult.FAILURE_INVALID_PW_OR_ID){
	System.out.println("회원정보 수정, 비밀번호 확인 실패: " + LoginResult.FAILURE_INVALID_PW_OR_ID);
%>
	<script>
		alert("비밀번호가 일치하지 않습니다!");
		history.back();
	</script>
<%
}
%>
