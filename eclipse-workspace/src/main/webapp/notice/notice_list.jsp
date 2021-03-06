<%@page import="dao.NoticeDAO"%>
<%@page import="dto.NoticeDTO"%>
<%@page import="dto.UsersDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   

<%

       

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
       int totalNotice=NoticeDAO.getDAO().selectAll_Notice();

     
       //1페이지 시작으로 ~ 끝 즉, 전체 게시물 페이지
       int totalPage=(int)Math.ceil((double)totalNotice/pageSize);
     
       //[검증] 없는 페이지를 요청할 경우에 대한 방지
       if(pageNum<=0||pageNum>totalPage) {
      	   pageNum=1; 
         }
       
       //게시글 시작행
       int startRow=(pageNum-1)*pageSize+1;
       //게시글 마지막행
       int endRow=pageNum*pageSize;
       //마지막 페이지에 게시물이 10개 이하일 경우 갯수에 해당하는 만큼 출력(비교)
       if(endRow>totalNotice) {
    	 endRow=totalNotice;
       }
     
       //시작행 ~ 종료행 사이의 모든 게시물 출력
	   List<NoticeDTO> noticeList=NoticeDAO.getDAO().selectNotice_List(startRow, endRow);
  
      //최신순 게시물을 상위에 노출하기위한 것(게시글 순서에 글번호 계산하여 저장) - 글번호 기준 식별자
      int number=totalNotice-(pageNum-1)*pageSize; // number → 전역변수
  
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
<style type="text/css">

#notice_title {
	font-size: 2.5em;
	font-weight: bold;
	margin: 3px 0;
}


#btn {
   text-align : right;
	max-width : 1000px;
    min-width : 50px;
	margin: 0 auto;
}
#btn button {
	border: 1px solid RGB(254,199,158);
	padding: 6px 20px;
	border-radius: 10px;
	background-color: RGB(254,199,158);
}

table {
	margin: 5px auto;
	border: 1px solid pink;
	border-collapse: collapse;
	width : 80%;
}

th {
	border: 1px RGB(254,199,158);
	background: RGB(254,199,158);
	color: white;
}

td {
	border: 1px solid RGB(254,199,158);
	text-align: center;
}

.title {
	text-align: left;
	padding: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

#notice_list a:hover {
	text-decoration: none;
	color: blue;
}

.secret, .remove {
	background: pink;
	color: white;
	font-size: 14px;
	border: 1px solid pink;
	border-radius: 4px;
}
.container{
	margin-top: 500px;
}
a:link { 

 color: #58595b;

 text-decoration: none;

}

a:visited {

 color: #58595b;

 text-decoration: none;

}

a:hover {

 color: #58595b;

 text-decoration: none;

}

a:active {

 color: #58595b;

 text-decoration: none;

}

</style>
<br>
<br>
<br>
<br>
<br>
<%-- 실질적인 노출 표 + 값 --%>
	<div id="notice_title" align="center">공지사항</div>
	   <hr>
	<br>
	<table>
		<tr>
			<th width="100">번호</th>
			<th width="500">제목</th>
			<th width="100">조회수</th>
			<th width="200" >작성날짜</th>
		</tr>
		<%--게시글이 하나도 없을 경우--%>
		<% if(totalNotice==0) { %>
		<tr>
			<td colspan="4">검색된 공지사항이 하나도 없습니다.</td>
		</tr>
		<% } else { %>
			<%-- 게시글 목록에서 게시글을 하나씩 제공받아 반복 출력 --%>
			<% for(NoticeDTO notice:noticeList) {  %>
			<tr>
				<%-- 글번호 : notice 테이블에 저장된 글번호가 아닌 계산된 글번호 출력 --%>
				<td><%=number %></td>
				
				<%-- 제목 --%>
				<td class="title" >
					<%-- 게시글의 상태에 따른 제목 출력과 링크 설정 --%>
					<% if(notice.getN_state()==0) { %>	
		<a href="<%=request.getContextPath()%>/home.jsp?workgroup=notice&work=notice_detail&n_no=<%=notice.getN_no()%>&pageNum=<%=pageNum%>"><%=notice.getN_title()%></a>		
					<% } else if(notice.getN_state()==9) {//삭제 게시글인 경우 %>
						<span class="remove">삭제글</span>
						 삭제된 글입니다.
					<% } %>
				</td>
				<% if(notice.getN_state()!=9) {//삭제 게시글이 아닌 경우 %>
					<%-- 조회수 --%>
					<td><%=notice.getReadcount() %></td>
					
					<%-- 작성일 : 오늘 작성된 게시글은 시간만 출력하고 과거에 작성된 게시글은 날짜와 시간 출력 --%>
					<td>
					<% if(currentDate.equals(notice.getN_date().substring(0, 10))) {//날짜가 같은 경우 %>
						<%=notice.getN_date().substring(11) %> <%-- 시간만 출력 --%>
					<% } else { %>
						<%=notice.getN_date().substring(0,10) %> <%-- 날짜만 출력 --%>
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
			<% if(loginUsers.getStatus()==9) { //로그인 사용자 중 관리자만 작성 가능 %>
				<div id="btn">
				<button type="button" onclick="location.href='<%=request.getContextPath()%>/home.jsp?workgroup=notice&work=notice_write';">
				글쓰기
				</button>
				</div>
			<% } %>
		<% } %>
	
	
	
<div align="center">
	<% //[처음][이전]...[다음][마지막] + 검색기능(식별자 : 작성자 / 제목 / 내용 포함)
	   if(startPage>blockSize) { %> 
		<a href="<%=request.getContextPath()%>/home.jsp?workgroup=notice&work=notice_list&pageNum=1">[처음]</a>
		<a href="<%=request.getContextPath()%>/home.jsp?workgroup=notice&work=notice_list&pageNum=<%=startPage-blockSize%>">[이전]</a>
	<% } else { %>
		[처음][이전]
	<% } %>
	
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) { %>
			<a href="<%=request.getContextPath()%>/home.jsp?workgroup=notice&work=notice_list&pageNum=<%=i%>">[<%=i %>]</a>
		<% } else { %>
			[<%=i %>]
		<% } %>
	<% } %>
	
	<% if(endPage!=totalPage) { %>
		<a href="<%=request.getContextPath()%>/home.jsp?workgroup=notice&work=notice_list&pageNum=<%=startPage+blockSize%>">[다음]</a>
		<a href="<%=request.getContextPath()%>/home.jsp?workgroup=notice&work=notice_list&pageNum=<%=totalPage%>">[마지막]</a>
	<% } else { %>
		[다음][마지막]
	<% } %>
	

</div>



