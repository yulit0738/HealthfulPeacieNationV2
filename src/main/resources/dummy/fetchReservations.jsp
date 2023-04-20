<%@page import="dto.*"%>
<%@page import="service.*"%>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String userId = (String)session.getAttribute("loginId");
ReservationService reservationService = new ReservationServiceImpl();
List<ReservationDTO> reservationList = reservationService.getListById(userId);

Gson gson = new Gson();

//회원 목록을 JSON 형식으로 변환
String jsonReservationList = gson.toJson(reservationList); 

//응답의 Content-Type을 JSON으로 설정
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

//JSON 형식의 회원 목록을 응답으로 전송
response.getWriter().write(jsonReservationList);
%>