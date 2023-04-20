<%@page import="service.TicketServiceImpl"%>
<%@page import="service.TicketService"%>
<%@page import="service.ReservationServiceImpl"%>
<%@page import="service.ReservationService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대기를 예약으로 업데이트</title>
</head>
<body>
<%

request.setCharacterEncoding("UTF-8");
long reservationId = Long.parseLong(request.getParameter("id"));

ReservationService reservationService = new ReservationServiceImpl();
int update = reservationService.waiterUpgrade(reservationId);
long ticketId = Long.parseLong(request.getParameter("ticketId"));
TicketService ticketService = new TicketServiceImpl();
int ticketNumber = ticketService.findById(ticketId).getTicketNumber();

if(update == 0 ){
	ticketNumber--;
	ticketService.update(ticketId, (ticketNumber));
	System.out.println("예약번호 "+reservationId+"번이 대기중에서 예약 확정으로 변경되었습니다.");
%>
	<script type="text/javascript">
		alert("예약되었습니다.");
		location.href='index.jsp';
	</script>
	<%
}	else{
	%>
	<script type="text/javascript">
		alert("정원을 초과했습니다. 예약할 수 없습니다.");
		history.back();
	</script>
	<%
}



%>
</body>
</html>