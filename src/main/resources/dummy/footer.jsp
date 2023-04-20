<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">

<style>
footer {
	background-color: #17171f;
	color: white;
	font-size: 14px;
	padding: 30px 0;
	bottom: 0;
	width: 100%;
}

.footer-container {
	max-width: 800px;
	margin: 0 auto;
	display: flex;
	justify-content: center;
	align-items: center;
}

.left-section {
	flex: 1;
}

.footer-banner {
	width: 300px;
	height: auto;
	max-height: 120px;
	margin: 10px;
}

.right-section {
	flex: 1;
	text-align: right;
}

.right-section p:last-child {
	margin-bottom: 0;
}

/* 포인트 컬러 */
.inform-head {
	font-weight: bold;
	font-size: 18px;
}

body {
	margin: 0;
	padding: 0;
}
</style>

<footer>
	<div class="footer-container">
		<div class="left-section">
			<img src="images/logo_white.png" alt="배너 이미지" class="footer-banner">
		</div>
		<div class="right-section">
			<p class="inform-head">헬스로운 평화나라</p>
			<p>대표자: 임서하, 한강빈, 이정훈, 김정은, 김요한, 안혜지, 임건재</p>
			<p>주소: 서울특별시 강남구 삼성로 1234번길 56</p>
			<p>사업자등록번호: 123-45-67890</p>
			<p>전화번호: 02-1234-5678</p>
			<p>이메일: [operation@healthful.com](mailto:operation@healthful.com)</p>
			<p>COPYRIGHT © 2023 MY COMPANY. ALL RIGHTS RESERVED.</p>
		</div>
	</div>
</footer>
</html>