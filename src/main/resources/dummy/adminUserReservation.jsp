<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="dto.TicketDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dto.ReservationDTO"%>
<%@page import="service.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDate"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 목록</title>
<style>

body {
	background-color: #e6e6e6;
}

.reservation-list-container {
	width: 1000px;
	margin: 15px auto;
	margin-bottom: 100px;
}

.reservation-list-label {
	margin-top: 15px;
	margin-bottom: 15px;
	margin-left: 15px;
	font-size: 18px;
	font-weight: bold;
    display: flex;
    align-items: center;
}

.normal {
}

.boundary {
	border-top: 1px solid #0077CC;
}

table {
	width: 100%;
	margin: 15px auto;
	max-width: 100%;
	border-collapse: separate;
	border-spacing: 0;
	overflow: hidden;
}

th {
	background-color: #0077CC;
	color: #ffffff;
	padding: 10px;
	text-align: center;
	border-right: 1px solid #ffffff;
}

th:last-child {
	border-right: 1px solid #0077CC;
}

td {
	padding: 7px;
	text-align: center;
	border-right: 1px solid #e6e6e6;
	background-color: #fff;
}

td:first-child {
	background-color: #f5f5f5;
	border-left: 1px solid #0077CC;
}

td:last-child {
	border-right: 1px solid #0077CC;
}

td:nth-of-type(3) {
	text-align: left;
}

.last-row {
	border-bottom: 1px solid #0077CC;
}
</style>
</head>

<header>
	<%@ include file="adminSidebar.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String searchId = request.getParameter("searchId");

	String reservationState = "전체예약";
	if (request.getParameter("state") != null) {
		reservationState = (String) request.getParameter("state");
	}
	%>
<div class="reservation-list-container">
	<p class="reservation-list-label">예약 목록</p>
	<table align="center">	
		<thead>
			<tr height="40" align="center">
				<th>예약번호</th>
				<th>트레이너</th>
				<th>예약자</th>
				<th>예약시간</th>
				<th>접수시간</th>
				<th>상태</th>
				<th>상태변경</th>
			</tr>
		</thead>
		<tbody>
		<%
		ReservationService reservationService = new ReservationServiceImpl();
				List<ReservationDTO> reservationDto = new ArrayList<>();
				List<ReservationDTO> reservationAllDto = new ArrayList<>();
				TicketService ticketService = new TicketServiceImpl();
				List<TicketDTO> ticketList = ticketService.findAllTickets();
				if (searchId == null || searchId.equals("")) {
			reservationAllDto = reservationService.getLists();
				} else {
			reservationAllDto = reservationService.getListById(searchId);
				}
				for (ReservationDTO reservation : reservationAllDto) {
			if (reservationState.equals("예약")) {
				if (reservation.getIsState() == 1 && reservation.getIsAwaiter() == 0) {
			reservationDto.add(reservation);
				}
			} else if (reservationState.equals("취소된예약")) {
				if (reservation.getIsState() == 0 && reservation.getIsAwaiter() == 0) {
			reservationDto.add(reservation);
				}
			} else if (reservationState.equals("대기중")) {
				if (reservation.getIsState() == 0 && reservation.getIsAwaiter() == 1) {
			reservationDto.add(reservation);
				}
			} else {
				reservationDto.add(reservation);
			}
				}
				
			    String prevTrainer = "";
			    String prevExerciseDateTime = "";
			    String prevCssClass = "";
			    String cssClass = "";
			    int reservationSize = reservationDto.size();
			    int currentIndex = 0;
				
				String trainer = "";
				//티켓 타입에 따라 한글 이름으로 변환하는 부분
			    for (ReservationDTO reservation : reservationDto) {
			        for (TicketDTO ticket : ticketList) {
			            if (reservation.getTicketId() == ticket.getTicketId()) {
			                trainer = ticket.getTicketType();

			                if (ticket.getTicketType().equals("minji")) {
			                    trainer = "정민지";
			                } else if (ticket.getTicketType().equals("yoonji")) {
			                    trainer = "최윤지";
			                } else if (ticket.getTicketType().equals("gwangpal")) {
			                    trainer = "마광팔";
			                }

			              	// 예약시간과 트레이너 이름이 동일한 경우에 대한 처리
							if (prevTrainer.equals(trainer)
									&& prevExerciseDateTime.equals(reservation.getExerciseDateTime().toString())) {
								cssClass = "normal";
							} else {
								cssClass = "boundary";
							}
							prevTrainer = trainer;
							prevExerciseDateTime = reservation.getExerciseDateTime().toString();

					        currentIndex++;
							//마지막 행인 경우 CSS 클래스에 'last-row' 추가
					        if (currentIndex == reservationSize) {
					            cssClass += " last-row";
					        }
		%>
		<tr>
			<td class="<%=cssClass%>"><%=reservation.getReservationId()%></td>
			<td class="<%=cssClass%>"><%=trainer%></td>
			<td class="<%=cssClass%>"><%=reservation.getUserId()%></td>
			<td class="<%=cssClass%>"><%=reservation.getExerciseDateTime()%></td>
			<td class="<%=cssClass%>"><%=reservation.getReservateAtDate()%></td>
			<%
			if (reservation.getIsState() == 0) {
				if (reservation.getIsAwaiter() == 1) {
			%>
			<td class="<%=cssClass%>">대기중</td>
			<td class="<%=cssClass%>"><button
					onclick="if (confirm('예약 상태로 변경합니다.')) { window.location.href = 'reservationUpdatePro.jsp?id=<%=reservation.getReservationId()%>&recentPage=adminUserReservation.jsp&ticketId=<%=reservation.getTicketId() %>' }">
					<b>예약가능</b>
				</button> <%
 } else {
 %>
			<td class="<%=cssClass%>">취소</td>
			<td class="<%=cssClass%>"></td>
			<%
			}
			} else {
			%>
			<td class="<%=cssClass%>">예약확정</td>
			<td class="<%=cssClass%>"><button
					onclick="if (confirm('예약을 취소합니다.')) { window.location.href = 'reservationCancelPro.jsp?id=<%=reservation.getReservationId()%>&recentPage=adminUserReservation.jsp' }">
					<b>예약취소</b>
				</button> <%
 }
 %>
		</tr>
		<%
		}
		}
		}
		%>
		</tbody>
	</table>
	<p align="center"></p>
	<form action="adminUserReservation.jsp" method="get">
		<input type="search" name="searchId"> <select name="state">
			<option value="전체예약"
				<%=reservationState == null || reservationState.equals("전체예약") ? "selected" : ""%>>전체
				예약</option>
			<option value="예약"
				<%=reservationState != null && reservationState.equals("예약") ? "selected" : ""%>>예약</option>
			<option value="취소된예약"
				<%=reservationState != null && reservationState.equals("취소된예약") ? "selected" : ""%>>취소
				예약</option>
			<option value="대기중"
				<%=reservationState != null && reservationState.equals("대기중") ? "selected" : ""%>>대기중</option>
		</select> <input type="submit" value="검색">
	</form>
</div>
</body>
</html>