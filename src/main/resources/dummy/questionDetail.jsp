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
<title>게시글 상세보기</title>
</head>
<style>
*{
cursor: url(cursor.cur), auto;
}
</style>
<body align="center">
	<%
		String userId = (String) session.getAttribute("loginId");
		
		long questionId = Long.parseLong(request.getParameter("id"));
		QuestionService questionService = new QuestionServiceImpl();
		QuestionDTO questionDTO = questionService.getQuestion(questionId);
		String category = request.getParameter("category");
		String goodsId = request.getParameter("goodsId");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String reply = request.getParameter("reply");
		
	%>
	
	<h2 align="center">문의글 상세보기</h2>
	<table align="center" border="1" style="width:600">
		<tr height="40" align="center">
			<td width="150">번호</td>
			<td width="350"><%=questionDTO.getQuestionId() %></td>
			<td width="150">작성자</td>
			<td width="350"><%=questionDTO.getUserId() %></td>
		</tr>
		<tr height="40" align="center">
			<td width="150">대분류</td>
			<td width="350"><%=questionDTO.getCategory() %></td>
			<td width="150">소분류</td>
			<td width="350"><%=questionDTO.getGoodsId() %></td>
		</tr>
		<tr height="40" align="center">
			<td width="150">작성일자</td>
			<td width="350"><%=questionDTO.getCreatedAt() %></td>
			<td width="150">제목</td>
			<td width="350"><%=questionDTO.getTitle() %></td>
		</tr>
		<tr height="40" align="center">
			<td width="150">내용</td>
			<td width="350" colspan="3" col="50" row="3"><%=questionDTO.getContent() %></td>
		</tr>
		<tr height="40" align="center">
			<td width="150">답변일자</td>
			<td width="350"><%=questionDTO.getUpdatedAt() %></td>
			<td width="150">답변</td>
			<td width="350" colspan="3" col="50" row="3"><%=questionDTO.getReply() %></td>
		</tr>
	<%	
		String idCheck = questionDTO.getUserId();
		System.out.println(userId + " : " + idCheck);
		String admin = "admin";
		if ((userId != null && admin.equals(userId)) || ((userId != null && idCheck.equals(userId)) && (questionDTO.getReply() == null))) {
	%>
		<tr height="40" align="center">
			<td colspan="4">
				<button type="button" onclick="location.href='questionUpdate.jsp?id=<%=questionDTO.getQuestionId() %>'"><b>수정</b></button>&nbsp;&nbsp;
				<button type="button" onclick="location.href='questionDeletePro.jsp?id=<%=questionDTO.getQuestionId() %>'"><b>삭제</b></button>&nbsp;&nbsp;
				
			</td>
		</tr>
	<%
		} 
	%>
		<tr height="40" align="center">
			<td colspan="4">
				<button type="button" onclick="location.href='question.jsp'"><b>문의하기</b></button>&nbsp;&nbsp;
				<button type="button" onclick="location.href='questionList.jsp'"><b>문의글 목록</b></button>
				
			</td>
		</tr>
	</table>
</body>
</html>