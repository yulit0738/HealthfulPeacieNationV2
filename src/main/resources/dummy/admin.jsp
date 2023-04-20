<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
String loginId = (String)session.getAttribute("loginId"); // 세션에서 id 값을 읽어옴
    if (loginId == null) { // id 값이 null이면 비로그인 상태로 간주
        response.sendRedirect("unauthorized.jsp"); // error.jsp 페이지로 이동
    } else if (!"admin".equals(loginId)){
%>
   	<script>
   		alert("관리자만 이용할 수 있습니다!");
   		history.back();
   	</script>
   	<%
   	}
%>

<head>
<meta charset="UTF-8">
<title>헬스로운 평화나라 관리자 모드</title>
</head>

<style>
	body{
	background-color: #e6e6e6;
	}
</style>

<header>
<%@ include file="adminSidebar.jsp"%>
</header>

<body>

</body>
</html>