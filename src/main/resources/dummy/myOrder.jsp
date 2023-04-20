<%@page import="dto.GoodsDTO"%>
<%@page import="service.OrderGoodsServiceImpl"%>
<%@page import="service.OrderGoodsService"%>
<%@page
	import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<%@page import="dto.OrderDTO"%>
<%@page import="service.GoodsService"%>
<%@page import="service.GoodsServiceImpl"%>
<%@page import="dto.OrderGoodsDTO"%>
<%@page import="java.util.List"%>
<%@page import="service.OrderService"%>
<%@page import="service.OrderServiceImpl"%>
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
	min-height: auto;
	background-color: #fff;
	margin: 0 auto;
	height: 100%;
	max-width: 1000px;
}

.body-content {
	width: 800px;
	min-height: 700px;
	border-left: 1px solid #ddd;
	padding: 20px;
	margin-bottom: 100px;
}

.content-head {
	font-weight: bold;
}

.menu-my-order {
	color: #5F32FF;
	font-weight: bold;
}

.order-created-at {
	display: inline-block;
	font-size: 20px;
	font-weight: bold;
}

.order-payment-method {
	margin-left: 10px;
	display: inline-block;
	background-color: orange;
	color: white;
	font-size: 14px;
	padding: 3px 10px;
	border-radius: 15px;
}

.order-container {
	display: flex;
	align-items: center;
	width: 750px;
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px;
	margin: 15px;
}

.order-status {
	margin-left: 15px;
	margin-right: 20px;
	font-weight: bold;
	color: white;
	background-color: #3ADF00;
	padding: 5px 10px;
	border-radius: 15px;
}

.order-thumbnail {
	display: block;
	width: 100px;
	height: 100px;
	background-size: cover;
	background-position: center;
	margin: 0 auto;
}

.order-info {
	margin-left: 20px;
	display: flex;
	flex-direction: column;
	flex-grow: 1;
	justify-content: center;
}

.order-info h3 {
	margin: 0;
}

.order-info .order-component {
	margin: 5px 0;
}

.refund-claim {
	margin-left: 10px;
	display: inline-block;
	font-size: 14px;
    background-color: #FF8B8B;
    margin-right: 15px;
    color: #fff;
    border-radius: 5px;
	padding: 3px 10px;
    transition: background-color 0.3s;
}

.refund-claim:hover {
    background-color: #FF3C3C;
}

.refund-claim-btn {
	background-color: transparent;
	border: none;
	color: #fff;
    cursor: pointer;
}

