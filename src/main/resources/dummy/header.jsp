<%@page import="java.util.List"%>
<%@page import="service.ReservationServiceImpl"%>
<%@page import="service.ReservationService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
String loginId = (String) session.getAttribute("loginId");
%>

<style>
/* 전체 설정 */
header {
	background-color: #17171f;
}

/* 컨테이너 설정 */
.header-container {
	max-width: 800px;
	margin: 0 auto;
	padding: 20px;
}

/* 헤더 상단 영역 */
.header-top {
	margin-top: -15px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: -50px;
}

.logo {
	margin-top: 50px;
	width: 300px;
	height: 150px;
}

.logo a {
	display: block;
	width: 100%;
	height: 100%;
	background-image: url('images/logo_white.png');
	background-repeat: no-repeat;
	background-size: contain;
	text-indent: -9999px;
}

.login-menu-group {
	text-align: right;
}

.btn-login {
	height: 35px; /*버튼 높이*/
	padding: 5px 15px;
	margin-left: 10px;
	border-radius: 20px;
	font-weight: bold;
	text-decoration: none;
	color: #fff;
	border: 1px solid #5F32FF;
	background-color: #5F32FF;
	transition: background-color 0.3s ease;
	cursor: pointer;
}

.btn-login:hover {
	background-color: #4124ad;
}

.btn-mypage {
	padding: 5px 15px;
	margin-left: 10px;
	border-radius: 20px;
	font-weight: bold;
	font-size: 14px;
	text-decoration: none;
	color: #fff;
	border: 1px solid #5F32FF;
	background-color: #5F32FF;
	transition: background-color 0.3s ease;
}

.btn-mypage:hover {
	background-color: #4124ad;
	color: #fff;
}

.btn-logout {
	height: 25px;
	line-height: 25px;
	padding: 5px 15px;
	margin-left: 10px;
	border-radius: 20px;
	font-weight: bold;
	font-size: 14px;
	text-decoration: none;
	color: #5F32FF;
	border: 1px solid #5F32FF;
	background-color: transparent;
	transition: color 0.3s ease;
	transition: background-color 0.3s ease;
}

.btn-logout:hover {
	background-color: #4124ad;
	color: #fff;
}

.btn-admin {
	padding: 5px 10px;
	margin-left: 10px;
	border-radius: 20px;
	font-weight: bold;
	font-size: 12px;
	text-decoration: none;
	color: orange;
	border: 1px solid orange;
	background-color: transparent;
	transition: color 0.3s ease;
	transition: background-color 0.3s ease;
}

.btn-admin:hover {
	background-color: orange;
	color: #fff;
}

.user-information {
	margin-top: 20px;
	text-align: right;
	font-size: 12px;
	color: #fff;
}

.user-Id {
	font-weight: bold;
}

/* 헤더 하단 영역 */
.header-bottom {
	margin-top: 20px;
	display: flex;
	justify-content: flex-start;
	align-items: center;
}

.nav-menu {
	display: flex;
	justify-content: flex-start;
	align-items: center;
	margin-left: 10px;
}

.nav-menu a {
	font-size: 13px;
	margin-right: 20px;
	font-weight: bold;
	color: #fff;
	border-radius: 20px;
	padding: 10px 20px;
	text-decoration: none;
	transition: background-color 0.3s ease;
}

.nav-menu a:hover {
	background-color: #5F32FF;
	color: #fff;
	border-radius: 20px;
	padding: 10px 20px;
	transition: background-color 0.3s ease;
}
/* 다이얼로그 설정 */
dialog {
  background-color: transparent;
  border: none;
}

dialog::backdrop {
  background-color: rgba(0, 0, 0, 0.6);
  animation: fadeIn 0.3s ease-in-out;
}

dialog.open {
  animation: fadeIn 0.3s ease-in-out;
}

@keyframes fadeIn {
  0% {
    opacity: 0;
  }
  100% {
    opacity: 1;
  }
}

dialog.closing::backdrop {
  animation: fadeOut 0.3s ease-in-out;
}

dialog.closing {
  animation: fadeOut 0.3s ease-in-out;
}

@keyframes fadeOut {
  0% {
    opacity: 1;
  }
  100% {
    opacity: 0;
  }
}

/* 서브메뉴 스타일 */
.nav-menu .submenu-container {
	position: relative;
}

.nav-menu .submenu {
	padding: 5px 7px;
	margin-top: 9px;
	display: none;
	position: absolute;
	background-color: rgba(0, 0, 0, 0.65);
	border-radius: 25px;
	opacity: 0;
	transition: opacity 0.3s ease;
	white-space: nowrap; /* 줄바꿈 방지 */
}

.nav-menu .submenu-container:hover .submenu {
	display: block;
	opacity: 1;
}

.trainer-menu {
	margin: 10px 0 10px 0;
}

.reservation-menu {
	margin: 15px 0 10px 0;
}

.nav-menu .submenu a {
	color: #fff;
	text-decoration: none;
	transition: background-color 0.3s ease;
}

.nav-menu .submenu a:hover {
	background-color: #5F32FF;
}
</style>

</head>

<header>
	<div class="header-container">
		<div class="header-top">
			<div class="logo">
				<a href="index.jsp"> <img src="images/logo_white.png"
					alt="로고 이미지">
				</a>
			</div>
			<div class="login-menu-group">
				<%
				if (loginId == null) {
				%>
				<button class="btn-login">로그인</button>
				<dialog><%@ include file="login.jsp"%></dialog>
				<%
				} else {
				%>
				<div>
					<a href="myOrder.jsp" class="btn-mypage">마이페이지</a> <a
						href="logoutPro.jsp" class="btn-logout">로그아웃</a>
				</div>
				<div class="user-information">
					<p>
						<span class="user-Id"> <%
 out.println(session.getAttribute("loginId"));
 %>
						</span>님 환영합니다! <span> <%
 if (loginId.equals("admin")) {
 %> <a href="adminUserList.jsp" class="btn-admin">관리자모드</a> <%
 }
 %>
						</span>
					</p>
				</div>
				<%
				}
				%>
			</div>
		</div>
		<div class="header-bottom">
			<nav class="nav-menu">
				<a href="index.jsp" class="menu-index">헬스로운 평화나라 소개</a> <a
					href="shopping.jsp" class="menu-shopping">헬창쇼핑</a>
				<div class="submenu-container">
					<a href="tickets.jsp" class="menu-tickets">헬창PT</a>
					<div class="submenu">
						<div class="trainer-menu">
							<a href="tickets.jsp" class="menu-pt">퍼스널 트레이너</a><br>
						</div>
						<div class="reservation-menu">
							<a href="reservationCalendar.jsp" class="menu-reservation">예약하기</a>
						</div>
					</div>
				</div>
			</nav>
		</div>
</header>

<script>
	function disableScroll() {
		document.body.style.overflow = "hidden";
	}

	function enableScroll() {
		document.body.style.overflow = "auto";
	}

	const button = document.querySelector("button");
	const dialog = document.querySelector("dialog");

	button.addEventListener("click", function() {
		dialog.showModal();
		dialog.classList.add("open");
	});

	dialog.addEventListener("click", function(event) {
		  if (event.target === dialog) {
		    dialog.classList.add("closing");
		    setTimeout(() => {
		      dialog.close();
		      dialog.classList.remove("closing");
		    }, 290);
		  }
		});
</script>

</html>