<%@page import="dao.CartDAO"%>
<%@page import="dto.CartDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.ProductsDAO"%>
<%@page import="dto.ProductsDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%!	int total=0; // 장바구니 상품 수량x금액들의 합 
	int	delPrice=0; // 배송비
%>

<%
	total = 0;
	delPrice = 0;

	String id = loginUsers.getId(); 
	List<CartDTO> cartList = CartDAO.getDAO().selectAllCart(id);
	
	
%>

<link type="text/css" rel="stylesheet" href="css/cartnOrder.css"/>

<div class="cart" style="text-align: center;">
	<br>
	<h1>장바구니</h1>
	<br><br>
</div>

<div style="text-align: right; font-size: 20px;" class="cart">
	<span>01 장바구니</span><span>&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/images/icon_join_step_on.png"></span>&nbsp;&nbsp;
	<span style="color: RGB(200,200,200);">02 주문서 작성/결제</span>&nbsp;&nbsp;<span><img src="<%=request.getContextPath()%>/images/icon_join_step_on.png"></span>&nbsp;&nbsp;
	<span style="color: RGB(200,200,200);">03 주문완료</span>
</div>

<div class="cart">
	<hr><br><br>
</div>

<form name="cartForm" id="cart" method="post" action="<%=request.getContextPath()%>/home.jsp?workgroup=order&work=order">
	<div class="cart">
		<table id="cartTable" style="width: 1200px;">
			<tr id="tableBar">
				
				<th>상품/옵션 정보</th>
				<th>수량</th>
				<th>레터링 문구</th>
				<th>상품 금액</th>
				<th>합계 금액</th>
				<th></th>
			</tr>
		
		<% if(cartList==null || cartList.size()==0) { %>
			<tr>
				<td colspan="6" style="font-size: 20px; height: 100px;"> 장바구니가 비었습니다. </td>
			</tr>
		<% } %>
		
		
	 	<% for(CartDTO cart : cartList) { %> 
			<% ProductsDTO product = ProductsDAO.getDAO().selectProductsInfo(cart.getpNo()); %>
			<tr>
				
				<td class="checkBox">
					

					<span>
						<!-- 상품이미지 출력 -->
					
						<a href="<%=request.getContextPath()%>/home.jsp?workgroup=product&work=cake_detail&pNo=<%=product.getpNo()%>">
						
							<img src="<%=request.getContextPath()%>/product_image/<%=product.getpNo()%>.jpg" width="80px" style="padding: 10px;">
							<%-- System.out.println(session.getServletContext().getRealPath("/")+"product_image\\cake_"+product.getpNo()+".jpg"); --%>
							<%-- System.out.println(request.getContextPath()+"/product_image/cake_"+product.getpNo()+".jpg"); --%>
						</a>
					</span>
					
					<div>
						<!-- 상품이름 출력 -->
						
						<%=product.getpName()%>
						
					</div>
					
				</td>
				
				<td>
					<!-- 상품 주문 개수 출력 -->
					
					1개
				</td>
				
				<td>
					<%=cart.getcLettering() %>
				</td>
				
				<td>
					<!-- 상품 단가 출력 -->
				
					<%=DecimalFormat.getInstance().format(product.getpPrice())%>원
				</td>

				<td>
					<%=DecimalFormat.getInstance().format(product.getpPrice())%>원 <!-- 합계급액 -->
					<% total+=product.getpPrice();%>
					
				</td>
				
				
				
				<td>
					<button type="button" class="deleteBtn"
						style="border: 1px solid RGB(200,200,200); font-size: 12px; width: 50px;" value="<%=cart.getcNo()%>">
						제거
					</button>
				</td>
			</tr>
		<% } %>
		
		<% 
			if(cartList!=null && cartList.size()!=0) { 
				if(total>40000) { 
					delPrice=0; 
				} else { 
					delPrice=3500; 
				} 
			} else { 
				delPrice=0; 
			}
		 %>
			<!-- 삭제할 부분 시작 -->
			
			
			<!-- 삭제할 부분 끝 -->
			
		</table>
	</div>
</form>

<div align="left" class="cart">
	<br>
	<button style="border: 1px solid black; width: 100px; height: 30px;" id="toProductBtn">쇼핑 계속하기</button>	
</div>
<br>

<div class="cart" style="height: 50px; text-align: center;">
	
	<span>
		<span>총 <%=cartList.size() %>개의 상품 금액</span>
		<span> <%=DecimalFormat.getInstance().format(total)%>원</span>
	</span>&nbsp;&nbsp;
	<span>
		<image src="<%=request.getContextPath()%>/images/order_price_plus.png"  width="20px">
	</span>&nbsp;&nbsp;
	<span>
		<span>배송비</span>
		<span><%=DecimalFormat.getInstance().format(delPrice)%>원</span>
	</span>&nbsp;&nbsp;
	<span>
		<image src="<%=request.getContextPath()%>/images/order_price_total.png"  width="20px">
	</span>&nbsp;&nbsp;
	<span>
		<span>합계</span>
		<span><%=DecimalFormat.getInstance().format(total+delPrice)%>원</span>
	</span>
	<div id="message" style="font-size: 15px; color: red;">
	<% if(cartList!=null && cartList.size()!=0) { %>
		<% if(total<40000) { %>
			> 주문금액 40,000원부터 무료 배송 서비스를 제공하고 있습니다.
		<% } %>
	<% } %>
	</div>
</div>
<br><br>
<div id="orderBtn" style="text-align: center;" class="cart">
	<!-- <button type="button" id="selectOrderBtn" class="order" >선택 주문</button>&nbsp;&nbsp;&nbsp;&nbsp;-->
	<button type="button" id="orderAllBtn" class="order" onclick="orderAll(this)">주문하기</button>
</div>

<script type="text/javascript">
// document.getElementById("toProductBtn").onclick = function() {
<%-- 	location.href = "<%=request.getContextPath()%>/home.jsp?workgroup=main&work=main"; --%>
// }

$("#toProductBtn").click(function() {
	location.href = "<%=request.getContextPath()%>/home.jsp?workgroup=product&work=cake_lettering";
	return;
});

$(".deleteBtn").click(function() {
	var cNo = $(this).val();
	var result = confirm('삭제하시겠습니까?');
	if(result) {
		location.href='<%=request.getContextPath()%>/home.jsp?workgroup=order&work=cart_del_action&cNo='+cNo;
		
	}	
});

	
// $("#allCheck").change(function() {
// 	if($(this).is(":checked")) {
// 		$(".check").prop("checked",true);
// 	} else {
// 		$(".check").prop("checked",false);
// 	}
// });


	
// $("#selectOrderBtn").click(function() {
// 	if($(".check").filter(":checked").length==0) {
// 		$("#message").text("선택된 상품이 없습니다.");
// 		return;
// 	}

// document.getElementById("deleteBtn").onclick = function() {
// 	alert("adsfadfaf");
// }


$("#orderAllBtn").click(function() {
	<% if(cartList==null || cartList.size()==0) { %>
		alert("주문할 내역이 없습니다.");
		return false;
	<% } %>
	$("#cart").submit();
});

$("#deleteCartList").click(function() {
	
});

</script>