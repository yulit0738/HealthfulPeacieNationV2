<%@page import="service.*"%>
<%@page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 확정 취소</title>
</head>
<body>
<p>cancel page</p>
<%

request.setCharacterEncoding("UTF-8");
String stringReservationId = request.getParameter("id");
int reservationId = Integer.parseInt(stringReservationId);
String recentPage = request.getParameter("recentPage");
System.out.println(recentPage);
out.println("예약번호 "+reservationId+"가 취소되었습니다.");

ReservationService reservationService = new ReservationServiceImpl();
TicketService ticketService = new TicketServiceImpl();
ReservationDTO reservationDto = new ReservationDTO();
reservationDto = reservationService.getById(reservationId);
long ticketId = reservationDto.getTicketId();

int ticketNumber = ticketService.findById(ticketId).getTicketNumber() +1;
reservationService.cancelReservation(reservationId);
ticketService.update(ticketId, ticketNumber);
response.sendRedirect(recentPage);
%>


</body>
</html>