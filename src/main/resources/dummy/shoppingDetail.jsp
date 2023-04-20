<%@page import="dto.QuestionDTO"%>
<%@page import="service.QuestionService"%>
<%@page import="service.QuestionServiceImpl"%>
<%@page import="dto.OrderGoodsDTO"%>
<%@page import="service.OrderGoodsService"%>
<%@page import="service.OrderGoodsServiceImpl"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="service.ReviewService"%>
<%@page import="service.ReviewServiceImpl"%>
<%@page import="repository.GoodsRepositoryImpl"%>
<%@page import="repository.GoodsRepository"%>
<%@page import="dto.GoodsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>헬스로운 쇼핑 - 상품 상세정보</title>

<style>
body {
	background-color: #17171f;
	color: white;
}

.body-label {
	font-size: 14px;
	font-weight: bold;
}

.body-container {
	max-width: 1000px;
	margin: 0 auto;
	align-items: center;
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

.quantity-label-soldout {
	margin-bottom: 5px;
	font-size: 14px;
	color: orange;
}

.quantity-label {
	margin-bottom: 5px;
	font-size: 14px;
	color: rgb(255, 255, 255, 0.6);
}

.quantity-input {
	display: flex;
	align-items: center;
	width: 250px;
	height: 40px;
	background-color: white;
	border-radius: 5px;
	overflow: hidden;
}

.quantity-input-field {
	flex: 1;
	height: 100%;
	padding: 5px 10px;
	border: none;
	outline: none;
	font-size: 16px;
	text-align: center;
}

.add-to-cart-button {
	width: 250px;
	margin-top: 20px;
	padding: 10px 20px;
	font-size: 16px;
	font-weight: bold;
	color: white;
	background-color: #007bff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.add-to-cart-button:hover {
	background-color: #0069d9;
}

.order-button {
	width: 250px;
	margin-top: 20px;
	padding: 10px 0;
	font-size: 16px;
	font-weight: bold;
	color: white;
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

.review-container {
	padding: 0 30px 30px;
}

.review-item {
	margin-top: 20px;
	padding: 20px;
	background-color: rgba(255, 255, 255, 0.2);
	border-radius: 10px;
	display: flex;
	flex-direction: column;
	font-size: 14px;
}

.review-rating-star {
	margin-top: 10px;
	margin-bottom: 10px;
	width: 18px;
}

.review-item-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.review-item-header>div {
	display: flex;
	align-items: center;
}

.review-item-header>div>img {
	width: 20px;
	height: 20px;
	margin-right: 5px;
}

.review-item-header>.review-item-header-username {
	font-size: 14px;
	font-weight: bold;
	margin-right: 10px;
}

.review-item-header>.review-item-header-date {
	font-size: 12px;
	color: rgba(255, 255, 255, 0.6);
}

.review-item-rating {
	margin-bottom: 10px;
}

.review-item-rating-star {
	width: 20px;
}

.review-writer {
	font-weight: bold;
}

.review-item-content {
	font-size: 14px;
	line-height: 1.5;
}

.review-date {
	margin-top: 10px;
	font-size: 14px;
	color: gray;
}

.toggle-reviews-button-container {
	text-align: center;
	margin-top: 30px;
	margin-bottom: 50px;
}

#toggleReviewsBtn {
	padding: 10px 25px;
	font-size: 16px;
	font-weight: bold;
	color: #fff;
	background-color: #ffc107;
	border: none;
	border-radius: 20px;
	cursor: pointer;
	transition: background-color 0.3s;
}

#toggleReviewsBtn:hover {
	background-color: #5F32FF;
}

.no-question {
	text-align: center;
}

.no-question-message {
	margin: 0 0 20px 0;
}

.exist-question {
	margin-top: 30px;
	text-align: center;
}

