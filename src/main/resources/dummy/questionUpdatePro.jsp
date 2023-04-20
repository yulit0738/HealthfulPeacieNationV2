<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dto.QuestionDTO"%>
<%@page import="service.QuestionService"%>
<%@page import="service.QuestionServiceImpl"%>
<%@page import="java.util.ArrayList"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String userId = request.getParameter("userId");
	String category = request.getParameter("category");
	String goodsId = request.getParameter("goodsId");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String reply = request.getParameter("reply");
	long questionId = Long.parseLong(request.getParameter("questionId"));
	
	//문의글 수정
	QuestionService questionService = new QuestionServiceImpl();
	QuestionDTO questionDTO = new QuestionDTO(questionId, userId, category, goodsId, title, content, reply);
	
	questionService.modifyQuestion(questionDTO);
	
	response.sendRedirect("questionList.jsp");
	//response.sendRedirect("questionDetail.jsp?id="+ questionDTO.getQuestionId());

	%>
</body>
</html>