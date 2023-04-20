<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>헬스로운 평화나라</title>
<head>
<meta charset="UTF-8">
<title>헬스로운 평화나라</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="calendar-gc.min.css" />
<script src="calendar-gc.min.js"></script>
	<style>
.body {
	background-color: #17171f;
	color: white;
}

.menu-tickets, .menu-reservation {
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
}

.reservation-label-container {
	margin: 20px auto;
	border: 1px solid #fff;
	padding: 20px;
}

.reservation-label-header {
	font-size: 24px;
	font-weight: bold;
	border-left: 2px solid #fff;
	padding: 10px 5px;
}

.reservation-label-body {
	line-height: 1.8;
	margin-top: 10px;
	font-size: 14px;
}

.calendar-label-container {
	margin: 50px;
	text-align: center;
}

.calendar-label {
	animation: shake 2s ease-in-out infinite; /* 애니메이션 지정 */
	font-size: 24px;
}

@keyframes shake {
  0% { transform: translateY(-10px); } /* 중간 위치 */
  50% { transform: translateY(0); } /* 애니메이션 시작 위치 */
  100% { transform: translateY(-10px); } /* 중간 위치 */
}

.calendar-container {
	display: flex;
	flex-direction: column;
	align-items: center;
}
.event-status {
  margin-left: 5px;
  color: gray;
  font-weight: normal;
}
</style>
</head>

<%
String alertList = request.getParameter("answer");
System.out.println("alertList : " + alertList); 
%>

<header>
	<%@ include file="header.jsp"%>
	<%@ include file="loadingModal.jsp"%>
</header>

<body class="body">
<%
request.setCharacterEncoding("UTF-8");
String ticketId = request.getParameter("ticketType");
System.out.println("ticketId Calendar: "+ticketId);
%>

	<div class="body-container">
		<p class="body-label">메인 > 헬창PT > 예약하기</p>
		<div class="reservation-label-container">
			<div class="reservation-label-header">퍼스널 트레이닝 예약 🔖</div>
			<div class="reservation-label-body">
				어딜 보시는 겁니까?<br>
				그건 지방의 <b>잔상</b>입니다만?
			</div>
		</div>
		<!-- 달력 컨테이너 -->
		<div class="calendar-label-container">
			<h3 class="calendar-label">🔽 예약하실 날짜를 선택해주세요 🔽</h3>
		</div>
		<div id="calendar"></div>
	</div>
</body>

</head>

<script>

//함수는 서버에서 회원 목록을 가져온다.
    function fetchReservations() {
        return $.ajax({
            url: "fetchReservations.jsp",
            method: "GET",
            dataType: "json"
        });
    }
//회원 목록을 인자로 받아 각 회원에 대한 달력 이벤트 객체를 생성하고, 이벤트 객체 배열을 반환한다.
    function createCalendarEvents(reservationList) {
    const reservationEvents = [];
    const eventUrl = "reservation.jsp?id=";
    const alertList = '<%= request.getParameter("answer") %>';
    reservationList.reverse().forEach(function (reservation) {
        let reservationTime = reservation.exerciseDateTime.slice(-11);
        let reservationDate = reservation.exerciseDateTime.split(',')[1] +' '+reservation.exerciseDateTime.split(',')[0];
        console.log("reservation.reservationId:", reservation.reservationId);
        
        let amPm = reservationTime.slice(-2);
        let timeParts = reservationTime.slice(0, -3).split(':');
        let hours = parseInt(timeParts[0], 10);
        let formattedTime;
        if (amPm === 'PM' && hours !== 12) {
            formattedTime = '오후 ' + hours + '시 ';
        } else if (amPm === 'AM' && hours === 12) {
            hours = 0;
            formattedTime = '오전 ' + hours + '시 ';
        } else {
            formattedTime = '오전 ' + hours + '시 ';
        }
        
		const c = '(취소됨)';
		const a = '(대기중)';
		const p = '확정하기';
	      //console.log("예약 아이디 넘어가는지 확인!!!", reservation.reservationId);
	      if (alertList.includes(reservation.reservationId)){
	           const reservationEvent = {
	                date: new Date(reservation.exerciseDateTime),
	                eventName: '<a href="myReservation.jsp?id=' + reservation.reservationId + '">' + formattedTime + '</a>' +
	                '<button onclick="window.location.href=\'reservationUpdatePro.jsp?id=' + reservation.reservationId + '\'">' + p + '</button>',
	                eventDesc: formattedTime,
	                className: "badge bg-info",
	                dateColor: "red"
	            };
	           reservationEvents.push(reservationEvent);
	       }else if (reservation.isState == 0 && reservation.isAwaiter == 0) {
        	const reservationEvent = {
                date: new Date(reservation.exerciseDateTime),
                eventName: '<a href= myReservation.jsp?id=' + reservation.reservationId + '>' + formattedTime + c + '</a>',
                eventDesc: formattedTime,
                className: "badge bg-info",
                dateColor: "red"
            };
            reservationEvents.push(reservationEvent);
        } else if (reservation.isState == 0 && reservation.isAwaiter == 1) {
        	const reservationEvent = {
                    date: new Date(reservation.exerciseDateTime),
                    eventName: '<a href= myReservation.jsp?id=' + reservation.reservationId + '>' + formattedTime + a + '</a>',      
                    eventDesc: formattedTime,
                    className: "badge bg-info",
                    dateColor: "red"
                };
                reservationEvents.push(reservationEvent);
        }else {
        	const reservationEvent = {
                date: new Date(reservation.exerciseDateTime),
                eventName: '<a href= myReservation.jsp?id=' + reservation.reservationId + '>' + formattedTime + '</a>',
                eventDesc: formattedTime,
                className: "badge bg-info",
                dateColor: "red"
            };
            reservationEvents.push(reservationEvent);
        }
    });
    return reservationEvents;
}

    
//(취소),(대기)
	