.exchange-refund-claim {
	margin-left: 10px;
	display: inline-block;
	font-size: 14px;
    background-color: #93C8FF;
    margin-right: 15px;
    color: #fff;
    border-radius: 5px;
	padding: 3px 10px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.exchange-refund-claim:hover {
    background-color: #3394E1;
}

.exchange-in-progress,
.refund-in-progress {
	margin-left: 10px;
	display: inline-block;
	font-size: 14px;
    background-color: #bfbfbf;
    margin-right: 15px;
    color: #fff;
    border-radius: 5px;
	padding: 3px 10px;
    cursor: not-allowed;
}

.review-btn {
	margin-left: 15px;
	margin-right: 20px;
	padding: 5px 10px;
	border-radius: 5px;
	border: 1px solid #ddd;
	cursor: pointer;
}
</style>

<header>
	<%@ include file="header.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<%
String userId = (String) session.getAttribute("loginId");
OrderService orderService = new OrderServiceImpl();
GoodsService goodsService = new GoodsServiceImpl();
OrderGoodsService orderGoodsService = new OrderGoodsServiceImpl();
List<OrderGoodsDTO> orderGoodsList = orderGoodsService.getOrderGoodsByUserId(userId);
%>

<body>
	<div class="body-container">
		<div class="side-bar">
			<%@ include file="myPageSidebar.jsp"%>
		</div>
		<div class="body-content">
			<p class="content-head">주문 내역</p>
			<hr>
			<%-- 주문 내역이 없을 경우에 대한 예외처리 --%>
		    <% if (orderGoodsList.isEmpty()) { %>
		        <p>주문 내역이 없습니다.</p>
		    <% } else { %>
				<div class="orderlist">
					<%
					long prevOrderId = 0;
	
					for (OrderGoodsDTO orderGoods : orderGoodsList) {
						long goodsId = orderGoods.getGoodsId();
						GoodsDTO goods = goodsService.findGoods(goodsId);
						String orderThumbnail = goods.getThumbnail();
						long orderId = orderGoods.getOrderId();
						OrderDTO order = orderService.getOrder(orderId);
						String orderCreatedAt = orderGoods.getOrderCreatedAt().toString().substring(0, 19);
						String goodsName = goods.getGoodsName();
						String orderQuantity = String.valueOf(orderGoods.getOrderQuantity());
						int orderPrice = orderGoods.getOrderPrice();
						String reviewWritten = orderGoods.getReviewWritten();
						String orderStatus = order.getOrderStatus();
						String paymentMethod = order.getPaymentMethod();
	
						if (prevOrderId != orderId) { // 이전 주문과 다른 주문인 경우에만 박스를 추가함
							if (prevOrderId != 0) { // 이전 주문이 끝난 경우 닫는 </div> 추가
					}
					prevOrderId = orderId;
					%>
					<div class="order-head">
						<div class="order-created-at">
							<%=orderCreatedAt%>
							주문
						</div>
						<div class="order-payment-method">
							<%=paymentMethod%>
						</div>					
						<%if(orderStatus.equals("주문접수")||orderStatus.equals("배송준비")||orderStatus.equals("배송중")) { %>
							<div class="refund-claim">
							<form method="post" action="adminOrderConfirm.jsp">
								<input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
								<input type="hidden" name="orderStatus" value="환불">		
								<input type="hidden" name="recentPage" value="myOrder.jsp">								
								<button type="submit" class="refund-claim-btn">구매취소</button>
							</form>
							</div>
						<%} else if (orderStatus.equals("배송완료")) {%>
							<div class="exchange-refund-claim">
							<form method="post" action="adminOrderConfirm.jsp">
								<input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
								<input type="hidden" name="orderStatus" value="교환">		
								<input type="hidden" name="recentPage" value="myOrder.jsp">								
								<button type="submit" class="refund-claim-btn">교환</button>
							</form>
							</div>					
						<%} else if (orderStatus.equals("교환")) {%>
							<div class="exchange-in-progress">
							교환 중
							</div>				
						<%} else if (orderStatus.equals("환불")) {%>
							<div class="refund-in-progress">
							환불완료
							</div>		
						<%} %>
					</div>
					<div class="order-container">
						<div class="order-status"><%=orderStatus%></div>
						<div class="order-thumbnail"
							style="background-image: url('goodsImages/<%=orderThumbnail%>')"></div>
						<div class="order-info">
							<h3><%=goodsName%></h3>
							<div class="order-component">
								<%=String.format("%,d", orderPrice)%>원 /
								<%=orderQuantity%>개
							</div>
						</div>
						<%if (!orderStatus.equals("주문접수")&&!orderStatus.equals("배송준비")&&!orderStatus.equals("배송중")&&reviewWritten.equals("N")) {%>	
						<div class="review-btn" onclick="location.href='reviewWriteForm.jsp?orderPk=<%=orderGoods.getOrderPk()%>'">
						리뷰작성
						</div>
						<% } %>
					</div>
					<%
					} else { // 이전 주문과 같은 주문인 경우, 추가적인 주문 상품 정보만 추가함
					%>
					<div class="order-container">
						<div class="order-status"><%=orderStatus%></div>
						<div class="order-thumbnail"
							style="background-image: url('goodsImages/<%=orderThumbnail%>')"></div>
						<div class="order-info">
							<h3><%=goodsName%></h3>
							<div class="order-component">
								<%=String.format("%,d", orderPrice)%>원 /
								<%=orderQuantity%>개
							</div>
						</div>
						<%if (!orderStatus.equals("주문접수")&&!orderStatus.equals("배송준비")&&!orderStatus.equals("배송중")&&reviewWritten.equals("N")) {%>	
						<div class="review-btn" onclick="location.href='reviewWriteForm.jsp?orderPk=<%=orderGoods.getOrderPk()%>'">
						리뷰작성
						</div>
						<% } %>
					</div>
					<%
					}
					}
					if (prevOrderId != 0) { // 마지막 주문이 끝난 경우 닫는 </div> 추가
					%>
				</div>
				<%
				}
			}
			%>
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