<%@page import="dao.ReviewDAO"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="dto.UsersDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
             <%-- ■■■■■■Review 목록(보이는 출력페이지)■■■■■■ --%>
<%

       //검색정보 전달용
       String search=request.getParameter("search");
       if(search==null) { //검색을 안해도 무관
    	    search="";
       }
       //키워드 사용
     	String keyword=request.getParameter("keyword");
     	if(keyword==null) {
   		keyword="";
     	}

       //페이징 처리
       //pageNum : 페이지번호 [1][2][3]..
       int pageNum=1; 
       if(request.getParameter("pageNum")!=null) { //전달값이 있는 경우 해당 페이지 이동
    	                                           //전달값 없을 시 첫페이지로 이동
    	   pageNum=Integer.parseInt(request.getParameter("pageNum"));
       }
     
       //pageSize : 페이지당 개시물 갯수 - 10개
       int pageSize=10; 
       
       //전체 게시글
       int totalReview=ReviewDAO.getDAO().selectReview_Count(search, keyword);//검색기능 포함

     
       //1페이지 시작으로 ~ 끝 즉, 전체 게시물 페이지
       int totalPage=(int)Math.ceil((double)totalReview/pageSize);
     
       //[검증] 없는 페이지를 요청할 경우에 대한 방지
       if(pageNum<=0||pageNum>totalPage) {
      	   pageNum=1; 
         }
       
       //게시글 시작행
       int startRow=(pageNum-1)*pageSize+1;
       //게시글 마지막행
       int endRow=pageNum*pageSize;
       //마지막 페이지에 게시물이 10개 이하일 경우 갯수에 해당하는 만큼 출력(비교)
       if(endRow>totalReview) {
    	 endRow=totalReview;
       }
     
       //시작행 ~ 종료행 사이의 모든 게시물 출력
	   List<ReviewDTO> reviewList=ReviewDAO.getDAO().selectReview_List(startRow, endRow, search, keyword);
  
      //최신순 게시물을 상위에 노출하기위한 것(게시글 순서에 글번호 계산하여 저장) - 글번호 기준 식별자
      int number=totalReview-(pageNum-1)*pageSize; // number → 전역변수
  
      //[Session] - 회원 및 관리자에게만 게시글 사용 권한 부여
      UsersDTO loginUsers =(UsersDTO)session.getAttribute("loginUsers");
    
      //글작성 시 현재 날짜정보 저장
      String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
  
 
      //5페이지 단위 >> [1][2][3][4][5]
	  int blockSize=5;

	  //페이지 블럭 시작 페이지(즉, 1페이지 부터 보이기)
	  int startPage=(pageNum-1)/blockSize*blockSize+1;

	   //페이지 블럭 종료 페이지(즉, 페이지당 끝은 5, 10, 15 - 5단위)
	   int endPage=startPage+blockSize-1;
		
	    //마지막 페이지 블럭 종료시 페이지 번호 맞춰서 종료
	    //ex) [60][61] <<이렇게 끝날 수도 있음
		if(endPage>totalPage) {
			endPage=totalPage;
		}
	%>
<!-- CSS -->
<link href="css/board.css" type="text/css" rel="stylesheet">
<br>
   <br>
      <br>
        <br>
          <br>
<%-- 실질적인 노출 표 + 값 --%>
 <div id="board_title" align="center">상품 후기</div>
<div id="board_list" >
   
	<div>&nbsp;</div>
	<%-- 게시글 검색 --%>
	<form action="<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_list" method="post">
		<!-- select 입력태그에 의해 전달되는 값은 컬럼명과 동일하게 설정 -->
		<p align="center"><select name="search">
			<option value="r_writer">&nbsp;작성자&nbsp;</option>
			<option value="r_title" selected="selected">&nbsp;제목&nbsp;</option>
			<option value="r_content">&nbsp;내용&nbsp;</option>
		</select>
		<input type="text" name="keyword">
		<button type="submit">검색</button>
		</p>
	    	<br>
	</form>
