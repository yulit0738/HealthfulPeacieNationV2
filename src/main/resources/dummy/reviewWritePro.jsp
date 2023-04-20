<%@page import="service.GoodsServiceImpl"%>
<%@page import="service.GoodsService"%>
<%@page import="service.ReviewServiceImpl"%>
<%@page import="service.ReviewService"%>
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
%>
<script>
	alert("세션이 만료됐습니다! 로그인 후 이용해주세요.]");
	history.back();
</script>
<%
}
%>

<%
request.setCharacterEncoding("UTF-8");
String userId = (String)session.getAttribute("loginId");
String reviewContent = request.getParameter("reviewContent");
long orderPk = Long.parseLong(request.getParameter("orderPk"));
int rating = Integer.parseInt(request.getParameter("rating"));
long goodsId = Long.parseLong(request.getParameter("goodsId"));

ReviewService reviewService = new ReviewServiceImpl();
reviewService.writeReview(goodsId, userId, orderPk, reviewContent, rating);
GoodsService goodsService = new GoodsServiceImpl();
goodsService.updateGoodsAverageScore(goodsId);

%>


<script>
	alert("리뷰가 작성됐습니다!");
	location.href = "myReview.jsp";
</script>

</body>
</html>