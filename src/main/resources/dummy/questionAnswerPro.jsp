<%@page import="service.QuestionServiceImpl"%>
<%@page import="service.QuestionService"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	long questionId = Long.parseLong(request.getParameter("questionId"));
	long goodsId = Long.parseLong(request.getParameter("goodsId"));
	String reply = request.getParameter("reply");
	
	QuestionService questionService = new QuestionServiceImpl();
	questionService.updateReply(questionId, reply);
	
	response.sendRedirect("shoppingDetail.jsp?goodsId=" + goodsId);
%>
</body>
</html>