</div>
	
	<table>
		<tr>
			<th width="100">번호</th>
			<th width="500">제목</th>
			<th width="100">작성자</th>
			<th width="100">조회수</th>
			<th width="200">작성날짜</th>
		</tr>
		<%--게시글이 하나도 없을 경우--%>
		<% if(totalReview==0) { %>
		<tr>
			<td colspan="5">검색된 리뷰가 하나도 없습니다.</td>
		</tr>
		<% } else { %>
			<%-- 게시글 목록에서 게시글을 하나씩 제공받아 반복 출력 --%>
			<% for(ReviewDTO review:reviewList) {  %>
			<tr>
				<%-- 글번호 : Review 테이블에 저장된 글번호가 아닌 계산된 글번호 출력 --%>
				<td><%=number %></td>
				
				<%-- 제목 --%>
				<td class="subject">
					<% if(review.getRe_step()!=0) {//답글인 경우 %>
						<%-- 답글의 깊이에 따라 왼쪽 여백을 다르게 설정하여 출력 --%>
						<span style="margin-left: <%=review.getRe_level()*20%>px;">└[답글]</span>
					<% } %>
					
					<%-- 게시글의 상태에 따른 제목 출력과 링크 설정 --%>
					<% if(review.getR_state()==0) {//일반 리뷰일 경우 %>
						<a href="<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_detail&r_no=<%=review.getR_no()%>&pageNum=<%=pageNum%>"><%=review.getR_title()%></a>
					<% } else if(review.getR_state()==1) {//비밀 게시글인 경우 %>
						<span class="secret">비밀글</span>
						<%-- 로그인 사용자 중 게시글 작성자이거나 관리자인 경우 - 권한이 있는 경우 --%>
						<% if(loginUsers!=null && (loginUsers.getId().equals
								(review.getId()) || loginUsers.getStatus()==9)) { %>
							<a href="<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_detail&r_no=<%=review.getR_no()%>&pageNum=<%=pageNum%>"><%=review.getR_title()%></a>
						<% } else {//비밀 리뷰에 대한 권한이 없는 경우 %>
							작성자 또는 관리자만 확인 가능합니다.
						<% } %>
					<% } else if(review.getR_state()==9) {//삭제 게시글인 경우 %>
						<span class="remove">삭제글</span>
						작성자 또는 관리자에 의해 삭제된 게시글입니다.
					<% } %>
				</td>
				<% if(review.getR_state()!=9) {//삭제 게시글이 아닌 경우 %>

					<%-- 작성자 --%>
                   <td><%=review.getR_writer() %></td>
					<%-- 조회수 --%>
					<td><%=review.getReadcount() %></td>
					
					<%-- 작성일 : 오늘 작성된 게시글은 시간만 출력하고 과거에 작성된 게시글은 날짜와 시간 출력 --%>
					<td>
					<% if(currentDate.equals(review.getR_date().substring(0, 10))) {//날짜가 같은 경우 %>
						<%=review.getR_date().substring(11) %> <%-- 시간만 출력 --%>
					<% } else { %>
						<%=review.getR_date().substring(0,10) %> <%-- 날짜와 시간 출력 --%>
					<% } %>	
					</td>
				<% } else {//삭제 게시글인 경우 %>	
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				<% } %>	
			</tr>
			
			<%-- 출력될 글번호 1씩 감소 --%>
			<% number--; %>
			<%} %>
		<% } %>
	</table>
	<br>
	
	  <%--글쓰기 버튼--%>
   <% if(loginUsers != null) {//로그인 사용자인 경우에만 버튼이 보이게함 / 비회원은 버튼이 안보이게함 %>
   <div id="btn">
   <button type="button" onclick="location.href='<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_write';">
   글쓰기</button>
	</div>
	<% } %>
	
	
	<div align="center">
	<% //[처음][이전]...[다음][마지막] + 검색기능(식별자 : 작성자 / 제목 / 내용 포함)
	   if(startPage>blockSize) { %> 76i
		<a href="<%=request.getContextPath()%>/home.jsp?workgroup=qna&work=review_list&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">[처음]</a>
		<a href="<%=request.getContextPath()%>/home.jsp?workgroup=qna&work=review_list&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>
	<% } else { %>
		[처음][이전]
	<% } %>
	
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) { %>
			<a href="<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_list&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i %>]</a>
		<% } else { %>
			[<%=i %>]
		<% } %>
	<% } %>
	
	<% if(endPage!=totalPage) { %>
		<a href="<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_list&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
		<a href="<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_list&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>">[마지막]</a>
	<% } else { %>
		[다음][마지막]
	<% } %>
	

</div>



