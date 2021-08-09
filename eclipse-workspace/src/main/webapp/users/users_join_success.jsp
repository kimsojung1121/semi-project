<%@page import="Utility.Utility"%>
<%@page import="dao.UsersDAO"%>
<%@page import="dto.UsersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="css/users_join_success.css"/>   
<%-- 회원가입 페이지에서 회원정보를 전달받아 USERS 테이블에 저장하고 회원가입 완료 페이지 --%>    
<%
	
	//비정상적인 요청에 대한 처리
	//if(request.getMethod().equals("GET")) {
	//	out.println("<script type='text/javascript'>");
	//	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
	//	out.println("</script>");
	//	return;
	//}

	//전달값을 반환받아 저장
	String id=request.getParameter("id");
	String pw=Utility.encrypt(request.getParameter("pw"));
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
	
	//회원정보를 전달받아 USERS 테이블에 삽입하여 저장하는 DAO 클래스의 메소드 호출
	UsersDAO.getDAO().insertUsers(users);	
%>

<div id="container">
<div id="contents">
<div class="sub_content">
<div class="content_box">
	<div class="top_bar">			
			<ol>
				<li><span>01</span> 약관동의<span><img src="https://www.ranicake.com//data/skin/front/jeonyul_200918/img/member/icon_join_step_off.png"></span></li>
				<li><span>02</span> 정보입력<span><img src="https://www.ranicake.com//data/skin/front/jeonyul_200918/img/member/icon_join_step_off.png"></span></li>
				<li class="page_on"><span>03</span> 가입완료</li>
			</ol>
	</div>
	<div class="member_wrap">	
		<div class="member_tit">	
			<h2>회원가입 성공</h2>
		</div>
		<!-- //member_tit -->
		<div class="member_cont">			
				<div class="find_id_box">
					<div class="find_id_sec">					
					<h3>가입을 축하드립니다!</h3>							
					</div>
					<!-- //find_id_sec -->
					<div class="btn_member_sec">
						<ul>
							<li><button class="btn_member_white js_btn_find_password" onclick="location.href='<%=request.getContextPath() %>/home.jsp'">HOME</button></li>
							<li><button class="btn_comfirm js_btn_login" onclick="location.href='<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_login'">로그인하기</button></li>
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
</body>
</html>