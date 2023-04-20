<%@page import="service.*"%>
<%@page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대기 예약 삭제</title>
</head>
<body>

<h1>대기 대기 대기 대기 예약 삭제</h1>
<%


request.setCharacterEncoding("UTF-8");
String stringReservationId = request.getParameter("id");
int reservationId = Integer.parseInt(stringReservationId);

ReservationService reservationService = new ReservationServiceImpl();
reservationService.cancelReservation(reservationId);
out.println("예약번호 "+reservationId+"가 취소되었습니다.");
response.sendRedirect("reservationCalendar.jsp");
%>
</body>
</html>