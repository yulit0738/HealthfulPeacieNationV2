<%@page import="dto.GoodsDTO"%>
<%@page import="repository.GoodsRepositoryImpl"%>
<%@page import="service.GoodsServiceImpl"%>
<%@page import="service.GoodsService"%>
<%@page import="dto.OrderGoodsDTO"%>
<%@page import="service.OrderGoodsServiceImpl"%>
<%@page import="service.OrderGoodsService"%>
<%@page import="dto.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="service.OrderServiceImpl"%>
<%@page import="service.OrderService"%>
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
request.setCharacterEncoding("UTF-8");
long orderId = Long.parseLong(request.getParameter("orderId"));
OrderGoodsService orderGoodsService = new OrderGoodsServiceImpl();
List<OrderGoodsDTO> orderList = orderGoodsService.getOrderGoodsByOrderId(orderId);

OrderService orderService = new OrderServiceImpl();
OrderDTO order = orderService.getOrder(orderId);
%>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>


<header>
	<%@ include file="adminSidebar.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<style>
body {
	background-color: #e6e6e6;
	font-size: 16px;
}

.container {
	width: 1000px;
	margin: 15px auto;
	background-color: #fff;
	padding: 30px;
	box-shadow: 0px 0px 5px 0px rgba(0, 0, 0, 0.2);
	border-radius: 10px;
}


.btn-back {
	display: block;
	margin-bottom: 20px;
	text-decoration: none;
	font-size: 16px;
	font-weight: bold;
	color: #0077CC;
}

h1 {
	font-size: 32px;
	margin-bottom: 30px;
	text-align: center;
}

.order-info {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.order-label {
    width: 150px;
    margin-right: 30px;
    font-weight: bold;
}

table {
	width: 100%;
	margin-bottom: 30px;
	border-collapse: separate;
	border-spacing: 0;
	border: 1px solid #ddd;
}

th, td {
	padding: 10px;
	text-align: center;
	border-right: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	width: 25%; /* 모든 td의 가로 크기를 25%로 설정 */
}

th {
	background-color: #f2f2f2;
}

tr:nth-child(even) td {
	background-color: #f9f9f9;
}

.total-price {
	font-weight: bold;
}

.order-status {
	font-weight: bold;
	color: #4CAF50;
}

.order-status-input {
	margin-top: 10px;
	padding: 8px 12px;
	background-color: #fff;
	border: 2px solid #0077CC;
	color: #0077CC;
	border-radius: 5px;
	font-size: 14px;
	cursor: pointer;
	transition: background-color 0.2s ease;
}

.order-status-input:hover {
	background-color: #0077CC;
	color: #fff;
}

.order-status-input:active {
	background-color: #0066B3;
	color: #fff;
	border: 2px solid #0066B3;
}

.order-status-select {
	width: 140px;
	padding: 8px 12px;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 14px;
	text-align: center;
}

.order-status-form {
	flex: none; /* flex item이 아닌 flex container로 동작하게 함 */
	margin-left: auto; /* 오른쪽으로 정렬시킴 */
	text-align: right;
}

.order-status-submit {
	display: inline-block;
	margin-top: 10px;
	padding: 8px 12px;
	background-color: #4CAF50;
	color: white;
	font-size: 14px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	padding: 8px 12px;
	background-color: #4CAF50;
	color: white;
	font-size: 14px;
	border: none;
	border-radius: 5px;
}

.order-status-submit:hover {
	background-color: #3e8e41;
}
</style>

<body>
	<div class="container">
	<a href="javascript:history.back();" class="btn-back">
		&lt; 뒤로가기
	</a>
		<h1>주문 상세 정보</h1>
		<div class="order-info">
		<table>
			<tr>
			<th>주문 번호</th>
			<td><%=order.getOrderId()%></td>
			<th>주문자 ID</th>
			<td><%=order.getUserId()%></td>
			</tr>
			<tr>
			<th>주문 일시</th>
			<td><%=order.getOrderCreatedAt().toString().substring(0, 19)%></td>
			<th>결제 수단</th>
			<td><%=order.getPaymentMethod()%></td>
			</tr>
			<tr>
			<th>주문 금액</th>
			<td><%=String.format("%,d", order.getTotalPrice())%>원</td>
			<th>주문 상태</th>
			<td class="order-status"><%=order.getOrderStatus()%></td>
			</tr>
						
		
		</table>
		<div class="order-status-form">
			<form method="post" action="adminOrderConfirm.jsp">
				<input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
				<input type="hidden" name="recentPage" value="adminShoppingDetail.jsp?orderId=<%= order.getOrderId() %>">		
				<select name="orderStatus" class="order-status-select" onchange="submitForm()">
					<option value="주문접수"
						<%=order.getOrderStatus().equals("주문접수") ? "selected" : ""%>>주문접수</option>
					<option value="배송준비"
						<%=order.getOrderStatus().equals("배송준비") ? "selected" : ""%>>배송준비</option>
					<option value="배송중"
						<%=order.getOrderStatus().equals("배송중") ? "selected" : ""%>>배송중</option>
					<option value="배송완료"
						<%=order.getOrderStatus().equals("배송완료") ? "selected" : ""%>>배송완료</option>
					<option value="구매확정"
						<%=order.getOrderStatus().equals("구매확정") ? "selected" : ""%>>구매확정</option>
					<option value="교환"
						<%=order.getOrderStatus().equals("교환") ? "selected" : ""%>>교환</option>
					<option value="환불"
						<%=order.getOrderStatus().equals("환불") ? "selected" : ""%>>환불</option>
				</select>
				<button type="submit" class="order-status-input">상태 변경</button>
			</form>
		</div>
		</div>
		<hr>
		<table>
			<thead>
				<tr>
					<th>상품번호</th>
					<th>상품명</th>
					<th>상품가격</th>
					<th>수량</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (OrderGoodsDTO orderGoods : orderList) {
					GoodsService goodsService = new GoodsServiceImpl();
					;
					GoodsDTO goods = goodsService.findGoods(orderGoods.getGoodsId());
				%>
				<tr>
					<td><%=goods.getGoodsId()%></td>
					<td><%=goods.getGoodsName()%></td>
					<td><%=String.format("%,d", goods.getGoodsCost())%>원</td>
					<td><%=orderGoods.getOrderQuantity()%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
</body>


<%
}
%>
</html>