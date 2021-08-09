<%@page import="dto.UsersDTO"%>
<%@page import="dao.UsersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="css/users_join.css"/>    
<%-- 회원가입 페이지--%>
<%-- => [회원가입]을 클릭한 경우 회원 가입 완료페이지(users_join_success.jsp)로 이동 - 입력값 전달 --%>
<%-- => [취소]를 클릭한 경우 메인페이지(home.jsp)로 이동 --%>
<%-- => [아이디 중복확인]를 클릭한 경우 새창에 아이디 중복 검사페이지(id_check.jsp)로 이동 - 아이디 전달 --%>	
<div id="container">
<div id="contents">
<div class="sub_content">
<div class="join_base_wrap">
<div class="member_tit">
	<ol>
		<li><span>01</span> 약관동의<span><img src="https://www.ranicake.com//data/skin/front/jeonyul_200918/img/member/icon_join_step_off.png"></span></li>
		<li class="page_on"><span>02</span> 정보입력<span><img src="https://www.ranicake.com//data/skin/front/jeonyul_200918/img/member/icon_join_step_on.png"></span></li>
		<li><span>03</span> 가입완료</li>
	</ol>
</div>
<!-- //member_tit -->
<div class="member_cont">
<form id="formJoin" name="formJoin" method="post" 
	action="<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_join_success">
<%-- 아이디 및 이메일 중복 검사 실행 여부를 확인하기 위한 입력 태그 --%>
<%-- 입력값 : 0 - 미실행(사용 불가 아이디), 1 - 실행(사용 가능 아이디) --%>
<input type="hidden" name="idCheckResult" id="idCheckResult" value="0">
<input type="hidden" name="emailCheckResult" id="emailCheckResult" value="0">

	<!-- 회원가입 기본정보 -->
	<div class="base_info_box">
	    <h3>회원가입</h3>
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
	                        <input type="text" id="id" name="id">
	                        <button type="button" id="btnIdCheck">아이디 중복확인</button>
	                        <div id="idMsg" class="error">아이디를 입력해 주세요.</div>
							<div id="idRegMsg" class="error">아이디는 영문자로 시작되는 영문자,숫자의 6~20 범위의 문자로만 작성 가능합니다.</div>
							<div id="idCheckMsg" class="error">아이디 중복검사를 반드시 실행해 주세요.</div>
	                    </div>
	                </td>	
	            </tr>
	            <tr>
	                <th><span class="important">* 비밀번호</span></th>
	                <td>
	                    <div class="member_warning">
	                        <input type="password" id="pw" name="pw">
							<div id="pwMsg" class="error">비밀번호를 입력해 주세요.</div>
							<div id="pwRegMsg" class="error">비밀번호는 영문자,숫자,특수문자가 반드시 하나이상 포함된 6~20 범위의 문자로만 작성 가능합니다.</div>						                   
	                    </div>
	                </td>
	            </tr>
	            <tr>
	                <th><span class="important">* 비밀번호 확인</span></th>
	                <td>
	                    <div class="member_warning">
	                        <input type="password" id="repw" name="repw">
		                    <div id="repwMsg" class="error">비밀번호 확인을 입력해 주세요.</div>
							<div id="repwMatchMsg" class="error">비밀번호와 비밀번호 확인이 서로 맞지 않습니다.</div>
	                    </div>
	                </td>
	            </tr>
	            <tr>
	                <th><span class="important">* 이름</span></th>
	                <td>
	                    <div class="member_warning">
	                        <input type="text" id="name" name="name">
	 						<div id="nameMsg" class="error">이름을 입력해 주세요.</div>                  
	 						<div id="nameRegMsg" class="error">이름은 2~6자의 한글로만 입력해 주세요.</div>                  
	                    </div>
	                </td>
	            </tr>
	            <tr>
	                <th><span>* 이메일</span></th>
	                <td>
	                    <div class="member_warning">
	                        <input type="text" name="email" id="email">
	                        <div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
							<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>														
	                    </div>						
	                </td>
	            </tr>
	            <tr>
	                <th><span>* 휴대폰번호</span></th>
	                <td class="member_warning">
	                		<select id="phone1" name="phone1">
	                			<option value="010" selected>&nbsp;010&nbsp;</option>
	                			<option value="011">&nbsp;011&nbsp;</option>
	                			<option value="016">&nbsp;016&nbsp;</option>
	                			<option value="017">&nbsp;017&nbsp;</option>
	                			<option value="018">&nbsp;018&nbsp;</option>
	                			<option value="019">&nbsp;019&nbsp;</option>
	                		</select>
	                        <input type="text" id="phone2" name="phone2" maxlength="4">
	                        <input type="text" id="phone3" name="phone3" maxlength="4">
	                   		<div id="phoneMsg" class="error">휴대폰번호를 입력해 주세요.</div>
							<div id="phoneRegMsg" class="error">휴대폰번호는 3~4자리의 숫자로만 입력해 주세요.</div>                  
	                </td>
	            </tr>
	            <tr>
	                <th><span class="important">* 생일</span></th>
	                <td>
	                    <div class="member_warning">                        
	                        <input type="text" id="birthday" name="birthday" maxlength="8" placeholder="예시) 20150903">
	                    	<div id="birthdayMsg" class="error">생년월일을 입력해 주세요.</div>
							<div id="birthdayRegMsg" class="error">입력한 생년월일이 형식에 맞지 않습니다.</div>
	                    </div>
	                </td>
	            </tr>
	            <tr>
	                <th><span>* 주소</span></th>
	                <td>
	                    <div>
	                        <input type="text" name="zipcode" id="zipcode" readonly="readonly">
	                        <button type="button" id="btnPostSearch" class="btnPostSearch">우편번호 검색</button>
	                        <input type="hidden" name="zipcode">
	                        <div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div>
	                    </div>
	                    <div>
	                        <div class="member_warning">
	                            <input type="text" name="address1" id="address1" readonly="readonly">
	                            <div id="address1Msg" class="error">기본주소를 입력해 주세요.</div>
	                        </div>
	                        <div class="member_warning js_address_sub">
	                            <input type="text" name="address2" id="address2">
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
		<button type="reset" id="btnCancel" class="btn_member_cancel">다시입력</button>
		<button type="submit" id="btnJoin" class="btn_comfirm js_btn_join">회원가입</button>
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
$("#formJoin").submit(function() {
	//입력값에 대한 유효성 검사
	var submitResult=true;
	
	$(".error").css("display","none");

	var idReg=/^[a-zA-Z]\w{5,19}$/g;
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		submitResult=false;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		submitResult=false;
	} else if($("#idCheckResult").val()==0) {
		$("#idCheckMsg").css("display","block");		
		submitResult=false;
	}
		
	var pwReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#pw").val()=="") {
		$("#pwMsg").css("display","block");
		submitResult=false;
	} else if(!pwReg.test($("#pw").val())) {
		$("#pwRegMsg").css("display","block");
		submitResult=false;
	} 
	
	if($("#repw").val()=="") {
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

//아이디 중복확인 버튼 클릭 시
$("#btnIdCheck").click(function () {
	$("#idMsg").css("display", "none");
	$("#idRegMsg").css("display", "none");
	
	var idReg=/^[a-zA-Z]\w{5,19}$/g;
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		return;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		return;
	}	
	window.open("<%=request.getContextPath()%>/users/id_check.jsp?id="+$("#id").val(),"idcheck","width=400,height=100,left=700,top=450");
});

//아이디의 입력값이 변경된 경우 
$("#id").change(function() {
	if($("#idCheckResult").val()=="1") {
		$("#idCheckResult").val("0");
	}
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

