<%@page import="service.OrderServiceImpl"%>
<%@page import="service.OrderService"%>
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
	long orderId = Long.parseLong(request.getParameter("orderId"));
	String orderStatus = request.getParameter("orderStatus");
	String recentPage = request.getParameter("recentPage");
	System.out.println("recent page: " + recentPage);

	OrderService orderService = new OrderServiceImpl();
	orderService.updateOrderStatus(orderId, orderStatus);
	System.out.println(orderId + " 주문건 상태 변경 -> " + orderStatus);
	response.sendRedirect(recentPage);
%>

</body>
</html>