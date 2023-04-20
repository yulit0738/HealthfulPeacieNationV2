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
GoodsService goodsService = new GoodsServiceImpl();
List<GoodsDTO> goodslist = goodsService.findAllGoods();
%>

<head>
<meta charset="UTF-8">
<title>헬스로운 상품 관리</title>

<style>
body {
	background-color: #e6e6e6;
}

.goods-list-container {
	width: 1000px;
	margin: 15px auto;
}

.goods-list-label {
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

.goods-thumbnail {
	display: inline-block;
	width: 80px;
	height: 80px;
	background-size: cover;
	background-position: center;
	margin: 0 auto;
}

a {
	color: #0077CC;
	font-weight: bold;
}

th {
	background-color: #0077CC;
	color: #ffffff;
	padding: 10px;
	text-align: center;
	border-right: 1px solid #ffffff;
}

td {
	padding-left: 7px;
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

td:nth-of-type(4) {
	text-align: left;
}

.add-goods-button {
	float: right;
	margin-bottom: 15px;
	padding: 10px 15px;
	background-color: #0077CC;
	color: #ffffff;
	font-size: 14px;
	font-weight: bold;
	text-decoration: none;
	border-radius: 5px;
}

.add-goods-button:hover {
	background-color: #005999;
	text-decoration: none;
}
</style>

</head>

<header>
	<%@ include file="adminSidebar.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<body>
	<div class="goods-list-container">
		<p class="goods-list-label">상품 관리 - 상품 목록</p>
		<a href="adminAddGoods.jsp" class="add-goods-button">상품 등록</a>
		<div class="goods-table">
			<table>
				<thead>
					<tr>
						<th>순번</th>
						<th>대표이미지</th>
						<th>상품번호</th>
						<th>제품명</th>
						<th>가격</th>
						<th>재고</th>
						<th>점수</th>
						<th>누적 판매량</th>
					</tr>
				</thead>
				<tbody>
					<%
					int count = 1;
					for (GoodsDTO goods : goodslist) {
					%>

					<tr>
						<td><%=count++%></td>
						<td><a href="adminGoodsDetail.jsp?id=<%=goods.getGoodsId()%>">
								<img src="goodsImages/<%=goods.getThumbnail()%>" alt="상품 이미지"
								class="goods-thumbnail"></td>
						<td><a class="goodsId"
							href="adminGoodsDetail.jsp?id=<%=goods.getGoodsId()%>"><%=goods.getGoodsId()%></a></td>
						<td><a class="goodsName"
							href="adminGoodsDetail.jsp?id=<%=goods.getGoodsId()%>"><%=goods.getGoodsName()%></a></td>
						<td><%=goods.getGoodsCost()%></td>
						<td><%=goods.getGoodsStock()%></td>
						<td><%=goods.getGoodsScore()%></td>
						<td><%=goods.getGoodsSales()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
</body>

<%
}
%>
</html>