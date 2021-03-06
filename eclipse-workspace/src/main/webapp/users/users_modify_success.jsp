<%@page import="dao.UsersDAO"%>
<%@page import="Utility.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="css/users_join_success.css"/>  
<%-- 변경할 회원정보를 전달받아 USERS 테이블에 저장된 회원정보를 변경하고 회원정보수정 완료 페이지 --%>
<%-- => 비로그인 사용자가 JSP 문서를 요청한 경우 비정상적인 요청으로 에러페이지 이동 --%>
<%@include file="/security/login_check.jspf" %>
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
	String pw=request.getParameter("pw");
	if(pw==null || pw.equals("")) {//비밀번호가 전달되지 않은 경우
		//로그인 사용자의 비밀번호를 변수에 저장 - 기존 비밀번호로 변경
		pw=loginUsers.getPw();
	} else {//비밀번호가 전달된 경우
		//전달된 비밀번호를 암호화 처리하여 변수에 저장 - 새로운 비밀번호로 변경
		pw=Utility.encrypt(request.getParameter("pw"));
	}
	String name=request.getParameter("name").trim();
	String email=request.getParameter("email");
	String phone=request.getParameter("phone1")+"-"+request.getParameter("phone2")+"-"+request.getParameter("phone3");
	String birthday=request.getParameter("birthday");
	String zipcode=request.getParameter("zipcode");
	String address1=request.getParameter("address1");
	String address2=Utility.stripTag(request.getParameter("address2"));
	
	//DTO 인스턴스를 생성하고 전달값으로 필드값 변경
	UsersDTO users=new UsersDTO();
	users.setId(id);
	users.setPw(pw);
	users.setName(name);
	users.setEmail(email);
	users.setPhone(phone);
	users.setBirthday(birthday);
	users.setZipcode(zipcode);
	users.setAddress1(address1);
	users.setAddress2(address2);
	
	//회원정보를 전달받아 USERS 테이블에 저장된 회원정보를 변경하는 DAO 클래스의 메소드 호출
	UsersDAO.getDAO().updateUsers(users);
	
	//세션에 저장된 권한 관련 정보(회원정보)를 변경
	session.setAttribute("loginUsers", UsersDAO.getDAO().selectUsersId(id));
%>
<div id="container">
<div id="container_sub">
<div id="contents">
<div class="sub_content">
<div class="content_box">	
	<div class="member_wrap">	
		<div class="member_tit">	
			<h2>회원정보수정 성공</h2>
		</div>
		<!-- //member_tit -->
		<div class="member_cont">			
				<div class="find_id_box">
					<div class="find_id_sec">					
					<h3>회원정보가 변경되었습니다!</h3>							
					</div>
					<!-- //find_id_sec -->
					<div class="btn_member_sec">
						<ul>
							<li><button class="btn_comfirm js_btn_login" onclick="location.href='<%=request.getContextPath() %>/home.jsp?workgroup=users&work=pw_confirm&action=modify'">정보수정</button></li>
							<li><button class="btn_member_white js_btn_find_password" onclick="location.href='<%=request.getContextPath() %>/home.jsp?workgroup=mypage&work=mypage_orders'">MYPAGE</button></li>
						</ul>
					</div>
					<!-- //btn_member_sec -->
				</div>
				<!-- //find_id_box -->			
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
</div>