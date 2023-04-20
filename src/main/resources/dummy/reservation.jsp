<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="dto.*"%>
<%@page import="service.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<header>
	<%@ include file="header.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>
<style>

body {
	background-color: #17171f;
	color: white;
}

.menu-tickets, .menu-reservation {
	background-color: #5F32FF;
	color: #fff;
	border-radius: 20px;
	padding: 10px 20px;
}

.body-label {
	font-size: 14px;
	font-weight: bold;
}

.ticket-head {
	margin-top: 50px;
	text-align: center;
	font-size: 20px;
	font-weight: bold;
}

.body-container {
	max-width: 1000px;
	min-height: 800px;
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
.reservation-wrapper {
    display: flex;
    justify-content: center;
    width: 100%;
}

.reservation-container {
	margin-top: 40px;
	justify-content: center;
	background-color: #17171f;
	color: #fff;
	width: 400px;
	height: 450px;
	background-color: #17171f;
	border-radius: 25px;
	padding: 20px;
	box-shadow: 0px 0px 20px #666666;
}

.container-title {
	font-size: 24px;
	font-weight: bold;
	text-align: center;
}

.time-option-container {
	width: 300px;
	display: block;
	margin-left: auto;
	margin-right: auto;
	overflow: hidden;
	height: 250px;
	border: 1px solid rgba(255,255,255,0.5);
	border-radius: 15px;
	padding: 5px;
}

/* 새로운 time-option-container-inner 스타일 생성 */
.time-option-container-inner {
	height: 100%;
	overflow-y: scroll;
}

.time-option {
	justify-content: center;
	font-size: 18px;
	display: flex;
	align-items: center;
	margin-bottom: 5px;
	text-align: center;
}

.time-option label {
	margin-left: 5px;
}

.reservation-submit-btn {
	font-weight: bold;
	font-size: 20px;
	background-color: #5F32FF;
	padding: 8px 25px;
	color: #fff;
	border: none;
	border-radius: 20px;
	text-align: center;
	display: block;
	margin-top: 20px;
	margin-left: auto;
	margin-right: auto;
	cursor: pointer;
	transition: background-color 0.3s ease;
	margin-bottom: 30px;
}

.reservation-submit-btn:hover {
	background-color: orange;
}

.time-option-container-inner::-webkit-scrollbar {
	width: 6px;
}

.time-option-container-inner::-webkit-scrollbar-thumb {
	background-color: #fff;
	border-radius: 3px;
}

.time-option-container-inner::-webkit-scrollbar-track {
	background-color: transparent;
}
/* 사용자 정의 라디오 버튼 스타일 */
.custom-radio {
	position: relative;
}

.custom-radio input[type="radio"] {
	display: none;
}

.custom-radio label:before {
	content: "";
	display: inline-block;
	width: 20px;
	height: 20px;
	border-radius: 50%;
	border: 2px solid #fff;
	margin-right: 5px;
	vertical-align: middle;
}

.custom-radio input[type="radio"]:checked + label:before {
	background-color: #5F32FF;
	border: 2px solid #5F32FF;
}

.custom-radio input[type="radio"]:disabled + label {
	opacity: 0.5;
}
</style>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	%>

	<%
	String reservationDate = request.getParameter("reservationDate");
	String ticketId = request.getParameter("ticketId");
	%>
	<div class="body-container">
		<p class="body-label">메인 > 헬창PT > 예약하기</p>
		<div class="ticket-label-container">
			<div class="ticket-label-header">퍼스널 트레이닝 예약</div>
			<div class="ticket-label-body">
				어딜 보시는 겁니까?<br>
				그건 지방의 <b>잔상</b>입니다만?
			</div>
		</div>
		<div class="reservation-wrapper">
			<form action="reservationPro.jsp" method="post" class="reservation-container">
				<p class="container-title"><%=reservationDate.split("-")[0] + "년 " + reservationDate.split("-")[1] + "월 " + reservationDate.split("-")[2]%>일
					예약
				</p>
				<%
				Timestamp currentTime = new Timestamp(System.currentTimeMillis());
				String currentDateToString = new SimpleDateFormat("yyyy-MM-dd").format(currentTime);
				String currentTimeToString = new SimpleDateFormat("HH:mm:ss").format(currentTime);
				int currentHour = Integer.parseInt(currentTimeToString.split(":")[0]);
				%>
				<div class="time-option-container">
					<div class="time-option-container-inner">
					<%
					for (int i = 7; i < 24; i++) {
						if (currentDateToString.equals(reservationDate)) {
							if (i <= currentHour) {
					%>
					<div class="time-option custom-radio">
						<input type="radio" id="exerciseTime<%=i%>" name="exerciseTime" value="<%=i%>" disabled>
						<label for="exerciseTime<%=i%>"><%=i%>:00</label>
					</div>
					<%
					} else {
					%>
					<div class="time-option custom-radio">
						<input type="radio" id="exerciseTime<%=i%>" name="exerciseTime" value="<%=i%>">
						<label for="exerciseTime<%=i%>"><%=i%>:00</label>
					</div>
					<%
					}
					}
		
					else {
					%>
					<div class="time-option custom-radio">
						<input type="radio" id="exerciseTime<%=i%>" name="exerciseTime" value="<%=i%>">
						<label for="exerciseTime<%=i%>"><%=i%>시</label>
					</div>
					<%
					}
					}
					%>
					</div>
				</div>
				<input type="hidden" name="ticketId" value="<%=ticketId%>"> 
				<input type="hidden" name="reservationDate" value="<%=reservationDate%>">
				<button type="submit" class="reservation-submit-btn">선택한 시간으로 예약하기</button>
			</form>
		</div>
	</div>

</body>
<script>
$(document).ready(function () {
	  $('html, body').animate({
	    scrollTop: $(".ticket-label-header").offset().top
	  }, 500);
	});
</script>
<footer>
	<%@ include file="footer.jsp"%>
</footer>
</html>