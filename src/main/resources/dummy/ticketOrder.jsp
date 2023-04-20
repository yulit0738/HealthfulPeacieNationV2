<%@page import="dto.GoodsDTO"%>
<%@page import="service.GoodsServiceImpl"%>
<%@page import="service.GoodsService"%>
<%@page import="dto.OrderGoodsDTO"%>
<%@page import="service.OrderServiceImpl"%>
<%@page import="service.OrderService"%>
<%@page import="dto.UserDTO"%>
<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<%
if ((String) session.getAttribute("loginId") == null) { // id 값이 null이면 비로그인 상태로 간주
	response.sendRedirect("login.jsp"); // login.jsp 페이지로 이동
%>

<script>
	alert("로그인 후 이용할 수 있습니다!");
	history.back();
</script>
<%
}
%>

<head>
<meta charset="UTF-8">
<title>PT이용권 구매</title>
</head>
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
	width: 800px;
	border-left: 1px solid #ddd;
	padding: 20px;
}

.content-head {
	font-weight: bold;
}

.menu-my-Cart {
	color: #5F32FF;
	font-weight: bold;
}

table {
	width: 100%;
	margin: 15px auto;
	max-width: 100%;
	border-collapse: separate;
	overflow: hidden;
	text-align: center;
}

.cart-thumbnail {
	display: inline-block;
	width: 80px;
	height: 80px;
	background-size: cover;
	background-position: center;
	margin: 0 auto;
}

.quantity-input-field {
	width: 40px;
	text-align: center;
}

.update-to-cart-button {
	font-size: 12px;
	cursot: pointer;
}

.cart-delete-button {
	text-decoration: none;
	color: orange;
}

.calculator-container {
	text-align: right;
}

.total-price-label {
	font-size: 20px;
}

.total-price {
	margin-right: 50px;
	font-size: 24px;
	color: #5F32FF;
	font-weight: bold;
}

.order-button {
	margin-top: 40px;
	text-align: center;
}

.order-cart-button {
	border: none;
	border-radius: 25px;
	width: 150px;
	height: 45px;
	background-color: #5F32FF;
	color: #fff;
	font-size: 18px;
	cursor: pointer;
	margin-bottom: 100px;
}

.order-cart-button-soldout {
	border: none;
	border-radius: 25px;
	width: 150px;
	height: 45px;
	background-color: #ddd;
	color: #fff;
	font-size: 18px;
	margin-bottom: 100px;
}
</style>
<header>
	<%@ include file="header.jsp"%>
</header>
<%
if ((String) session.getAttribute("loginId") != null) {
	String userId = (String) session.getAttribute("loginId");
	String ticketType = request.getParameter("ticketType");
	String thumbnail = "";
	if (ticketType.equals("minji")){
		thumbnail = "trainersImages/trainer1.png";
	} else if (ticketType.equals("yoonji")){
		thumbnail = "trainersImages/trainer2.png";		
	} else if (ticketType.equals("gwangpal")){
		thumbnail = "trainersImages/trainer3.png";		
	}
	String ticketName = "";
	if (ticketType.equals("minji")){
		ticketName = "정민지 PT 10회 이용권";
	} else if (ticketType.equals("yoonji")){
		ticketName = "최윤지 PT 10회 이용권";		
	} else if (ticketType.equals("gwangpal")){
		ticketName = "마광팔 PT 10회 이용권";		
	}
	int cost = 0;
	if (ticketType.equals("minji")){
		cost = 330000;
	} else if (ticketType.equals("yoonji")){
		cost = 290000;		
	} else if (ticketType.equals("gwangpal")){
		cost = 790000;		
	}
	
%>

<body>
	<div class="body-container">
		<div class="side-bar">
			<%@ include file="myPageSidebar.jsp"%>
		</div>
		<div class="body-content">
			<p class="content-head">PT 이용권 주문하기</p>
			<hr>
			<div class="order-form">
				<form method="post" action="ticketOrderConfirm.jsp">
					<table>
						<thead>
							<tr>
								<th>대표이미지</th>
								<th>서비스</th>
								<th>가격</th>
								<th>횟수</th>
								<th>결제수단</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<div class="cartlist-thumbnail">
										<div class="cart-thumbnail"	style="background-image: url('<%=thumbnail%>')"></div>
									</div>
								</td>
								<td style="width: 30%"><a class="goodsName" href="ticketDetail.jsp?ticketType=<%=ticketType%>"><%=ticketName%></a></td>
								<td style="width: 15%"><%=String.format("%,d", cost)%></td>
								<td style="width: 10%"><input type="hidden" name="ticketType" value="<%=ticketType%>">10회</td>
								<td>
									<div class="order-form-row">
										<select name="paymentMethod" class="order-form-input">
											<option value="신용카드">신용카드</option>
											<option value="무통장입금">무통장입금</option>
											<option value="계좌이체">계좌이체</option>
											<option value="토스페이">토스페이</option>
											<option value="카카오페이">카카오페이</option>
											<option value="외상">외상</option>
											<option value="저신용 풀할부">저신용 풀할부</option>
											<option value="도토리">도토리🌰</option>
											<option value="비트코인">비트코인</option>
											<option value="물물교환(조개껍질)">물물교환(조개껍질)</option>
										</select>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="order-button">
						<button type="submit" class="order-cart-button">주문하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<%
}
%>

<footer>
	<%@ include file="footer.jsp"%>
</footer>
</html>