<%@page import="service.OrderGoodsService"%>
<%@page import="service.GoodsServiceImpl"%>
<%@page import="service.GoodsService"%>
<%@page import="service.OrderGoodsServiceImpl"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="service.ReviewService"%>
<%@page import="service.ReviewServiceImpl"%>
<%@page import="dto.UserDTO"%>
<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<%
if ((String) session.getAttribute("loginId") == null) { // id 값이 null이면 비로그인 상태로 간주
	response.sendRedirect("login.jsp"); // login.jsp 페이지로 이동
%>
<script>
	alert("로그인 후 이용할 수 있습니다!");
	history.back();
</script>
<%
}
%>

<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<style>

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

body {
	background-color: #e6e6e6;
	height: 100%;
}

.side-bar {
	width: 150px;
}

.body-container {
	display: flex;
	max-width: 1000px;
	min-height: auto;
	background-color: #fff;
	margin: 0 auto;
	height: 100%;
	max-width: 1000px;
}

.body-content {
	width: 800px;
	min-height: 700px;
	border-left: 1px solid #ddd;
	padding: 20px;
	margin-bottom: 100px;
}

.content-head {
	font-weight: bold;
}

.menu-my-review {
	color: #5F32FF;
	font-weight: bold;
}

.review-container {
	padding: 20px;
	width: 750px;
	display: flex;
	flex-wrap: wrap;
}

.review-item {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px;
	width: 100%;
}

.review-thumbnail {
	display: block;
	width: 150px;
	height: 150px;
	margin-right: 20px;
	background-size: cover;
	background-position: center;
}

.review-info {
	width: 450px;
	max-width: 450px;
	flex-grow: 1;
}

.review-info h3 {
	font-size: 18px;
}

.review-content {
	margin-top: 10px;
	font-size: 14px;
	color: #555;
	line-height: 1.5;
}

.review-date {
	margin-top: 10px;
	font-size: 12px;
	color: #999;
}

.goods-detail-rating-star {
	width: 20px;
	height: 20px;
}

.goods-detail-rating {
	margin-right: 10px;
}

.review-goods-name {
	margin-top: 0px;
}

.btn-group {
	margin-left: 30px;
	display: flex;
	flex-direction: column;
}

.modify-btn {
	font-size: 14px;
	margin-right: 20px;
	padding: 5px 10px;
	border-radius: 5px;
	border: 1px solid #ddd;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.delete-btn {
	font-size: 14px;
	background-color: #fff;
	margin-top: 10px;
	margin-right: 20px;
	padding: 5px 10px;
	border-radius: 5px;
	border: 1px solid #ddd;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.modify-btn:hover, .delete-btn:hover, .modify-confirm-btn:hover {
	background-color: #ddd;
}

textarea {
	resize: none;
	width: 750px;
	height: 150px;
}
.modify-confirm-btn-div{
	justify-content: center;
	align-items: center;
}

.modify-confirm-btn {
	font-size: 14px;
	background-color: #fff;
	margin-top: 10px;
	margin: 10px auto;
	padding: 5px 10px;
	border-radius: 5px;
	border: 1px solid #ddd;
	cursor: pointer;
	transition: background-color 0.3s ease;
	margin-bottom: 25px;
}
</style>
<header>
	<%@ include file="header.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>
<%
String userId = (String) session.getAttribute("loginId");
UserService userService = new UserServiceImpl();
UserDTO user = userService.getUser(userId);
ReviewService reviewService = new ReviewServiceImpl();
List<ReviewDTO> reviewList = reviewService.getReviewList(userId);
GoodsService goodsService = new GoodsServiceImpl();
OrderGoodsService orderGoodsService = new OrderGoodsServiceImpl();
%>

<body>
	<div class="body-container">
		<div class="side-bar">
			<%@ include file="myPageSidebar.jsp"%>
		</div>
		<div class="body-content">
			<p class="content-head">나의 리뷰</p>
			<hr>
			<div class="review-container">
				<%
				if (reviewList.isEmpty()) {
				%>
				<p>작성한 리뷰가 없습니다.</p>
				<%
				} else {
				for (ReviewDTO review : reviewList) {
					String goodsName = goodsService.findGoods(review.getGoodsId()).getGoodsName();
					String reviewContent = review.getReviewContent();
					int rating = orderGoodsService.getOrderGoodsByOrderPk(review.getOrderPk()).getRating();
				%>
				<div class="review-item">
					<a href="shoppingDetail.jsp?goodsId=<%=review.getGoodsId()%>">
						<img class="review-thumbnail"
						src="goodsImages/<%=goodsService.findGoods(review.getGoodsId()).getThumbnail()%>">
					</a>
					<div class="review-info">
						<div class="goods-detail-rating">
							<%-- 별점 구현 --%>
							<%
							int fullStarCount = rating;
							%>
							<%
							int emptyStarCount = 5 - fullStarCount;
							%>
							<%
							for (int i = 1; i <= fullStarCount; i++) {
							%>
							<img class="goods-detail-rating-star"
								src="images/rating-full.png" alt="별점">
							<%
							}
							%>
						</div>
						<h3 class="review-goods-name">
							<a href="shoppingDetail.jsp?goodsId=<%=review.getGoodsId()%>"><%=goodsName%></a>
						</h3>
						<div class="review-date"><%=review.getReviewCreatedAt().toString().substring(0, 19)%> / 글 번호: <%= review.getReviewId() %></div>
						<div class="review-content">
							<%=reviewContent%>
						</div>
					</div>

					<div class="btn-group">
						<div class="modify-btn" onclick="showEditForm(this)">수정</div>
						<form method="post" action="myReviewDelete.jsp" id="delete-form-<%=review.getReviewId()%>">
						    <input type="hidden" name="reviewId" value="<%=review.getReviewId()%>">
						    <button type="submit" class="delete-btn" onclick="event.preventDefault(); confirmDelete(<%=review.getReviewId()%>);" class="delete-btn">삭제</button>
						</form>
					</div>
				</div>
				<!-- 수정 입력창 -->
				<div id="edit-form" style="display: none;" class="modify-confirm-btn-div">
					<form method="POST" action="myReviewModify.jsp">
						<textarea id="edit-content" class="review-content"
							name="reviewContent" required><%=reviewContent%></textarea>
						<input type="hidden" name="reviewId"
							value="<%=review.getReviewId()%>">
						<button type="button" onclick="editReview(this)" class="modify-confirm-btn">수정 완료</button>
					</form>
				</div>
				<%
				}
				}
				%>
			</div>
		</div>
	</div>
</body>

<script>
	function showEditForm(btn) {
		const reviewItem = btn.parentElement.parentElement;
		const editForm = reviewItem.nextElementSibling;
		editForm.style.display = editForm.style.display === "none" ? "block"
				: "none";
	}

	function editReview(btn) {
		const editForm = btn.parentElement;
		const editContent = editForm.querySelector("#edit-content");
		if (editContent.value.trim() === "") {
			alert("리뷰 내용을 입력하세요.");
			return;
		}
		editForm.submit();
	}

	function confirmDelete(id) {
        var r = confirm("정말 삭제하시겠습니까?");
        if (r == true) {
            document.getElementById("delete-form-" + id).submit();
        }
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
</script>


<footer>
	<%@ include file="footer.jsp"%>
</footer>
</html>