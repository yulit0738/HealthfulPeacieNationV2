<%@page import="java.sql.Timestamp"%>
<%@page import="dto.TicketDTO"%>
<%@page import="service.TicketService"%>
<%@page import="service.TicketServiceImpl"%>
<%@page
	import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
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

.menu-my-tickets {
	color: #5F32FF;
	font-weight: bold;
}

.order-created-at {
	display: inline-block;
	font-size: 20px;
	font-weight: bold;
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
	cursor: pointer;
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

.ticket-detail-box {
	text-align: center;
}

.ticket-number {
	margin-right: 20px;
	color: orange;
}

.ticket-reservation-btn {
	margin-right: 20px;
	margin-top: 10px;
	color: #fff;
	padding: 5px 15px;
	border: none;
	border-radius: 20px;
	background-color: #5F32FF;
	font-size: 18px;
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.ticket-reservation-btn:hover {
	background-color: #4124ad;
}
</style>

<header>
	<%@ include file="header.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<%
String userId = (String) session.getAttribute("loginId");
TicketService ticketService = new TicketServiceImpl();
List<TicketDTO> tickets = ticketService.findListById(userId);
%>

<body>
	<div class="body-container">
		<div class="side-bar">
			<%@ include file="myPageSidebar.jsp"%>
		</div>
		<div class="body-content">
			<p class="content-head">나의 이용권</p>
			<hr>
			<%-- 주문 내역이 없을 경우에 대한 예외처리 --%>
			<% if (tickets.isEmpty()) { %>
			<p>PT서비스 이용권 구매 이력이 없습니다.</p>
			<% } else { %>
			<div class="orderlist">
				<%
					long prevOrderId = 0;
	
					for (TicketDTO ticket : tickets) {
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
							ticketName = "정민지 PT 10회 이용권";
						} else if (ticketType.equals("yoonji")){
							ticketName = "최윤지 PT 10회 이용권";		
						} else if (ticketType.equals("gwangpal")){
							ticketName = "마광팔 PT 10회 이용권";		
						}
						int cost = 0;
						if (ticketType.equals("minji")){
							cost = 330000;
						} else if (ticketType.equals("yoonji")){
							cost = 290000;		
						} else if (ticketType.equals("gwangpal")){
							cost = 790000;		
						}
					%>
				<div class="order-head">
					<div class="order-created-at">
						<%=ticketCreatedAt.toString().substring(0,16)%>
						구매
					</div>
					<%if(ticketNumber>0) { %>
					<div class="ticket-status-valid">이용중</div>
					<%} else {%>
					<div class="ticket-status-invalid">만료</div>
					<%} %>
				</div>
				<div class="order-container">
					<div class="order-thumbnail"
						style="background-image: url('<%=thumbnail%>')" onclick="location.href='ticketDetail.jsp?ticketType=<%=ticketType%>'"></div>
					<div class="order-info">
						<a href="ticketDetail.jsp?ticketType=<%=ticketType%>"><h3><%=ticketName%></h3></a>
						<div class="order-component">
							<%=String.format("%,d", cost)%>원
						</div>
					</div>
					<div class="ticket-detail-box">
						<div class="ticket-number">
							<span><b><%= ticketNumber %>회</b></span> 사용 가능
						</div>
						<div>
							<button onclick="location.href='reservationCalendar.jsp'" class="ticket-reservation-btn">예약하기</button>
						</div>
					</div>
				</div>
				<% } }  %>
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