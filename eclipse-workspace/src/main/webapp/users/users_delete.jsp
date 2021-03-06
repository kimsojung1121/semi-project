<%@page import="Utility.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="css/mypage.css"/>     
<%-- 비밀번호를 전달받아 로그인 사용자의 비밀번호와 비교하여 같은 경우 출력되는 회원탈퇴 페이지 --%>
<%-- => 전달받은 비밀번호가 로그인 사용자의 비밀번호가 같지 않은 경우 비밀번호 입력페이지(pw_confirm.jsp)로 이동 --%>
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
	String pw=Utility.encrypt(request.getParameter("pw"));
	
	//전달받은 비밀번호와 로그인 사용자의 비밀번호가 같지 않은 경우 - 비밀번호 입력페이지 재요청
	if(!loginUsers.getPw().equals(pw)) {
		session.setAttribute("message", "비밀번호가 맞지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=users&work=pw_confirm&action=delete';");
		out.println("</script>");
		return;	
	}	
%>

<div id="container">
        <div id="contents">
        <!-- 본문 시작 -->
            <div class="sub_content">
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
                <li><a href="<%=request.getContextPath() %>/home.jsp?workgroup=users&work=pw_confirm&action=modify">- 회원정보 변경</a></li>
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

<div class="content">
    <div class="mypage_cont">
        <form id="formDelete" name="formDelete" method="post" 
        	action="<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_delete_action" >
            <div class="hack_out">
                <div class="mypage_unregister">
                    <div class="mypage_zone_tit">
                        <h3>01. 회원탈퇴 안내</h3>
                    </div>

                    <div class="unregister_info">
                        IMO CAKE | IMO 케이크 탈퇴안내<br/>
<br/>
회원님께서 회원 탈퇴를 원하신다니 저희 쇼핑몰의 서비스가 많이 부족하고 미흡했나 봅니다.<br/>
불편하셨던 점이나 불만사항을 알려주시면 적극 반영해서 고객님의 불편함을 해결해 드리도록 노력하겠습니다.<br/>
<br />
■ 아울러 회원 탈퇴시의 아래 사항을 숙지하시기 바랍니다.<br />
1. 회원 탈퇴 시 회원님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서의 소비자 보호에 관한 법률에 의거한 고객정보 보호정책에 따라 관리됩니다.<br />
2. 탈퇴 시 회원님께서 보유하셨던 마일리지는 삭제 됩니다.
                    </div>
                    <!-- //unregister_info -->
					<div class="mypage_zone_tit">
                        <h3>02. 회원탈퇴 하기</h3>
                    </div>
                    <div class="mypage_table_type">
                        <table class="table_left">
                            <colgroup>
                                <col style="width:15%;">
                                <col style="width:85%;">
                            </colgroup>
                            <tbody>                           
                            <tr>
                                <th scope="row">탈퇴사유</th>
                                <td>
                                    <div class="form_element">
                                        <ul class="hack_out_list">
	                                        <li id="reasonCk">
	                                        <input type="checkbox" id="reasonCd01003001" name="reasonCd[]" class="checkbox" value="01003001">
	                                        <label for="reasonCd01003001" class="check-s">고객서비스(상담,포장 등) 불만</label>
	                                        </li>
	                                        <li id="reasonCk">
	                                        <input type="checkbox" id="reasonCd01003002" name="reasonCd[]" class="checkbox" value="01003002">
	                                        <label for="reasonCd01003002" class="check-s">배송불만</label>
	                                        </li>
	                                        <li id="reasonCk">
	                                        <input type="checkbox" id="reasonCd01003003" name="reasonCd[]" class="checkbox" value="01003003">
	                                        <label for="reasonCd01003003" class="check-s">교환/환불/반품 불만</label>
	                                        </li>
	                                        <li id="reasonCk">
	                                        <input type="checkbox" id="reasonCd01003004" name="reasonCd[]" class="checkbox" value="01003004">
	                                        <label for="reasonCd01003004" class="check-s">방문 빈도가 낮음</label>
	                                        </li>
	                                        <li id="reasonCk">
	                                        <input type="checkbox" id="reasonCd01003005" name="reasonCd[]" class="checkbox" value="01003005">
	                                        <label for="reasonCd01003005" class="check-s">상품가격 불만</label>
	                                        </li>
	                                        <li id="reasonCk">
	                                        <input type="checkbox" id="reasonCd01003006" name="reasonCd[]" class="checkbox" value="01003006">
	                                        <label for="reasonCd01003006" class="check-s">개인 정보유출 우려</label>
	                                        </li>
	                                        <li id="reasonCk">
	                                        <input type="checkbox" id="reasonCd01003007" name="reasonCd[]" class="checkbox" value="01003007">
	                                        <label for="reasonCd01003007" class="check-s">쇼핑몰의 신뢰도 불만</label>
	                                        </li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">남기실 말씀</th>
                                <td><textarea cols="30" rows="5"  name="reasonDesc"></textarea></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- //mypage_unregister -->
 
            </div>
            <!-- //hack_out -->

            <div class="btn_center_box">
                <a href="<%=request.getContextPath()%>/home.jsp?workgroup=mypage&work=mypage_orders" id="btnCancel" class="btnCancel">취소</a>
                <button type="button" id="btnDelete" class="btn_claim_ok" onclick="check();">탈퇴하기</button>
            </div>
        </form>
    </div>
    <!-- //mypage_cont -->
</div>
<!-- //content -->
</div>
<!-- //sub_content -->
</div>
<!-- //본문 끝 contents -->
</div>
<!-- //container -->
    
<script type="text/javascript">
function check() {
	if($("input:checkbox[name='reasonCd[]']").is(":checked")==false) {
		alert("탈퇴사유를 1개 이상 체크하여 주시기바랍니다.");
		return;
	}
	
	if(confirm("탈퇴 시 보유중인 회원혜택은 모두 삭제됩니다. 정말로 탈퇴하시겠습니까?")==false) {
		return;
	}
	
	$("#formDelete").submit();
}
</script>

<%-- <script type="text/javascript">

//폼태그 액션 = (action="<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_delete_action") 삭제 후 적용 

$("#btnDelete").click(function() {
	//검색 엘리먼트의 자식 엘리먼트(checkbox) 중 선택된 엘리먼트만 검색
	var $check=$("#reasonCk").children(":checked");
	if($check.length==0) {//선택된 엘리먼트가 없는 경우
		alert("탈퇴사유를 1개 이상 체크하여 주시기바랍니다.");
		return false;
	} else {
		if(confirm("탈퇴 시 보유중인 회원혜택은 모두 삭제됩니다. 정말로 탈퇴하시겠습니까?")) {
	$("#formDelete").attr("action", "<%=request.getContextPath() %>/home.jsp?workgroup=users&work=users_delete_action");
	$("#formDelete").submit();
		}else{
			return false;
		}
	}
});

</script> --%>
