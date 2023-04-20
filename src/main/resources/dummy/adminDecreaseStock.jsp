<%@page import="service.GoodsServiceImpl"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>

<%
	Long goodsId = Long.parseLong(request.getParameter("goodsId"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	String action = request.getParameter("action");
	GoodsService goodsService = new GoodsServiceImpl();

	if(action.equals("increase")) {
		goodsService.updateGoodsStock(goodsId, quantity);
	} else if(action.equals("decrease")) {
		quantity = quantity * -1;
		goodsService.updateGoodsStock(goodsId, quantity);
	}

	response.sendRedirect("adminGoodsDetail.jsp?id="+goodsId);
%>


</html>