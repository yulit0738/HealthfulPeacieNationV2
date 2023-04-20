<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="service.QuestionService"%>
<%@ page import="service.QuestionServiceImpl"%>
<%@page import="dto.QuestionDTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의글 작성 처리</title>
</head>
<style>
</style>

	<%
	request.setCharacterEncoding("UTF-8");
	String userId = (String) session.getAttribute("loginId");
	String category = request.getParameter("category");
	long goodsId = Long.parseLong(request.getParameter("goodsId"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");

	System.out.println(userId + ", " + category + ", " + goodsId + ", " + title + ", " + content);

	//문의글 등록
	QuestionService questionService = new QuestionServiceImpl();
	questionService.createQuestion(userId, category, goodsId, title, content);
	
	response.sendRedirect("shoppingDetail.jsp?goodsId=" + goodsId);
	%>

</body>
</html>