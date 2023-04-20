<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.loading-modal {
    display: none;
    position: fixed;
    z-index: 999;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.4);
}

.loader {
    border: 16px solid #f3f3f3;
    border-top: 16px solid #5F32FF;
    border-radius: 50%;
    width: 120px;
    height: 120px;
    animation: spin 2s linear infinite;
    position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -60px;
    margin-left: -60px;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}
</style>
</head>
<body>

<div class="loading-modal">
    <div class="loader"></div>
</div>

<script>
    function showLoadingModal() {
        document.querySelector(".loading-modal").style.display = "block";
    }

    function hideLoadingModal() {
        document.querySelector(".loading-modal").style.display = "none";
    }
    
    // 페이지 로딩이 시작될 때 로딩 모달 표시
        showLoadingModal();

    // 페이지 로딩이 완료되면 로딩 모달 숨김
    window.addEventListener("load", function() {
        hideLoadingModal();
    });
</script>

</body>
</html>