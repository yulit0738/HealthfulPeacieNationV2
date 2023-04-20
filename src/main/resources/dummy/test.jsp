<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test Page</title>
</head>
<body>
  <% 
  String clickedYear = request.getParameter("clickedYear"); // 클릭한 년도 데이터 받기
  String clickedMonth = request.getParameter("clickedMonth"); // 클릭한 월 데이터 받기
  String clickedDate = request.getParameter("clickedDate"); // 클릭한 날짜 데이터 받기
  System.out.println("Clicked year: " + clickedYear); // 콘솔에 클릭한 년도 출력
  System.out.println("Clicked month: " + clickedMonth); // 콘솔에 클릭한 월 출력
  System.out.println("Clicked date: " + clickedDate); // 콘솔에 클릭한 날짜 출력
    
  %>
</body>
</html>