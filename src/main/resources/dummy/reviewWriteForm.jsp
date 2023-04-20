<%@page import="service.GoodsServiceImpl"%>
<%@page import="service.GoodsService"%>
<%@page import="dto.GoodsDTO"%>
<%@page import="dto.OrderGoodsDTO"%>
<%@page import="service.OrderGoodsServiceImpl"%>
<%@page import="service.OrderGoodsService"%>
<%@page import="dto.UserDTO"%>
<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

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

<script>
	document.addEventListener("DOMContentLoaded", function() {
		const starContainer = document.querySelector(".rating-selector");
		const stars = [];
		let selectedStarIndex = -1;

		for (let i = 0; i < 5; i++) {
			const star = document.createElement("img");
			star.src = "images/rating-empty.png";
			star.style.width = "25px";
			star.style.height = "25px";
			star.style.margin = "0 3px";
			star.style.cursor = "pointer";
			star.addEventListener("mouseenter", function() {
				updateStars(i);
			});
			star.addEventListener("click", function() {
				selectedStarIndex = i;
				document.getElementById("rating-input").value = i + 1;
			});
			starContainer.appendChild(star);
			stars.push(star);
		}

		starContainer.addEventListener("mouseleave", function() {
			updateStars(selectedStarIndex);
		});

		function updateStars(index) {
			for (let i = 0; i < 5; i++) {
				if (i <= index) {
					stars[i].src = "images/rating-full.png";
				} else {
					stars[i].src = "images/rating-empty.png";
				}
			}
		}
	});
	
	function validateForm() {
		  const ratingValue = document.getElementById("rating-input").value;
		  if (ratingValue === "0") {
		    alert("별점을 선택해주세요.");
		    return false;
		  }
		  return true;
		}
</script>

</head>

<style>
body {
	background-color: #e6e6e6;
	height: 100%;
}

.side-bar {
	width: 150px;
}

.menu-my-review {
	color: #5F32FF;
	font-weight: bold;
}

.body-container {
	display: flex;
	max-width: 1000px;
	background-color: #fff;
	margin: 0 auto;
	height: 100%;
}

.body-content {
	width: 800px;
	border-left: 1px solid #ddd;
	padding: 20px;
}

.content-head {
	font-weight: bold;
}

.order-goods-info {
	display: flex;
	align-items: center;
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px;
}

.order-goods-thumbnail {
	width: 140px;
	height: 140px;
	background-size: cover;
	background-position: center;
	margin: 0 auto;
}


.rating-selector {
    justify-content: center;
    align-items: center;
    margin-left: 50px;
    text-align: center;
    width: 250px;
    height: 100px;
    border: 1px solid #ddd;
    border-radius: 15px;
}

.rating-text p {
    margin-top: 20px;
    margin-bottom: 10px;
}

.rating-stars {
    display: flex;
}

.review-container {
	width: 100%;
}

form {
	margin-top: 30px;
	padding: 20px;
	box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
	border-radius: 5px;
	line-height: 1.5;
	font-size: 14px;
	color: #333;
	text-align: left;
	background-color: white;
}

input[type="text"] {
	width: 100%;
	height: 25px;
	border: none;
	outline: none;
	padding: 0 5px;
	background-color: #f7f7f7;
	border-bottom: 1px solid #333;
}

input[type="text"]::placeholder {
	color: #c7c7c7;
}

textarea {
	width: 100%;
	margin-top: 10px;
	height: 400px;
	padding: 10px;
	border: none;
	outline: none;
	color: #333;
	border-bottom: 1px solid #333;
	resize: none;
}

textarea::placeholder {
	color: #c7c7c7;
}

input[type="submit"] {
	margin-top: 10px;
	background-color: #0077CC;
	color: white;
	border: none;
	outline: none;
	padding: 5px 10px;
	border-radius: 5px;
	cursor: pointer;
}
/* 입력창 포커스 시 스타일 */
.post-form input[type="text"]:focus, .post-form textarea:focus {
	background-color: #fff;
	border: 2px solid #0077CC;
	box-shadow: none;
}

</style>

<header>
	<%@ include file="header.jsp"%>
</header>

<%
String userId = (String) session.getAttribute("loginId");
UserService userService = new UserServiceImpl();
UserDTO user = userService.getUser(userId);

long orderPk = Long.parseLong(request.getParameter("orderPk"));
OrderGoodsService orderGoodsService = new OrderGoodsServiceImpl();
GoodsService goodsService = new GoodsServiceImpl();
OrderGoodsDTO orderGoods = orderGoodsService.getOrderGoodsByOrderPk(orderPk);
GoodsDTO goods = goodsService.findGoods(orderGoods.getGoodsId());
%>

<body>
	<div class="body-container">
		<div class="side-bar">
			<%@ include file="myPageSidebar.jsp"%>
		</div>
		<div class="body-content">
			<p class="content-head">리뷰 작성</p>
			<hr>
			<div class="order-goods-info">
				<a href="shoppingDetail.jsp?goodsId=<%=goods.getGoodsId()%>"> <img
					src="goodsImages/<%=goods.getThumbnail()%>" alt="상품 이미지"
					class="order-goods-thumbnail">
				</a>
				<div class="order-info">
					<a href="shoppingDetail.jsp?goodsId=<%=goods.getGoodsId()%>">
						<h3><%=goods.getGoodsName()%></h3>
					</a>
					<div class="order-component">
						<%=String.format("%,d", orderGoods.getOrderPrice())%>원 /
						<%=orderGoods.getOrderQuantity()%>개
					</div>
				</div>
				<div class="rating-selector">
					<div class="rating-text">
						<p>구매하신 상품은 어땠나요?</p>
					</div>
					<div id="rating-stars">
						<!-- 별점 선택 기능은 js로 대체 -->
					</div>
				</div>
			</div>
			<div class="review-container">
				<form method="post" action="reviewWritePro.jsp" class="post-form" onsubmit="return validateForm();">
					<input type="hidden" id="rating-input" name="rating" value="0" />
					<input type="hidden" id="goods-id-input" name="goodsId" value="<%=goods.getGoodsId()%>" />
					<input type="hidden" id="orderPk-input" name="orderPk" value="<%= orderPk %>" />
					<textarea id="content" name="reviewContent"
					placeholder="구매하신 상품에 대한 리뷰 내용을 입력해주세요.
					&#13;&#10;
					&#13;&#10;
					해당 상품 자체와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은
					&#13;&#10;
					예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.
					&#13;&#10;
					&#13;&#10;
					꼼꼼히 작성한 리뷰는 다른 회원님들과 판매자에게 큰 도움이 됩니다!"
						required></textarea>
					<br> <input type="submit" value="리뷰 등록">
				</form>

			</div>
		</div>
	</div>
</body>

<footer>
	<%@ include file="footer.jsp"%>
</footer>

</html>