//달력의 이벤트 렌더링을 사용자 정의하여, 이벤트가 3개를 초과하면 "..." 으로 표시하도록 설정
    function customizeCalendarEventRendering(calendar) {
        calendar.onRenderDay = function (e, data) {
            if (data.cell.hasClass("badge")) {
                const $badge = data.cell.find(".badge");
                const events = $badge.text().split(",");

                if (events.length > 3) {
                    $badge.text(events.slice(0, 3).join(",") + "...");
                }
            }
        };
    } 
    
    const date = new Date();
    let year = date.getFullYear();
    let month = date.getMonth()+1;
    let day = date.getDate();

    if ((day+"").length < 2) {
        day = "0" + day;
    }
    if ((month+"").length < 2) {
    	month = "0" + month;
    }
    
    const getDate = year + month + day;
    
//문서가 준비되면 실행되며, 달력을 초기화하고 회원 목록을 가져온 후, 회원 가입일 이벤트를 달력에 추가하고 렌더링.
//이 과정에서 사용자 정의 렌더링도 적용
    $(document).ready(function () {
  const calendar = $("#calendar").calendarGC({
    dayBegin: 0,
    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
    monthNames: [
      '🗓️ 1월', '🗓️ 2월', '🗓️ 3월', '🗓️ 4월', '🗓️ 5월', '🗓️ 6월', '🗓️ 7월',
      '🗓️ 8월', '🗓️ 9월', '🗓️ 10월', '🗓️ 11월', '🗓️ 12월'
    ],
    nextIcon: '&gt;',
    prevIcon: '&lt;',
    onPrevMonth: function (e) {
    },
    onNextMonth: function (e) {
    },
    onclickDate: function (e, data) {
        let clickedDate = data.date;
        let clickedYear = data.year;
        let clickedMonth = data.month;

        if ((clickedDate+"").length < 2) {
        	clickedDate = "0" + clickedDate;
        }
        if ((clickedMonth+"").length < 2) {
        	clickedMonth = "0" + clickedMonth;
        }
        let clicked = clickedYear + clickedMonth + clickedDate;
        
    	if(getDate > clicked){
            alert("현재날짜 이후 날짜로 예약 가능합니다"); 
    	}else{

        const url = "ticketList.jsp" +
          "?clickedYear=" + clickedYear +
          "&clickedMonth=" + clickedMonth +
          "&clickedDate=" + clickedDate;

        window.location.href = url; // GET 방식으로 URL을 호출합니다.
      }
    }
    });

    fetchReservations().done(function (reservationList) {
      const reservationEvents = createCalendarEvents(reservationList);
      calendar.setEvents(reservationEvents);
      customizeCalendarEventRendering();
      calendar.render();
    });
  });
  
    $(document).ready(function () {
    	  $('html, body').animate({
    	    scrollTop: $(".calendar-label").offset().top
    	  }, 500);
    	});
</script>
<footer>
	<%@ include file="footer.jsp"%>
</footer>

</html>