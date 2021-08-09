<%@page import="dao.UsersDAO"%>
<%@page import="dto.UsersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="css/users_login_find.css"/>    
<%-- 아이디를 전달받아 인증처리 후 USERS 테이블에 저장된 회원 이메일주소와 휴대폰번호를 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 인증 실패 : 세션에 메세지를 저장하고 비밀번호 찾기 페이지(users_find_pw.jsp)로 이동 --%>
<%-- => 인증 성공 : 세션에 회원정보를 저장하고 회원 이메일주소와 휴대폰번호 출력 --%>    
<%
	//비정상적인 요청에 대한 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장
	String id=request.getParameter("id");
	
	//아이디를 전달받아 USERS 테이블에 저장된 회원정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	UsersDTO users=UsersDAO.getDAO().selectUsersId(id);
	
	//아이디가 존재하지 않을 경우(아이디 인증 실패)
	if(users==null) {
		session.setAttribute("message", "가입된 아이디가 없습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=users&work=users_find_pw';");
		out.println("</script>");
		return;
	}
	
	//인증 성공 - 세션에 회원정보를 저장
	session.setAttribute("usersInfo", UsersDAO.getDAO().selectUsersId(id));	
%>
<div id="container">
        <div id="contents">
        <!-- 본문 시작 -->
		<div class="sub_content">
		<!-- //side_cont -->
<div class="content_box">
	<form name="formFindPw" id="formFindPw" method="post">
		<div class="member_wrap">
			<div class="member_tit">
				<h2>비밀번호 찾기</h2>
			</div>
			<div class="member_cont">
				<div class="find_password_box">
					<h3>이메일 발송</h3>
					<p>가입시 등록한 이메일로 인증 확인 메일을 발송드립니다.</p>
					<div class="login_input">
						<div class="member_warning" id="member_warning">
							<input type="checkbox" id="emailCheck">
								<span class="emailCheck">이메일 인증&nbsp;(<%=users.getEmail() %>)</span>													
						</div>
						<div class="btn_center_box">
							<button type="button" id="btnFindPw">발송</button>
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
	if($("#emailCheck").is(":checked")==false) {
		alert("발송할 이메일을 체크해주시기 바랍니다.");
		return false;
	} else {
		alert("발송 완료되었습니다. 이메일 확인 후 다시 로그인하시기 바랍니다.");		
		$("#formFindPw").attr("action", "<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_login");
		$("#formFindPw").submit();		
	}
});
</script>