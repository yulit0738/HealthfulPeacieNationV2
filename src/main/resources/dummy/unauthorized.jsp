<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Unauthorized</title>
</head>
<body>
<%
HttpSession sessions = request.getSession();
sessions.invalidate();
%>
<script>
    alert("로그인 후 이용할 수 있습니다.");
    location.href = "login.jsp";
</script>
</body>
</html>