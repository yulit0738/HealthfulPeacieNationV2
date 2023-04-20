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

UserService userService = new UserServiceImpl();
userService.withdrawUser(loginId);
session.invalidate();

%>
<script>
	alert("<%= loginId %> 님의 탈퇴가 정상적으로 처리되었습니다");
	// userId 파라미터를 전달하여 리다이렉션
	location.href = "index.jsp";
</script>

<% } %>
</html>