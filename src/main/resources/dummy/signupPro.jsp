<%@page import="repository.SignupResult"%>
<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<%
//회원가입 데이터 저장
request.setCharacterEncoding("UTF-8");
String userId = request.getParameter("userId");
String userPw = request.getParameter("userPw");
String userName = request.getParameter("userName");
String userPhoneNumber = request.getParameter("userPhoneNumber");
String userEmail = request.getParameter("userEmail");

//회원가입
UserService userService = new UserServiceImpl();

if (userService.registerUser(userId, userPw, userName, userPhoneNumber, userEmail) == SignupResult.SIGNUP_SUCCESS) {
	System.out.println("회원가입 성공: " + userId);
%>
<script>
	alert("헬스로운 평화나라 회원이 되신 것을 환영합니다!");
	location.href = "index.jsp";
</script>
<%
} else {
System.out.println("회원가입 실패: " + SignupResult.FAILURE_ID_ALREADY_EXIST);
%>
<script>
	alert("이미 존재하는 아이디입니다!");
	history.back();
</script>
<%
}
//검사 결과에 따른 로직 실행
%>
</html>