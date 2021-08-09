<%@page import="dao.OrdersDAO"%>
<%@page import="dto.OrdersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 로그인 상태의 관리자만 접근 가능 --%>
<%@include file="/security/admin_check.jspf"%>

<%
	//비정상적이 요청에 대한 처리
	if(request.getParameter("oNo")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;		
	}

	//전달값을 반환받아 저장
	int oNo=Integer.parseInt(request.getParameter("oNo"));

	//주문정보를 전달받아 ORDERS 테이블에 저장된 해당 주문번호의 주문정보를 검색하여 
	//반환하는 DAO 클래스의 메소드 호출
	OrdersDTO order=OrdersDAO.getDAO().selectOrderNoRow(oNo);
%>


<style type="text/css">
table {
	width: 100%;
	border: 1px solid RGB(220,220,220);
	border-collapse: collapse;
	border-left-style: none;
	border-right-style: none;
}

th {
	border: 1px solid RGB(220,220,220);
	border-collapse: collapse;
}

td {
	border: 1px solid RGB(220,220,220);
	border-left-style: none;
	border-right-style: none;
	border-collapse: collapse;
}

input {
	width: 100%;
	float: left;
	display: inline-block;
}

td span {
	color: red;
}

.cart {
	margin: 0 auto;
	font-size: 20px;
}

#cartTable {
	font-size: 20px;
}
</style>

<%-- CSS --%>
<link type="text/css" rel="stylesheet" href="css/admin.css"/>


<div class="baseContent">
	<h2>주문변경</h2>
	
	<form action="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=order_modify_action" method="post" id="orderForm">
		<table class="cart" id="cartTable">
			<tr>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
			</tr>
			<tr>
				<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">주문번호</td>
				<td height="20px;" colspan="4"  align="left">
					<input type="text" name="oNo" id="oNo" maxlength="20" value="<%=order.getoNo()%>" readonly>
				</td>
			</tr>
			<tr>
				<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">회원 ID</td>
				<td height="20px;" colspan="4"  align="left">
					<input type="text" name="id" id="id" maxlength="20" value="<%=order.getId()%>" readonly>
				</td>
			</tr>
			<tr>
				<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">주문상품</td>
				<td height="20px;" colspan="4"  align="left">
					<input type="text" name="pNo" id="pNo" maxlength="20" value="<%=order.getpNo()%>" readonly>
				</td>
			</tr>
			
			<%-- 주문상태가 주문완료일 때 - 레터링, 배송지, 상태 변경 가능 --%>
			<% if(order.getoState()==1) { %>
			<tr>
				<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">레터링</td>
				<td height="20px;" colspan="4"  align="left">
						<input type="text" name="cLettering" id="cLettering" maxlength="20" value="<%=order.getcLettering()%>">
					
				</td>
			</tr>
			<tr>
				<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">배송지</td>
					
				<td height="20px;" colspan="4"  align="left">
					<div style="margin-top: 10px; margin-bottom: 10px; margin-left: 0;">
						<input type="text" id="zipcode" name="zipcode" style="border: 2px solid RGB(220,220,220); width: 200px; height: 35px;" readonly="readonly" value="<%=order.getoZipcode()%>">
						<button type="button" style="border: 1px solid black; margin-left:10px; margin-right:700px; width: 100px; height: 35px; float:left; display:inline-block;"onclick="sample6_execDaumPostcode()">우편번호검색</button>		
					</div>
					<div style="margin-top: 10px; margin-bottom: 10px;">
						<input type="text" id="address1" name="address1" style="border: 2px solid RGB(220,220,220); width: 400px; height: 35px;"readonly="readonly" value="<%=order.getoAddress1()%>">
						<input type="text" id="address2" name="address2" style="border: 2px solid RGB(220,220,220); margin-left:10px; width: 300px; height: 35px;" value="<%=order.getoAddress2()%>">
					</div>
					<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script>
						function sample6_execDaumPostcode() {
							new daum.Postcode( { oncomplete : function(data) {
						
									var addr = ''; // 주소 변수
									if (data.userSelectedType === 'R') {
									   addr = data.roadAddress;
									} else {
								 	  addr = data.roadAddress;
									}
									document.getElementById('zipcode').value = data.zonecode;
									document.getElementById("address1").value = addr;
									document.getElementById("address2").focus();
								}
							}).open();
						}
	                 </script>
				</td>
			</tr>
			<%-- 주문상태가 배송준비, 배송중, 배송완료일 때 - 상태 변경 가능 --%>
			<% } else { %>
			<tr>
				<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">레터링</td>
				<td height="20px;" colspan="4"  align="left">
						<input type="text" name="cLettering" id="cLettering" maxlength="20" value="<%=order.getcLettering() %>" readonly>
					
				</td>
			</tr>
			<tr>
				<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">배송지</td>
					
				<td height="20px;" colspan="4"  align="left">
					<div style="margin-top: 10px; margin-bottom: 10px;">
						<input type="text" id="zipcode" name="zipcode" style="border: 2px solid RGB(220,220,220); width: 200px; height: 35px;" readonly="readonly" value="<%=order.getoZipcode()%>">		
					</div>
					<div style="margin-top: 10px; margin-bottom: 10px;">
						<input type="text" id="address1" name="address1" style="border: 2px solid RGB(220,220,220); margin-left:10px; width: 400px; height: 35px;" readonly="readonly" value="<%=order.getoAddress1()%>">
						<input type="text" id="address2" name="address2" style="border: 2px solid RGB(220,220,220); margin-left:10px; width: 300px; height: 35px;" readonly="readonly" value="<%=order.getoAddress2()%>">
					</div>
				</td>
			</tr>
			<% } %>
			
			<tr>
				<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">주문일자</td>
				<td height="20px;" colspan="4"  align="left">
					<input type="text" name="oDate" id="oDate" maxlength="20" value="<%=order.getoDate()%> " readonly>
				</td>
			</tr>
			<tr>
				<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">주문상태</td>
				<td height="20px;" colspan="4"  align="left">
					<input type="text" name="oState" id="oState" maxlength="20" value="<%=order.getoState()%>" style="width: 30%">
					<select name="oState" style="float:left; display:inline-block;">
						<option value="1">&nbsp;주문확인&nbsp;</option>
						<option value="2">&nbsp;배송준비&nbsp;</option>
						<option value="3">&nbsp;배송중&nbsp;</option>
						<option value="4">&nbsp;배송완료&nbsp;</option>
					</select>
				</td>
			</tr>
			
		</table>
		<button type="submit" class="btn">주문정보 변경</button>	
	</form>
	
	<div id="message" style="color: red;"></div>
</div>

<script type="text/javascript">
$('select[name=oState]').change(function() {

	if($(this).val()=="1"){
		$('#oState').val(1);

	} else if($(this).val()=="2"){
		$('#oState').val(2);

	} else if($(this).val()=="3"){
		$('#oState').val(3);

	} else if($(this).val()=="4"){
		$('#oState').val(4);

	}

});

$("#orderForm").submit(function() {
	if($("#cLettering").val()=="") {
		$("#message").text("레터링을 입력해 주세요.");
		$("#cLettering").focus();
		return false;
	}
	
	
	if($("#zipcode").val()=="") {
		$("#message").text("배송지를 입력해 주세요.");
		$("#zipcode").focus();
		return false;
	}
	if($("#address1").val()=="") {
		$("#message").text("배송지를 입력해 주세요.");
		$("#address1").focus();
		return false;
	}
	if($("#address2").val()=="") {
		$("#message").text("배송지를 입력해 주세요.");
		$("#address2").focus();
		return false;
	}
	
});

</script>