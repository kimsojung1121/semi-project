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
	border: 1px solid black;
	border-collapse: collapse;
	width : 1000px;
	margin: 0 auto;
}

th, td {
	border: 1px solid RGB(200,200,200);
	padding: 0;
	line-height : 50px;
}

th { width: 100px; 
     background-color: #f7f7f7;
     font-size: 20px;
}

td { width: 400px;
      font-size: 15px;
 }

#title {
      font-size: 18px;
      color: black;
      
}
#savebtn {
   text-align : center;
	max-width : 1000px;
    min-width : 50px;
	margin: 0 auto;
	font-size: 50px;
}
#savebtn button {
	border: 1px solid RGB(254,199,158);
	padding: 6px 20px;
	border-radius: 10px;
	background-color: RGB(254,199,158);
	color: #fff;
}

#message {
	text-align: center;
}

textarea {
    padding: 5px;
    color: black;
    border: none;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    width: 100%;
    resize:none;
    font-size: 16px;
}

input[type="checkbox"] {
    width: 13px;
    height: 13px;
    vertical-align: middle;
    margin-left: 60px;
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
				<input type="text" name="n_title" id="title" size="85" style="border: none;">
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="20" cols="100" name="n_content" id="content"></textarea>
			</td>
		</tr>
	</table>	
			<div id="savebtn">
				<button type="submit">글저장</button>&nbsp;&nbsp;&nbsp;
				<button type="reset" id="resetBtn">다시쓰기</button>
			</div>
	
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