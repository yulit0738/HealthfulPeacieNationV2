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
<title>게시글 수정 화면 - boardUpdateForm.jsp</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String userId = (String) session.getAttribute("loginId");
		long questionId = Long.parseLong(request.getParameter("id"));
		QuestionService questionService = new QuestionServiceImpl();
		QuestionDTO questionDTO = questionService.getQuestion(questionId);

	%>
	
	<h2 align="center">수정</h2>
		<form action="questionUpdatePro.jsp" method="post">
			<table align="center" border="1" style="width:600">
				<tr height="40" align="center">
					<td width="150">번호</td>
					<td width="350"><%=questionDTO.getQuestionId() %></td>
					<td width="150">작성자</td>
					<td width="350"><%=questionDTO.getUserId() %></td>
				</tr>
				<tr height="40" align="center">
					<td width="150">대분류</td>
					<td>
					<% 
					String check1[] = {" ", " "};
					String ET1 = questionDTO.getCategory();
					String ET1_1[] = {"exercise", "goods"};
					
					for(int i=0;i<2;i++){
						if(ET1.equals(ET1_1[i])){
							check1[i] = "selected";
						}
					}
					%>
					<select name="category">
						<option value="exercise" <%=check1[0]%>>exercise</option>
						<option value="goods" <%=check1[1]%>>goods</option>
					<%  %>
					</select>
					</td>
					<td width="150">소분류</td>
					<td>
					<% 
					String check2[] = {" ", " ", " ", " ", " "};
					String ET2 = questionDTO.getGoodsId();
					String ET2_1[] = {"goods1", "goods2", "goods3", "goods4", "goods5"};
					
					for(int i=0;i<5;i++){
						if(ET2.equals(ET2_1[i])){
							check2[i] = "selected";
						}
					}
					%>
					<select name="goodsId">
						<option value="goods1" <%=check2[0]%>>goods1</option>
						<option value="goods2" <%=check2[1]%>>goods2</option>
						<option value="goods3" <%=check2[2]%>>goods3</option>
						<option value="goods4" <%=check2[3]%>>goods4</option>
						<option value="goods5" <%=check2[4]%>>goods5</option>
					<%  %>
					</select>
					</td>
				</tr>
				<tr height="40" align="center">
					<td width="150">작성일자</td>
					<td width="350"><%=questionDTO.getCreatedAt() %></td>
					<td width="150">제목</td>
					<td width="350"><input type="text" name="title" value="<%=questionDTO.getTitle() %>"></td>
				</tr>
				<tr height="40" align="center">
					<td width="150">내용</td>
					<td width="350" colspan="3" col="50" row="3"><input type="text" name="content" value="<%=questionDTO.getContent() %>"></td>
				</tr>
				
				<%	
					String admin = "admin";
					String reply = questionDTO.getReply();
					if ((userId != null && admin.equals(userId))) {
				%>
						<tr height="40" align="center">
							<td width="150">답변일자</td>
							<td width="350"><%=questionDTO.getUpdatedAt() %></td>
							<td width="150">답변</td>
							<td width="350" colspan="3" col="50" row="3"><input type="text" name="reply" value="<%=questionDTO.getReply() %>"></td>
						</tr>
				</table>
				<%
					} else {
					
				%>
					<tr height="40" align="center">
						<td width="150">답변일자</td>
						<td width="350"><%=questionDTO.getUpdatedAt() %></td>
						<td width="150">답변</td>
						<td width="350" colspan="3" col="50" row="3"><%=questionDTO.getReply() %></td>
					</tr>
				<%
					}
				%>
				
				<table>
					<div align="center">
				      <button type="submit">수정</button>
				      <button type="reset">취소</button>
				      <button type="button" onclick="location.href='question.jsp'"><b>문의하기</b></button>
				      <button type="button" onclick="location.href='questionList.jsp'"><b>문의글 목록</b></button>
				    </div>
			    </table>
					
	
			<input type="hidden" name="userId" value="<%=userId %>">
			<input type="hidden" name="questionId" value="<%=questionDTO.getQuestionId() %>">
			<input type="hidden" name="createdAt" value="<%=questionDTO.getCreatedAt() %>">
			<input type="hidden" name="updatedAt" value="<%=questionDTO.getUpdatedAt() %>">
			
	    </form>
</body>
</html>
