<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.ProductsDAO"%>
<%@page import="dto.ProductsDTO"%>
<%@page import="dto.OrdersDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.OrdersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>

<%! int orderSeq; %>

<%
	List<OrdersDTO> orderList = OrdersDAO.getDAO().selectTodayOrders(loginUsers.getId());
	if(orderList.size()==0)
		System.out.println("orderList가 없습니다.");
	orderSeq = 1;
%>

<link type="text/css" rel="stylesheet" href="css/cartnOrder.css"/>
<link type="text/css" rel="stylesheet" href="css/mypage_orders.css"/>

<div>
	<br><br>
		<div class="cart">
			<h2 align="center">주문상세 정보</h2>
		</div>
		<br><br>
		<div style="text-align: right; font-size: 20px;" class="cart">
			<span style="color: RGB(200,200,200);">01 장바구니</span><span>&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/images/icon_join_step_on.png"></span>&nbsp;&nbsp;
			<span style="color: RGB(200,200,200);">02 주문서 작성/결제</span>&nbsp;&nbsp;<span><img src="<%=request.getContextPath()%>/images/icon_join_step_on.png"></span>&nbsp;&nbsp;
			<span>03 주문완료</span>
		</div>
		
		<div class="cart">
			<hr><br><br>
		</div>
		
		<% for(OrdersDTO order : orderList) { %>
			<%
			ProductsDTO product = ProductsDAO.getDAO().selectProductsInfo(order.getpNo());
			
			%>
			
			<br><br>
				
			<table class="cart" id="cartTable">
				<tr height="30px" style="background: RGB(254,199,158);">
					<th class="colName">구분</th>
					<th class="colName">주문일자</th>
					<th class="colName">결제 금액</th>
					<th class="colName">케이크 & 레터링</th>
					<th class="colName">배송 상태</th>
				</tr>

				<tr id="showDetail" onclick="shownHideDetail(<%=orderSeq%>)">
					<td class="orderedList">
						<%=orderSeq%>
					</td>
					<td class="orderedList">
						<%=order.getoDate() %>
					</td>
					<td class="orderedList">
						<%=DecimalFormat.getInstance().format(product.getpPrice()) %>원
					</td>
					<td class="orderedList">
						<div>
							<img src="<%=request.getContextPath()%>/product_image/<%=product.getpNo()%>.jpg" width="80px" style="padding: 10px;">
							<p><%=product.getpName() %></p>
							<p><%=order.getcLettering() %></p>
						</div>
					</td>
					
					<td class="orderedList">
							<% int state=order.getoState(); %>
							<% if(state==1) {%>
								<span style="color: black;">주문 확인</span>	
							<% } else if(state==2) { %>
								<span style="color: blue;">배송준비</span>	
							<% } else if(state==3) { %>
								<span style="color: orange;">배송 중</span>	
							<% } else if(state==4) { %>
								<span style="color: red;">배송 완료</span>	
							<% } %>
						
					</td>	
				</tr>
			
			</table>
				
			
			<div class="<%=orderSeq%>" style="display: none;" >
				<table class="cart" id="cartTable">
					<tr>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
					</tr>
					
					<tr>
						<td colspan="5" height="40px" style="font-size: 20px; color:red;">상세 내역</td>
					</tr>
	
					<tr>
						<td class="orderList" colspan="1">주문 번호</td>
						<td class="orderListVal" colspan="4"><span class="orderValue"><%=order.getoNo()%></span></td>
					</tr>
					
					<tr>
						<td colspan="1" class="orderList">주문자 ID</td>
						<td class="orderListVal" colspan="4"><span class="orderValue"><%=loginUsers.getId()%></span></td>
					</tr>
					
					<tr>
						<td colspan="1" class="orderList">주문 상품</td>
						
						<td class="orderListVal" colspan="4"><span class="orderValue"><%=product.getpName()%></span></td>
					</tr>
					
					<tr>
						<td colspan="1" class="orderList">결제 금액</td>
						
						<td class="orderListVal" colspan="4"><span class="orderValue"><%=DecimalFormat.getInstance().format(product.getpPrice())%>원</span></td>
					</tr>
					
					<tr>
						<td class="orderList" colspan="1">레터링</td>
						<td class="orderListVal" colspan="4"><span class="orderValue"><%=order.getcLettering()%></span></td>
	
					</tr>
					
					<tr>
						<td class="orderList" colspan="1">배송지</td>
						<td class="orderListVal" colspan="4">
							<span class="orderValue">
								[<%=order.getoZipcode()%>]&nbsp;<%=order.getoAddress1()%>&nbsp;&nbsp;<%=order.getoAddress2() %>
							</span>
	
						</td>
					</tr>
					
					<tr>
						<td class="orderList" colspan="1">주문일자</td>
						<td class="orderListVal" colspan="4"><span class="orderValue"><%=order.getoDate()%></span></td>
	
					</tr>
					
					<tr>
						<td class="orderList" colspan="1">배송상태</td>
						<td class="orderListVal" colspan="4">
							<span class="orderValue">
							<% if(state==1) {%>
								주문 확인
							<% } else if(state==2) { %>
								배송준비
							<% } else if(state==3) { %>
								배송 중
							<% } else if(state==4) { %>
								배송 완료
							<% } %>
							</span>
						</td>
					</tr>
					
				</table>
			</div>
			<br>
			<% orderSeq++; %>
		<% } %>
</div>

<script type="text/javascript">

function shownHideDetail(value) {
	$("."+value+"").toggle();
}
</script>
