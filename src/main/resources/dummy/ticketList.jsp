<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.time.LocalDate" %>
            <%@page import="java.util.*" %>
        <%@page import="java.sql.*" %>
    <%@page import="dto.*" %>
    <%@page import="service.*" %>
    <%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
</head>

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
	font-size: 24px;
	font-weight: bold;
	animation: shake 2s ease-in-out infinite; /* 애니메이션 지정 */
}

@keyframes shake {
  0% { transform: translateY(-10px); } /* 중간 위치 */
  50% { transform: translateY(0); } /* 애니메이션 시작 위치 */
  100% { transform: translateY(-10px); } /* 중간 위치 */
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
	flex-wrap: wrap;
	justify-content: center;
}

.to-purchase-link {
	color: #5F32FF;
	font-weight: bold;
	margin-bottom: 100px;
}


.order-created-at {
	display: flex;
	font-size: 16px;
	color: #ddd;
}

.order-container {
	display: flex;
	align-items: center;
	width: 750px;
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px;
	margin: 15px;
	transition: background-color 0.3s ease;
}

.order-container:hover {
	background-color: rgba(255,255,255,0.1);
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

.ticket-status-valid {
	margin-left: 10px;
	display: inline-block;
	font-size: 14px;
    background-color: #FF8B8B;
    margin-right: 15px;
    color: #fff;
    border-radius: 5px;
	padding: 3px 10px;
}

.ticket-status-invalid {
	margin-left: 10px;
	display: inline-block;
	font-size: 14px;
    background-color: #ddd;
    margin-right: 15px;
    color: #fff;
    border-radius: 5px;
	padding: 3px 10px;
}

.ticket-number {
	margin-bottom: 5px;
	width: 80px;
	text-align: center;
	padding: 5px 10px;
	border-radius: 20px;
	border: none;
	background-color: orange;
	color: #fff;
}
.submit-btn {
	font-size: 16px;
	font-weight: bold;
	margin-right: 20px;
	padding: 10px 15px;
	border-radius: 20px;
	border: none;
	background-color: #5F32FF;
	color: #fff;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.submit-btn:hover{
	background-color: #4124ad;
}

</style>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String userId = (String) session.getAttribute("loginId");

	TicketService ticketService = new TicketServiceImpl();
	List<TicketDTO> ticketList = new ArrayList<>();
	ticketList = ticketService.findListById(userId);
	
	String clickedYear = request.getParameter("clickedYear");
	String clickedMonth = request.getParameter("clickedMonth");
	String clickedDate = request.getParameter("clickedDate");

	String reservationDate = clickedYear+"-"+clickedMonth+"-"+clickedDate;
	%>
	<div class="body-container">
		<p class="body-label">메인 > 헬창PT > 예약하기</p>
		<div class="ticket-label-container">
			<div class="ticket-label-header">퍼스널 트레이닝 예약 🔖</div>
			<div class="ticket-label-body">
				어딜 보시는 겁니까?<br>
				그건 지방의 <b>잔상</b>입니다만?
			</div>
		</div>
		<%-- 주문 내역이 없을 경우에 대한 예외처리 --%>
			<% if (ticketList.isEmpty()) { %>
		<div class="ticket-head">이용권 없음</div>
		<div class="ticket-container">
			사용 가능한 PT이용권이 없습니다.&nbsp;
			<a href="tickets.jsp" class="to-purchase-link"> 이용권 구매</a>
			<% } else { %>
		<div class="ticket-head">🔽 사용하실 이용권을 선택해주세요 🔽</div>
		<div class="ticket-container">
			<div class="orderlist">
				<%
					long prevOrderId = 0;
	
					for (TicketDTO ticket : ticketList) {
						long ticketId = ticket.getTicketId();
						int ticketNumber = ticket.getTicketNumber();
						String ticketType = ticket.getTicketType();
						Timestamp ticketCreatedAt = ticket.getTicketCreatedAt();
						String thumbnail = "";
						if (ticketType.equals("minji")){
							thumbnail = "trainersImages/trainer1.png";
						} else if (ticketType.equals("yoonji")){
							thumbnail = "trainersImages/trainer2.png";		
						} else if (ticketType.equals("gwangpal")){
							thumbnail = "trainersImages/trainer3.png";		
						}
						String ticketName = "";
						if (ticketType.equals("minji")){
							ticketName = "정민지 퍼스널 트레이닝 이용권";
						} else if (ticketType.equals("yoonji")){
							ticketName = "최윤지 퍼스널 트레이닝 이용권";		
						} else if (ticketType.equals("gwangpal")){
							ticketName = "마광팔 퍼스널 트레이닝 이용권";		
						}
					%>
					<% if(ticketNumber>0) {%>
				<div class="order-container">
					<div class="order-thumbnail"
						style="background-image: url('<%=thumbnail%>')"></div>
					<div class="order-info">
						<div class="ticket-number">
							<span><b><%=ticketNumber%></b></span> / 10 회
						</div>
						<h3><%=ticketName%></h3>
						<div class="order-created-at">
							<%=ticketCreatedAt.toString().substring(0, 10)%>
							구매
						</div>
					</div>
					<form action="reservation.jsp" method="post">
					<input type="hidden" name="ticketId" value="<%= ticketId %>">
					<input type="hidden" name="reservationDate" value="<%=reservationDate%>">
					<input type="submit" value="예약하기" class="submit-btn">
				</form>
				</div>
				<% } } }  %>
			</div>
		</div>
	</div>
</body>

<script>
$(document).ready(function () {
	  $('html, body').animate({
	    scrollTop: $(".ticket-head").offset().top
	  }, 500);
	});
</script>
<footer>
	<%@ include file="footer.jsp"%>
</footer>

</html>