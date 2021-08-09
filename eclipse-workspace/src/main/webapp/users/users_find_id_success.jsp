<%@page import="dao.UsersDAO"%>
<%@page import="dto.UsersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="css/users_login_find.css"/>
<%-- 이름과 이메일을 전달받아 인증처리 후 USERS 테이블에 저장된 회원 아이디를 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 인증 실패 : 세션에 메세지를 저장하고 아이디 찾기 페이지(users_find_id.jsp)로 이동 --%>
<%-- => 인증 성공 : 세션에 회원정보를 저장하고 아이디 출력 --%>    

<%
	//비정상적인 요청에 대한 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	
	//이메일을 전달받아 USERS 테이블에 저장된 회원정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	UsersDTO users=UsersDAO.getDAO().selectUsersEmail(email);
	
	//이메일이 존재하지 않을 경우(이메일 인증 실패)
	if(users==null) {
		session.setAttribute("message", "가입된 아이디가 없거나 이메일이 맞지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=users&work=users_find_id';");
		out.println("</script>");
		return;
	}
	
	//이름과 이메일이 일치하지 않을 경우(인증 실패가 발생한 경우)
	if(!users.getName().equals(name)) {
		session.setAttribute("message", "가입된 아이디가 없거나 이메일이 맞지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=users&work=users_find_id';");
		out.println("</script>");
		return;
	}

	//인증 성공 - 세션에 회원정보를 저장
	session.setAttribute("usersInfo", UsersDAO.getDAO().selectUsersEmail(email));	
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
			<form id="formFindId" method="post" action="../member/member_ps.php">
				<div class="find_id_box">
					<div class="find_id_sec">				
						<div class="find_complete_box"><p><%=users.getName()%> 회원님의 아이디는 <br><strong><%=users.getId()%></strong> 입니다</p></div>
					</div>
					<!-- //find_id_sec -->
					<div class="btn_member_sec">
						<ul>
							<li>
								<button type="button" class="btn_member_white js_btn_find_password" 
									onclick="location.href='<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_find_pw'">비밀번호 찾기</button>
							</li>
							<li>
								<button type="button" class="btn_comfirm js_btn_login" 
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

