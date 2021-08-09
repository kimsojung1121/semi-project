<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

                             
<%--비정상 접근 방지 - 에러페이지로 이동 --%>
<%@include file="/security/login_check.jspf" %> 
<%
      
	//답글 전달값을 저장하기 위한 변수
	//새글일 경우
	String ref="0", re_Step="0", re_Level="0"; //전달값이 없는것을 대비해서 초기화 시킴
	String pageNum="1";
	
	
	//답글일 경우
	if(request.getParameter("ref")!=null) {//전달값이 있는 경우 - 답글
		ref=request.getParameter("ref");
		re_Step=request.getParameter("re_Step");
		re_Level=request.getParameter("re_Level");
		pageNum=request.getParameter("pageNum"); //답글 (부모글의 전달값)
		
	
	}
%>

<style type="text/css">
#review_title {
	font-size: 2.5em;
	font-weight: bold;
}

table {
	margin: 0 auto;
}

th {
	width: 70px;
	font-weight: normal;
	font-size: 18px;
}

td {
	text-align: left;
}
#btn {
   text-align : right;
	max-width : 1000px;
    min-width : 50px;
	margin: 0 auto;
}
#btn button {
	border: 1px solid black;
	padding: 3px 5px;
	border-radius: 10px;
	background-color: #ccc;
}
</style>
<% if(ref.equals("0")) {//ref값이 0일 경우 : 새글쓰기 %>
<br>
  <br>
    <br>
      <br>
         <br>
           <br>
<div align="center" id="review_title">상품후기 글쓰기</div>
<br>
<br>
<br>
<% } else { //ref값이 1일 경우 : 답글쓰기 %>
<br>
  <br>
    <br>
<div align="center" id="review_title">답글 쓰기</div>
<% } %>
  <br>
    <br>
<form action="<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_write_action"
	method="post" id="reviewForm">
	<input type="hidden" name="ref" value="<%=ref%>">	
	<input type="hidden" name="re_Step" value="<%=re_Step%>">	
	<input type="hidden" name="re_Level" value="<%=re_Level%>">	
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="r_title" id="title" size="40">
				<input type="checkbox" name="secret" value="1">&nbsp;&nbsp;비밀글
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="7" cols="60" name="r_content" id="content"></textarea>
			</td>
		</tr>
		<tr>
			<th colspan="2">
			<div id="btn">
				<button type="submit">글저장</button>&nbsp;&nbsp;&nbsp;
				<button type="reset" id="resetBtn">다시쓰기</button>
		   </div>
			</th>
		</tr>
	</table>	
	
</form>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
<%--제목과 내용 입력 없으면 'submit'취소--%>
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