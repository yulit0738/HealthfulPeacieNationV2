<%@page import="dto.GoodsDTO"%>
<%@page import="dto.QuestionDTO"%>
<%@page import="service.GoodsService"%>
<%@page import="service.GoodsServiceImpl"%>
<%@page import="service.QuestionService"%>
<%@page import="service.QuestionServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의글 상세보기</title>
<style>

body {
	background-color: #e6e6e6;
	height: 100%;
}

.side-bar {
	width: 150px;
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
}

.body-content {
	border-left: 1px solid #ddd;
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
	margin: 60px;
	text-align: center;
	font-size: 14px;
}

.no-answer-head {
	color: #5F32FF;
	font-weight: bold;
	font-size: 16px;
}

.question-delete-btn {
	padding: 5px 10px;
	border-radius: 5px;
	background-color: #fff;
	cursor: pointer;
	border: 1px solid #ddd;
}

.question-delete-btn:hover {
	background-color: #ddd;
}

</style>
<header>
	<%@ include file="header.jsp"%>
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
		<div class="side-bar">
			<%@ include file="myPageSidebar.jsp"%>
		</div>
		<div class="body-content">
			<p class="content-head">고객센터</p>
			<hr>
			<div class="question-container">
				<a class="back-button" href="myQuestionList.jsp">&lt; 뒤로가기</a>

				<%-- 상품 정보 영역, 카테고리가 shopping일 경우에만 표시 --%>
				<% if(question.getCategory().equals("shopping")) {%>
				<div class="question-detail-header">
					접수번호:
					<%=question.getQuestionId()%>
					| 카테고리:<%=question.getCategory()%>
					<button
						onclick="deleteConfirm(<%=question.getQuestionId()%>, 'myQuestionList.jsp')"
						class="question-delete-btn">삭제</button>
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
				<p class="no-answer-head">답변을 기다리고 있어요!</p>
				- 업무 시간 안내 -<br>
				평일 09:00 ~ 18:00<br>
				주말 및 공휴일 휴무
				</div>
				<% } %>
				</div>
			</div>
		</div>
	</div>
	<script>

	function deleteConfirm(questionId, recentPage) {
		console.log("deleteConfirm 함수 호출됨");
	    var result = confirm("삭제된 문의는 복구할 수 없습니다. 정말로 삭제하시겠습니까?");
	    if (result) {
	    	location.href = "questionDeletePro.jsp?questionId=" + questionId + "&recentPage=" + recentPage;
	    }
	}
	</script>
</body>
<footer>
	<%@ include file="footer.jsp"%>
</footer>
</html>