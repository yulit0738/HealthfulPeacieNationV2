<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dto.QuestionDTO"%>
<%@page import="service.QuestionService"%>
<%@page import="service.QuestionServiceImpl"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의글 목록</title>
<style>
    body {
        font-family: Arial, sans-serif;
    }
    header {
        background-color: #f1f1f1;
        padding: 20px;
        text-align: center;
    }
    table {
        width: 80%;
        margin: 50px auto;
        border-collapse: collapse;
    }
    th, td {
        padding: 10px;
        text-align: center;
        border-bottom: 1px solid #dddddd;
    }
    th {
        background-color: #f2f2f2;
    }
    tr:hover {
        background-color: #f5f5f5;
    }
    form {
        text-align: center;
    }
    button {
        margin-right: 10px;
    }
</style>
</head>
<body>

<header>
    <h1>문의글 목록</h1>
</header>


<body>
   <%
      //데이터베이스 연결을 위한 객체 생성-mvc2 방식
      QuestionService questionService = new QuestionServiceImpl();
      
      int pageSize = 10; //한 페이지에 출력되는 글(리스트) 개수
      String userId = (String) session.getAttribute("loginId");
      String category = request.getParameter("category");
      String state = request.getParameter("state");
      String pageNumber = request.getParameter("pageNumber"); //현재페이지 String타입
      int currentPageNumber = 0;  //현재페이지 int 타입 
      String searchBy = request.getParameter("searchBy"); //현재페이지 String타입

      int totalCount = 0;
      //글의 총 개수
    		if(totalCount == 0){
    			totalCount = questionService.getAllcount();
    		}
      if(category == null){
         category = "";
      }
      if(searchBy == null){
         searchBy = "";
      }
      if(state == null){
         state = "";
      }
      if(pageNumber == null){ //처음이면 = 첫페이지이면
         pageNumber = "1";
      }
      try{
         currentPageNumber = Integer.parseInt(pageNumber); //현재페이지 int 타입 변환
      }catch(Exception e){
         System.err.println("페이지 숫자가 올바르지 않습니다.");
      }
      
      
      List<QuestionDTO> questionAllDto = new ArrayList<>();   //가져온 dto   
      questionAllDto = questionService.getList();
      
      List<QuestionDTO> questionDto = new ArrayList<>(); //add할 dto
      
      //questionDto 초기화
      if (searchBy != null && !searchBy.equals("")) { 
            if(category != null && !category.equals("")){
               if(category.equals("writer")){
                  for(QuestionDTO question: questionAllDto){
                     if(question.getUserId().contains(searchBy)){
                        if(state != null && !state.equals("")){
                           if(state.equals("yes")){
                              if (question.getReply() != null && !question.getReply().isEmpty()) {
                                 questionDto.add(question);
                              }
                           }else if(state.equals("no")){
                              if (!(question.getReply() != null && !question.getReply().isEmpty())) {
                                 questionDto.add(question);
                              }
                           }
                        }else{
                            questionDto.add(question);
                         }
                     }
                  }   
               }
               if(category.equals("title")){
                  for(QuestionDTO question: questionAllDto){
                     if(question.getTitle().contains(searchBy)){
                        if(state != null && !state.equals("")){
                           if(state.equals("yes")){
                              if (question.getReply() != null && !question.getReply().isEmpty()) {
                                 questionDto.add(question);
                              }
                           }else if(state.equals("no")){
                              if (!(question.getReply() != null && !question.getReply().isEmpty())) {
                                 questionDto.add(question);
                              }
                           }
                        }else{
                            questionDto.add(question);
                         }
                     }
                  }   
               }
               if(category.equals("content")){
                  for(QuestionDTO question: questionAllDto){
                     if(question.getContent().contains(searchBy)){
                        if(state != null && !state.equals("")){
                           if(state.equals("yes")){
                              if (question.getReply() != null && !question.getReply().isEmpty()) {
                                 questionDto.add(question);
                              }
                           }else if(state.equals("no")){
                              if (!(question.getReply() != null && !question.getReply().isEmpty())) {
                                 questionDto.add(question);
                              }
                           }
                        }else{
                            questionDto.add(question);
                         }
                     }
                  }   
               }
               if(category.equals("reply")){
                  for(QuestionDTO question: questionAllDto){
                     if((question.getReply() !=null && question.getReply().contains(searchBy))){
                        if(state != null && !state.equals("")){
                           if(state.equals("yes")){
                              if (question.getReply() != null && !question.getReply().isEmpty()) {
                                 questionDto.add(question);
                              }
                           }else if(state.equals("no")){
                              if (!(question.getReply() != null && !question.getReply().isEmpty())) {
                                 questionDto.add(question);
                              }
                           }
                        }else{
                            questionDto.add(question);
                         }
                     }
                  }   
               }
            } else {
               for(QuestionDTO question: questionAllDto){
                  if (question.getUserId().contains(searchBy) || question.getTitle().contains(searchBy) || question.getContent().contains(searchBy) || (question.getReply() !=null && question.getReply().contains(searchBy))) {
                     if(state != null && !state.equals("")){
                        if(state.equals("yes")){
                           if (question.getReply() != null && !question.getReply().isEmpty()) {
                              questionDto.add(question);
                           }
                        }else if(state.equals("no")){
                           if (!(question.getReply() != null && !question.getReply().isEmpty())) {
                              questionDto.add(question);
                           }
                        }
                     }else{
                           questionDto.add(question);
                     }
                  }
               }
            }
      }else{
         for(QuestionDTO question: questionAllDto){
            if(state != null && !state.equals("")){
               if(state.equals("yes")){
                  if (question.getReply() != null && !question.getReply().isEmpty()) {
                     questionDto.add(question);
                  }
               }else if(state.equals("no")){
                  if (!(question.getReply() != null && !question.getReply().isEmpty())) {
                     questionDto.add(question);
                  }
               }else{
                  questionDto.add(question);
               }
            }else//모든 리스트가 questionDto에 들어감
            questionDto = questionAllDto;
         }
      }//questionDto 초기화 끝

      
       int totalQuestions = questionDto.size(); //총 게시글 수
       
       int lastPageQuestions = totalQuestions % 10; //마지막 페이지의 게시글 수
       if(lastPageQuestions == 0){
    	   lastPageQuestions = 10;
       }
       
       int lastPageNumber = 0; //밑에 페이지 넘버로 나오는 마지막 숫자         

       lastPageNumber = ((totalQuestions -1) / 10)+1;
      
       int onePageQuestionCount = 0;         //현재페이지 게시글 갯수
       int onePageQuestionPerIndex = 0;   //직전 페이지의 마지막 인덱스 번호, 이 다음 수부터 현재 페이지 인덱스로 사용
       int questionIndex = 0; //리스트인덱스 호출 번호 = onePageQuestionPerIndex + onePageQuestionCount
       
       onePageQuestionPerIndex = ( currentPageNumber -1 ) * 10 ; //시작index = ( intPageNumber -1 ) * 10
       int countContain=0;
      
      %>      

      <h2 align>문의글 목록(<%= totalCount%>)</h2>
         <table align="center">
            <tr height="40" align="center">
               <td width="150">글번호</td>
               <td width="150">작성자</td>
               <td width="150">대분류</td>
               <td width="150">제목</td>
               <td width="150">문의글 작성 시간</td>
               <td width="150">답변</td>
            </tr>   
            
         <% 
