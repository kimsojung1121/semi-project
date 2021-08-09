<%@page import="dao.NoticeDAO"%>
<%@page import="dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>
<%
	//비정상적이 요청에 대한 처리
	if(request.getParameter("n_no")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;		
	}

	//전달값을 반환받아 저장
	int n_no=Integer.parseInt(request.getParameter("n_no"));
	String pageNum=request.getParameter("pageNum");
	
	
	//글번호를 전달받아 Notice 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	NoticeDTO notice=NoticeDAO.getDAO().selectNotice_No(n_no);

	
	//검색된 게시글이 없거나 검색된 게시글이 삭제글인 경우 - 비정상적인 요청
	if(notice==null || notice.getN_state()==9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}
	
	//로그인 사용자가 게시글 작성자가 아니거나 관리자가 아닌 경우 - 비정상적인 요청
	if(!loginUsers.getId().equals(notice.getId()) && loginUsers.getStatus()!=9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}
%>
<style type="text/css">
table {
	margin: 0 auto;
	
}

th {
	width: 70px;
	font-weight: normal;
}

td {
	text-align: left;
	
}
#noticeForm {
     text-align: center;
}
</style>
<br>
   <br>
      <br>
<h2 align="center">공지사항 수정</h2>
<br>
   <br>
<p align="center"><form action="<%=request.getContextPath()%>/home.jsp?workgroup=notice&work=notice_modify_action"
	method="post" id="noticeForm">
	<input type="hidden" name="n_no" value="<%=n_no%>">	
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="n_title" id="title" size="40" value="<%=notice.getN_title()%>">
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="7" cols="60" name="n_content" id="content"><%=notice.getN_content() %></textarea>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<button type="submit">글변경</button>
				<button type="reset" id="resetBtn">다시쓰기</button>
			</th>
		</tr>
	</table>	
</form>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#title").focus();

$("#noticeForm").submit(function() {
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