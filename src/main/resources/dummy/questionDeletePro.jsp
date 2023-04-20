<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dto.QuestionDTO"%>
<%@page import="service.QuestionService"%>
<%@page import="service.QuestionServiceImpl"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");	

	long questionId = Long.parseLong(request.getParameter("questionId"));
	String recentPage = request.getParameter("recentPage");

	QuestionService questionService = new QuestionServiceImpl();
	QuestionDTO questionDTO = new QuestionDTO();
	questionService.deleteQuestion(questionId);
	
	System.out.println(questionId + " 문의글 삭제 후 이전 페이지 이동 -> " + recentPage);
	
	response.sendRedirect(recentPage);

%>
</body>
</html>