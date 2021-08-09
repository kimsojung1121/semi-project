
<%@page import="dto.UsersDTO"%>
<%@page import="dao.QnaDAO"%>
<%@page import="dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%-- ■■■■■■Q&A 게시글 상세출력페이지■■■■■■ --%>
<%
	//비정상적이 요청에 대한 처리
	if(request.getParameter("q_no")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;		
	}
    //전달받은값 저장
	int q_no=Integer.parseInt(request.getParameter("q_no"));
	String pageNum=request.getParameter("pageNum");
	
	String search=request.getParameter("search");
	if (search==null){
		search ="";
	}
	String keyword=request.getParameter("keyword");
	if (keyword==null){
		keyword ="";
	}
// 	int q_no=Integer.parseInt(request.getParameter("q_no"));
// 	String pageNum=request.getParameter("pageNum");
// 	String search=request.getParameter("search");
// 	String keyword=request.getParameter("keyword");
	

	//글번호를 전달받아 Q&A 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	QnaDTO qna=QnaDAO.getDAO().selectQna_No(q_no);
	
	//검색된 게시글이 없거나 검색된 게시글이 삭제글인 경우 - [비정상적인 요청]
	if(qna==null || qna.getQ_state()==9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}
	
	//세션에 저장된 권한 관련 정보(회원정보)를 반환받아 저장
	UsersDTO loginUsers=(UsersDTO)session.getAttribute("loginUsers");
	
	//검색된 게시글이 비밀글인 경우
	if(qna.getQ_state()==1) {
		//비로그인 사용자이거나 로그인 사용자가 작성자 또는 관리자가 아닌 경우 - 비정상적인 경우 
		if(loginUsers==null || !loginUsers.getId().equals(qna.getId())
				&& loginUsers.getStatus()!=9) {
			out.println("<script type='text/javascript'>");
			out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
			out.println("</script>");
			return;
		}
	}
	
	//조회수증가
	QnaDAO.getDAO().updateQnaCount(q_no);
%>
<style type="text/css">
#qna_detail {
	margin: 0 auto;
}

table {
	border: 1px solid black;
	border-collapse: collapse;
	width : 1000px;
	margin: 0 auto;
}

th, td {
	border: 1px solid black;
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

#qna_menu {
/* 	text-align: right; */
/* 	margin: 5px; */
   text-align : center;
	max-width : 1000px;
    min-width : 50px;
	margin: 0 auto;
	font-size: 50px;
}
#qna_menu button {
	border: 1px solid black;
	padding: 3px 5px;
	border-radius: 10px;
	background-color: #ccc;
}
#title_qna {
    font-size: 2.5em
}
#listBtn {
   text-align : center;
	max-width : 1000px;
    min-width : 50px;
	margin: 0 auto;
}


</style>

<div id="qna_detail">
<br>
   <br>
      <br>
         <br>
            <br>
	<h2 align="center" id="title_qna">Q&A</h2>
            <br>
         <br>
	  <div>
	<table>
		<tr>
			<th><p id="background_color">제목</p></th>
			<td class="title" colspan="4">
				<% if(qna.getQ_state()==1) {//비밀글인 경우 %>
					[비밀글]
				<% } %>
				<%=qna.getQ_title() %>
			</td>
		<tr>
			<th><p id="background_color">작성자</p></th>
			<td class="writer" colspan="4">
				<%=qna.getQ_writer() %>
				<% if(loginUsers!=null && loginUsers.getStatus()==9) {//관리자인 경우 %>
				<% } %>
				</p>
			</td>
		</tr>
<!-- 		<tr> -->
<!-- 			<th><p id="background_color">작성일</p></th> -->
<%-- 			<td><%=qna.getQ_date().substring(0,10) %></td> --%>
<!-- 		</tr> -->
<!-- 		<tr> -->
<!-- 			<th><p id="background_color">조회수</p></th> -->
<%-- 			<td><%=qna.getReadcount()+1 %></td> --%>
<!-- 		</tr> -->
<!-- 		</tr> -->
		<tr>
			<th><p id="background_color">작성일</p></th>
			<td><%=qna.getQ_date().substring(0,10) %></td>
			<th><p id="background_color">조회수</p></th>
			<td><%=qna.getReadcount()+1 %></td>
		</tr>
	
		<tr>
			<th><p id="background_color">내용</p></th>
			<td class="content" colspan="4"><%=qna.getQ_content().replace("\n", "<br>") %></td>
		</tr>	
	</table>
		</div>
	
	<%-- 답변 깊이 1 초과하지 않도록 답변을 관리자만 한 번 달 수 있도록 임시 변경(08/07 추가) --%>
	<div id="qna_menu">
		<%-- 로그인 사용자가 작성자이거나 관리자인 경우에만 삭제와 변경 기능 제공 --%>
		<% if(loginUsers!=null && (loginUsers.getId().equals
				(qna.getId()) || loginUsers.getStatus()==9)) { %>
			<button type="button" id="removeBtn">글삭제</button>
			<button type="button" id="modifyBtn">글변경</button>
		<% } %>		
		<%-- 로그인 사용자인 경우에만 답글 기능 제공 --%>
		<% if(loginUsers!=null && qna.getRe_Step()==0 || qna.getRe_Step()==2) { %>
			<% if(loginUsers.getStatus()==9) { %>
				<button type="button" id="replyBtn">답글쓰기</button>
			<% } %>
		<% } else if(loginUsers!=null && qna.getRe_Step()==1 || qna.getRe_Step()==3) {%>
			<% if(loginUsers.getId().equals(qna.getId())) { %>
				<button type="button" id="replyBtn">답글쓰기</button>
			<% } %>
		<% } %>
		<button type="button" id="listBtn">글목록</button>
	</div>
	
	<form id="qnaForm" method="post">
	                      <%--보낼 값 선언 --%>                      
		<%-- 게시글 변경 입력페이지와 삭제 처리 페이지 요청시 전달값 --%>
		<input type="hidden" name="q_no" value="<%=qna.getQ_no()%>">
		<%-- 답글 입력페이지 요청시 전달값 --%>
		<input type="hidden" name="ref" value="<%=qna.getRef()%>">
		<input type="hidden" name="re_Step" value="<%=qna.getRe_Step()%>">
		<input type="hidden" name="re_Level" value="<%=qna.getRe_Level()%>">
		<%-- 게시글 목록 출력페이지 요청시 전달값 --%>
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="search" value="<%=search%>">
		<input type="hidden" name="keyword" value="<%=keyword%>">
	</form>
	
	<script type="text/javascript">
	$("#removeBtn").click(function() {
		if(confirm("정말로 게시글을 삭제 하시겠습니까?")) {
			$("#qnaForm").attr("action", "<%=request.getContextPath()%>/home.jsp?workgroup=qna&work=qna_remove_action");
			$("#qnaForm").submit();
		}
	});
	
	$("#modifyBtn").click(function() {
		$("#qnaForm").attr("action", "<%=request.getContextPath()%>/home.jsp?workgroup=qna&work=qna_modify");
		$("#qnaForm").submit();
	});
	
	$("#replyBtn").click(function() {
		$("#qnaForm").attr("action", "<%=request.getContextPath()%>/home.jsp?workgroup=qna&work=qna_write");
		$("#qnaForm").submit();
	});
	
	$("#listBtn").click(function() {
		$("#qnaForm").attr("action", "<%=request.getContextPath()%>/home.jsp?workgroup=qna&work=qna_list&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>");
		$("#qnaForm").submit();
	});
	</script>	
</div>







