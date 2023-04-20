<%@page import="dto.GoodsDTO"%>
<%@page import="service.GoodsServiceImpl"%>
<%@page import="service.GoodsService"%>
<%@page import="dto.CartDTO"%>
<%@page import="java.util.List"%>
<%@page import="service.CartServiceImpl"%>
<%@page import="service.CartService"%>
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
<title>마이페이지</title>
</head>

<style>

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

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
	font-size:12px;
	cursot: pointer;
}

.cart-delete-button {
	text-decoration: none;
	color: orange;
}

.calculator-container {
	text-align: right;
	margin-bottom: 20px;
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

.order-container {	
	margin-top: 40px;
	margin-right: 50px;
	text-align: right;
}

.payment-method-input {
	padding: 5px 10px;
	margin-bottom: 15px;
	text-align: center;
	border-radius: 15px;
}

.order-cart-button {
	border: none;
	border-radius: 25px;
	width: 180px;
	height: 45px;
	background-color: #5F32FF;
	color: #fff;
	font-size: 18px;
	cursor: pointer;
	margin-bottom: 100px;
	transition: background-color 0.3s ease;
}

.order-cart-button:hover {
	background-color: #4124ad;
}


</style>

<header>
	<%@ include file="header.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<%
if ((String) session.getAttribute("loginId") != null) {
	String userId = (String) session.getAttribute("loginId");
	CartService cartService = new CartServiceImpl();
	GoodsService goodsService = new GoodsServiceImpl();
	List<CartDTO> cartList = cartService.getCartList(userId);
%>

<body>
	<div class="body-container">
		<div class="side-bar">
			<%@ include file="myPageSidebar.jsp"%>
		</div>
		<div class="body-content">
			<p class="content-head">장바구니</p>
			<hr>
			<div class="cartlist-table">
				<table>
				<thead>
					<tr>
						<th>대표이미지</th>
						<th>제품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>합계</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<%
					int count = 1;
					for (CartDTO cart : cartList) {
						GoodsDTO goods = goodsService.findGoods(cart.getGoodsId());
					%>
	
					<tr>
						<td>
							<div class="cartlist-thumbnail">
								<div class="cart-thumbnail"
									style="background-image: url('goodsImages/<%=goods.getThumbnail()%>')"></div>
							</div>
						</td>
						<td style="width: 30%";><a class="goodsName"
							href="shoppingDetail.jsp?goodsId=<%=goods.getGoodsId()%>"><%=goods.getGoodsName()%></a></td>
						<td style="width: 15%"><%= String.format("%,d", goods.getGoodsCost())%></td>
						<td style="width: 10%">
						<form action="myFixCartQuantity.jsp?cartId=<%= cart.getCartId()%>" method="post">
							<input type="hidden" name="goodsId" value="<%= goods.getGoodsId() %>">
							<div class="quantity-input">
							<input type="number" name="quantity" class="quantity-input-field" min="1" max="<%= goods.getGoodsStock() %>" value="<%=cart.getCartQuantity()%>">
							</div>
							<button type="submit" class="update-to-cart-button">변경</button>
						</form>			
						</td>
							<td style="width: 15%">
							<%= String.format("%,d", goods.getGoodsCost()*cart.getCartQuantity())%>
						</td>
						<td style="width: 5%">
						<a href="myDeleteCart.jsp?cartId=<%= cart.getCartId()%>" class="cart-delete-button">삭제</a>
						<td>
					</tr>
					<%
				}
				%>
				</tbody>
			</table>
			</div>
			<hr>
			<p class="content-head">합계</p>
			<div class="calculator-container">
				<span class="total-price-label">예상 결제 금액 : </span>
				<span class="total-price">
					<%
					int totalPrice = 0;
					for (CartDTO cart : cartList) {
						GoodsDTO goods = goodsService.findGoods(cart.getGoodsId());
						totalPrice += goods.getGoodsCost()*cart.getCartQuantity();
					}
					%>
					<%= String.format("%,d", totalPrice) %>원
				</span>
			</div>
			<hr>
			<p class="content-head">결제</p>
			<div class="order-container">
				<form method="post" action="orderCart.jsp?userId=<%= userId%>">
					결제수단 <select name="paymentMethod"
						class="payment-method-input">
						<option value="신용카드">신용카드</option>
						<option value="무통장입금">무통장입금</option>
						<option value="계좌이체">계좌이체</option>
						<option value="토스페이">토스페이</option>
						<option value="카카오페이">카카오페이</option>
						<option value="외상">외상</option>
						<option value="저신용 풀할부">저신용 풀할부</option>
						<option value="비트코인">비트코인</option>
						<option value="도토리">도토리🌰</option>
						<option value="물물교환(조개껍질)">물물교환(조개껍질)</option>
					</select><br>
					<button type="submit" class="order-cart-button">모두 주문하기</button>
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