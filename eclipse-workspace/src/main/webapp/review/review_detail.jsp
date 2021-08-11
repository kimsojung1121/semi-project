
<%@page import="dao.ReviewDAO"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="dto.UsersDTO"%>
<%@page import="dao.QnaDAO"%>
<%@page import="dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
	//비정상적이 요청에 대한 처리
	if(request.getParameter("r_no")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;		
	}
    //전달받은값 저장
     //전달받은값 저장
	int r_no=Integer.parseInt(request.getParameter("r_no"));
	String pageNum=request.getParameter("pageNum");
	
	String search=request.getParameter("search");
	if (search==null){
		search ="";
	}
	String keyword=request.getParameter("keyword");
	if (keyword==null){
		keyword ="";
	}
    
    
// 	int r_no=Integer.parseInt(request.getParameter("r_no"));
// 	String pageNum=request.getParameter("pageNum");
// 	String search=request.getParameter("search");
// 	String keyword=request.getParameter("keyword");




	//글번호를 전달받아 Review 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	ReviewDTO review=ReviewDAO.getDAO().selectReview_No(r_no);
	
	//검색된 게시글이 없거나 검색된 게시글이 삭제글인 경우 - [비정상적인 요청]
	if(review==null || review.getR_state()==9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}
	
	//세션에 저장된 권한 관련 정보(회원정보)를 반환받아 저장
	UsersDTO loginUsers=(UsersDTO)session.getAttribute("loginUsers");
	
	//검색된 게시글이 비밀글인 경우
	if(review.getR_state()==1) {
		//비로그인 사용자이거나 로그인 사용자가 작성자 또는 관리자가 아닌 경우 - 비정상적인 경우 
		if(loginUsers==null || !loginUsers.getId().equals(review.getId())
				&& loginUsers.getStatus()!=9) {
			out.println("<script type='text/javascript'>");
			out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
			out.println("</script>");
			return;
		}
	}
	
	//조회수증가
	ReviewDAO.getDAO().updateReviewCount(r_no);
	
%>
<style type="text/css">
#review_detail {
	margin: 0 auto;
}

table {
	border: 1px solid black;
	border-collapse: collapse;
	width : 1000px;
	margin: 0 auto;
}

th, td {
	border: 1px solid RGB(200,200,200);
	padding: 5px;
	line-height : 50px;
}

th { width: 100px; 
     background-color: #f7f7f7;
     font-size: 20px;
}
  

td { width: 400px;
     text-align: center;
      font-size: 15px;
           
 }

.title, .content, .writer { text-align: left; }
	
.content {
	height: 400px;
	vertical-align: middle;
}

#review_menu {
/* 	text-align: right; */
/* 	margin: 5px; */
   text-align : center;
	max-width : 1000px;
    min-width : 50px;
	margin: 0 auto;
	font-size: 50px;
}
#review_menu button {
	border: 1px solid RGB(254,199,158);
	padding: 6px 20px;
	border-radius: 10px;
	background-color: RGB(254,199,158);
	color: #fff;
	font-size: 14px;
}
#title_review {
    font-size: 2.5em
}
#listBtn {
   text-align : center;
	max-width : 1000px;
    min-width : 50px;
	margin: 0 auto;
}
</style>

<div id="review_detail">
<br>
   <br>
      <br>
         <br>
            <br>
	<h2 align="center" id="title_review">상품 후기</h2>
            <br>
         <br>
      <div>
	<table>
		<tr>
			<th><p id="background_color">제목</p></th>
			<td class="title" colspan="4">
				<% if(review.getR_state()==1) {//비밀글인 경우 %>
					[비밀글]
				<% } %>
				<%=review.getR_title() %>
			</td>
		</tr>
		<tr>
			<th><p id="background_color">작성자</p></th>
			<td class="writer" colspan="4">
				<%=review.getR_writer() %>
				<% if(loginUsers!=null && loginUsers.getStatus()==9) {//관리자인 경우 %>
				<% } %>
			</td>
		</tr>
		<tr>
			<th><p id="background_color">작성일</p></th>
			<td><%=review.getR_date().substring(0,10)%></td>
			<th><p id="background_color">조회수</p></th>
			<td><%=review.getReadcount()+1 %></td>
		</tr>
		<tr>
			<th><p id="background_color">내용</p></th>
			<td class="content" colspan="4"><%=review.getR_content().replace("\n", "<br>") %></td>
		</tr>	
	</table>
   	 </div> 
	
	<div id="review_menu">
		<%-- 로그인 사용자가 작성자이거나 관리자인 경우에만 삭제와 변경 기능 제공 --%>
		<% if(loginUsers!=null && (loginUsers.getId().equals
				(review.getId()) || loginUsers.getStatus()==9)) { %>
			<button type="button" id="removeBtn">글삭제</button>
			<button type="button" id="modifyBtn">글변경</button>
		<% } %>		
		<%-- 로그인 사용자인 경우에만 답글 기능 제공 --%>
		<% if(loginUsers!=null) { %>
			<button type="button" id="replyBtn">답글쓰기</button>
		<% } %>
		<button type="button" id="listBtn">글목록</button>
	</div>
	
	<form id="reviewForm" method="post">
	                      <%--보낼 값 선언 --%>                      
		<%-- 게시글 변경 입력페이지와 삭제 처리 페이지 요청시 전달값 --%>
		<input type="hidden" name="r_no" value="<%=review.getR_no()%>">
		<%-- 답글 입력페이지 요청시 전달값 --%>
		<input type="hidden" name="ref" value="<%=review.getRef()%>">
		<input type="hidden" name="re_Step" value="<%=review.getRe_step()%>">
		<input type="hidden" name="re_Level" value="<%=review.getRe_level()%>">
		<%-- 게시글 목록 출력페이지 요청시 전달값 --%>
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="search" value="<%=search%>">
		<input type="hidden" name="keyword" value="<%=keyword%>">
	</form>
	
	<script type="text/javascript">
	$("#removeBtn").click(function() {
		if(confirm("정말로 게시글을 삭제 하시겠습니까?")) {
			$("#reviewForm").attr("action", "<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_remove_action");
			$("#reviewForm").submit();
		}
	});
	
	$("#modifyBtn").click(function() {
		$("#reviewForm").attr("action", "<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_modify");
		$("#reviewForm").submit();
	});
	
	$("#replyBtn").click(function() {
		$("#reviewForm").attr("action", "<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_write");
		$("#reviewForm").submit();
	});
	
	$("#listBtn").click(function() {
		$("#reviewForm").attr("action", "<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_list&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>");
		$("#reviewForm").submit();
	});
	</script>	
</div>







