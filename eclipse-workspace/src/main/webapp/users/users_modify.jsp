<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="dao.UsersDAO"%>
<%@page import="Utility.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="css/users_join.css"/> 
<link type="text/css" rel="stylesheet" href="css/mypage.css"/>
<%-- 회원정보 수정 페이지 --%> 
<%-- 비밀번호를 전달받아 로그인 사용자의 비밀번호와 비교하여 같은 경우 회원정보 변경값을 입력받기 위한 페이지 --%>
<%-- => 전달받은 비밀번호가 로그인 사용자의 비밀번호가 같지 않은 경우 비밀번호 입력페이지(pw_confirm.jsp)로 이동 --%>
<%-- => 비로그인 사용자가 JSP 문서를 요청한 경우 비정상적인 요청으로 에러페이지 이동 --%>
<%-- => [정보수정]을 클릭한 경우 회원정보 변경 처리페이지(users_modify_success.jsp)로 이동 - 입력값 전달 --%>
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
	String pw=Utility.encrypt(request.getParameter("pw"));
	
	//전달받은 비밀번호와 로그인 사용자의 비밀번호가 같지 않은 경우 - 비밀번호 입력페이지 재요청
	if(!loginUsers.getPw().equals(pw)) {
		session.setAttribute("message", "비밀번호가 맞지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=users&work=pw_confirm&action=modify';");
		out.println("</script>");
		return;
	}
		
%>

<div id="container">
<div id="contents">
<div class="sub_content">
<div class="join_base_wrap">
<div class="side_cont">
<div class="sub_menu_box">
    <h2>MYPAGE</h2>
    <ul class="sub_menu_mypage">
        <li>쇼핑정보
            <ul class="sub_depth1">
                <li><a href="<%=request.getContextPath()%>/home.jsp?workgroup=mypage&work=mypage_orders">- 주문목록/배송조회</a></li>
                <li><a href="<%=request.getContextPath()%>/home.jsp?workgroup=mypage&work=mypage_cart">- 장바구니</a></li>
            </ul>
        </li>
        <li>회원정보
            <ul class="sub_depth1">
                <li><a href="<%=request.getContextPath() %>/home.jsp?workgroup=users&work=pw_confirm&action=modify">- 회원정보 수정</a></li>
                <li><a href="<%=request.getContextPath() %>/home.jsp?workgroup=users&work=pw_confirm&action=delete">- 회원 탈퇴</a></li>
            </ul>
        </li>
        <li><a href="<%=request.getContextPath() %>/home.jsp?workgroup=mypage&work=mypage_qna">나의 Q&amp;A</a></li>
        <li><a href="<%=request.getContextPath() %>/home.jsp?workgroup=mypage&work=mypage_review">나의 상품후기</a></li>       
    </ul>
