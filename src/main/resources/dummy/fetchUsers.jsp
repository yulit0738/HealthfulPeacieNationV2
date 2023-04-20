<%@page import="dto.UserDTO"%>
<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
UserService userService = new UserServiceImpl();
List<UserDTO> userList = userService.getUserList();

Gson gson = new Gson();

//회원 목록을 JSON 형식으로 변환
String jsonUserList = gson.toJson(userList); 

//응답의 Content-Type을 JSON으로 설정
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

//JSON 형식의 회원 목록을 응답으로 전송
response.getWriter().write(jsonUserList);
%>