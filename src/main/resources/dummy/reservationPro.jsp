<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@page import="service.*" %>
<%@page import ="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 처리 - reservPro.jsp</title>
</head>
<style>
</style>
<body  align="center" >
   <%
   request.setCharacterEncoding("UTF-8");
      
      //***************************************************&&유저가 같은 시간대에 예약한 내역이 있다면 예약불가 추가
      
   	String userId = (String) session.getAttribute("loginId");
      
   	long ticketId = Long.parseLong(request.getParameter("ticketId"));
   	String reservationDate = request.getParameter("reservationDate");
   	String reservationTime = request.getParameter("exerciseTime");
   	String reservationDateTime = reservationDate +" "+ reservationTime + ":00:00.000000000";
   	
   	
   	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSSSSS");
   	
   	System.out.println("ticketId reservation: "+ticketId);
   	System.out.println("시간 reservation" +reservationDate);
   	
   	java.util.Date date = sdf.parse(reservationDateTime);
   	Timestamp exerceseDateTime = new Timestamp(date.getTime());
   	

   	TicketService ticketService = new TicketServiceImpl();
   	int ticketNumber = ticketService.findById(ticketId).getTicketNumber();

   	
         ReservationService reservationService = new ReservationServiceImpl();
         ReservationDTO reservationDto = new ReservationDTO(userId, exerceseDateTime, ticketId);
        

   	int reservationSuccess = reservationService.makeReservation(reservationDto);
   	if(reservationSuccess < 0 ){
   %>
		<script type="text/javascript">
			alert("예약에 실패했습니다.");
			history.back();
		</script>
		<%
	}else if(reservationSuccess == 2 ){
		%>
		<script type="text/javascript">
			alert("정원을 초과했습니다. 대기자로 예약되었습니다.");
			history.back();
		</script>
		<%
	}else if(reservationSuccess == 3 ){
		%>
		<script type="text/javascript">
			alert("중복 예약입니다");
			history.back();
		</script>
		<%
	}else if(reservationSuccess == 4 ){
		%>
		<script type="text/javascript">
			alert("대기자로 예약된 내역이 있습니다.");
			history.back();
		</script>
		<%
	}else  if(reservationSuccess == 1 ){
		ticketNumber--;
		ticketService.update(ticketId, (ticketNumber));
		%>
		<script type="text/javascript">
			alert("정상적으로 예약됐습니다!");
			location.href = "reservationCalendar.jsp";
		</script>
		<%
		
		
	}
	
	
%>
      
</body>
</html>