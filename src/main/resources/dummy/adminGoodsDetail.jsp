<%@page import="dto.GoodsDTO"%>
<%@page import="repository.GoodsRepositoryImpl"%>
<%@page import="repository.GoodsRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<header>
	<%@ include file="adminSidebar.jsp"%>
</header>


<style>
body {
	background-color: #e6e6e6;
}

.goods-detail-container {
	max-width: 1000px;
	padding: 20px;
	margin: 0 auto;
	align-items: center;
	background-color: #fff;
	box-sizing: border-box;
}

.goods-detail-label {
	margin-top: 15px;
	margin-bottom: 15px;
	margin-left: 15px;
	font-size: 18px;
	font-weight: bold;
    display: flex;
    align-items: center;
}

.btn-back {
	margin-bottom: 20px;
	text-decoration: none;
	font-size: 16px;
	font-weight: bold;
	color: #0077CC;
}


.goods-top-section {
	margin-top: 40px;
	display: flex;
	margin-bottom: 40px;
}

.goods-top-section-first {
	width: 300px;
}

.goods-thumbnail {
	width: 100%;
	padding-bottom: 100%;
	background-size: cover;
	background-position: center;
}

.goods-top-section-second {
	width: 300px;
	padding: 10px 30px;
}

.goods-name {
	font-size: 20px;
	font-weight: bold;
}

.goods-detail-rating {
	margin-top: 20px;
}

.goods-detail-rating-star {
	width: 24px;
}

.current-stock-label {

}

.goods-top-section-third {
	width: 300px;
	max-width: 300px;
}

.modify-menu-container {
	background-color: rgb(0, 0, 0, 0.2);
	width: 100%;
	height: 100%;
	border-radius: 15px;
	padding: 20px;
	box-sizing: border-box;
	display: flex;
	flex-direction: column;
	justify-content: center;
	text-align: center;
}

.quantity-label {
	margin-bottom: 5px;
	font-size: 14px;
	color: rgb(0, 0, 0, 0.6);
}

.quantity-input {
	align-items: center;
	width: 200px;
	height: 40px;
	background-color: white;
	border-radius: 5px;
	border: none;
	outline: none;
	overflow: hidden;
	font-size: 16px;
	text-align: center;
}

.add-to-cart-button {
	width: 250px;
	margin-top: 20px;
	padding: 10px 20px;
	font-size: 16px;
	font-weight: bold;
	color: white;
	background-color: #007bff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.add-to-cart-button:hover {
	background-color: #0069d9;
}

.modify-button {
	width: 250px;
	margin-top: 20px;
	padding: 10px 0;
	font-size: 16px;
	font-weight: bold;
	color: white;
	background-color: #ffc107;
	border: none;
	border-radius: 5px;
	text-align: center;
	text-decoration: none;
	cursor: pointer;
	transition: background-color 0.3s;
}

.delete-button {
	width: 250px;
	margin-top: 20px;
	padding: 10px 0;
	font-size: 16px;
	font-weight: bold;
	color: white;
	background-color: #ff4242;
	border: none;
	border-radius: 5px;
	text-align: center;
	text-decoration: none;
	cursor: pointer;
	transition: background-color 0.3s;
}

.modify-button:hover, .delete-button:hover {
	background-color: #5F32FF;
}

.copy-link-button {
	width: 250px;
	margin-top: 20px;
	padding: 10px 20px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.3s;
}

.copy-link-button:hover {
	background-color: #0069d9;
}

.goods-bottom-section {
	min-height: 500px;
}

.goods-bottom-section-label {
	padding: 20px;
	font-size: 20px;
	font-weight: bold;
}
</style>

<body>
	<div class="goods-detail-container">
		<a href="javascript:history.back();" class="btn-back"> &lt; 뒤로가기 </a>
		<p class="goods-detail-label">상품 관리 - 상품 상세정보</p>
		<div class="goods-top-section">
			<%-- 상품 정보 가져오기 --%>
			<%
			GoodsRepository goodsRepository = new GoodsRepositoryImpl();
			long goodsId = Integer.parseInt(request.getParameter("id"));
			GoodsDTO goods = goodsRepository.findById(goodsId);
			%>
			
			<div class="goods-top-section-first">
				<div class="goods-thumbnail" style="background-image: url('goodsImages/<%=goods.getThumbnail()%>')"></div>
			</div>
			
			<div class="goods-top-section-second">
			
				<div class="goods-name">
					<%= goods.getGoodsName() %>
				</div>

				<div class="goods-detail-rating">
				    <%-- 별점 구현 --%>
				    <% double rating = Math.round(goods.getGoodsScore() * 2) / 2.0; %>
				    <% int fullStarCount = (int) rating; %>
				    <% boolean hasHalfStar = (rating - fullStarCount) >= 0.5; %>
				    <% int emptyStarCount = 5 - fullStarCount - (hasHalfStar ? 1 : 0); %>
				    <% for (int i = 1; i <= fullStarCount; i++) { %>
				        <img class="goods-detail-rating-star" src="images/rating-full.png" alt="별점">
				    <% } %>
				    <% if (hasHalfStar) { %>
				        <img class="goods-detail-rating-star" src="images/rating-half.png" alt="별점">
				    <% } %>
				    <%-- 별점 수치 구현 --%>
				    <span class="goods-detail-rating-score"> (<%= String.format("%.1f", goods.getGoodsScore()) %>) </span>
				</div>
				<span class="current-stock-label">재고:</span>
				<span class="current-stock"><%=goods.getGoodsStock() %></span>개
			</div>	
			<div class="goods-top-section-third">
				<div class="modify-menu-container">
					<%-- 수량 입력 --%>
						<label class="quantity-label">재고 추가/차감</label>
						<form id="stock-form" action="adminFixStock.jsp" method="post">
							<input type="hidden" name="goodsId" value="<%= goods.getGoodsId() %>">
							<input type="number" class="quantity-input" min="1" name="quantity" value="1">
							<button type="button" class="add-to-cart-button" name="action" value="increase" onclick="submitForm('increase')">재고 추가</button>
							<button type="button" class="add-to-cart-button" name="action" value="decrease" onclick="submitForm('decrease')">재고 차감</button>
						</form>
					<%-- 상품 수정 --%>
					<a href="adminGoodsUpdateForm.jsp?goodsId=<%= goods.getGoodsId() %>" class="modify-button">상품 정보 수정</a>
					<%-- 상품 제거 --%>
					<a href="adminGoodsDelete.jsp?goodsId=<%= goods.getGoodsId() %>" class="delete-button">상품 제거</a>
				</div>
			</div>
		</div>
		<div class="goods-bottom-section">
			<hr>
			<div class="goods-bottom-section-label">제품 설명</div>
			<div class="goods-description"><%= goods.getGoodsDescription() %></div>
		</div>
	</div>
</body>

<script>
function submitForm(action) {
    document.getElementById('stock-form').action = 'adminFixStock.jsp?action=' + action;
    document.getElementById('stock-form').submit();
  }
</script>
</html>