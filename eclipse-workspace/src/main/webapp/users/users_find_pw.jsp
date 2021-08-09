<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="css/users_login_find.css"/>
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
	<form id="formFindPw" method="post" action="<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_find_pw_success">
		<div class="member_wrap">
			<div class="member_tit">
				<h2>비밀번호 찾기</h2>
			</div>
			<div class="member_cont">
				<div class="find_password_box">
					<h3>아이디 입력</h3>
					<p>비밀번호를 찾고자 하는 아이디를 입력해 주세요.</p>
					<div class="login_input">
						<div class="member_warning">
							<input type="text" id="id" name="id" placeholder="아이디">
							<p class="info_again">아이디를 모르시나요? 
							<a href="<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_find_id">아이디 찾기</a></p>
							<div id="message" class="error"><%=message %></div>
						</div>
						<div class="btn_center_box">
							<button type="button" id="btnFindPw">다음</button>
						</div>
					</div>
				</div>
				<!-- //find_password_box -->
			</div>
			<!-- //member_cont -->
		</div>
		<!-- //member_wrap -->
	</form>
</div>
<!-- //content_box -->
</div>
<!-- //sub_content -->
</div>
<!-- //본문 끝 contents -->
</div>
<!-- //container -->
    
<script type="text/javascript">
$("#btnFindPw").click(function() {
	if($("#id").val()=="") {
		$("#message").text("아이디를 입력해 주세요.");
		return;
	}
	
	$("#formFindPw").submit();
});

</script>
            