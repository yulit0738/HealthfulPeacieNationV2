<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="service.*" %>
    <%@ page import="dto.*" %>
    <%@ page import="repository.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 상세 보기</title>
</head>
<body>


<%
long reservationId = Long.parseLong(request.getParameter("id"));
ReservationService reservationService = new ReservationServiceImpl();
ReservationDTO reservationDto = new ReservationDTO();
reservationDto = reservationService.getById(reservationId);




System.out.println(reservationDto.getReservationId());
System.out.println(reservationDto.getIsAwaiter());
System.out.println(reservationDto.getTicketId());
%>

	<h2 align>예약 목록</h2>
		<table align="center">
			<tr height="40" align="center">
				<td width="150">예약 번호</td>
				<td width="150">예약자 아이디</td>
				<td width="150">운동할 날짜</td>
				<td width="150">예약한 시간</td>
				<td width="150">상태</td>
				<td width="150">취소하기</td>
				
			</tr>	
		
		<tr height="40" align="center">
			<td><%=reservationDto.getReservationId() %></td>
			<td><%=reservationDto.getUserId() %></td>
			<td><%=reservationDto.getExerciseDateTime() %></td>
			<td><%=reservationDto.getReservateAtDate() %></td>
			<% if(reservationDto.getIsState() == 0){
				if(reservationDto.getIsAwaiter() == 1){
					%>
					<td>대기중</td>
					<td width="150"><button onclick="if (confirm('예약 상태로 변경합니다.')) { window.location.href = 'reservationUpdatePro.jsp?id=<%=reservationDto.getReservationId() %>' }"><b>예약으로 변경</b></button>
				<td width="150"><button onclick="if (confirm('예약을 취소하시겠습니까?')) { window.location.href = 'reservationRemovePro.jsp?id=<%=reservationDto.getReservationId() %>' }"><b>예약취소</b></button>
				
				<%
				}else{
			%>
				<td>취소됨</td>
			<%
			}
			}else{
				%>
				<td></td>
				<td width="150"><button onclick="if (confirm('예약을 취소하시겠습니까?')) { window.location.href = 'reservationCancelPro.jsp?id=<%=reservationDto.getReservationId() %>' }"><b>예약취소</b></button>
			<%
			}
			%>
		</tr>

	</table>
				<button type="button" onclick="location.href='reservation.jsp'"><b>예약하기</b></button>				
				<button type="button" onclick="location.href='question.jsp'"><b>문의하기</b></button>				
				<button type="button" onclick="location.href='reservationList.jsp'"><b>예약글 목록</b></button>	

	<p align="center">
	</p>

</body>
</html>