<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>헬스로운 평화나라</title>
<%
String userId = (String) session.getAttribute("loginId");
ReservationService reservationService = new ReservationServiceImpl();
List<Long> alertList = reservationService.alertMe(userId);

if (alertList != null && !alertList.isEmpty()) {
%>
<script>
      var alertList = <%=alertList%>;
      var alertCount = alertList.length;
        var message = "참여 가능한 수업 " + alertCount + "개가 생겼습니다. 예약 목록으로 이동하시겠습니까?";
        var confirmed = confirm(message);
        if (confirmed) {
            window.location.href = "myReservation.jsp";
            //window.location.href = "reservationCalendar.jsp";
        }
</script>
<%
}
%>

<style>
body {
	background-color: #17171f;
	color: white;
}

.menu-index {
	background-color: #5F32FF;
	color: #fff;
	border-radius: 20px;
	padding: 10px 20px;
}

.body-container-1 {
	max-width: 800px;
	margin: 0 auto;
	text-align: center;
	margin-bottom: 50px;
}

.body-1-title {
	margin-top: 100px;
	margin-bottom: 50px;
	font-size : 24px;
	font-weight: bold;
	font-size: 30px;
	animation: shake 2s ease-in-out infinite; /* 애니메이션 지정 */
}

@keyframes shake {
  0% { transform: translateY(-15px); } /* 중간 위치 */
  50% { transform: translateY(0); } /* 애니메이션 시작 위치 */
  100% { transform: translateY(-15px); } /* 중간 위치 */
}

.body-container-logo {
	background-color: #fff;
	height: 300px;
	display: flex;
	justify-content: center;
}

.body-logo-component {
	width: 500px;
	margin: 0 auto;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 300px;
}

.body-logo {
	width: 100%;
	background-size: cover;
	background-position: center;
}

.body-container-text {
	text-align: center;
	height: 300px;
	margin: 0 auto;
	max-width: 800px;
}

.body-3-title {
	margin-top: 60px;
	font-size: 30px;
	font-weight: bold;
	display: inline-block;
}

.body-3-content {
	margin-top: 35px;
	font-size: 18px;
}

.body-container-text-small {
	text-align: center;
	height: 200px;
	margin: 0 auto;
	max-width: 800px;
}

.trainers-iamges {
	display: flex;
	justify-content: center;
	align-items: center;
}

.trainer {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-right: 30px;
}

.trainer img {
  margin-bottom: 10px;
}

.trainers-iamges a{
	text-decoration: none;
	color: #fff	
}

.trainer-nav-contianer {
	margin-top: 50px;
	text-align: center;
	margin-bottom: 100px;
}

.trainer-nav-btn {
	padding: 10px 25px;
	font-size: 18px;
	font-weight: bold;
	border-radius: 25px;
	border: none;
	background-color: #5F32FF;
	cursor: pointer;
	transition: background-color 0.3s ease;
	color: #fff;
}

.trainer-nav-btn:hover {
	background-color: #4124ad;
}
</style>

<header>
	<%@ include file="header.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<body>

	<div class="body-container-1">
		<div class="body-1-title">아직도 나의 루틴을 못찾았나요? 🤔</div>
		<iframe width=800 height=400
			src="https://www.youtube.com/embed/EyHo-C6STPk" title="풀리지 않는 논쟁"
			frameborder="0"
			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
			allowfullscreen></iframe>
	</div>
	<div class="body-container-text">
		<div class="body-3-title">HEALTHFUL LIFE</div>
		<div class="body-3-content">
			압구정, 교대, 신논현, 선릉, 양재에서 다양한 프로그램과 편리한 시설을 자랑하는<br>
			한국 최고의 럭셔리 퍼블릭 피트니스 클럽을 만나보세요.
		</div>
	</div>
	<div class="body-container-logo">
		<div class="body-logo-component">
			<img src="images/logo_theme.png" alt="로고 이미지" class="body-logo">
		</div>
	</div>
	<div class="body-container-text">
		<div class="body-3-title">FACILITY</div>
		<div class="body-3-content">
			각각의 고객의 높은 취향과 건강하고 즐거운 삶을 위해 최적화된 공간 디자인.<br>
			품격과 운동, 휴식을 모두 갖춘 도심 속 재충전의 모든 기반을 제공합니다.<br>
			첨단 기능을 갖춘 세계적인 이탈리아 테크노짐사를 비롯한<br>
			60여 대의 머신과 장비를 통해 효과적인 운동법을 제안합니다.
		</div>
	</div>	
	<img src="images/facility.png" alt="로고 이미지" class="facility">
	<div class="body-container-text">
		<div class="body-3-title">3S SYSTEM</div>
		<div class="body-3-content">
			헬스로운 평화마을은 첫 운동 입문부터 회원권 종료시까지 회원님의 건강과 아름다움을 위해 운동방법을 제시하는 것은 물론, 지속적으로 지도와 상담 등을 통해 회원님의 피트니스 목표를 달성할 수 있도록 최선을 다합니다.
		</div>
	</div>
	<img src="images/3ssystem.png" alt="로고 이미지" class="3ssystem">
	<div class="body-container-text-small">
		<div class="body-3-title">대표 헬창 소개</div>
	</div>
	<div class="trainers-iamges">
		<div class="trainer">
			<a href="ticketDetail.jsp?ticketType=minji"
					class="trainer">
					<img src="trainersImages/trainer1.png" alt="트레이너">
					<span><b>정민지</b> 대표이사</span>
				</a>
		</div>
		<div class="trainer">
			<a href="ticketDetail.jsp?ticketType=yoonji"
					class="trainer">
					<img src="trainersImages/trainer2.png" alt="트레이너">
					<span><b>최윤지</b> 선수</span>
				</a>
		</div>
		<div class="trainer">
			<a href="ticketDetail.jsp?ticketType=gwangpal"
					class="trainer">
					<img src="trainersImages/trainer3.png" alt="트레이너">
					<span><b>마광팔</b> 선수</span>
				</a>
		</div>
	</div>
	<div class="trainer-nav-contianer">
		<button class="trainer-nav-btn" onclick="window.location.href='tickets.jsp'">퍼스널 트레이닝 더보기 👀</button>
	</div>
</body>

<footer>
	<%@ include file="footer.jsp"%>
</footer>

</html>