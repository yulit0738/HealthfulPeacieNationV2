<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
</head>

<header>
    <%@ include file="adminSidebar.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<style>
body {
	background-color: #e6e6e6;
}

.goods-modify-container {
	max-width: 1000px;
	padding: 20px;
	margin: 0 auto;
	align-items: center;
	background-color: #fff;
	box-sizing: border-box;
}

.goods-modify-label {
	margin-top: 15px;
	margin-bottom: 15px;
	margin-left: 15px;
	font-size: 18px;
	font-weight: bold;
    display: flex;
    align-items: center;
}

.btn-back {
	margin-bottom: 20px;
	text-decoration: none;
	font-size: 16px;
	font-weight: bold;
	color: #0077CC;
}

.form-group {
	margin-bottom: 20px;
	display: flex;
	align-items: center;
}

.form-group label {
	width: 150px;
	font-size: 16px;
	font-weight: bold;
}

.form-group input {
	width: 100%;
	height: 40px;
	padding: 5px 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.form-group textarea {
	width: 100%;
	padding: 5px 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
	resize: vertical;
}

.form-group input[type="file"] {
	border: none;
}

.submit-button-wrapper {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

.submit-button {
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

.submit-button:hover {
	background-color: #0069d9;
}

.hr-divider {
	margin: 30px 0;
	border: 0;
	border-top: 1px solid #ccc;
}
</style>

<body>
<div class="goods-modify-container">
        <a href="javascript:history.back();" class="btn-back"> &lt; 뒤로가기 </a>
        <p class="goods-modify-label">상품 관리 - 상품 등록</p>
        <form action="adminAddGoodsPro.jsp" method="post" enctype="multipart/form-data">
        	<input type="hidden" name="goodsCategory" value="shopping">
            <div class="form-group">
                <label for="goodsName">상품 이름:</label>
                <input type="text" id="goodsName" name="goodsName" required>
            </div>
            <div class="form-group">
                <label for="goodsCost">상품 가격:</label>
                <input type="number" id="goodsCost" name="goodsCost" required>
            </div>
            <div class="form-group">
                <label for="goodsStock">초기 재고:</label>
                <input type="number" id="goodsStock" name="goodsStock" required>
            </div>
            <hr class="hr-divider">
            <div class="form-group">
                <label for="goodsDescription">제품 설명:</label>
                <textarea id="goodsDescription" name="goodsDescription" rows="5" required></textarea>
            </div>
            <div class="form-group">
                <label for="goodsThumbnail">썸네일:</label>
                <br>
                <input type="file" id="goodsThumbnail" name="goodsThumbnail" accept="image/*" required>
            </div>
            <div class="form-group">
                <label for="goodsImage1">이미지 1:</label>
                <br>
                <input type="file" id="goodsImage1" name="goodsImage1" accept="image/*">
            </div>
            <div class="form-group">
                <label for="goodsImage2">이미지 2:</label>
                <br>
                <input type="file" id="goodsImage2" name="goodsImage2" accept="image/*">
            </div>
            <div class="submit-button-wrapper">
                <button type="submit" class="submit-button">등록 완료</button>
            </div>
        </form>
</div>

</body>
</html>