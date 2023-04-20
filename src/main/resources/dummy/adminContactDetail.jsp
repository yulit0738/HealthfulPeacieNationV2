<%@page import="dto.GoodsDTO"%>
<%@page import="service.GoodsServiceImpl"%>
<%@page import="service.GoodsService"%>
<%@page import="service.QuestionService"%>
<%@page import="service.QuestionServiceImpl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.QuestionDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
String loginId = (String) session.getAttribute("loginId");
if (loginId == null) {
	response.sendRedirect("unauthorized.jsp");
} else if (!"admin".equals(loginId)) {
%>
<script>
	alert("관리자만 이용할 수 있습니다!");
	history.back();
</script>
<%
} else {
%>

<head>
<meta charset="UTF-8">
<title>헬스로운 고객센터</title>
<style>

body {
	background-color: #e6e6e6;
}

.body-container {
	display: flex;
	max-width: 1000px;
	min-height: 800px;
	background-color: #fff;
	margin: 0 auto;
	height: 100%;
	border-left: 1px solid #ddd;
	border-right: 1px solid #ddd;
	justify-content: center;
}

.body-content {
	padding: 20px;
}

.content-head {
	font-weight: bold;
}

.menu-my-question-list {
	color: #5F32FF;
	font-weight: bold;
}

.question-container {
	width: 700px;
	margin: 30px auto;
	background-color: #fff;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.back-button {
	text-decoration: none;
	color: #000;
	font-weight: bold;
	font-size: 1.1em;
	margin-bottom: 10px;
}

.product-info {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	align-items: center;
	padding: 20px;
}

.product-title {
	font-size: 18px;
	font-weight: bold;
	margin: 0px;
}

.product-code {
	margin: 0px;
	font-size: 14px;
	color: #888;
}

.product-img {
	width: 100px;
	height: 100px;
	object-fit: cover;
}

.question-detail-container {
	padding: 20px;
}

.question-detail-header {
	margin-top:15px;
	font-size: 14px;
	color: #888;
}
.question-created_at {
	color: #888;
	font-size: 14px;
}

.question-detail-title-box {
	background-color: rgb(0, 0, 0, 0.04);
	padding: 10px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.question-detail-title {
	font-weight: bold;
}

.question-detail-content {
	padding: 20px 10px;
	white-space: pre-wrap;
	background-color: #f1f8ff;
}

hr {
	margin-top: 15px;
	border-top: 1px solid #ddd;
}

.answer-container {
	padding: 20px;
}

.answer-header {
	font-weight: bold;
	margin-bottom: 10px;
}

.answer-created-at {
	font-size: 14px;
	color: #888;
}

.answer-content{
	margin: 15px 15px;
}

.answer-component {
	padding: 5px 10px;
	background-color: rgb(0, 0, 0, 0.04);
}

.no-answer-component {
	color: #888;
	margin-top: 15px;
	text-align: center;
}

.reply-textarea {
	width: 100%;
	min-height: 200px;
	resize: none;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-bottom: 10px;
	box-sizing: border-box;
	font-size: 14px;
}

</style>
<header>
	<%@ include file="adminSidebar.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	long questionId = Long.parseLong(request.getParameter("questionId"));
	QuestionService questionService = new QuestionServiceImpl();
	QuestionDTO question = questionService.getQuestion(questionId);
	GoodsService goodsService = new GoodsServiceImpl();
	GoodsDTO goods = goodsService.findGoods(question.getGoodsId());
%>

<body>
	<div class="body-container">
		<div class="body-content">
			<p class="content-head">고객센터</p>
			<hr>
			<div class="question-container">
				<a class="back-button" href="adminContact.jsp">&lt; 뒤로가기</a>

				<%-- 상품 정보 영역, 카테고리가 shopping일 경우에만 표시 --%>
				<% if(question.getCategory().equals("shopping")) {%>
				<div class="question-detail-header">
					접수번호: <%= question.getQuestionId() %> | 카테고리:<%= question.getCategory() %>
				</div>
				<div class="product-info">
					<img class="product-img" src="goodsImages/<%= goods.getThumbnail() %>" alt="상품 이미지">			
					<div>
						<p class="product-title"><%= goods.getGoodsName() %></p>
						<p class="product-code">상품 코드: <%= goods.getGoodsId() %></p>
					</div>
				</div>
				<% } %>
				<div class="question-detail-container">
					<div class="answer-header">문의 내용</div>
					<div class="question-detail-title-box">
						<span class="question-detail-title"><%= question.getTitle() %></span>
						<span class="question-created_at"><%= question.getCreatedAt().toString().substring(0,16) %></span>
					</div>
					<div class="question-detail-content"><%= question.getContent() %></div>
					<hr>
			<%-- 답변 영역, 답변이 존재할 경우에만 표시 --%>
			<% if(question.getReply()!="") {%>
				<div class="answer-container">
					<div class="answer-header">관리자 답변</div>
					<div class="answer-component">
						<p class="answer-created-at"><%=question.getUpdatedAt()%></p>
						<p class="answer-content"><%=question.getReply()%></p>
					</div>
				</div>
				<% } else {%>
				<div class="no-answer-component">
					<form action="adminQuestionAnswerPro.jsp?questionId=<%=question.getQuestionId()%>" method="post">
						<input type="hidden" name="goodsId" value="<%=question.getGoodsId()%>">
						<textarea class="reply-textarea" name="reply" placeholder="답변 내용을 입력하세요." required></textarea>
						<br><input type="submit" value="답변완료" class="answer-submit-btn">
					</form>
				</div>
				<% } %>
				</div>
			</div>
		</div>
	</div>
</body>
<% } %>
</html>