.new-question-btn {
	padding: 5px 15px;
	font-size: 16px;
	font-weight: bold;
	color: #fff;
	background-color: #ffc107;
	border: none;
	border-radius: 20px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.new-question-btn:hover {
	background-color: #5F32FF;
}

.question-form {
	display: none;
	margin: auto;
	width: 800px;
	margin-top: 30px;
	text-align: center;
}

.question-title-input input {
	padding-left: 10px;
	width: 100%;
	height: 30px;
	border: none;
	border-radius: 5px;
	box-sizing: border-box;
}

.question-content-input textarea {
	padding: 10px;
	margin-top: 3px;
	width: 100%;
	height: 200px;
	border: none;
	border-radius: 5px;
	resize: none;
	box-sizing: border-box;
}

.question-write-btn button {
	margin-top: 10px;
	font-size: 14px;
	padding: 5px 15px;
	background-color: #fff;
	border: none;
	border-radius: 15px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.question-write-btn button:hover {
	background-color: #ddd;
}

.question-component {
	border: 0.5px solid;
	padding: 30px;
	font-size: 12px;
	color: #ddd;
}

.question-component p {
	color: #fff;
}

.question-component hr {
	margin: 30px 0 30px 0;
	border-top: 0.5px;
}

.question-index {
	padding: 0;
	border: none;
}

.question-item {
	margin-top: 20px;
	padding: 20px;
	background-color: rgba(255, 255, 255, 0.1);
	border-radius: 10px;
	display: flex;
	flex-direction: column;
	font-size: 14px;
}

.question-item-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.question-item-header>div {
	display: flex;
	align-items: center;
}

.question-item-header-username {
	font-size: 14px;
	font-weight: bold;
	margin-right: 10px;
}

.question-item-header-title {
	background-color: #5F32FF;
	padding: 5px 15px;
	border-radius: 15px;
}

.question-item-header-date {
	font-size: 12px;
	color: rgba(255, 255, 255, 0.6);
}

.question-delete-btn {
	color: #fff;
	margin-left: 15px;
	background-color: #FE2E2E;
	border: none;
	border-radius: 10px;
	padding: 5px 10px auto;
	cursor: pointer;
}

.question-item-content {
	font-size: 14px;
	line-height: 1.5;
	margin-bottom: 10px;
}

.question-item-reply {
	margin-left: 20px;
	padding: 15px;
	background-color: rgba(255, 255, 255, 0.2);
	border-radius: 5px;
	font-size: 14px;
	line-height: 1.5;
}

.question-item-reply-title {
	font-weight: bold;
	margin-bottom: 5px;
}

.reply-btn-component {
	width: 100px;
	margin-bottom: 15px;
}

.reply-btn, .answer-submit-btn {
	padding: 3px 8px;
	background-color: #fff;
	border: none;
	border-radius: 10px;
	cursor: pointer;
}

.reply-btn:hover, .answer-submit-btn:hover {
	background-color: #ddd;
}

.reply-textarea {
	width: 100%;
	resize: none;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-bottom: 10px;
	box-sizing: border-box;
}
</style>

<header>
	<%@ include file="header.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<body>
	<div class="body-container">
		<p class="body-label">메인 > 헬창쇼핑 > 제품 상세</p>
		<div class="goods-top-section">
			<%-- 상품 정보 가져오기 --%>
			<%
			GoodsRepository goodsRepository = new GoodsRepositoryImpl();
			long goodsId = Integer.parseInt(request.getParameter("goodsId"));
			GoodsDTO goods = goodsRepository.findById(goodsId);
			String userId = (String) session.getAttribute("loginId");
			if (userId == null) {
				userId = "";
			}
			%>

			<div class="goods-top-section-first">
				<div class="goods-thumbnail"
					style="background-image: url('goodsImages/<%=goods.getThumbnail()%>')"></div>
			</div>

			<div class="goods-top-section-second">

				<div class="goods-name">
					<%=goods.getGoodsName()%>
				</div>

				<div class="goods-detail-rating">
					<%-- 별점 구현 --%>
					<%
					double rating = Math.round(goods.getGoodsScore() * 2) / 2.0;
					%>
					<%
					int fullStarCount = (int) rating;
					%>
					<%
					boolean hasHalfStar = (rating - fullStarCount) >= 0.5;
					%>
					<%
					int emptyStarCount = 5 - fullStarCount - (hasHalfStar ? 1 : 0);
					%>
					<%
					for (int i = 1; i <= fullStarCount; i++) {
					%>
					<img class="goods-detail-rating-star" src="images/rating-full.png"
						alt="별점">
					<%
					}
					%>
					<%
					if (hasHalfStar) {
					%>
					<img class="goods-detail-rating-star" src="images/rating-half.png"
						alt="별점">
					<%
					}
					%>
					<%-- 별점 수치 구현 --%>
					<span class="goods-detail-rating-score"> (<%=String.format("%.1f", goods.getGoodsScore())%>)
					</span>
				</div>
			</div>
			<div class="goods-top-section-third">
				<div class="order-menu-container">
					<%-- 수량 입력 --%>

					<%
					if (goods.getGoodsStock() < 1) {
					%>
					<label class="quantity-label-soldout">일시 품절 상태입니다</label>
					<%
					} else {
					%>
					<label class="quantity-label">주문 수량</label>
					<%
					}
					%>
					<%-- 장바구니 --%>
					<form action="shoppingAddCart.jsp" method="post">
						<input type="hidden" name="goodsId"
							value="<%=goods.getGoodsId()%>">
						<div class="quantity-input">
							<input type="number" name="quantity" class="quantity-input-field"
								min="1" max="<%=goods.getGoodsStock()%>" value="1">
						</div>
						<button type="submit" class="add-to-cart-button">장바구니에 담기</button>
					</form>
					<%-- 주문하기 --%>

					<a href="order.jsp?goodsId=<%=goods.getGoodsId()%>"
						class="order-button">주문하기</a>
					<%-- 상품 링크 복사 --%>
					<button type="button" class="copy-link-button"
						onclick="copyToClipboard()">상품 링크 복사</button>
				</div>
			</div>
		</div>
		<div class="goods-bottom-section">
			<hr>
			<div class="section-label">상품 설명</div>
			<%
			if (!goods.getGoodsImage1().equals("No-Image-Placeholder.png")) {
			%>
			<div class="goods-thumbnail"
				style="background-image: url('goodsImages/<%=goods.getGoodsImage1()%>')">
			</div>
			<%
			}
			%>
			<%
			if (!goods.getGoodsImage2().equals("No-Image-Placeholder.png")) {
			%>
			<div class="goods-thumbnail"
				style="background-image: url('goodsImages/<%=goods.getGoodsImage2()%>')">
			</div>
			<%
			}
			%>
			<div class="goods-description"><%=goods.getGoodsDescription()%></div>
		</div>
		<hr>
		<%
		ReviewService reviewService = new ReviewServiceImpl();
		List<ReviewDTO> recentReviewList = reviewService.getRecentThreeReviews(goodsId);
		List<ReviewDTO> allReviewList = reviewService.getReviewList(goodsId);
		%>
		<div class="review-section">
			<div class="section-label">상품 리뷰</div>
			<div class="review-container">
				<div id="recentReviews">
					<%
					for (ReviewDTO review : recentReviewList) {
						OrderGoodsService orderGoodsService = new OrderGoodsServiceImpl();
						OrderGoodsDTO orderGoods = orderGoodsService.getOrderGoodsByOrderPk(review.getOrderPk());
					%>
					<div class="review-item">
						<div class="review-header">
							<div class="review-writer"><%=review.getUserId()%></div>
							<div class="review-rating">
								<%-- 별점 구현 --%>
								<%
								int userRating = orderGoods.getRating();
								for (int i = 1; i <= userRating; i++) {
								%>
								<img class="review-rating-star" src="images/rating-full.png"
									alt="별점">
								<%
								}
								%>
							</div>
						</div>
						<div class="review-body">
							<div class="review-content"><%=review.getReviewContent()%></div>
							<div class="review-date"><%=review.getReviewCreatedAt().toString().substring(0, 16)%></div>
						</div>
					</div>
					<%
					}
					%>
				</div>
				<div id="allReviews" style="display: none;">
					<%
					for (ReviewDTO review : allReviewList) {
						OrderGoodsService orderGoodsService = new OrderGoodsServiceImpl();
						OrderGoodsDTO orderGoods = orderGoodsService.getOrderGoodsByOrderPk(review.getOrderPk());
					%>
					<div class="review-item">
						<div class="review-header">
							<div class="review-writer"><%=review.getUserId()%></div>
							<div class="review-rating">
								<%-- 별점 구현 --%>
								<%
								int userRating = orderGoods.getRating();
								for (int i = 1; i <= userRating; i++) {
								%>
								<img class="review-rating-star" src="images/rating-full.png"
									alt="별점">
								<%
								}
								%>
							</div>
						</div>
						<div class="review-body">
							<div class="review-content"><%=review.getReviewContent()%></div>
							<div class="review-date"><%=review.getReviewCreatedAt().toString().substring(0, 16)%></div>
						</div>
					</div>
					<%
					}
					%>
				</div>
				<%
				if (allReviewList.size() > 3) {
				%>
				<div class="toggle-reviews-button-container">
					<button id="toggleReviewsBtn" onclick="toggleReviews()">모든
						리뷰 보기</button>
				</div>
				<%
				}
				%>

			</div>
		</div>
		<hr>
		<div class="question-section">
			<div class="section-label">상품 문의</div>
			<div class="question-container">
				<%
				QuestionService questionService = new QuestionServiceImpl();
				List<QuestionDTO> questionList = questionService.getQuestionsByGoodsId(goodsId);
				if (questionList.size() == 0) {
				%>
				<div class="no-question">
					<div class="no-question-message">등록된 문의가 없습니다.</div>
					<div class="new-question-component">
						<button class="new-question-btn">문의글 남기기</button>
						<button type="button" class="question-cancel-btn" style="display: none">작성 취소</button>
					</div>
				</div>
				<div class="question-form">
					<form method="post" action="questionPro.jsp">
						<div class="question-title-input">
							<input type="text" name="title" placeholder="제목을 입력해주세요">
						</div>
						<div class="question-content-input">
							<textarea name="content" placeholder="문의하실 내용을 입력해주세요"></textarea>
						</div>
						<input type="hidden" name="category" value="shopping">
						<input type="hidden" name="goodsId" value="<%= goodsId %>">
						<div class="question-write-btn">
							<button type="submit">작성완료</button>
						</div>
					</form>
				</div>
				<%
				} else {
				%>
				<div class="question-list">
					<div class="question-component">
						<div class="question-index">
							<p>구매한 상품의 <b>취소/반품은 마이페이지 주문내역</b>에서 신청 가능합니다.</p>
							<p>상품문의 및 리뷰를 통해 취소나 환불, 반품 등은 처리되지 않습니다.</p>
							<p><b>가격, 판매자, 교환/환불 및 배송 등 해당 상품 자체와 관련 없는 문의는 고객센터 내 1:1 문의하기</b>를 이용해주세요.</p>
							<p><b>"해당 상품 자체"와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.</b></p>
							<p>공개 게시판이므로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</p>
							<hr>
						</div>
						<% for (int i = 0; i < questionList.size() && i < 5; i++) { %>
						<div class="question-item">
							<div class="question-item-header">
								<div>
									<span class="question-item-header-username"><%=questionList.get(i).getUserId()%></span>
									<span class="question-item-header-title"><%=questionList.get(i).getTitle()%></span>
									<% if(userId.equals("admin") || userId.equals(questionList.get(i).getUserId())) { %>
									<form method="post" action="questionDeletePro.jsp?questionId=<%=questionList.get(i).getQuestionId() %>">
									<input type="hidden" name="recentPage" value="shoppingDetail.jsp?goodsId=<%= goodsId %>">
									<input type="submit" value="삭제" class="question-delete-btn">
									</form>
									<% } %>
								</div>
								<span class="question-item-header-date"><%=questionList.get(i).getCreatedAt().toString().substring(0, 10)%></span>
							</div>
							<div class="question-item-content">
								<%=questionList.get(i).getContent()%>
							</div>
							<%
							if (questionList.get(i).getReply() != null && !questionList.get(i).getReply().isEmpty()) {
							%>
							<div class="question-item-reply">
								<div class="question-item-reply-title">관리자 답변 / <span><%=questionList.get(i).getUpdatedAt().toString().substring(0, 16) %></span></div>
								<%=questionList.get(i).getReply()%>
							</div>							
							<%
							}
							%>
							<!-- 관리자 계정일 경우 '답변하기' 버튼 추가 -->
							<% if ("admin".equals(userId) && (questionList.get(i).getReply() == null || questionList.get(i).getReply().isEmpty())) { %>
							<div class="reply-btn-component">
							    <button id="replyButton_<%=i%>" onclick="showReplyForm(<%=i%>)" class="reply-btn">답변하기</button>
							</div>
						    <div id="replyForm_<%=i%>" style="display:none;">
						        <form id="answerForm" action="questionAnswerPro.jsp?questionId=<%=questionList.get(i).getQuestionId() %>" method="post">
						        	<input type="hidden" name="goodsId" value="<%= goodsId %>">
						            <textarea class="reply-textarea" id="replyContent" name="reply" rows="4" cols="50" placeholder="답변 내용을 입력하세요." required></textarea>
						            <input type="submit" value="답변완료" class="answer-submit-btn">
						        </form>
						    </div>
							<% } %>
						</div>
						<%
						}
						%>						
						<div class="exist-question">
							<div class="new-question-component">
							<% if(userId != null) {%>
								<button class="new-question-btn">문의글 남기기</button>
								<% } %>
								<button type="button" class="question-cancel-btn" style="display: none">작성 취소</button>
							</div>
						</div>
						<div class="question-form">
							<form method="post" action="questionPro.jsp">
								<div class="question-title-input">
									<input type="text" name="title" placeholder="제목을 입력해주세요" required>
								</div>
								<div class="question-content-input">
									<textarea name="content" placeholder="문의하실 내용을 입력해주세요" required></textarea>
								</div>
								<input type="hidden" name="category" value="shopping">
								<input type="hidden" name="goodsId" value="<%= goodsId %>">
								<div class="question-write-btn">
									<button type="submit">작성완료</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<% } %>
			</div>
		</div>
	</div>
</body>
<script>
	function toggleReviews() {
		var recentReviews = document.getElementById("recentReviews");
		var allReviews = document.getElementById("allReviews");
		var toggleBtn = document.getElementById("toggleReviewsBtn");

		if (recentReviews.style.display === "none") {
			recentReviews.style.display = "block";
			allReviews.style.display = "none";
			toggleBtn.innerText = "모든 리뷰 보기";
		} else {
			recentReviews.style.display = "none";
			allReviews.style.display = "block";
			toggleBtn.innerText = "최근 리뷰만 보기";
		}
	}

	const newQuestionBtn = document.querySelector('.new-question-btn');
	const questionForm = document.querySelector('.question-form');

	newQuestionBtn.addEventListener('click', function() {
		if (questionForm.style.display === 'block') {
			questionForm.style.display = 'none';
			newQuestionBtn.textContent = '문의글 남기기';
		} else {
			questionForm.style.display = 'block';
			newQuestionBtn.textContent = '작성 취소';
		}
	});

	function copyToClipboard() {
		const element = document.createElement('textarea');
		element.value = window.location.href;
		document.body.appendChild(element);
		element.select();
		document.execCommand('copy');
		document.body.removeChild(element);
		alert('상품 링크가 복사되었습니다! "Ctrl+V" 로 붙여넣기 하세요!');
	}

	// 페이지가 로드되었을 때 이전 스크롤 위치로 이동
	window.addEventListener('load', function() {
		var scrollPosition = sessionStorage.getItem('scrollPosition');
		if (scrollPosition) {
			window.scrollTo(0, parseInt(scrollPosition));
		}
	});

	// 페이지가 언로드되기 전에 현재 스크롤 위치를 저장
	window.addEventListener('beforeunload', function() {
		sessionStorage.setItem('scrollPosition', window.scrollY);
	});
	
	// 관리자 답변 기능 표시
	const replybtn = document.querySelector('.reply-btn');
	
	function showReplyForm(index) {
	    const replyForm = document.getElementById("replyForm_" + index);
	    const replybtn = document.getElementById("replyButton_" + index);
	    if (replyForm.style.display === "none") {
	        replyForm.style.display = "block";
	        replybtn.textContent = '작성 취소';
	    } else {
	        replyForm.style.display = "none";
	        replybtn.textContent = '답변하기';
	    }
	}
</script>
<footer>
	<%@ include file="footer.jsp"%>
</footer>
</html>