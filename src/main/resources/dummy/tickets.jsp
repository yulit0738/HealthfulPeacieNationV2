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

.menu-tickets, .menu-pt {
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

.ticket-label-container {
	margin: 20px auto;
	border: 1px solid #fff;
	padding: 20px;
}

.ticket-label-header {
	font-size: 24px;
	font-weight: bold;
	border-left: 2px solid #fff;
	padding: 10px 5px;
}

.ticket-label-body {
	line-height: 1.8;
	margin-top: 10px;
	font-size: 14px;
}

.ticket-container {
	margin-top: 40px;
	display: flex;
	justify-content: center;
	margin-bottom: 100px;
}

.ticket-item {
	display: flex;
	justify-content: center;
	align-items: center;
}

.ticket-item-info {
	text-decoration: none;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.ticket-thumbnail {
	width: 100%;
	padding-bottom: 150%;
	background-size: cover;
	background-position: center;
}

.ticket-name {
	margin-top: 10px;
	font-size: 16px;
	color: white;
	text-align: center;
}

.ticket-price {
	margin-top: 5px;
	font-size: 16px;
	font-weight: bold;
	text-align: center;
}

.soldout {
	text-align: center;
	font-size: 12px;
	color: orange;
}

.trainer {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-right: 30px;
}

.trainer img {
	margin: 10px;
	width: 280px;
	margin-bottom: 10px;
}

.ticket-item a {
	text-decoration: none;
	color: #fff
}
</style>

<header>
	<%@ include file="header.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<body>
	<div class="body-container">
		<p class="body-label">메인 > 헬창PT > 퍼스널 트레이너</p>
		<div class="ticket-label-container">
			<div class="ticket-label-header">지옥에서 온 헬창 🔥</div>
			<div class="ticket-label-body">
				<p>근매스와 데피니션을 위해서라면 지옥의 트레이닝을 감수하셔야죠.</p>
				<p>레게노급 헬창들이 여러분을 지옥으로 인도합니다. 자신에게 맞는 트레이너를 선택해보세요.</p>
			</div>
		</div>
		<div class="ticket-container">
			<div class="ticket-item">
				<a href="ticketDetail.jsp?ticketType=minji"
					class="trainer">
					<img src="trainersImages/trainer1.png" alt="트레이너">
					<span><b>정민지</b> 대표이사</span>
				</a>
				<a href="ticketDetail.jsp?ticketType=yoonji"
					class="trainer">
					<img src="trainersImages/trainer2.png" alt="트레이너">
					<span><b>최윤지</b> 선수</span>
				</a>
				<a href="ticketDetail.jsp?ticketType=gwangpal"
					class="trainer">
					<img src="trainersImages/trainer3.png" alt="트레이너">
					<span><b>마광팔</b> 선수</span>
				</a>
			</div>
		</div>
	</div>
</body>
</script>
<footer>
	<%@ include file="footer.jsp"%>
</footer>
</html>