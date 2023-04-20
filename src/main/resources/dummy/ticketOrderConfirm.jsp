<%@page import="dto.TicketDTO"%>
<%@page import="service.TicketServiceImpl"%>
<%@page import="service.TicketService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
	String userId = (String)session.getAttribute("loginId");
	String ticketType = request.getParameter("ticketType");
	String paymentMethod = request.getParameter("paymentMethod");
	int ticketNumber = 10;

	System.out.println("userId: " + userId);
	System.out.println("ticketType: " + ticketType);
	System.out.println("paymentMethod: " + paymentMethod);
	System.out.println("ticketNumber: " + ticketNumber);
	
	TicketDTO ticket = new TicketDTO();
	ticket.setUserId(userId);
	ticket.setTicketType(ticketType);
	ticket.setTicketNumber(ticketNumber);
	TicketService ticketService = new TicketServiceImpl();
	ticketService.create(ticket);
	System.out.println(userId + " PT 이용권 주문 생성");
	response.sendRedirect("myTickets.jsp");
%>

<script>
	alert("PT이용권 주문 성공! 결제모듈이 없으니 결제 됐다고 칩시다!");
	location.href = "myOrder.jsp";
</script>

</body>
</html>