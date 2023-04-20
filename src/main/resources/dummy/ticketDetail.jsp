<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지옥에서 온 헬창</title>
</head>

<header>
	<%@ include file="header.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<style>
body {
	background-color: #17171f;
	color: white;
}

.menu-tickets, .menu-pt {
	background-color: #5F32FF;
	color: #fff;
	border-radius: 20px;
	padding: 10px 20px;
}

.body-label {
	font-size: 14px;
	font-weight: bold;
}

.body-container {
	max-width: 1000px;
	margin: 0 auto;
	align-items: center;
	margin-bottom: 100px;
}

.goods-top-section {
	margin-top: 40px;
	display: flex;
	margin-bottom: 40px;
}

.goods-top-section-first {
	width: 300px;
}

.goods-thumbnail {
	width: 100%;
	padding-bottom: 100%;
	background-size: cover;
	background-position: center;
}

.goods-top-section-second {
	width: 300px;
	padding: 10px 30px;
}

.goods-name {
	font-size: 20px;
	font-weight: bold;
}

.goods-name li {
	font-size: 16px;
	font-weight: normal;
}

.goods-detail-rating {
	margin-top: 20px;
}

.goods-detail-rating-star {
	width: 24px;
}

.goods-top-section-third {
	width: 300px;
}

.order-menu-container {
	background-color: rgb(255, 255, 255, 0.2);
	width: 100%;
	height: 100%;
	border-radius: 15px;
	padding: 20px;
	box-sizing: border-box;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.ticket-cost-before {
	margin-top: 10px;
	text-align: center;
	font-size: 22px;
	color: rgba(255,255,255,0.5);
	margin-bottom: -10px;
}

.ticket-cost {
	text-align: center;
	font-size: 24px;
	font-weight: bold;
	color: #fff;
	margin-bottom: 20px;
}

.order-button {
	width: 250px;
	padding: 10px 0;
	font-size: 16px;
	font-weight: bold;
	color: #fff;
	background-color: #ffc107;
	border: none;
	border-radius: 5px;
	text-align: center;
	text-decoration: none;
	cursor: pointer;
	transition: background-color 0.3s;
}

.order-button:hover {
	background-color: #5F32FF;
}

.copy-link-button {
	width: 250px;
	margin-top: 20px;
	padding: 10px 20px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.3s;
}

.copy-link-button:hover {
	background-color: #0069d9;
}

.section-label {
	padding: 20px;
	font-size: 20px;
	font-weight: bold;
}

.goods-description {
	margin-top: 25px;
	margin-bottom: 50px;
}

</style>

<body>

<%
	request.setCharacterEncoding("UTF-8");
	String ticketType = request.getParameter("ticketType");
	System.out.println(ticketType);
	String userId = (String) session.getAttribute("loginId");
	if (userId == null) {
		userId = "";
	}
	int cost = 0;
	if (ticketType.equals("minji")){
		cost = 330000;
	} else if (ticketType.equals("yoonji")){
		cost = 290000;		
	} else if (ticketType.equals("gwangpal")){
		cost = 790000;		
	}
%>

	<div class="body-container">
		<p class="body-label">메인 > 헬창PT > 퍼스널 트레이너</p>
		<div class="goods-top-section">	
			<div class="goods-top-section-first">			
					<% if(ticketType.equals("minji")) {	%> 	
				<div class="goods-thumbnail" style="background-image: url('trainersImages/trainer1.png')"></div>
					<% } else if (ticketType.equals("yoonji")) { %> 	
				<div class="goods-thumbnail" style="background-image: url('trainersImages/trainer2.png')"></div>
					<% } else if (ticketType.equals("gwangpal")) { %> 	
				<div class="goods-thumbnail" style="background-image: url('trainersImages/trainer3.png')"></div>
					<% } %>
			</div>				
				
			<div class="goods-top-section-second">	
				<div class="goods-name">
					<% if(ticketType.equals("minji")) {
						%><span>정민지 대표이사</span>
						<li>생활 스포츠 지도사 1급 (보디빌딩)</li>
						<li>LPTI 자격 및 졸업 / NASM 자격</li>
						<li>KKF 케틀벨 CKI 과정 수료</li><br>
						<span>CAREER</span>
						<li>성남 - 70kg 1위</li>
						<li>내추럴 보디빌딩 1위</li>						
						<li>헬스로운 평화나라 대표이사(현)</li>
					<% } else if (ticketType.equals("yoonji")) {
						%> <span><b>최윤지</b> 선수</span>
						<li>바디프로필, 다이어트, 근력 PT 전문</li>
						<li>완벽한 식단 & 루틴 관리</li>
						<li>근막이완 & 스포츠마사지</li><br>
						<span>CAREER</span>
						<li>평택 - 80kg 2위</li>
						<li>내추럴 보디빌딩 2위</li>						
						<li>자메이카 휘트니스 실장</li>					
						<li>헬스로운 평화나라 트레이너(현)</li>
					<% } else if (ticketType.equals("gwangpal")) {
						%> <span><b>마광팔</b> 선수</span>
						<li>복싱 선수 권필쌍 피지컬 코치</li>
						<li>MMA 컨디셔닝 전문가</li>
						<li>TFC MMA 심판</li><br>
						<span>CAREER</span>
						<li>TFC MMA - 50kg 우승</li>
						<li>TFC MMA - 70kg 우승</li>						
						<li>주짓수 토너먼트 -77kg 브론즈</li>
						<% } %>				
				</div>
			</div>
			
			<div class="goods-top-section-third">
				<div class="order-menu-container">
					<span>PT <b>10회</b> 기준</span>
					<span class="ticket-cost-before"><del><%= String.format("%,d", cost+100000) %>원</del></span>
					<span class="ticket-cost"><%=String.format("%,d", cost)%>원</span>
					<a href="ticketOrder.jsp?ticketType=<%= ticketType%>"
						class="order-button">PT 이용권 구매하기</a>
					<%-- 상품 링크 복사 --%>
					<button type="button" class="copy-link-button"
						onclick="copyToClipboard()">링크 복사</button>
				</div>
			</div>
		</div>
		<div class="goods-bottom-section">
			<hr>
			<div class="section-label">트레이너 설명</div>
			<% if(ticketType.equals("minji")) {	%> 	
				<img alt="트레이너 사진" src="trainersImages/trainer1.png"><br>
				<p>한 20대 회원님이 기억에 남습니다.</p>
				이 회원님은 398KG의 초고도비만이었고 좋아하는 사람에게<br>
				본인의 마음을 전하고 싶으나 외모에 자신감이 너무 떨어져서<br>
				다이어트를 결심하고 상담을 하러 오셨습니다.<br><br>
				상담 전까지만 해도 다이어트에 대한 잘못된 정보로 인해<br>
				무탄수화물 또는 하루에 닭찌 1개, 유산소 2시간 등<br>
				무리하고 불건강한 루틴을 강행해온 회원님께서는<br><br>
				<p><b>폭식증, 우울증</b>을 동반하여 오히려 건강이 악화되었습니다</p>
				저는 이 회원님의 건강을 돌려주고 싶었고 올바른 다이어트 방법을 알려줬습니다<br>
				처음에는 하루 3끼 먹는 습관, 근력운동 1시간, 유산소 30분 등<br>
				천천히 생활습관을 고치는 작은 단계부터 시작하였으며<br>
				회원님의 수준이 올라감에 따라 운동 강도를 늘리고<br>
				식단 또한 점점 깨끗하게 변화시켰습니다.<br><br>
				결과적으로 이 회원님께서는 <b>9개월 만에 322KG 감량</b>을 할 수 있었습니다.
				<% } else if (ticketType.equals("yoonji")) { %>					
				<img alt="트레이너 사진" src="trainersImages/trainer2.png"><br>
				1990년 고딩2때 청주에서 전국체전이 열렸다. 그리고 주간야구라는 당시 유일했던 야구잡지사에서 글을 쓰는 기자분이 그라운드안에서 내게 인사를 건냈다. 그리고 몇가지 질문을 하고나서 내게 훗날 좋은 선수가 되길바란다고했다. 그리고 다음해 1991년 여름, 국가대표로 미국에서 활약하고 돌아온 나는 공항에서 일년전 그기자형을 만났다. 당시 다른선수들과는 달리 서울에서 갈곳이 없었던 나를 집에 데리고가서 하루밤을 재워주셨다. 그기자형의 집에 도착해서 나는 기자형의 방안에 있던 책장속에 눈을 뗄수가 없었다. 책장속에는 온갓 영어로만된 미식축구, 농구,야구 잡지들이 가득했다. 그중에서 놀란라이언의 책은 나의 심장을 자극했다. 나는 기자형의 도움으로 대충 책속의 내용을 들으며 사진들을 관찰했다. 나의 그런모습을 보고는 그기자형은 내게 그책을 선물로 주셨다. 미국가서 좋은성적을 낸것보다 몇배 더 좋았다. 그뒤로 난 책속의 놀란라이언을 흉내내기시작했다. 놀란라이언처럼 강속구 투수가 되고싶었다. 그래서 런닝을 많이하고 웨이트트레이닝을 많이 한다는 책속의 내용과 사진들을 따라했다. 그리고 어느덧 난 강속구투구가 되어있었다. 꿈을 갖는다는것 그리고 꿈을 준다는것....그렇게 기자형님과 나는 꿈을 주고 받는 소중한 인연을 이어갔다. 훗날 나는 최초의 코리언 메이저리거가 되었고 그 기자형은 야구전문기자로써 최초의 야구단 사장이 되었다. 소중함과 고마운인연. #ncdinos#이태일사장#야구전문기자#야구의꿈#박찬호#메이저리거#놀란라이언#chanhopark61 #nolanryanexpress #koreanexpress
				<% } else if (ticketType.equals("gwangpal")) { %> 	
				<img alt="트레이너 사진" src="trainersImages/trainer3.png"><br>
				<p>안녕하세요. 퍼스널 트레이너 마광팔 선수입니다.</p>
				저와의 수업에서는<br>
				1. 하루 컨디션 체크를 통해 <b>그 날의 적절한 운동 강도</b>를 약속드립니다.<br>
				2. '운동습관'을 위해 당일 운동 일지를 공유하고 <b>컨디션에 맞는 강도의 개인 운동</b>을 제시합니다<br>
				3. 식단, 수면, 직업환경 등 <b>생활 환경의 균형</b>을 코칭해드립니다.<br><br>
				운동은 스스로 컨디션 관리를 할 수 있는 평생의 수단입니다.<br>
				많은 분들이 단순히 살을 빼기 위해 운동을 해야 한다고 생각하지만<br>
				사실 운동이란 삶을 활력 있게 만들고 하루의 스트레스 관리를 하는 데에 큰 도움이 됩니다<br><br>
				PT를 통해 얻을 수 있는 가장 큰 자산은<br>
				운동을 통해 건강을 유지하고 스트레스 관리법을 배우는 것입니다<br><br>
				여러분의 삶에 건강이라는 가장 큰 자산을 드리겠습니다.
				<% } %>
		</div>
	</div>
</body>

<footer>
	<%@ include file="footer.jsp"%>
</footer>
</html>