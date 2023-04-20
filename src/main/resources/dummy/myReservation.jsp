<%@page import="service.TicketService"%>
<%@page import="service.TicketServiceImpl"%>
<%@page import="dto.ReservationDTO"%>
<%@page import="service.ReservationServiceImpl"%>
<%@page import="service.ReservationService"%>
<%@page import="java.sql.*"%>
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
.side-bar{
	width: 150px;
}
.body-container {
	display: flex;
	max-width: 1000px;
	background-color: #fff;
	margin: 0 auto;
	height: 100%;
}
.body-content {
	border-left: 1px solid darkgray;
	padding: 20px;
}
.content-head {
	font-weight: bold;
}
.menu-my-reservation {
	color: #5F32FF;
	font-weight: bold;
}
.reservation-table {
	width: 750px;
	text-align: center;
	border-collapse: collapse;
}

.reservation-table th, td {
	border-bottom: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

.reservation-table th {
	background-color: #f2f2f2;
	font-weight: bold;
}
.reservation-table tr:hover {
	background-color: #f5f5f5;
}

.reservation-table th:nth-child(1), td:nth-child(1) {
	width: 70px;
	text-align: center;
}

.reservation-table th:nth-child(5), td:nth-child(5) {
	width: 60px;
	text-align: center;
}

.reservation-confirm {
	font-weight: bold;
	padding: 3px 5px;
	background-color: #5F32FF;
	border-radius: 5px;
    transition: background-color 0.3s;
}

.reservation-confirm a {
	color: #fff;
	font-size: 14px;
}

.reservation-confirm:hover {
	background-color: #4124ad;
}

.reservation-cancel {
	font-weight: bold;
	padding: 3px 5px;
	background-color: #FF8B8B;
	border-radius: 5px;
    transition: background-color 0.3s;
}

.reservation-cancel:hover {
    background-color: #FF3C3C;
}

.reservation-cancel a {
	color: #fff;
	font-size: 14px;
}

.reservation-info {
	margin-top: 50px;
	text-align: center;
	color: orange;
	margin-bottom: 100px;
}
.point-color {
	background-color: #3ADF00;
	color: #fff;
}
.normal {
}

</style>

<header>
	<%@ include file="header.jsp"%>
</header>

<%
String userId = (String)session.getAttribute("loginId");
long reservationId = 0;
if(request.getParameter("id") != null){
	reservationId = Long.parseLong(request.getParameter("id"));
}
String cssClass = "";
ReservationService reservationService = new ReservationServiceImpl();
List<ReservationDTO> reservationList = reservationService.getListById(userId);
%>

<body>
	<div class="body-container">
		<div class="side-bar">
			<%@ include file="myPageSidebar.jsp"%>
		</div>
		<div class="body-content">
			<p class="content-head">예약 내역</p>
			<hr>
			<%-- 예약 내역이 없을 경우에 대한 예외처리 --%>
		    <% if (reservationList.isEmpty()) { %>
		        <p>예약 내역이 없습니다.</p>
		    <% } else { %>
		    <!-- 예약 내역 출력 -->
			<div class="information-table">
			<table class="reservation-table">
				<thead>
					<th>예약번호</th>
					<th>트레이너</th>
					<th>예약시간</th>
					<th>예약상태</th>
					<th>이용권</th>
					<th>접수시간</th>	
					<th>
				</thead>			
			<%
				for (ReservationDTO reservation : reservationList){
					if(reservationId != reservation.getReservationId()){
	            		cssClass = "normal";
					} else {
						cssClass = "point-color";
					}
					TicketService ticketService = new TicketServiceImpl();
					String ticketType = ticketService.findById(reservation.getTicketId()).getTicketType();
					
					Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
					if(reservation.getExerciseDateTime().after(currentTimestamp)){
					if(ticketType.equals("minji")){
						ticketType = "정민지 대표";
					} else if(ticketType.equals("yoonji")){
						ticketType = "최윤지 선수";
					} else if(ticketType.equals("gwangpal")){
						ticketType = "마광팔 선수";
					}
					String isState = "";
					if(reservation.getIsState() == 1 && reservation.getIsAwaiter() == 0){
						isState = "예약확정";
					} else if(reservation.getIsState() == 0 && reservation.getIsAwaiter() == 1){
						isState = "예약대기";
					} else {
						isState = "취소";
					}
					%>
				<tbody>
					<td class="<%=cssClass%>"><%= reservation.getReservationId() %></td> 
					<td class="<%=cssClass%>"><%= ticketType %></td> 
					<td class="<%=cssClass%>"><%= reservation.getExerciseDateTime().toString().substring(2,16) %></td> 
					<td class="<%=cssClass%>"><%= isState %></td> 
					<td class="<%=cssClass%>"><%= reservation.getTicketId() %></td> 
					<td class="<%=cssClass%>"><%= reservation.getReservateAtDate().toString().substring(2,16) %></td>	
					<% if(reservation.getIsState() == 1 && reservation.getIsAwaiter() == 0) {%>				
					<td class="<%=cssClass%>">
					<div class="reservation-cancel">
	           	  	  <a href="reservationCancelPro.jsp?id=<%=reservation.getReservationId() %>&recentPage=myReservation.jsp">취소</a>
	               </div>
               </td>
               <%
               }else if(reservation.getIsState() == 0 && reservation.getIsAwaiter() == 1) {
                  boolean check = reservationService.changeList(reservation.getReservationId());
                  if (check == true){
                  
               %>      
               <td class="<%=cssClass%>">
	               <div class="reservation-confirm">
	            	   <a href="reservationUpdatePro.jsp?id=<%=reservation.getReservationId() %>&recentPage=myReservation.jsp&ticketId=<%=reservation.getTicketId() %>">확정</a>
	               </div>
               </td>
               <% } else {%>
               <td class="<%=cssClass%>"></td>
               <% } } else {%>
               <td class="<%=cssClass%>"></td>
               <% } %>
				</tbody>
					<%
				} }
			%>
			</table>
			<div class="reservation-info">─── 현재시간 이후의 예약건만 조회합니다 ───</div>
			</div>
			<% } %>
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