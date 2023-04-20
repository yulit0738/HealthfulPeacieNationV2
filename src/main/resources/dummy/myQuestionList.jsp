<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dto.QuestionDTO"%>
<%@page import="service.QuestionService"%>
<%@page import="service.QuestionServiceImpl"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>나의 문의</title>
</head>

<header>
	<%@ include file="header.jsp"%>
</header>

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
	margin-bottom: 100px;
}

.content-head {
	font-weight: bold;
}

.menu-my-question-list {
	color: #5F32FF;
	font-weight: bold;
}

/* New styles */
table {
	border-collapse: collapse;
	width: 750px;
}

th, td {
	border-bottom: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
	font-weight: bold;
}

tr:hover {
	background-color: #f5f5f5;
}

tbody {
	display: block;
}

tr {
	display: table;
	width: 100%;
	table-layout: fixed;
}

.pagination {
	display: flex;
	justify-content: center;
	margin: 20px 0;
}

.pagination a, .pagination .current-page {
	display: inline-block;
	padding: 5px 10px;
	margin: 0 3px;
	border: 1px solid #ddd;
	border-radius: 3px;
	text-decoration: none;
	color: #333;
}

.pagination a:hover {
	background-color: #f2f2f2;
}

.pagination .current-page {
	background-color: #5F32FF;
	color: #fff;
	font-weight: bold;
}

th:nth-child(1), td:nth-child(1) {
	width: 50px;
	text-align: center;
} /* 번호 */

th:nth-child(2), td:nth-child(2) {
	width: auto;
} /* 제목 */

th:nth-child(3), td:nth-child(3) {
	width: 100px;
	text-align: center;
} /* 작성일 */

th:nth-child(4), td:nth-child(4) {
	width: 90px;
	text-align: center;
} /* 상태 */
.question-done {
	font-size: 14px;
	color: #fff;
	font-weight: bold;
	padding: 5px 10px;
	background-color: #01DF74;
	border-radius: 10px;
}

.question-wait {
	font-size: 14px;
	color: #fff;
	font-weight: bold;
	padding: 5px 10px;
	background-color: #FACC2E;
	border-radius: 10px;
}
</style>

<body>
	<div class="body-container">
		<div class="side-bar">
			<%@ include file="myPageSidebar.jsp"%>
		</div>
		<div class="body-content">
			<p class="content-head">나의 문의</p>
			<hr>
			<div class="information-container">
				<%
//데이터베이스 연결을 위한 객체 생성-mvc2 방식
QuestionService questionService = new QuestionServiceImpl();
int pageSize = 10; //한 페이지에 출력되는 글(리스트) 개수
  String userId = (String) session.getAttribute("loginId");
  String state = request.getParameter("state");
  String pageNumber = request.getParameter("pageNumber"); //현재페이지 String타입
  int currentPageNumber = 0;  //현재페이지 int 타입 
  int listCount = 0;
  int totalCount = 0;
  //글의 총 개수
      if(totalCount == 0){
         totalCount = questionService.getAllCountById(userId);
      }
  if(state == null){
     state = "";
  }
  if(pageNumber == null){ //처음이면 = 첫페이지이면
     pageNumber = "1";
  }
  try{
     currentPageNumber = Integer.parseInt(pageNumber); //현재페이지
} catch (NumberFormatException e) {
currentPageNumber = 1; // If there's an error parsing the page number, set it to 1.
}

int startRow = (currentPageNumber - 1) * pageSize; // Starting row of the current page
int endRow = startRow + pageSize; // Ending row of the current page

List<QuestionDTO> questionList = questionService.getQuestionsByUserId(userId, startRow, endRow);

int pageCount = totalCount / pageSize + (totalCount % pageSize == 0 ? 0 : 1); // Calculate the total number of pages
int startPage = (currentPageNumber - 1) / 10 * 10 + 1; // Starting page number of the page list
int endPage = startPage + 9; // Ending page number of the page list

if (endPage > pageCount) {
endPage = pageCount; // If the ending page is greater than the total number of pages, set it to the last page.
}

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); //날짜 포맷 지정

%>
				<table>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>상태</th>
					</tr>
					<%
        for (QuestionDTO question : questionList) {
        %>
					<tr>
						<td><%= question.getQuestionId() %></td>
						<td><a
							href="myQuestionDetail.jsp?questionId=<%= question.getQuestionId() %>"><%= question.getTitle() %></a></td>
						<td><%= dateFormat.format(question.getCreatedAt()) %></td>
						<% if(question.getReply()!="") {
						%> <td><p class="question-done">답변 완료</p></td> <%
						} else {
						%> <td><p class="question-wait">답변 대기</p></td> <%
						}
						%>		
					</tr>
					<%
        }
        %>
				</table>

				<div class="pagination">
					<% if (startPage > 1) { %>
					<a href="myQuestionList.jsp?pageNumber=<%= startPage - 1 %>">&laquo;</a>
					<% } %>

					<% for (int i = startPage; i <= endPage; i++) { %>
					<% if (i == currentPageNumber) { %>
					<span class="current-page"><%= i %></span>
					<% } else { %>
					<a href="myQuestionList.jsp?pageNumber=<%= i %>"><%= i %></a>
					<% } %>
					<% } %>
					<% if (endPage < pageCount) { %>
					<a href="myQuestionList.jsp?pageNumber=<%= endPage + 1 %>">&raquo;</a>
					<% } %>
				</div>
			</div>
		</div>
	</div>
</body>
<script>


// 페이지가 로드되었을 때 이전 스크롤 위치로 이동
window.addEventListener('load', function() {
	var scrollPosition = sessionStorage.getItem('scrollPosition');
	if (scrollPosition) {
		window.scrollTo(0, parseInt(scrollPosition));
	}
});

// 페이지가 언로드되기 전에 현재 스크롤 위치를 저장
window.addEventListener('beforeunload', function() {
	sessionStorage.setItem('scrollPosition', window.scrollY);
});
</script>
<footer>
	<%@ include file="footer.jsp"%>
</footer>
</html>