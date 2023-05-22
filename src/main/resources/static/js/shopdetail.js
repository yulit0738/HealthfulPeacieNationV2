    // 상품 링크 복사
	function copyToClipboard() {
        navigator.clipboard.writeText(window.location.href)
            .then(() => {
                alert('상품 링크가 복사되었습니다! "Ctrl+V" 로 붙여넣기 하세요!');
            })
    }

    // 모든 리뷰 보기
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

	// 문의글 남기기 버튼 비동기 처리
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

	// 페이지가 언로드되기 전에 현재 스크롤 위치를 저장
	window.addEventListener('beforeunload', function() {
		sessionStorage.setItem('scrollPosition', window.scrollY);
	});

	// 페이지가 로드되었을 때 이전 스크롤 위치로 이동
	window.addEventListener('load', function() {
		var scrollPosition = sessionStorage.getItem('scrollPosition');
		if (scrollPosition) {
			window.scrollTo(0, parseInt(scrollPosition));
		}
	});