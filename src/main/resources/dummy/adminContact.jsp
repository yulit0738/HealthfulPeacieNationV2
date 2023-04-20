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

.question-list-container {
	width: 1000px;
	margin: 15px auto;
}

.question-list-label {
	margin-top: 15px;
	margin-bottom: 15px;
	margin-left: 15px;
	font-size: 18px;
	font-weight: bold;
	display: flex;
	align-items: center;
}

.toggle-container {
	justify-content: flex-end;
  	margin-top: 15px;
	margin-left: 15px;
	display: flex;
	align-items: center;
	z-index: 200; /* 토글 버튼에 z-index 적용 */
}

.switch {
	position: relative;
	display: inline-block;
	width: 60px;
	height: 34px;
}

.switch input {
	display: none;
}

.slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	transition: 0.4s;
}

.slider:before {
	position: absolute;
	content: "";
	height: 26px;
	width: 26px;
	left: 4px;
	bottom: 4px;
	background-color: white;
	transition: 0.4s;
}

input:checked+.slider {
	background-color: #0077CC;
}

input:checked+.slider:before {
	transform: translateX(26px);
}

.slider.round {
	border-radius: 34px;
}

.slider.round:before {
	border-radius: 50%;
}

table {
	width: 100%;
	margin: 15px auto;
	max-width: 100%;
	border-collapse: separate;
	overflow: hidden;
}

th {
	background-color: #0077CC;
	color: #ffffff;
	padding: 10px;
	text-align: center;
	border-right: 1px solid #ffffff;
}

.question-component {
	cursor: pointer;
}

