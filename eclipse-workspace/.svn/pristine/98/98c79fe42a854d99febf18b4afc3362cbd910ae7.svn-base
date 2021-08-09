<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<link type="text/css" rel="stylesheet" href="css/users_login.css"/> 
<%-- 로그인 페이지 --%>
<%-- => [LOGIN]을 클릭한 경우 로그인 처리페이지(users_login_action.jsp)로 이동 - 입력값 전달 --%>
<%-- => [JOIN US]을 클릭한 경우 회원가입 페이지(users_join_agree.jsp)로 이동 --%>
<%-- => [FIND ID]을 클릭한 경우 아이디 찾기 페이지(users_find_id.jsp)로 이동 --%>
<%-- => [FIND PASSWORD]을 클릭한 경우 비밀번호 찾기 페이지(users_find_pw.jsp)로 이동 --%>
<%
	if(request.getParameter("state")!=null) {
		if(request.getParameter("state").equals("1")) {
			session.removeAttribute("url");
		}
	}

	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
	
	String id=(String)session.getAttribute("id");
	if(id==null) {
		id="";
	} else {
		session.removeAttribute("id");
	}
%>

<div id="container">
<div id="contents">
<div class="sub_content">
<!-- //side_cont -->
<div class="content_box">
	<div class="member_wrap">
		<div class="member_tit">
			<h2>로그인</h2>
		</div>
		<!-- //member_tit -->
		<div class="member_cont">

			<form id="formLogin" method="post" 
			action="<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_login_action">				
				<div class="member_login_box">					
					<div class="login_input_sec">
						<div>
							<input type="text" id="id" name="id" placeholder="아이디" 
								value="<%=id%>">	
							<input type="password" id="pw" name="pw" placeholder="비밀번호">
						</div>
						<button type="button" id="btnLogin">LOGIN</button>
					</div>
					<div class="id_chk">
						<span class="form_element">
							<input type="checkbox" id="saveId" name="saveId"/>
			                <label for="saveId">아이디 저장</label>
						</span>
						<div id="message" class="error"><%=message %></div>
					</div>
				</div>
				<!-- //login_box -->
				</form>				
				<div class="btn_login_box">
					<ul>
						<li><button id="btnJoinMember" onclick="location.href='<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_join_agree'">JOIN US</button></li>
						<li><button id="btnFindId" onclick="location.href='<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_find_id'">FIND ID</button></li>
						<li><button id="btnFindPwd" onclick="location.href='<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_find_pw'">FIND PASSWORD</button></li>
					</ul>
				</div>
				<!-- //btn_login_box -->
			
		</div>
		<!-- //member_cont -->
	</div>
	<!-- //member_wrap -->
</div>
<!-- //content_box -->
</div>
<!-- //sub_content -->
</div>
<!-- //본문 끝 contents -->
</div>
<!-- //container -->


<script type="text/javascript">
$(document).ready(function() {
	$("#btnLogin").click(function() {
		if($("#id").val()=="") {
			$("#message").text("아이디를 입력해 주세요.");
			return;
		}
		
		if($("#pw").val()=="") {
			$("#message").text("비밀번호를 입력해 주세요.");
			return;
		}
		
		$("#formLogin").submit();
	});
});

</script>
            