try{
         if(lastPageNumber == currentPageNumber){
        	//onePageQuestionCount<lastPageQuestions: 한페이지에 들어가는 개수를 찾는 횟수가 마지막 페이지의 게시글 번호보다 작아야 함
              for( onePageQuestionCount = 0 ;onePageQuestionCount<lastPageQuestions; onePageQuestionCount++) {
                  questionIndex = onePageQuestionPerIndex + onePageQuestionCount;               %>
               
             <tr height="40" align="center">
                <td><%=questionDto.get(questionIndex).getQuestionId() %></td>
                <td><%=questionDto.get(questionIndex).getUserId() %></td>
                <td><%=questionDto.get(questionIndex).getCategory() %></td>
                <td><a href="questionDetail.jsp?id=<%=questionDto.get(questionIndex).getQuestionId() %>"><%=questionDto.get(questionIndex).getTitle() %></a></td>
                <td><%=questionDto.get(questionIndex).getCreatedAt() %></td>
                <td><%=questionDto.get(questionIndex).getReply() %></td>
             </tr>
      <%
               }
         }
         else{
              for( onePageQuestionCount = 0 ;onePageQuestionCount<pageSize; onePageQuestionCount++) {
                 questionIndex = onePageQuestionPerIndex + onePageQuestionCount ;
              %>
             <tr height="40" align="center">
                <td><%=questionDto.get(questionIndex).getQuestionId() %></td>
                <td><%=questionDto.get(questionIndex).getUserId() %></td>
                <td><%=questionDto.get(questionIndex).getCategory() %></td>
                <td><a href="questionDetail.jsp?id=<%=questionDto.get(questionIndex).getQuestionId() %>"><%=questionDto.get(questionIndex).getTitle() %></a></td>
                <td><%=questionDto.get(questionIndex).getCreatedAt() %></td>
                <td><%=questionDto.get(questionIndex).getReply() %></td>
             </tr>
        <%
              }
           }
         if(totalQuestions != 0){
     		%>
     		<h2 align>검색 결과(<%=totalQuestions%>)</h2>
     		<%
     		}
}catch (Exception e){
    //e.printStackTrace();
    System.out.println("검색결과 없음");
    %>
    <script>
       alert("검색 결과가 없습니다.");
    </script>
    <%
}
      %>
      </table>
      
         <form action="questionList.jsp" method="get">
      <% 
         String check1[] = {"", "", "", "", ""};
         String ET1 = category;
         String ET1_1[] = {"", "writer", "title", "content", "reply"};
         
         for(int i=0;i<2;i++){
            if(ET1.equals(ET1_1[i])){
               check1[i] = "selected";
            }
         }
      %>
      <select name="category">
           <option value="" <%=check1[0]%>>통합</option>
           <option value="writer" <%=check1[1]%>>아이디</option>
           <option value="title" <%=check1[2]%>>제목</option>
           <option value="content" <%=check1[3]%>>내용</option>
           <option value="reply" <%=check1[4]%>>답변</option>
      </select>
      <input type="search" name="searchBy">
      <% 
         String check2[] = {"", "", ""};
         String ET2 = state;
         String ET2_1[] = {"", "yes", "no"};
         
         for(int i=0;i<2;i++){
            if(ET2.equals(ET2_1[i])){
               check2[i] = "selected";
            }
         }
      %>
      <select name="state">
        <option value="" <%=check2[0]%>>답변 여부</option>
        <option value="yes" <%=check2[1]%>>답변 완료</option>
        <option value="no" <%=check2[2]%>>미답변</option>
      </select>
     <input type="submit" value="검색">
   </form>
   <p align="center">
   <%
   int count = totalQuestions;
   if(count > 0){
      // 124 / 10 +(124 % 10) = 124 / 10 + 1 = 13
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0:1);
      
      int startPage = 1;
      
      if(currentPageNumber % 10 != 0){ // 124
         startPage = (int)(currentPageNumber / 10) * 10 + 1;
      }else{
         startPage = (int)(currentPageNumber / 10 - 1) * 10 + 1;
      }
      //한페이지당 표시할 번호수
      int pageBlock = 10;
      
      //화면에 보여줄 마지막 페이지 숫자 
      int endPage = startPage + pageBlock - 1;// 13 + 10 - 1 = 22 
      
      //이전 페이지 링크 작성
      if(endPage > pageCount){
         endPage = pageCount;
      }
      
      if(startPage > 10) {
   %>
      <a href="questionList.jsp?pageNumber=<%=startPage - 10 %>&searchBy=<%=searchBy %>&category=<%=category %>&state=<%=state %>">[이전페이지]</a>
   <%
      }
      
      for(int i=startPage; i <= endPage; i++){
   %>
      <a href="questionList.jsp?pageNumber=<%=i %>&searchBy=<%=searchBy %>&category=<%=category %>&state=<%=state %>">[<%=i %>]</a>
   <%
         }   
      
      //[next]링크 작성
      if(endPage < pageCount){
   %>
      <a href="questionList.jsp?pageNumber=<%=startPage + 10 %>&searchBy=<%=searchBy %>&category=<%=category %>&state=<%=state %>">[다음 페이지]</a>   
   <%
         }         
      }
   %>   
   </p>
   
   
</body>
</html>