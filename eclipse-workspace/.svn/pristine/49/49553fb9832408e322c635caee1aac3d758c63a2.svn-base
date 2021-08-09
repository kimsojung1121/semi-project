<%@page import="dao.ProductsDAO"%>
<%@page import="dto.ProductsDTO"%>
<%@page import="dao.OrdersDAO"%>
<%@page import="dto.OrdersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 로그인 상태의 관리자만 접근 가능 --%>
<%@include file="/security/admin_check.jspf"%>
    
<%
	/*
	//비정상적이 요청에 대한 처리
	if(request.getParameter("productNum")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;		
	}
	*/

	//전달값을 반환받아 저장
	int oNo=Integer.parseInt(request.getParameter("oNo"));

	//주문번호를 전달받아 ORDERS 테이블에 저장된 해당 주문번호의 주문정보를 검색하여 
	//반환하는 DAO 클래스의 메소드 호출
	OrdersDTO order=OrdersDAO.getDAO().selectOrderNoRow(oNo);
	
	ProductsDTO product = ProductsDAO.getDAO().selectProductsInfo(order.getpNo());
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
	<br><br>
	<h2>주문상세 정보</h2>	
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
			<td height="20px;" colspan="4"  align="left"><%=order.getoNo()%></td>
		</tr>
		
		<tr>
			<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">회원 ID</td>
			<td height="20px;" colspan="4"  align="left"><%=order.getId()%></td>
		</tr>
		
		<tr>
			<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">주문상품</td>
			
			<td height="20px;" colspan="4"  align="left">[<%=order.getpNo()%>] <%=product.getpName() %></td>
		</tr>
		
		<tr>
			<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">레터링</td>
			<td height="20px;" colspan="4"  align="left"><%=order.getcLettering()%></td>
		</tr>
		
		<tr>
			<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">배송지</td>
			<td height="20px;" colspan="4"  align="left">
				<%=order.getoAddress1()%>&nbsp;&nbsp;<%=order.getoAddress2() %>
			</td>
		</tr>
		
		
		<tr>
			<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">주문 일자</td>
			<td height="20px;" colspan="4"  align="left"><%=order.getoDate()%></td>
		</tr>
		
		<tr>
			<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">배송상태</td>
			<td height="20px;" colspan="4"  align="left">
				<% if(order.getoState()==1) {%>
					주문 확인
				<% } else if(order.getoState()==2) { %>
					배송준비
				<% } else if(order.getoState()==3) { %>
					배송 중
				<% } else if(order.getoState()==4) { %>
					배송 완료
				<% } %>
			</td>
		</tr>
	</table>
	<br>
			
	<div style="padding-bottom: 50px;">
	<button type="button" class="removeBtn" id="removeOrdertBtn">주문 취소</button>
	<button type="button" class="modifyBtn" id="modifyOrderBtn">주문정보 변경</button>
	<button type="button" class="modifyBtn" id="listBtn" style="background-color:#dcdcdc;">목록으로</button>
	</div>
</div>

<script type="text/javascript">
$("#modifyOrderBtn").click(function() {
	location.href="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=order_modify&oNo=<%=order.getoNo() %>";
});

$("#removeOrdertBtn").click(function() {
	if(window.confirm("주문을 취소 처리 하겠습니까?")) {
		location.href="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=order_remove_action&oNo=<%=order.getoNo() %>";
	}
});

$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=orders";
});
</script>