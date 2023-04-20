<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
String loginId = (String)session.getAttribute("loginId"); // 세션에서 id 값을 읽어옴
    if (loginId == null) { // id 값이 null이면 비로그인 상태로 간주
        response.sendRedirect("unauthorized.jsp"); // error.jsp 페이지로 이동
   	} else {

		String userId = request.getParameter("userId");
		String userPw = request.getParameter("userPw");
		String userPhoneNumber = request.getParameter("userPhoneNumber");
		String userEmail = request.getParameter("userEmail");
		System.out.println(userId + "회원정보 수정");
		UserService userService = new UserServiceImpl();
		userService.modifyUserInformation(userId, userPw, userPhoneNumber, userEmail);
		
		%>
		<script>
			alert("회원정보가 수정되었습니다!");
			location.href = "myInfo.jsp";
		</script>
		<%

   	}
%>
</html>