<%@page import="service.GoodsService"%>
<%@page import="service.GoodsServiceImpl"%>
<%@page import="repository.GoodsRepositoryImpl"%>
<%@page import="repository.GoodsRepository"%>
<%@page import="dto.GoodsDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>헬스로운 쇼핑</title>

<style>
body {
	background-color: #17171f;
	color: white;
}

.menu-shopping {
	background-color: #5F32FF;
	color: #fff;
	border-radius: 20px;
	padding: 10px 20px;
}

.body-label {
	font-size: 14px;
	font-weight: bold;
}

.body-container {
	max-width: 1000px;
	margin: 0 auto;
	align-items: center;
}

.goods-label-container {
	margin: 20px auto;
	border: 1px solid #fff;
	padding: 20px;
}

.goods-label-header {
	font-size: 24px;
	font-weight: bold;
	border-left: 2px solid #fff;
	padding: 10px 5px;
}

.goods-label-body {
	line-height: 1.8;
	margin-top: 10px;
	font-size: 14px;
}

.goods-container {
	margin-top: 40px;
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
}

.goods-item {
	width: 190px;
	height: 260px;
	margin: 20px;
}

.goods-item-info {
	text-decoration: none;
}

.goods-thumbnail {
	width: 100%;
	padding-bottom: 100%;
	background-size: cover;
	background-position: center;
	max-width: 200px;
	max-height: 200px;
}

.goods-name {
	margin-top: 10px;
	font-size: 16px;
	color: white;
}

.goods-price {
	margin-top: 5px;
	font-size: 16px;
	font-weight: bold;
}

.goods-name, .goods-price {
	text-align: center;
}

.soldout {
	text-align: center;
	font-size: 12px;
	color: orange;
}
</style>

<header>
	<%@ include file="header.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<body>
	<div class="body-container">
		<p class="body-label">메인 > 헬창쇼핑</p>
		<div class="goods-label-container">
			<div class="goods-label-header">체고급 헬창용품 🛒</div>
			<div class="goods-label-body">
				득근을 위해, 그리고 근손실을 방지하기 위해서도 좋은 장비를 갖추는 것도 필수입니다.<br> 헬스로운 평화나라에는
				소비자의 근손실 방지를 최대의 가치로 삼습니다. (사실 그냥 사란 뜻)
			</div>
		</div>
		<div class="goods-container">
			<%-- 상품 정보 가져오기 --%>
			<%
			GoodsService goodsService = new GoodsServiceImpl();
			List<GoodsDTO> goodsList = goodsService.findAllGoods();
			for (GoodsDTO goods : goodsList) {
				System.out.println("불러온 상품 아이디: " + goods.getGoodsId());
			%>
			<div class="goods-item">
				<%-- 해당 상품의 id값이 할당된 shoppingDetail.jsp 페이지로 이동할 수 있도록 a태그 사용 --%>
				<a href="shoppingDetail.jsp?goodsId=<%=goods.getGoodsId()%>"
					class="goods-item-info"> <%-- 썸네일(가로세로 2:3비율)바로 아래에 상품명이 나오도록 합니다. --%>
					<div class="goods-thumbnail"
						style="background-image: url('goodsImages/<%=goods.getThumbnail()%>')"></div>
					<div class="goods-name">
						<%=goods.getGoodsName()%>
					</div>
				</a>
				<%-- 그 아래에 가격이 표기되도록 합니다. --%>
				<div class="goods-price">
					<%=String.format("%,d", goods.getGoodsCost())%>원
				</div>
				<%
				if (goods.getGoodsStock() < 1) {
				%>
				<div class="soldout">일시품절</div>
				<%
				}
				%>
			</div>
			<%
			}
			%>
		</div>
	</div>
</body>

<footer>
	<%@ include file="footer.jsp"%>
</footer>

</html>