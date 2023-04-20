<%@page import="repository.UserRepositoryImpl"%>
<%@page import="repository.UserRepository"%>
<%@page import="java.util.List"%>
<%@page import="dto.UserDTO"%>
<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
String loginId = (String) session.getAttribute("loginId"); // 세션에서 id 값을 읽어옴
if (loginId == null) { // id 값이 null이면 비로그인 상태로 간주
	response.sendRedirect("unauthorized.jsp"); // error.jsp 페이지로 이동
} else if (!"admin".equals(loginId)) {
%>
<script>
	alert("관리자만 이용할 수 있습니다!");
	history.back();
</script>
<%
} else { // 로그인 상태이며 관리자 권한이 있는 경우
UserService userService = new UserServiceImpl();
%>

<head>
<meta charset="UTF-8">
<title>헬스로운 평화나라 관리자 모드</title>
<style>
body {
	background-color: #e6e6e6;
}

.user-list-container {
	width: 1000px;
	margin: 15px auto;
}

.user-list-label {
	margin-top: 15px;
	margin-bottom: 15px;
	margin-left: 15px;
	font-size: 18px;
	font-weight: bold;
    display: flex;
    align-items: center;
}
.user-count {
	font-size: 16px;
	color: #0077CC;
	margin-left: 10px;
}

table {
	width: 100%;
	margin: 15px auto;
	max-width: 100%;
	border-collapse: separate;
	border-spacing: 0;
	overflow: hidden;
}

th {
	background-color: #0077CC;
	color: #ffffff;
	padding: 10px;
	text-align: center;
	border-right: 1px solid #ffffff;
}

td {
	padding: 7px;
	text-align: center;
	border-right: 1px solid #e6e6e6;
}

td:first-child {
	background-color: #f5f5f5;
}

tr:nth-child(even) td {
	background-color: #ffffff;
}

tr:nth-child(odd) td {
	background-color: #f1f8ff;
}

td:last-child {
	border-right: none;
}

td:nth-of-type(2), td:nth-of-type(3), td:nth-of-type(6) {
	text-align: left;
}

.container-pagination{
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
%>
<body>

		<%

if(search == null || search == ""){
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

				int totalUsers = userService.getUserCount();
				System.out.println("totalUsers: " + totalUsers);

				// 마지막 페이지는 올림처리 하기 위해 math.ceil메소드 사용.
				int totalPages = (int) Math.ceil((double) totalUsers / pageSize); // 전체 페이지 수 계산
				System.out.println("totalPages: " + totalPages);

				List<UserDTO> users = userService.getUserListByRange(start, end);
				%>
				
	<div class="user-list-container">
		<p class="user-list-label">사용자 관리 - 회원 목록 <span class="user-count">(<%= userService.getUserCount() %>)</span></p>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>비밀번호</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>가입일</th>
				</tr>
			</thead>
			<tbody>
			<%	
				int count = 1;
				for (UserDTO userlist : users) {
				%>

				<tr>
					<td><%=count++%></td>
					<td><a class="userId"
						href="adminUserDetail.jsp?id=<%=userlist.getUserId()%>"><%=userlist.getUserId()%></a></td>
					<td><%=userlist.getUserPw()%></td>
					<td><%=userlist.getUserName()%></td>
					<td><%=userlist.getUserPhoneNumber()%></td>
					<td><%=userlist.getUserEmail()%></td>
					<td><%=userlist.getUserCreatedAt().toString().substring(0,16)%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
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
		<!-- 검색창 폼 -->
		<form method="get" action="${pageContext.request.contextPath}/adminUserList.jsp" class="form-search">
			<input type="text" id="search" name="search" value="${param.search}" class="input-search">
			<button type="submit" class="btn-search">검색</button>
		</form>
	</div>
	<%
	} else {
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
			  
			  int totalUsers = userService.searchUserCount(search);
			  System.out.println("totalUsers: " + totalUsers);
			  
			  // 마지막 페이지는 올림처리 하기 위해 math.ceil메소드 사용. 더블계산을 
			  int totalPages = (int) Math.ceil((double) totalUsers / pageSize); // 전체 페이지 수 계산
			  System.out.println("totalPages: " + totalPages);

			List<UserDTO> users = userService.searchUserList(search, start, end);
	%>
	
	<div class="user-list-container">
		<p class="user-list-label">사용자 관리 - 회원 검색</p>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>가입일</th>
			</tr>
		</thead>
		<tbody>
		<%
		int count = 1;
		for (UserDTO userlist : users) {
		%>
			<tr>
				<td><%=count++%></td>
				<td><a class="userId"
					href="adminUserDetail.jsp?id=<%=userlist.getUserId()%>"><%=userlist.getUserId()%></a></td>
				<td><%=userlist.getUserPw()%></td>
				<td><%=userlist.getUserName()%></td>
				<td><%=userlist.getUserPhoneNumber()%></td>
				<td><%=userlist.getUserEmail()%></td>
				<td><%=userlist.getUserCreatedAt().toString().substring(0,16)%></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	</div>
	<div class="container-pagination">
		<div class="pagination">
			<%
			if (currentPage > 1) {
			%>
			<a href="?page=<%=currentPage - 1%>&search=<%=search%>">&laquo;</a>
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
			<a href="?page=<%=i%>&search=<%=search%>"><%=i%></a>
			<%}%>
			<%}%>
	
			<%if (currentPage < totalPages) {%>
			<a href="?page=<%=currentPage + 1%>&search=<%=search%>">&raquo;</a>
			<%} else {%>
			<span class="disabled">&raquo;</span>
			<%}%>
		</div>
		<!-- 검색창 폼 -->
		<form method="get" action="${pageContext.request.contextPath}/adminUserList.jsp" class="form-search">
			<input type="text" id="search" name="search" value="${param.search}" class="input-search">
			<button type="submit" class="btn-search">검색</button>
		</form>
	</div>
	<%
		}
}
%>
</body>
</html>