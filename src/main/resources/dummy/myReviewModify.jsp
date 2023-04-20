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
Long reviewId = Long.parseLong(request.getParameter("reviewId"));
String reviewContent = request.getParameter("reviewContent");

ReviewService reviewService = new ReviewServiceImpl();
reviewService.modifyReview(reviewId, reviewContent);
%>

<script>
	alert("리뷰가 수정됐습니다!");
	location.href = "myReview.jsp";
</script>
</body>
</html>