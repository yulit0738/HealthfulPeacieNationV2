<%@page import="service.CartServiceImpl"%>
<%@page import="service.CartService"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
	Long cartId = Long.parseLong(request.getParameter("cartId"));
	CartService cartService = new CartServiceImpl();
	cartService.removeGoodsFromCart(cartId);
	
	response.sendRedirect("myCart.jsp");
%>

</body>
</html>