td {
	padding: 7px;
	text-align: center;
	border-right: 1px solid #e6e6e6;
	background-color: #ffffff;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

td:first-child {
	background-color: #f5f5f5;
}

td:last-child {
	border-right: none;
}

td:nth-of-type(3) {
	text-align: left;
}

td:nth-of-type(4) {
	text-align: left;
}

th:nth-child(1), td:nth-child(1) {
	width: 100px;
} /* 상태 */
th:nth-child(2), td:nth-child(2) {
	width: 100px;
} /* 문의번호 */
th:nth-child(3), td:nth-child(3) {
	width: auto;
} /* 제목 */
th:nth-child(4), td:nth-child(4) {
	width: 120px;
} /* 작성자 */
th:nth-child(5), td:nth-child(5) {
	width: 150px;
} /* 날짜 */

.container-pagination {
	margin: 15px auto;
	width: 1000px;
	display: flex;
	justify-content: space-between; /* 추가 */
}

.pagination {
	display: flex;
	justify-content: flex-start; /* 변경 */
}

.pagination a {
	color: #0077CC;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	transition: background-color .3s;
	border: 1px solid #ddd;
	background-color: #fff;
}

.pagination .active {
	background-color: #0077CC;
	color: white;
	padding: 8px 16px;
	border: 1px solid #0077CC;
}

.pagination a:hover:not(.active) {
	background-color: orange;
	color: #fff;
}

.pagination .disabled {
	color: darkgray;
	pointer-events: none;
	cursor: default;
	border: 1px solid #ddd;
	padding: 8px 16px;
}

.userId {
	color: #0077CC;
	font-weight: bold;
}

.form-search {
	display: flex;
	justify-content: flex-end;
	align-items: center;
}

.input-search {
	padding-left: 8px;
	height: 30px;
	border: 1px #ddd solid;
}

.btn-search {
	padding: 5px 10px;
	background-color: orange;
	color: #fff;
	border: none;
	cursor: pointer;
}

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

a {
	text-decoration: none;
	font-weight: bold;
	color: #0077CC;
}
</style>

</head>

<header>
	<%@ include file="adminSidebar.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<%
//검색어 파라미터 추출
String search = request.getParameter("search");

//요청정보 확인
System.out.println("Request URI: " + request.getRequestURI());
System.out.println("Query String: " + request.getQueryString());
System.out.println("Search: " + search);

QuestionService questionService = new QuestionServiceImpl();
%>

<body>
	<%
	if (search == null || search == "") {

		int currentPage = 1;
		int pageSize = 20;
		
		if (request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		System.out.println("현재 페이지: " + currentPage);
		
		int start = (currentPage - 1) * pageSize + 1; // 시작 인덱스 계산
		int end = currentPage * pageSize; // 끝 인덱스 계산
		System.out.println("start: " + start);
		System.out.println("end: " + end);
		
		int totalQuestions = questionService.getAllCount();
		System.out.println("totalQuestions: " + totalQuestions);
		
		// 마지막 페이지는 올림처리 하기 위해 math.ceil메소드 사용.
		int totalPages = (int) Math.ceil((double) totalQuestions / pageSize); // 전체 페이지 수 계산
		System.out.println("totalPages: " + totalPages);
		
		List<QuestionDTO> questionList = questionService.getQuestionsWithPagenation(start, end);

	%>
	<div class="question-list-container">
		<p class="question-list-label">고객센터 - 전체 문의 목록</p>
		<div class="toggle-container">
			<label class="switch">
				<input type="checkbox" id="toggleReply" onchange="toggleReply();">
				<span class="slider round"></span>
			</label>
			<span>답변 없는 문의만 보기</span>
		</div>
		<div class="question-table">
			<table>
				<thead>
					<tr>
						<th>상태</th>
						<th>문의번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (QuestionDTO question : questionList) {
					%>
					<tr class="question-component" onclick="window.location.href='adminContactDetail.jsp?questionId=<%=question.getQuestionId()%>'">						
						<% if(question.getReply()!="") {
						%> <td><p class="question-done">답변 완료</p></td> <%
						} else {
						%> <td><p class="question-wait">답변 대기</p></td> <%
						}
						%>						
						<td><%=question.getQuestionId()%></td>
						<td><%=question.getTitle()%></td>
						<td><%=question.getUserId() %> <td><%=question.getCreatedAt().toString().substring(0,16)%></td>
					</tr>
					<%
					}
					%>			
			</table>
			<div class="container-pagination">
				<div class="pagination">
					<%if (currentPage > 1) {%>
					<a href="?page=<%=currentPage - 1%>">&laquo;</a>
					<%} else {%>
					<span class="disabled">&laquo;</span>
					<%}%>
			
					<%
					int startPage = Math.max(currentPage - 5, 1); // 시작 페이지 계산
					int endPage = Math.min(startPage + 9, totalPages); // 끝 페이지 계산
					for (int i = startPage; i <= endPage; i++) {
					%>
					<%if (currentPage == i) {%>
					<span class="active"><%=i%></span>
					<%} else {%>
					<a href="?page=<%=i%>"><%=i%></a>
					<%}%>
					<%}%>
					<%if (currentPage < totalPages) {%>
					<a href="?page=<%=currentPage + 1%>">&raquo;</a>
					<%} else {%>
					<span class="disabled">&raquo;</span>
					<%}%>
				</div>
				<!-- 검색창 폼 자리 -->
			<form method="get" action="${pageContext.request.contextPath}/adminContact.jsp" class="form-search">
				<input type="text" id="search" name="search" value="${param.search}" class="input-search" placeholder="아이디로 검색">
				<button type="submit" class="btn-search">검색</button>
			</form>
			</div>
		</div>
		</div>
		<% } else { 
		int currentPage = 1;
		int pageSize = 20;
		
		if (request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		System.out.println("현재 페이지: " + currentPage);
		
		int start = (currentPage - 1) * pageSize + 1; // 시작 인덱스 계산
		int end = currentPage * pageSize; // 끝 인덱스 계산
		System.out.println("start: " + start);
		System.out.println("end: " + end);
		
		int totalQuestions = questionService.getAllCountById(search);
		System.out.println("totalQuestions: " + totalQuestions);
		
		// 마지막 페이지는 올림처리 하기 위해 math.ceil메소드 사용.
		int totalPages = (int) Math.ceil((double) totalQuestions / pageSize); // 전체 페이지 수 계산
		System.out.println("totalPages: " + totalPages);
		
		List<QuestionDTO> questionList = questionService.getQuestionsByUserId(search, start, end);

	%>
	<div class="question-list-container">
		<p class="question-list-label">고객센터 - 특정 회원 문의 검색</p>

		<div class="question-table">
			<table>
				<thead>
					<tr>
						<th>상태</th>
						<th>문의번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (QuestionDTO question : questionList) {
						System.out.println("출력");
					%>
					<tr class="question-component">
						<% if(question.getReply()!="") {
						%> <td><p class="question-done">답변 완료</p></td> <%
						} else {
						%> <td><p class="question-wait">답변 대기</p></td> <%
						}
						%>
						<td><%=question.getQuestionId()%></td>
						<td><a
							href="adminContactDetail.jsp?questionId=<%=question.getQuestionId()%>"><%=question.getTitle()%></a></td>
						<td><%=question.getUserId() %> <td><%=question.getCreatedAt().toString().substring(0,16)%></td>
					</tr>
					<%
					}
					%>			
			</table>
			<div class="container-pagination">
				<div class="pagination">
					<%if (currentPage > 1) {%>
					<a href="?page=<%=currentPage - 1%>">&laquo;</a>
					<%} else {%>
					<span class="disabled">&laquo;</span>
					<%}%>
			
					<%
					int startPage = Math.max(currentPage - 5, 1); // 시작 페이지 계산
					int endPage = Math.min(startPage + 9, totalPages); // 끝 페이지 계산
					for (int i = startPage; i <= endPage; i++) {
					%>
					<%if (currentPage == i) {%>
					<span class="active"><%=i%></span>
					<%} else {%>
					<a href="?page=<%=i%>"><%=i%></a>
					<%}%>
					<%}%>
					<%if (currentPage < totalPages) {%>
					<a href="?page=<%=currentPage + 1%>">&raquo;</a>
					<%} else {%>
					<span class="disabled">&raquo;</span>
					<%}%>
				</div>
				<!-- 검색창 폼 자리 -->
			<form method="get" action="${pageContext.request.contextPath}/adminContact.jsp" class="form-search">
				<input type="text" id="search" name="search" value="${param.search}" class="input-search" placeholder="아이디로 검색">
				<button type="submit" class="btn-search">검색</button>
			</form>
			</div>
		</div>
		</div>
		<% } %>
	</body>
<script>
function toggleReply() {
	const isChecked = document.getElementById('toggleReply').checked;
	const allQuestions = document.getElementsByClassName('question-component');
	for (let i = 0; i < allQuestions.length; i++) {
		const status = allQuestions[i].getElementsByTagName('td')[0].innerText;
		if (isChecked && status !== '답변 대기') {
			allQuestions[i].style.display = 'none';
		} else {
			allQuestions[i].style.display = '';
		}
	}
}
</script>
<%
}
%>
</html>