<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="service.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
request.setCharacterEncoding("UTF-8");

String directory = "D:/jspworkspace/HealthfulPeacieNation/src/main/webapp/goodsImages";
int sizeLimit = 100 * 1024 * 1024; // 100MB 제한

MultipartRequest multi = new MultipartRequest(request, directory, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());

long goodsId = Long.parseLong(multi.getParameter("goodsId"));
String goodsName = multi.getParameter("goodsName");
int goodsCost = Integer.parseInt(multi.getParameter("goodsCost"));
String goodsDescription = multi.getParameter("goodsDescription");
String goodsThumbnail = multi.getFilesystemName("goodsThumbnail");
String goodsImage1 = multi.getFilesystemName("goodsImage1");
String goodsImage2 = multi.getFilesystemName("goodsImage2");
String oldThumbnail = multi.getParameter("oldThumbnail");
String oldImage1 = multi.getParameter("oldImage1");
String oldImage2 = multi.getParameter("oldImage2");

if(goodsThumbnail == null){
	System.out.println("goodsThumbnail 이 null임");
	if(oldThumbnail == null) {
		System.out.println("oldThumbnail 이 null임");
		goodsThumbnail = "No-Image-Placeholder.png";
		System.out.println("goodsThumbnail 을 No-Image-Placeholder.png로 대체함");
	} else {
		goodsThumbnail = oldThumbnail;
		System.out.println("goodsThumbnail 을 oldThumbnail 로 대체함");
	}
}

if(goodsImage1 == null){
	System.out.println("goodsImage1 이 null임");
	if(oldImage1.equals("null")) {
		System.out.println("oldImage1 이 null임");
		goodsImage1 = "No-Image-Placeholder.png";
		System.out.println("goodsImage1 을 No-Image-Placeholder.png로 대체함");
	} else {
		goodsImage1 = oldImage1;
		System.out.println("goodsImage1 을 oldImage1 로 대체함");
	}
	System.out.println(goodsImage1);
	
}if(goodsImage2 == null){
	System.out.println("goodsImage2 이 null임");
	if(oldImage2.equals("null")) {
		System.out.println("oldImage2 이 null임");
		goodsImage2 = "No-Image-Placeholder.png";
		System.out.println("goodsImage2 을 No-Image-Placeholder.png로 대체함");
	} else {
		goodsImage2 = oldImage2;
		System.out.println("goodsImage2 을 oldImage2 로 대체함");
	}
	System.out.println(goodsImage2);
}

GoodsService goodsService = new GoodsServiceImpl();
goodsService.modifyGoods(goodsId, goodsName, goodsCost, goodsThumbnail, goodsImage1, goodsImage2, goodsDescription);
%>

<script>

	alert("상품 정보가 수정됐습니다!");
	location.href = "adminGoods.jsp";
	
</script>

</body>
</html>