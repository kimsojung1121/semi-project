<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="css/pw_confirm.css"/>            
<%-- 에러메세지를 클라이언트에게 전달하는 JSP 문서 --%>    
<%-- => [메인으로]를 클릭한 경우 메인페이지(main.jsp)로 이동 --%>
<div id="container">
        <div id="contents">
        <!-- 본문 시작 -->
        <div class="sub_content">  
		<div class="content">
   		<div class="mypage_cont">
        <div class="my_page_password">
            <div class="mypage_zone_tit"></div>          
                <div class="id_pw_cont">
                <p class="errorMsg">비정상적인 방법으로 페이지를 요청 하였습니다.</br>
            	정상적인 방법으로 요청해 주세요.</p>                
                </div>
                <div class="btn_center_box">          
                    <button type="submit" class="btn_pw_certify" id="btnPwCheck" 
                    onclick="location.href = '<%=request.getContextPath()%>/home.jsp?workgroup=main&work=main'">HOME</button>
                </div>
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
