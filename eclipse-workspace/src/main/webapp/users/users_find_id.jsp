<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="css/users_login_find.css"/>
 <%-- 아이디 찾기 페이지 --%>
<%-- => [아이디 찾기]를 클릭한 경우 아이디 찾기 처리페이지(users_find_success.jsp)로 이동 - 입력값 전달 --%>
<%-- => [비밀번호 찾기]를 클릭한 경우 비밀번호 찾기 페이지(users_find_pw.jsp)로 이동 --%>
<%-- => [로그인하기]를 클릭한 경우 로그인 페이지(users_login.jsp)로 이동 --%>
<%
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
%>
<div id="container">
        <div id="contents">
        <!-- 본문 시작 -->           
            <div class="sub_content">
                <!-- //side_cont -->
<div class="content_box">
	<div class="member_wrap">
		<div class="member_tit">
			<h2>아이디찾기</h2>
		</div>
		<!-- //member_tit -->
		<div class="member_cont">
			<form id="formFindId" method="post" action="<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_find_id_success">
				<div class="find_id_box">
					<div class="find_id_sec">					
						<div class="login_input">
							<div>
								<input type="text" id="name" name="name" placeholder="이름">
								<input type="text" id="email" name="email" placeholder="가입메일주소">
							</div>
							<button type="button" class="btnFindId" id="btnFindId">아이디 찾기</button>
						</div>
						<div id="message" class="error"><%=message %></div>
					</div>
					<!-- //find_id_sec -->
					<div class="btn_member_sec">
						<ul>
							<li>
							<button type="button" class="btn_member_white js_btn_find_password"
								onclick="location.href='<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_find_pw'">비밀번호 찾기</button>
							</li>
							<li>
							<button type="button" id="btnLogin" class="btn_comfirm js_btn_login"
								onclick="location.href='<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_login'">로그인하기</button>
							</li>
						</ul>
					</div>
					<!-- //btn_member_sec -->
				</div>
				<!-- //find_id_box -->
			</form>
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
$("#btnFindId").click(function() {
	if($("#name").val()=="") {
		$("#message").text("이름을 입력해 주세요.");
		return;
	}
	
	if($("#email").val()=="") {
		$("#message").text("이메일을 입력해 주세요.");
		return;
	}
	
	$("#formFindId").submit();
});
</script>
