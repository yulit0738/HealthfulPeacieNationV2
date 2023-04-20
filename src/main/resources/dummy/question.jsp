<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 게시판(Q&A)</title>
</head>
<body>
<%
	String userId = (String) session.getAttribute("loginId");
%>

	<form action="questionPro.jsp" method="post">
		<h2>문의</h2>
		<input type="hidden" name=userId value="<%=userId%>">
		<div>
			<select name="category">
				<option value="exercise" selected="selected">exercise</option>
				<option value="goods">goods</option>
			</select>
		</div>
		<div>
			<select name="goodsId">
				<option value="goods1" selected="selected">goods1</option>
				<option value="goods2">goods2</option>
				<option value="goods3">goods3</option>
				<option value="goods4">goods4</option>
				<option value="goods5">goods5</option>
			</select>
		</div>
		<div>
			<input type="text" name="title" required="required">
		</div>
		<div>
			<textarea rows="5" cols="100" name="content" required="required">
			</textarea>
		</div>
		
	<%	
		String admin = "admin";
		if (userId != null && admin.equals(userId)) {
	%>
		<div>
			<input type="text" name="reply" placeholder="관리자의 답변란입니다.">
		</div>
	<%
		}
		
	%>	
		
		<div>
	    	<button type="submit">작성</button>
	    	<button type="reset">취소</button>
	    	<button type="button" onclick="location.href='questionList.jsp'"><b>문의글 목록</b></button>
	    	<button type="button" onclick="location.href='reservationInput.jsp'"><b>예약</b></button>

	    </div>
	</form>

</body>
</html>