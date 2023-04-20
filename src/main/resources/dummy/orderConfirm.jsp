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
if ((String) session.getAttribute("loginId") == null) { // id 값이 null이면 비로그인 상태로 간주
	response.sendRedirect("login.jsp"); // login.jsp 페이지로 이동
}
	
	request.setCharacterEncoding("UTF-8");
	String userId = (String)session.getAttribute("loginId");
	long goodsId = Long.parseLong(request.getParameter("goodsId"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	String paymentMethod = request.getParameter("paymentMethod");
	
	OrderService orderService = new OrderServiceImpl();
	orderService.addOrder(userId, goodsId, quantity, paymentMethod);
	System.out.println(userId + " 단건 주문 생성");
	response.sendRedirect("myOrder.jsp");
%>

<script>
	alert("단건 주문 성공! 결제모듈이 없으니 결제 됐다고 칩시다!");
	location.href = "myOrder.jsp";
</script>

</body>
</html>