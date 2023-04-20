<%@page import="service.GoodsServiceImpl"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dto.GoodsDTO"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Add Goods</title>
</head>
<body>
	<%
	String directory = "D:/jspworkspace/HealthfulPeacieNation/src/main/webapp/goodsImages";
	int sizeLimit = 100 * 1024 * 1024; // 100MB 제한

	MultipartRequest multi = new MultipartRequest(request, directory, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());

	String goodsName = multi.getParameter("goodsName");
	int goodsCost = Integer.parseInt(multi.getParameter("goodsCost"));
	int goodsStock = Integer.parseInt(multi.getParameter("goodsStock"));
	String goodsThumbnail = multi.getFilesystemName("goodsThumbnail");
	String goodsImage1 = multi.getFilesystemName("goodsImage1");
	String goodsImage2 = multi.getFilesystemName("goodsImage2");
	String goodsDescription = multi.getParameter("goodsDescription");
	String goodsCategory = multi.getParameter("goodsCategory");

	GoodsService goodsService = new GoodsServiceImpl();
	goodsService.addGoods(goodsName, goodsCost, goodsStock, goodsThumbnail, goodsImage1, goodsImage2, goodsDescription, goodsCategory);

	response.sendRedirect("adminGoods.jsp");
	%>
</body>
</html>