</div>
<!-- //sub_menu_box -->
</div>
<!-- //side_cont -->
<div class="member_cont">
<form id="formModify" name="formModify" method="post" 
	action="<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_modify_success">

	<!-- 회원가입 기본정보 -->
	<div class="base_info_box">
	    <h3>회원정보수정</h3>
	    <span class="important">* 표시는 반드시 입력하셔야 하는 항목입니다.</span>
	    <div class="base_info_sec">
	        <table>
	            <colgroup>
	                <col width="25%">
	                <col width="75%">
	            </colgroup>
	            <tbody>
	            <tr>
	                <th><span class="important">* 아이디</span></th>
	                <td>
	                    <div class="member_warning">
	                        <input type="text" name="id" id="idFixed" value="<%=loginUsers.getId()%>" readonly="readonly">                      
	                    </div>
	                </td>	
	            </tr>
	            <tr>
	                <th><span class="important">* 비밀번호</span></th>
	                <td>
	                    <div class="member_warning">
	                        <input type="password" id="pw" name="pw" placeholder="비밀번호를 변경할 경우에만 입력해 주세요.">
							<div id="pwRegMsg" class="error">비밀번호는 영문자,숫자,특수문자가 반드시 하나이상 포함된 6~20 범위의 문자로만 작성 가능합니다.</div>						                   
	                    </div>
	                </td>
	            </tr>
	            <tr>
	                <th><span class="important">* 비밀번호 확인</span></th>
	                <td>
	                    <div class="member_warning">
	                        <input type="password" id="repw" name="repw" placeholder="비밀번호를 변경할 경우에만 입력해 주세요.">
	                        <div id="repwMsg" class="error">비밀번호 확인을 입력해 주세요.</div>
							<div id="repwMatchMsg" class="error">비밀번호와 비밀번호 확인이 서로 맞지 않습니다.</div>
	                    </div>
	                </td>
	            </tr>
	            <tr>
	                <th><span class="important">* 이름</span></th>
	                <td>
	                    <div class="member_warning">
	                        <input type="text" id="name" name="name" value="<%=loginUsers.getName()%>">
	 						<div id="nameMsg" class="error">이름을 입력해 주세요.</div>                  
	 						<div id="nameRegMsg" class="error">이름은 2~6자의 한글로만 입력해 주세요.</div>                  
	                    </div>
	                </td>
	            </tr>
	            <tr>
	                <th><span>* 이메일</span></th>
	                <td>
	                    <div class="member_warning">
	                        <input type="text" name="email" id="email" value="<%=loginUsers.getEmail()%>">
	                        <div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
							<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>														
	                    </div>						
	                </td>
	            </tr>
	            <tr>
	            	<% String[] phone=loginUsers.getPhone().split("-"); %>
	                <th><span>* 휴대폰번호</span></th>
	                <td class="member_warning">
	                		<select id="phone1" name="phone1">
	                			<option value="010" <% if(phone[0].equals("010")) { %>selected<% } %>>&nbsp;010&nbsp;</option>
	                			<option value="011" <% if(phone[0].equals("011")) { %>selected<% } %>>&nbsp;011&nbsp;</option>
	                			<option value="016" <% if(phone[0].equals("016")) { %>selected<% } %>>&nbsp;016&nbsp;</option>
	                			<option value="017" <% if(phone[0].equals("017")) { %>selected<% } %>>&nbsp;017&nbsp;</option>
	                			<option value="018" <% if(phone[0].equals("018")) { %>selected<% } %>>&nbsp;018&nbsp;</option>
	                			<option value="019" <% if(phone[0].equals("019")) { %>selected<% } %>>&nbsp;019&nbsp;</option>
	                		</select>
	                        <input type="text" id="phone2" name="phone2" maxlength="4" value="<%=phone[1]%>">
	                        <input type="text" id="phone3" name="phone3" maxlength="4" value="<%=phone[2]%>">
	                   		<div id="phoneMsg" class="error">휴대폰번호를 입력해 주세요.</div>
							<div id="phoneRegMsg" class="error">휴대폰번호는 3~4자리의 숫자로만 입력해 주세요.</div>                  
	                </td>
	            </tr>
	            <tr>
	                <th><span class="important">* 생일</span></th>
	                <td>
	                    <div class="member_warning">                        
	                        <input type="text" id="birthday" name="birthday" maxlength="8" placeholder="예시) 20150903" value="<%=loginUsers.getBirthday()%>">
	                    	<div id="birthdayMsg" class="error">생년월일을 입력해 주세요.</div>
							<div id="birthdayRegMsg" class="error">입력한 생년월일이 형식에 맞지 않습니다.</div>
	                    </div>
	                </td>
	            </tr>
	            <tr>
	                <th><span>* 주소</span></th>
	                <td>
	                    <div>
	                        <input type="text" name="zipcode" id="zipcode" readonly="readonly" value="<%=loginUsers.getZipcode()%>">
	                        <button type="button" id="btnPostSearch" class="btnPostSearch" onclick="sample4_execDaumPostcode()">우편번호 검색</button>
	                        <input type="hidden" name="zipcode">
	                        <div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div>
	                    </div>
	                    <div>
	                        <div class="member_warning">
	                            <input type="text" name="address1" id="address1" readonly="readonly" value="<%=loginUsers.getAddress1()%>">
	                            <div id="address1Msg" class="error">기본주소를 입력해 주세요.</div>
	                        </div>
	                        <div class="member_warning js_address_sub">
	                            <input type="text" name="address2" id="address2" value="<%=loginUsers.getAddress2()%>">
	                            <div id="address2Msg" class="error">상세주소를 입력해 주세요.</div>
	                        </div>
	                    </div>
	                </td>
	            </tr>
	            </tbody>
	        </table>
	    </div>
 		<!-- //base_info_sec -->
	</div>
	<!-- //base_info_box --><!-- 회원가입 기본정보 -->				
	<div class="btn_center_box">
		<button type="button" id="btnCancel" class="btn_member_cancel" onclick="location.href='<%=request.getContextPath()%>/home.jsp?workgroup=mypage&work=mypage_orders';">취소</button>
		<button type="submit" id="btnModify" class="btn_comfirm js_btn_join">정보수정</button>
	</div>				
</form>
</div>
<!-- //member_cont -->
</div>
<!-- //join_base_wrap -->
</div>
<!-- //content_box -->
</div>
</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$("#formModify").submit(function() {
	//입력값에 대한 유효성 검사
	var submitResult=true;
	
	$(".error").css("display","none");
		
	var pwReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#pw").val()!="" && !pwReg.test($("#pw").val())) {
		$("#pwRegMsg").css("display","block");
		submitResult=false;
	} 
	
	if($("#pw").val()!="" && $("#repw").val()=="") {
		$("#repwMsg").css("display","block");
		submitResult=false;
	} else if($("#pw").val()!=$("#repw").val()) {
		$("#repwMatchMsg").css("display","block");
		submitResult=false;
	}
	
	var nameReg=/^[가-힣]{2,6}$/;
	if($("#name").val()=="") {
		$("#nameMsg").css("display","block");		
		submitResult=false;
	} else if(!nameReg.test($("#name").val())) {
		$("#nameRegMsg").css("display","block");
		submitResult=false;
	}
	
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
		submitResult=false;
	} else if(!emailReg.test($("#email").val())) {
		$("#emailRegMsg").css("display","block");
		submitResult=false;
	} 
	
	var phone2Reg=/\d{3,4}/;
	var phone3Reg=/\d{4}/;
	if($("#phone2").val()=="" || $("#phone3").val()=="") {
		$("#phoneMsg").css("display","block");
		submitResult=false;
	} else if(!phone2Reg.test($("#phone2").val()) || !phone3Reg.test($("#phone3").val())) {
		$("#phoneRegMsg").css("display","block");
		submitResult=false;
	}
	
	var birthdayReg=/^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
	if($("#birthday").val()=="") {
		$("#birthdayMsg").css("display","block");
		submitResult=false;
	} else if(!birthdayReg.test($("#birthday").val())) {
		$("#birthdayRegMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#zipcode").val()=="") {
		$("#zipcodeMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#address1").val()=="") {
		$("#address1Msg").css("display","block");
		submitResult=false;
	}
	
	if($("#address2").val()=="") {
		$("#address2Msg").css("display","block");
		submitResult=false;
	}
	
	return submitResult;
});

//우편번호 검색 버튼 클릭 시
$("#btnPostSearch").click(function() {
	new daum.Postcode({
        oncomplete: function(data) {
        	$('input[id=zipcode]').val(data.zonecode);    
        	$('input[id=address1]').val(data.address);       	  
        	$('input[id=address2]').focus();       	  
        }
    }).open();
});

</script>