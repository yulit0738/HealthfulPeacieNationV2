<%@page import="dto.CartDTO"%>
<%@page import="service.CartService"%>
<%@page import="service.CartServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
if ((String) session.getAttribute("loginId") == null) { // id 값이 null이면 비로그인 상태로 간주
	response.sendRedirect("login.jsp"); // login.jsp 페이지로 이동
%>
<script>
	alert("로그인 후 이용할 수 있습니다!");
	history.back();
</script>
<%
}
%>

<head>
<meta charset="UTF-8">
<title>장바구니에 담기</title>
</head>
<body>
	<%
	String userId = (String) session.getAttribute("loginId");
	long goodsId = Long.parseLong(request.getParameter("goodsId"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));

	CartService cartService = new CartServiceImpl();
	
	if (cartService.findSameGoodsInCart(goodsId, userId) == 0) {
		cartService.addGoodsToCart(userId, goodsId, quantity);
		%>
		<script>
			alert("상품이 장바구니에 담겼습니다!");
			history.back();
		</script>
		<%
	} else {
	%>
	<script>
		if (confirm("이미 장바구니에 담긴 상품입니다. 장바구니로 가시겠습니까?")) {
			location.href = "myCart.jsp";
		} else {
			history.back();
		}
	</script>
	<%
	}
	%>

</body>
</html>