<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>

<style>
body {
	background-color: #e6e6e6;
	height: 100%;
}
.side-bar{
	width: 150px;
}
.body-container {
	display: flex;
	max-width: 1000px;
	background-color: #fff;
	margin: 0 auto;
	height: 100%;
}
.body-content {
	border-left: 1px solid darkgray;
	padding: 20px;
}
.content-head {
	font-weight: bold;
}
.menu-contact {
	color: #5F32FF;
	font-weight: bold;
}
</style>

<header>
	<%@ include file="header.jsp"%>
</header>

<body>
	<div class="body-container">
		<div class="side-bar">
			<%@ include file="myPageSidebar.jsp"%>
		</div>
		<div class="body-content">
			<p class="content-head">주문 내역</p>
			주문 내역을 출력하는 비즈니스 로직 담당.<br>
			ex)<br>
			OrderService orderService = new OrderSerivceImpl();<br>
			GoodsService goodsService = new goodsService();<br>
			List(OrderDTO) list = orderService.getOrderListById(userId);<br>
			for(OrderDTO order : list){<br>
				img src="goodsService.findGood(order.getGoodsId)"<br>
				order.getGoodsName<br>
				order.getPrices<br>
				order.getCreatedAt<br>
			}<br>
			
		</div>
	</div>
</body>

<footer>
	<%@ include file="footer.jsp"%>
</footer>

</html>