<%@page import="service.CartServiceImpl"%>
<%@page import="service.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
	String userId = (String)session.getAttribute("loginId");
	Long cartId = Long.parseLong(request.getParameter("cartId"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	System.out.println(quantity);
	CartService cartService = new CartServiceImpl();

	cartService.updateCartQuantity(cartId, userId, quantity);
	
%>

<script>
	window.location.href = "myCart.jsp";
</script>

</body>
</html>