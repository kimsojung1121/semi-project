<%@page import="dao.NoticeDAO"%>
<%@page import="dto.NoticeDTO"%>
<%@page import="dto.UsersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//비정상적이 요청에 대한 처리
	if(request.getParameter("n_no")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;		
	}
    //전달받은값 저장
	int n_no=Integer.parseInt(request.getParameter("n_no"));
	String pageNum=request.getParameter("pageNum");
	

	//글번호를 전달받아 notice 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	NoticeDTO notice=NoticeDAO.getDAO().selectNotice_No(n_no);
	
	
	//검색된 게시글이 없거나 검색된 게시글이 삭제글인 경우 - [비정상적인 요청]
	if(notice==null || notice.getN_state()==9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}
	
	//세션에 저장된 권한 관련 정보(회원정보)를 반환받아 저장
	UsersDTO loginUsers=(UsersDTO)session.getAttribute("loginUsers");
	
	
	//조회수증가
	NoticeDAO.getDAO().updateNoticeCount(n_no);
	
%>
<style type="text/css">
#notice_detail {
	margin: 0 auto;
}

table {
    align-content : center;
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
.title, .content { text-align: left; }
	
.content {
	height: 400px;
	vertical-align: middle;
}

#notice_menu {
   text-align : center;
	max-width : 1000px;
    min-width : 50px;
	margin: 0 auto;
	font-size: 50px;
}
#notice_menu button {
	border: 1px solid RGB(254,199,158);
	padding: 6px 20px;
	border-radius: 10px;
	background-color: RGB(254,199,158);
	color: #fff;
	font-size: 14px;
}
#title_notice {
    font-size: 2.5em
}
#listBtn {
   text-align : center;
	max-width : 1000px;
    min-width : 50px;
	margin: 0 auto;
}
</style>

<div id="notice_detail">
<br>
   <br>
      <br>
         <br>
            <br>
	<h2 align="center" id="title_notice">공지사항 상세</h2>
            <br>
         <br>
     <div>
	<table>
		<tr>
			<th><p id="background_color">제목</p></th>
			<td class="title" colspan="4">
			<%=notice.getN_title() %>
			</td>
		</tr>
		<tr>
			<th><p id="background_color">작성일</p></th>
			<td><%=notice.getN_date() %></td>
			<th><p id="background_color">조회수</p></th>
			<td><%=notice.getReadcount()+1 %></td>
		</tr>
		<tr>
			<th><p id="background_color">내용</p></th>
			<td class="content" colspan="4"><%=notice.getN_content().replace("\n", "<br>") %></td>
		</tr>	
	</table>
	    </div>
	
	<div id="notice_menu">
		<%-- 로그인 사용자가 작성자이거나 관리자인 경우에만 삭제와 변경 기능 제공 --%>
		<% if(loginUsers!=null && (loginUsers.getId().equals
				(notice.getId()) || loginUsers.getStatus()==9)) { %>
			<button type="button" id="removeBtn">글삭제</button>
			<button type="button" id="modifyBtn">글변경</button>
		<% } %>		
		<button type="button" id="listBtn">글목록</button>
	</div>
	
	<form id="noticeForm" method="post">
	                      <%--보낼 값 선언 --%>                      
		<%-- 게시글 변경 입력페이지와 삭제 처리 페이지 요청시 전달값 --%>
		<input type="hidden" name="n_no" value="<%=notice.getN_no()%>">
		<%-- 답글 입력페이지 요청시 전달값 --%>
		<%-- 게시글 목록 출력페이지 요청시 전달값 --%>
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
	</form>
	
	<script type="text/javascript">
	$("#removeBtn").click(function() {
		if(confirm("정말로 게시글을 삭제 하시겠습니까?")) {
			$("#noticeForm").attr("action", "<%=request.getContextPath()%>/home.jsp?workgroup=notice&work=notice_remove_action");
			$("#noticeForm").submit();
		}
	});
	
	$("#modifyBtn").click(function() {
		$("#noticeForm").attr("action", "<%=request.getContextPath()%>/home.jsp?workgroup=notice&work=notice_modify");
		$("#noticeForm").submit();
	});
	
	$("#listBtn").click(function() {
		$("#noticeForm").attr("action", "<%=request.getContextPath()%>/home.jsp?workgroup=notice&work=notice_list");
		$("#noticeForm").submit();
	});
	</script>	
</div>







