<%@page import="dao.ReviewDAO"%>
<%@page import="dto.ReviewDTO"%><%@page import="dao.ReviewDAO"%>
<%@page import="dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
        <%-- ■■■■■■■■■■■■변경 입력 페이지■■■■■■■■■■■■■ --%>

<%@include file="/security/login_check.jspf" %>
<%
	//비정상적이 요청에 대한 처리
	if(request.getParameter("r_no")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;		
	}

	//전달값을 반환받아 저장
	int r_no=Integer.parseInt(request.getParameter("r_no"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	//글번호를 전달받아 Review 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	ReviewDTO reivew=ReviewDAO.getDAO().selectReview_No(r_no);
	
	//검색된 게시글이 없거나 검색된 게시글이 삭제글인 경우 - 비정상적인 요청
	if(reivew==null || reivew.getR_state()==9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}
	
	//로그인 사용자가 게시글 작성자가 아니거나 관리자가 아닌 경우 - 비정상적인 요청
	if(!loginUsers.getId().equals(reivew.getId()) && loginUsers.getStatus()!=9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}
%>
<link href="css/review.css" type="text/css" rel="stylesheet">
<br>
   <br>
      <br>
<h2 align="center" id="title_review">Review 변경</h2>
 <br>
    <div id="message" style="color: red;"></div>
     <br>
<p align="center"><form action="<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_modify_action"
	method="post" id="reviewForm"></p>
	<input type="hidden" name="r_no" value="<%=r_no%>">	
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<input type="hidden" name="search" value="<%=search%>">	
	<input type="hidden" name="keyword" value="<%=keyword%>">	
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="r_title" id="title" size="85" value="<%=reivew.getR_title()%>" style="border: none;">
				<input type="checkbox" name="secret" value="1" 
					<% if(reivew.getR_state()==1) { %>checked="checked"<% } %>>&nbsp;비밀글
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="20" cols="100" name="r_content" id="content" style="border: none;"><%=reivew.getR_content() %></textarea>
			</td>
		</tr>
	</table>
	<div id="savebtn">
		<button type="submit">글변경</button>
		<button type="reset" id="resetBtn">다시쓰기</button>
	</div>
		
</form>

<script type="text/javascript">
$("#title").focus();

$("#reviewForm").submit(function() {
	if($("#title").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#title").focus();
		return false;
	}
	
	if($("#content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#content").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#title").focus();
	$("#message").text("");
});
</script>