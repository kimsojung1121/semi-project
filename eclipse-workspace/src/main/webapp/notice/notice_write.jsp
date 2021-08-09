<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

                             
<%--비정상 접근 방지 - 에러페이지로 이동 --%>
<%@include file="/security/login_check.jspf" %> 
<%
    String pageNum="1"; 

    if(request.getParameter("pagenum")!=null) {
      pageNum=request.getParameter("pageNum");
    }
%>
<style type="text/css">
#notice_title {
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
<br>
  <br>
    <br>
      <br>
         <br>
           <br>
<div align="center" id="notice_title">공지사항 글쓰기</div>
<br>
<br>
<br>
<br>
<form action="<%=request.getContextPath()%>/home.jsp?workgroup=notice&work=notice_write_action"
	method="post" id="noticeForm">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="n_title" id="title" size="40">
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="7" cols="60" name="n_content" id="content"></textarea>
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

$("#noticeForm"").submit(function() {
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
</html>