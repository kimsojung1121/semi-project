<%@page import="dao.UsersDAO"%>
<%@page import="dto.UsersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원가입 페이지에서 아이디를 전달받아 중복확인 후 사용 가능 여부를 전달하는 페이지 --%>
<%-- => 사용 가능 : 가능 메세지 전달 - 부모창의 아이디 입력태그의 입력값으로 변경 --%>
<%-- => 사용 불가능 : 불가능 메세지 전달 - 아이디를 입력 받아 현재 페이지 재요청 --%>
<%
	//비정상적인 요청에 대한 처리
	if(request.getParameter("id")==null) {//전달값이 없는 경우
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}
	
	//전달값을 반환받아 저장
	String id=request.getParameter("id");
	
	//아이디를 전달받아 USERS 테이블에 저장된 회원정보를 검색하여 반환하는 DAO 클래스의 메소드 호출 
	// => null 반환 : 회원정보 미검색 - 아이디 사용 가능
	// => UsersDTO 인스턴스 반환 : 회원정보 검색 - 아이디 사용 불가능
	UsersDTO users=UsersDAO.getDAO().selectUsersId(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
<style type="text/css">
div {
	text-align: center;
	margin: 10px;
	font-family: 'Arita-dotum-Medium';
}

.id {
	color: #985f53;
	font-family: 'Arita-dotum-Medium';
}

button {
	font-family: 'Arita-dotum-Medium';
	border: 1px solid;
	padding: 4px;
	background: #ffc89b;
	color: #fff;
	cursor: pointer;
}
</style>
</head>
<body>
	<% if(users==null) {//아이디가 사용 가능한 경우 %>
		<div><span class="id">[<%=id %>]</span>는 사용 가능한 아이디입니다.</div>
		<div>
			<button type="button" onclick="windowClose();">사용하기</button>
		</div>
		
		<script type="text/javascript">
		function windowClose() {
			opener.formJoin.id.value="<%=id%>";
			opener.formJoin.idCheckResult.value="1";
			window.close();
		}
		</script>
	<% } else {//아이디가 사용 불가능한 경우 %>
	<div id="message"><span class="id">[<%=id %>]</span>는 이미 사용 중인 아이디입니다.<br>
	다른 아이디를 입력해 주세요.</div>
	<div>
		<form name="checkForm">
			<input type="text" name="id">
			<button type="button" id="btn">확인</button>
		</form>
	</div>	
	
	<script type="text/javascript">
	document.getElementById("btn").onclick=function() {
		var id=checkForm.id.value;
		if(id=="") {
			document.getElementById("message").innerHTML="아이디를 입력해 주세요.";
			document.getElementById("message").style="color: #985f53;";
			return;
		}
		
		var idReg=/^[a-zA-Z]\w{5,19}$/g;
		if(!idReg.test(id)) {
			document.getElementById("message").innerHTML="아이디는 영문자로 시작되는 영문자,숫자의 6~20 범위의 문자로만 작성 가능합니다.";
			document.getElementById("message").style="color: #985f53;";
			return;
		}
		
		checkForm.submit();
	}
	</script>
	<% } %>
</body>
</html>