<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>

<style>
.myPageSidebar {
	padding: 15px;
	max-width: 150px;
	background-color: rgb(0, 0, 0, 0.03);
	height: 100%;
}
.mypage-title {
	text-align: center;
	font-weight: bold;
}

.sidebar-hr {
	border-top: 1px solid #ddd;
}

li {
	padding-top: 10px;
	padding-bottom: 10px;
	list-style-type: none;
	font-size: 14px;
}

.first-li {
	margin-top: 40px;
}

li:hover a {
  color: #5F32FF;
}

a {
	color: rgb(0, 0, 0, 0.7);
	text-decoration: none;
}

ul {
  padding-left: 5px;
  margin-top: 0;
}

</style>

<body>
	<div class="myPageSidebar">
		<div class="mypage-title">
			<p>마이페이지</p>
		</div>
		<div class="menu-group">
			<li class="first-li">쇼핑</li>
			<ul>
			  <li><a href="myOrder.jsp" class="menu-my-order">주문 내역</a></li>
			  <li><a href="myCart.jsp" class="menu-my-Cart">장바구니</a></li>
			  <li><a href="myReview.jsp" class="menu-my-review">나의 리뷰</a></li>
			</ul>
		</div>
		<hr class="sidebar-hr">
		<div class="menu-group">
			<li>예약</li>
			<ul>
			<li><a href="myTickets.jsp" class="menu-my-tickets">나의 이용권</a></li>
			<li><a href="myReservation.jsp" class="menu-my-reservation">예약 내역</a></li>
			</ul>
		</div>
		<hr class="sidebar-hr">
		<div class="menu-group">
			<li><a href="myQuestionList.jsp" class="menu-my-question-list">나의 문의</a></li>
		</div>
		<hr class="sidebar-hr">
		<div class="menu-group">
			<li><a href="myInfoPwcheck.jsp" class="menu-modify-information">회원정보</a></li>
		</div>
	</div>
</body>
</html>