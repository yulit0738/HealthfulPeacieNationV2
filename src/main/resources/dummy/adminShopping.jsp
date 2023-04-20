<%@page import="dto.OrderDTO"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="dto.OrderGoodsDTO"%>
<%@page import="service.OrderServiceImpl"%>
<%@page import="service.OrderService"%>
<%@page import="service.GoodsServiceImpl"%>
<%@page import="service.GoodsService"%>
<%@page import="dto.GoodsDTO"%>
<%@page import="java.util.List"%>
<%@page import="repository.GoodsRepositoryImpl"%>
<%@page import="repository.GoodsRepository"%>
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
	OrderService orderService = new OrderServiceImpl();
%>

<head>
<meta charset="UTF-8">
<title>헬스로운 주문 관리</title>

<style>
body {	
	background-color: #e6e6e6;
}

.order-list-container {
	width: 1000px;
	margin: 15px auto;
}

.order-list-label {
	margin-top: 15px;
	margin-bottom: 15px;
	margin-left: 15px;
	font-size: 18px;
	font-weight: bold;
    display: flex;
    align-items: center;
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

.order-component {
	cursor: pointer;
}

td {
	padding: 7px;
	text-align: center;
	border-right: 1px solid #e6e6e6;
	background-color: #ffffff;
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

td:nth-of-type(5) {
	text-align: right;
}

.subtable {
	margin-left: 20px;
}

.order-status-input {
	text-align: center;
}

.contatiner-pagination{
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
	
	int totalUsers = orderService.getOrderCount();
	System.out.println("totalUsers: " + totalUsers);
	
	// 마지막 페이지는 올림처리 하기 위해 math.ceil메소드 사용.
	int totalPages = (int) Math.ceil((double) totalUsers / pageSize); // 전체 페이지 수 계산
	System.out.println("totalPages: " + totalPages);
	
	List<OrderDTO> orders = orderService.getOrderListByRange(start, end);
%>
	<div class="order-list-container">
		<p class="order-list-label">주문 관리 - 전체 주문 목록</p>
		
		<div class="order-table">
			<table>
				<thead>
					<tr>
						<th>주문번호</th>
						<th>주문 일시</th>
						<th>주문자 아이디</th>
						<th>결제 수단</th>
						<th>주문 금액</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (OrderDTO order : orders) {
						String orderStatus = orderService.getOrder(order.getOrderId()).getOrderStatus();
						String paymentMethod = orderService.getOrder(order.getOrderId()).getPaymentMethod();
					%>
					<tr class="order-component">
					<td onclick="location.href='adminShoppingDetail.jsp?orderId=<%=order.getOrderId()%>'"><%=order.getOrderId()%></td>
					<td onclick="location.href='adminShoppingDetail.jsp?orderId=<%=order.getOrderId()%>'"><%=order.getOrderCreatedAt().toString().substring(0, 19)%></td>
					<td onclick="location.href='adminShoppingDetail.jsp?orderId=<%=order.getOrderId()%>'"><%=order.getUserId()%></td>
					<td onclick="location.href='adminShoppingDetail.jsp?orderId=<%=order.getOrderId()%>'"><%=order.getPaymentMethod()%></td>
					<td class="total-price" onclick="location.href='adminShoppingDetail.jsp?orderId=<%=order.getOrderId()%>'"><%=String.format("%,d", order.getTotalPrice())%>원</td>
					<td>
					<form method="post" action="adminOrderConfirm.jsp" id="order-form-<%=order.getOrderId()%>">
					    <input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
					    <input type="hidden" name="recentPage" value="adminShopping.jsp">
					    <select name="orderStatus" class="order-status-input" onchange="submitForm(<%= order.getOrderId() %>)">
					        <option value="주문접수" <%= order.getOrderStatus().equals("주문접수") ? "selected" : "" %>>주문접수</option>
					        <option value="배송준비" <%= order.getOrderStatus().equals("배송준비") ? "selected" : "" %>>배송준비</option>
					        <option value="배송중" <%= order.getOrderStatus().equals("배송중") ? "selected" : "" %>>배송증</option>
					        <option value="배송완료" <%= order.getOrderStatus().equals("배송완료") ? "selected" : "" %>>배송완료</option>
					        <option value="구매확정" <%= order.getOrderStatus().equals("구매확정") ? "selected" : "" %>>구매확정</option>
					        <option value="교환" <%= order.getOrderStatus().equals("교환") ? "selected" : "" %>>교환</option>
					        <option value="환불" <%= order.getOrderStatus().equals("환불") ? "selected" : "" %>>환불</option>
					    </select>
					</form>
					</td>
					</tr>
					<%
				}
				%>
				</tbody>
			</table>
		</div>
			<div class="contatiner-pagination">
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
		<form method="get" action="${pageContext.request.contextPath}/adminShopping.jsp" class="form-search">
			<input type="text" id="search" name="search" value="${param.search}" class="input-search" placeholder="아이디로 검색">
			<button type="submit" class="btn-search">검색</button>
		</form>
	</div>
		<% } else { int currentPage = 1;
		  int pageSize = 20;
		  
		  if (request.getParameter("page") != null) {
		    currentPage = Integer.parseInt(request.getParameter("page"));
		  }
		  
		  System.out.println("현재 페이지: " + currentPage);
		  
		  int start = (currentPage - 1) * pageSize + 1; // 시작 인덱스 계산
		  int end = currentPage * pageSize; // 끝 인덱스 계산
		  System.out.println("start: " + start);
		  System.out.println("end: " + end);
		  
		  int totalOrders = orderService.countOrdersByUserId(search);
		  System.out.println("totalUsers: " + totalOrders);
		  
		  // 마지막 페이지는 올림처리 하기 위해 math.ceil메소드 사용. 더블계산을 
		  int totalPages = (int) Math.ceil((double) totalOrders / pageSize); // 전체 페이지 수 계산
		  System.out.println("totalPages: " + totalPages);
	
		List<OrderDTO> orders = orderService.searchOrdersByKeyword(search, start, end);
	%>
	<div class="order-list-container">
		<p class="order-list-label">주문 관리 - 아이디 별 주문 목록</p>
		
		<div class="order-table">
			<table>
				<thead>
					<tr>
						<th>주문번호</th>
						<th>주문 일시</th>
						<th>주문자 아이디</th>
						<th>결제 수단</th>
						<th>주문 금액</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (OrderDTO order : orders) {
						String orderStatus = orderService.getOrder(order.getOrderId()).getOrderStatus();
						String paymentMethod = orderService.getOrder(order.getOrderId()).getPaymentMethod();
					%>
					<tr class="order-component">
					<td onclick="location.href='adminShoppingDetail.jsp?orderId=<%=order.getOrderId()%>'"><%=order.getOrderId()%></td>
					<td onclick="location.href='adminShoppingDetail.jsp?orderId=<%=order.getOrderId()%>'"><%=order.getOrderCreatedAt().toString().substring(0, 19)%></td>
					<td onclick="location.href='adminShoppingDetail.jsp?orderId=<%=order.getOrderId()%>'"><%=order.getUserId()%></td>
					<td onclick="location.href='adminShoppingDetail.jsp?orderId=<%=order.getOrderId()%>'"><%=order.getPaymentMethod()%></td>
					<td class="total-price" onclick="location.href='adminShoppingDetail.jsp?orderId=<%=order.getOrderId()%>'"><%=String.format("%,d", order.getTotalPrice())%>원</td>
					<td>
					<form method="post" action="adminOrderConfirm.jsp" id="order-form-<%=order.getOrderId()%>">
					    <input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
					    <input type="hidden" name="recentPage" value="adminShopping.jsp">
					    <select name="orderStatus" class="order-status-input" onchange="submitForm(<%= order.getOrderId() %>)">
					        <option value="주문접수" <%= order.getOrderStatus().equals("주문접수") ? "selected" : "" %>>주문접수</option>
					        <option value="배송준비" <%= order.getOrderStatus().equals("배송준비") ? "selected" : "" %>>배송준비</option>
					        <option value="배송중" <%= order.getOrderStatus().equals("배송중") ? "selected" : "" %>>배송증</option>
					        <option value="배송완료" <%= order.getOrderStatus().equals("배송완료") ? "selected" : "" %>>배송완료</option>
					        <option value="구매확정" <%= order.getOrderStatus().equals("구매확정") ? "selected" : "" %>>구매확정</option>
					        <option value="교환" <%= order.getOrderStatus().equals("교환") ? "selected" : "" %>>교환</option>
					        <option value="환불" <%= order.getOrderStatus().equals("환불") ? "selected" : "" %>>환불</option>
					    </select>
					</form>
					</td>
					</tr>
					<%
				}
				%>
				</tbody>
			</table>
		</div>
			<div class="contatiner-pagination">
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
		<form method="get" action="${pageContext.request.contextPath}/adminShopping.jsp" class="form-search">
			<input type="text" id="search" name="search" value="${param.search}" class="input-search" placeholder="아이디로 검색">
			<button type="submit" class="btn-search">검색</button>
		</form>
	</div>
	<% } %>
	</div>
</body>

<script>
function submitForm(orderId) {
    document.getElementById("order-form-" + orderId).submit();
}
</script>

<%
}
%>
</html>