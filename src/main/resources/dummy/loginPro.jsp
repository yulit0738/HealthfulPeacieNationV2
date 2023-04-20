<%@page import="service.LoginResult"%>
<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<%
//로그인 데이터 저장
request.setCharacterEncoding("UTF-8");
String userId = request.getParameter("userId");
System.out.println("로그인 시도 - userId: " + userId);
String userPw = request.getParameter("userPw");
System.out.println("로그인 시도 - userPw: " + userPw);

//로그인 유효성 검사
UserService userService = new UserServiceImpl();
LoginResult loginResult = userService.loginCheck(userId, userPw);

//검사 결과에 따른 로직 실행
if (loginResult == LoginResult.SUCCESS){
	System.out.println("로그인 성공: " + userId);
	session.setAttribute("loginId", userId);
	System.out.println("세션 생성 : " + userId);
	response.sendRedirect("index.jsp");
} else if(loginResult == LoginResult.FAILURE_INVALID_PW_OR_ID){
	System.out.println("로그인 실패: " + LoginResult.FAILURE_INVALID_PW_OR_ID);
%>
	<script>
		alert("아이디/비밀번호가 일치하지 않습니다!");
		history.back();
	</script>
<%
}
%>
