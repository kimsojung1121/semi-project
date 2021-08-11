<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="css/pw_confirm.css"/>        
<%-- 회원정보 수정 or 회원 탈퇴를 위해 비밀번호를 입력하는 페이지 --%>
<%-- => 비로그인 사용자가 JSP 문서를 요청한 경우 비정상적인 요청으로 에러페이지 이동 --%>
<%@include file="/security/login_check.jspf" %>
<%
	if(request.getParameter("action")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;		
	}
	
	//전달값을 반환받아 저장
	String action=request.getParameter("action");

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
		<div class="content">
   		<div class="mypage_cont">
        <div class="my_page_password">
            <div class="mypage_zone_tit">
            	<% if(action.equals("modify")) { %>
                <h2>회원정보수정</h2>
                <% } else if(action.equals("delete")) { %>
                <h2>회원탈퇴</h2>
                <% } %>
            </div>
            <p><strong>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해 주세요.</strong></p>

            <form id="formPwCheck" name="formPwCheck" method="post">
                <div class="id_pw_cont">
                    <dl>
                        <dt>아이디</dt>
                        <dd><strong><%=loginUsers.getId() %></strong></dd>
                    </dl>
                    <dl>
                        <dt>비밀번호</dt>
                        <dd>
                            <div class="member_warning">
                                <input type="password" name="pw" id="pw">
                                <div id="message" class="error"><%=message %></div>
                            </div>
                        </dd>
                    </dl>
                </div>
                <div class="btn_center_box">
                    <a class="btn_pw_cancel js_btn_back" href="<%=request.getContextPath()%>/home.jsp?workgroup=mypage&work=mypage_orders">취소</a>
                    <button type="button" class="btn_pw_certify" id="btnPwCheck">인증하기</button>
                </div>
            </form>
        </div>
        <!-- //my_page_password -->
    </div>
    <!-- //mypage_cont -->
</div>
<!-- //content -->
</div>
<!-- //sub_content -->
</div>
</div>
<!-- //container -->

<script type="text/javascript">
$("#btnPwCheck").click(function() {
	if($("#pw").val()=="") {
		$("#message").text("비밀번호를 입력해 주세요.");
		return;
	}
	
	<% if(action.equals("modify")) { %>
		formPwCheck.action="<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_modify";
	<% } else if(action.equals("delete")) { %>
		formPwCheck.action="<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_delete";
	<% } %>
	
	$("#formPwCheck").submit();
});
		
</script>

