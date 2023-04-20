<%@page import="java.text.SimpleDateFormat,
                    java.util.ArrayList,
                    java.util.Collections,
                    java.util.HashMap,
                    java.util.List,
                    java.util.Map,
                    java.util.stream.Collectors"%>
<%@page import="dto.GoodsDTO,
                    dto.OrderDTO,
                    dto.OrderGoodsDTO"%>
<%@page import="repository.GoodsRepository,
                    repository.GoodsRepositoryImpl"%>
<%@page import="service.GoodsService,
                    service.GoodsServiceImpl,
                    service.OrderService,
                    service.OrderServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
String loginId = (String) session.getAttribute("loginId"); // 세션에서 id 값을 읽어옴
if (loginId == null) { // id 값이 null이면 비로그인 상태로 간주
	response.sendRedirect("unauthorized.jsp"); // error.jsp 페이지로 이동
} else if (!"admin".equals(loginId)) {
%>
<script>
	alert("관리자만 이용할 수 있습니다!");
	history.back();
</script>
<%
} else { // 로그인 상태이며 관리자 권한이 있는 경우
	OrderService orderService = new OrderServiceImpl();
%>

<head>
<meta charset="UTF-8">
<title>헬스로운 주문 관리</title>

<style>
body {	
	background-color: #e6e6e6;
}

.order-list-container {
	width: 1000px;
	margin: 15px auto;
}

.order-list-label {
	margin-top: 15px;
	margin-bottom: 15px;
	margin-left: 15px;
	font-size: 18px;
	font-weight: bold;
	display: flex;
	align-items: center;
}

table {
	width: 100%;
	margin: 15px auto;
	max-width: 100%;
	border-collapse: separate;
	overflow: hidden;
}

th {
	background-color: #0077CC;
	color: #ffffff;
	padding: 10px;
	text-align: center;
	border-right: 1px solid #ffffff;
}

td {
	padding: 7px;
	text-align: center;
	border-right: 1px solid #e6e6e6;
	background-color: #ffffff;
}

td:first-child {
	background-color: #f5f5f5;
}

.total-price {
	font-weight: bold;
}
</style>

</head>

<header>
	<%@ include file="adminSidebar.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<%
//검색어 파라미터 추출
String search = request.getParameter("search");

//요청정보 확인
System.out.println("Request URI: " + request.getRequestURI());
System.out.println("Query String: " + request.getQueryString());
System.out.println("Search: " + search);
%>
<body>
    <div class="order-list-container">
        <p class="order-list-label">매출 현황</p>
        
        <div class="order-table">
            <table>
                <thead>
                    <tr>
                        <th>순번</th>
                        <th>날짜</th>
                        <th>결제 건수</th>
                        <th>총 매출</th>
                    </tr>
                </thead>
                <tbody>
					<%
					int totalOrders = 0;
					int totalRevenue = 0;
					Map<String, Integer[]> dailyData = new HashMap<>();

					List<OrderDTO> orders = orderService.getAllOrders();
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

					for (OrderDTO order : orders) {
						String date = dateFormat.format(order.getOrderCreatedAt());
						int price = order.getTotalPrice();

						if (dailyData.containsKey(date)) {
							Integer[] data = dailyData.get(date);
							data[0]++; // 결제 건수 증가
							data[1] += price; // 일 매출 증가
							totalOrders++;
							totalRevenue += price;
						} else {
							dailyData.put(date, new Integer[] { 1, price });
							totalOrders++;
							totalRevenue += price;
						}
					}

					List<Map.Entry<String, Integer[]>> dailyDataList = new ArrayList<>(dailyData.entrySet());
					Collections.sort(dailyDataList, (o1, o2) -> o2.getKey().compareTo(o1.getKey()));

					int count = 1;
					for (Map.Entry<String, Integer[]> data : dailyDataList) {
					%>
					<tr class="order-component">
                            <td><%=count%></td>
                            <td><%=data.getKey()%></td>
                            <td><%=data.getValue()[0]%></td>
                            <td class="total-price"><%=String.format("%,d", data.getValue()[1])%>원</td>
                        </tr>
                        <% count++; %>
                    <% } %>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="2">총 매출</td>
                        <td><%=totalOrders%></td>
                        <td class="total-price"><%=String.format("%,d", totalRevenue)%>원</td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</body>
<%
}
%>
</html>