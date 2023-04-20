<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<%
	System.out.println(session.getAttribute("loginId") + " > logoutPro.jsp");
	session.invalidate();
%>
<script>
    alert("로그아웃되었습니다.");
    location.href = "index.jsp";
</script>