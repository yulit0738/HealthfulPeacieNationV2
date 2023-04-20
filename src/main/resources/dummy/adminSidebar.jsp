<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헬스로운 관리자 메뉴</title>
<style>
/* 전체 스타일 */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

/* 사이드바 스타일 */
.sidebar {
	position: fixed;
	top: 0;
	left: 0px; /* 처음에는 숨겨져 있어야 함 */
	width: 300px;
	height: 100%;
	background-color: #17171f;
	transition: all 0.5s; /* 슬라이드 효과를 위한 트랜지션 */
	padding-top: 50px;
}

/* 열기/닫기 버튼 스타일 */
.openbtn {
	position: absolute;
	top: 0;
	right: 0;
	font-size: 20px;
	cursor: pointer;
	background-color: #17171f;
	color: #fff;
	padding: 10px 15px;
	border: none;
}

.admin-close {
	position: absolute;
	bottom: 0;
	right: 0;
	font-size: 13px;
	cursor: pointer;
	background-color: orange;
	color: #fff;
	padding: 10px 15px;
	border: none;
}

/* 메뉴 항목 스타일 */
.menu-item {
	width: 100%;
	height: 50px;
	background-color: #17171f;
	color: #ffffff;
	display: flex;
	align-items: center;
	padding-left: 20px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s;
}

/* 마우스를 올렸을 때 메뉴 항목의 배경색 변경 */
.menu-item:hover {
	background-color: #0077CC;
	transition: background-color 0.3s;
}

/* 선택된 메뉴 항목 스타일 */
.active {
	background-color: #0077CC;
}
</style>
</head>
<body>
	<!-- 사이드바 -->
	<div class="sidebar" id="sidebar">
		<button class="openbtn" onclick="toggleSidebar()">☰</button>
		<hr>
		<div class="menu-item" onclick="window.location.href='adminUserList.jsp'">사용자 관리</div>
		<div class="menu-item" onclick="window.location.href='adminGoods.jsp'">상품 관리</div>
		<div class="menu-item" onclick="window.location.href='adminShopping.jsp'">쇼핑</div>
		<div class="menu-item" onclick="window.location.href='adminUserReservation.jsp'">예약</div>
		<div class="menu-item" onclick="window.location.href='adminContact.jsp'">고객센터</div>
		<div class="menu-item" onclick="window.location.href='adminSales.jsp'">누적매출</div>
		<div class="admin-close" onclick="window.location.href='index.jsp'">종료</div>
	</div>

	<!-- 바디영역 -->
	<div id="body"></div>

	<script>
		/* 열기/닫기 버튼 클릭 시 사이드바 토글 */
		function toggleSidebar() {
			var sidebar = document.getElementById("sidebar");
			sidebar.style.left = sidebar.style.left || "0px";
			if (sidebar.style.left === "0px") {
				sidebar.style.left = "-250px";
			} else {
				sidebar.style.left = "0px";
			}
		}


		/* 메뉴 선택 시마다 active css 활성화 */
		/*
		var menuItems = document.getElementsByClassName("menu-item");

		for (var i = 0; i < menuItems.length; i++) {
			menuItems[i].addEventListener("click", function() {
				// 모든 .menu-item 요소에서 active 클래스를 제거
				for (var j = 0; j < menuItems.length; j++) {
					menuItems[j].classList.remove("active");
				}
				// 클릭한 요소에 active 클래스를 추가
				this.classList.add("active");
			});
		}
		*/
	</script>
</body>
</html>