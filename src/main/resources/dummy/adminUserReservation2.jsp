<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dto.ReservationDTO"%>
<%@page import="service.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDate" %>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<meta charset="UTF-8">
<body>
<title>예약 목록</title>
</head>
<body>

<%

request.setCharacterEncoding("UTF-8");
String searchId = request.getParameter("searchId");

String reservationState = null;
 if(request.getParameter("state") != null){
	reservationState = (String) request.getParameter("state");
}



%>



	
	<h2 align>예약 목록</h2>
		<table align="center">
			<tr height="40" align="center">
				<td width="150">예약 번호</td>
				<td width="150">예약자 아이디</td>
				<td width="150">운동할 날짜</td>
				<td width="150">상태</td>
				<td width="150">취소하기</td>
				
			</tr>	
		
	<%
		
					
						ReservationService reservationService = new ReservationServiceImpl();
					List<ReservationDTO> reservationDto = new ArrayList<>();
					List<ReservationDTO> reservationAllDto = new ArrayList<>();
					

					if(searchId == null || searchId.equals("")){
						reservationAllDto = reservationService.getLists();
						
					}else{
						reservationAllDto = reservationService.getListById(searchId);
					}
					
					
					

					if((reservationState == null) || (reservationState.equals("전체예약"))){
						reservationDto = reservationAllDto;
					}else if(reservationState.equals("예약")){
						for(ReservationDTO reservations: reservationAllDto){
							if(reservations.getIsState() == 1 && reservations.getIsAwaiter() == 0){
								reservationDto.add(reservations);
							}
						}
					}else if(reservationState.equals("취소된예약")){
						for(ReservationDTO reservations: reservationAllDto){
							if(reservations.getIsState() == 0 && reservations.getIsAwaiter() == 0){
								reservationDto.add(reservations);
							}
						}
					}else if(reservationState.equals("대기중")){
						for(ReservationDTO reservations: reservationAllDto){
							if(reservations.getIsState() == 0 && reservations.getIsAwaiter() == 1){
								reservationDto.add(reservations);
							}
						}
					}
						
					      int pageSize = 10; //한 페이지에 출력되는 글(리스트) 개수
					      int currentPageNumber = 0;  //현재페이지 int 타입 
						int totalQuestions = reservationDto.size(); //총 게시글 수
						int lastPageQuestions = totalQuestions % 10; //마지막 페이지의 게시글 수
						int lastPageNumber = 0; //밑에 페이지 넘버로 나오는 마지막 숫자         
						if(lastPageQuestions == 0){
						   lastPageNumber = totalQuestions / 10;
						}else{
						   lastPageNumber = (totalQuestions / 10) + 1;
						}
						int onePageQuestionCount = 0;         //현재페이지 게시글 갯수
						int onePageQuestionPerIndex = 0;   //직전 페이지의 마지막 인덱스 번호, 이 다음 수부터 현재 페이지 인덱스로 사용
						int questionIndex = 0; //리스트인덱스 호출 번호 = onePageQuestionPerIndex + onePageQuestionCount

						onePageQuestionPerIndex = ( currentPageNumber -1 ) * 10 ; //시작index = ( intPageNumber -1 ) * 10 
						int countContain=0;

						for(ReservationDTO reservations: reservationDto){
				%>
		<tr height="40" align="center">
			<td><%=reservations.getReservationId() %></td>
			<td><%=reservations.getUserId() %></td>
			<td><%=reservations.getExerciseDateTime() %></td>
			<td><%=reservations.getReservateAtDate() %></td>
			
			
			
			
			
			<% if(reservations.getIsState() == 0){
				if(reservations.getIsAwaiter() == 1){
					%>
					<td>대기중</td>
					<td width="150"><button onclick="if (confirm('예약 상태로 변경합니다.')) { window.location.href = 'reservationUpdatePro.jsp?id=<%=reservations.getReservationId() %>' }"><b>예약으로 변경</b></button>
				
				<%
				}else{
			%>
				<td>취소</td>
				
			<%
			}
			}else{
				%>
				<td></td>
				<td width="150"><button onclick="if (confirm('예약을 취소합니다.')) { window.location.href = 'reservationCancelPro.jsp?id=<%=reservations.getReservationId() %>' }"><b>예약취소</b></button>
				

			<%
			}}
			%>
			
			</tr>





		
	</table>

	<p align="center">
	</p>
	
	
	
	<form action="adminUserReservation2.jsp" method="get">
		<input type="search" name="searchId">
		
		
		<select name="state">
		  <option value="전체예약">전체 예약</option>
		  <option value="예약">예약</option>
		  <option value="취소된예약">취소 예약</option>
		  <option value="대기중">대기중</option>
		</select>
	  <input type="submit" value="검색">
	</form>
	
	
   </p>
</body>
</html>