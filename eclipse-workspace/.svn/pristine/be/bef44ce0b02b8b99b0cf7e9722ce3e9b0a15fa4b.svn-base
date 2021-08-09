<%@page import="dao.ProductsDAO"%>
<%@page import="dto.ProductsDTO"%>
<%@page import="dao.CartDAO"%>
<%@page import="dto.CartDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.ProductsDTO"%>
<%@page import="dao.ProductsDAO"%>

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
	String zipcode = loginUsers.getZipcode();
	String address1 = loginUsers.getAddress1();
	String address2 = loginUsers.getAddress2();

	List<CartDTO> cartList = CartDAO.getDAO().selectAllCart(id);
%>

<link type="text/css" rel="stylesheet" href="css/cartnOrder.css"/>

<div style="margin-top: 100px; text-align: center;">
	<br>
	<h1>주문서 작성</h1>
	<br><br>
</div>

<div style="text-align: right; font-size: 20px;" class="cart">
	<span style="color: RGB(200,200,200);">01 장바구니</span><span>&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/images/icon_join_step_on.png"></span>&nbsp;&nbsp;
	<span>02 주문서 작성/결제</span>&nbsp;&nbsp;<span><img src="<%=request.getContextPath()%>/images/icon_join_step_on.png"></span>&nbsp;&nbsp;
	<span style="color: RGB(200,200,200);">03 주문완료</span>
</div>

<div class="cart">
	<hr><br><br>
</div>

<form name="orderForm" id="order" method="post" action="<%=request.getContextPath()%>/home.jsp?workgroup=order&work=order_add_action">
	<div style="text-align: center;" class="cart">
		<table class="cart" id="cartTable">
			<tr id="tableBar">
				<th>상품/옵션 정보</th>
				<th>수량</th>
				<th>레터링 문구</th>
				<th>상품 금액</th>
	<!-- 			<th>할인/적립</th> -->
				<th>합계 금액</th>
				
				
			</tr>
			
	 		<% for(CartDTO cart : cartList) { %>
	 			<% ProductsDTO product = ProductsDAO.getDAO().selectProductsInfo(cart.getpNo()); %>
				<tr>
					<td>
						<span>
							<div>
								<a href="<%=request.getContextPath()%>/home.jsp?workgroup=product&work=cake_detail&pNo=<%=product.getpNo()%>">
									<img src="<%=request.getContextPath()%>/product_image/<%=product.getpNo()%>.jpg" width="80px" style="padding: 10px;">
								</a>
							</div>
						</span>
						<span>
							<div>
								<p><%=product.getpName()%></p>
								
							</div>
						</span>
					</td>
					
					<td>
						1개
					</td>
					
					<td>
						<input type="hidden" name="letters" value="<%=cart.getcLettering()%>">
						<%=cart.getcLettering()%>
					</td>
					
					<td>
						<%=DecimalFormat.getInstance().format(product.getpPrice())%>원
					</td>
					<td>
						<%=DecimalFormat.getInstance().format(product.getpPrice())%>원
						<% total+=product.getpPrice(); %>
					</td>
				</tr>
			<% } %>
			
			<% if(cartList!=null && cartList.size()!=0) { %>
				<% if(total>40000) { %>
					<% delPrice=0; %>
				<% } else { %>
					<% delPrice=3500; %>
				<% } %>
			<% } else { %>
				<% delPrice=0; %>
			<% } %>
		</table>
		
		<div align="left">
			<br>
			<button type="button" style="border: 1px solid black; width: 100px; height: 30px;" id="toCartBtn">장바구니로 이동</button>	
		</div>
		<br>
		<div class="cart" style="height: 50px; text-align: center;">
			
			<span>
				<span>총 <%=cartList.size()%>개의 상품 금액</span>
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


	<br><br><br>
	
		<div>
			<h3>주문정보 작성</h3>
			<br>
			<table class="cart" id="cartTable">
			
				<tr>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">주문자 ID</td>
					
					<td height="20px;" colspan="4" align="left">
						<input type="hidden" name="id" value="<%=id%>">
						<p style="margin-left:50px; margin-top:18px; width: 350px; height: 35px;"><%=id%></p>
					</td>
				</tr>
				
				
				
				<tr>
					<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">수량</td>
					
					<td height="20px;" colspan="4" align="left" style="">
						
						<span style="margin-left:50px; width: 350px; height: 35px;"><%=cartList.size()%>개</span>
					</td>
				</tr>
				
				<tr>
					<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">받으실 곳</td>
					
					<td height="20px;" colspan="4"  align="left">
						<div style="margin-top: 10px; margin-bottom: 10px;">
							<input type="text" id="zipcode" name="zipcode" style="border: 2px solid RGB(220,220,220); margin-left:50px; width: 200px; height: 35px;" readonly="readonly" value="<%=zipcode%>">
							<button type="button" style="border: 1px solid black; margin-left:20px; width: 100px; height: 35px;"onclick="sample6_execDaumPostcode()">우편번호검색</button>
							
						</div>
						<div style="margin-top: 10px; margin-bottom: 10px;">
							<input type="text" id="address1" name="address1" style="border: 2px solid RGB(220,220,220); margin-left:50px; width: 400px; height: 35px;"readonly="readonly" value="<%=address1%>">
							<input type="text" id="address2" name="address2" style="border: 2px solid RGB(220,220,220); margin-left:20px; width: 300px; height: 35px;" value="<%=address2%>">
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
			</table>
			<br><br><br>	
			
			<br><br>
			<h3>결제정보</h3>
			<br>
			<table class="cart" id="cartTable">
				<tr>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>

				<tr>
					<td colspan="1" height="60px" style="font-size: 15px; background: RGB(250,250,250);">결제 수단</td>
					
					<td height="20px;" colspan="4"  align="left">
						<input type="radio" name="pay" value="card" checked="checked" style="border: 2px solid RGB(220,220,220); margin-left:50px; width: 80px; height: 20px;">카드결제
						<input type="radio" name="pay" value="account" style="border: 2px solid RGB(220,220,220); margin-left:50px; width: 80px; height: 20px;">계좌이체
						<input type="radio" name="pay" value="virtual" style="border: 2px solid RGB(220,220,220); margin-left:50px; width: 80px; height: 20px;">가상계좌
						
					</td>
				</tr>	
			</table>
		</div>
	
	
		<br><br><br>
		<div id="orderBtn">
			<button type="submit" class="order" id="payment" onclick="requestPay()">결제하기</button>
		</div>	
		
		<div id="message" style="font-size: 15px; color: red; font-weight: bold;"></div>
	</div>
</form>	

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-x.y.z.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>
<script type="text/javascript">
document.getElementById("toCartBtn").onclick = function() {
	location.href = "<%=request.getContextPath()%>/home.jsp?workgroup=order&work=cart";
	return;
}

$("#letteringNo").click(function() {
	$("#letters").val("");
	$("#letters").attr("disabled", true);
});

$("#letteringYes").click(function() {
	$("#letters").removeAttr("disabled");
});



$("#order").submit(function() {
	if(confirm("결제 하시겠습니까?")) {
		alert("결제 되었습니다.");
		location.href = "<%=request.getContextPath()%>/home.jsp?workgroup=order&work=order_add_action";
	}
});


// function requestPay() {
// 	var IMP = window.IMP; // 생략가능
// 	IMP.init('imp19968408'); // 가맹점 식별 코드
// 	IMP.request_pay({ // param
//         pg: "html5_inicis",
//         pay_method: "card",
//         merchant_uid: "ORD20180131-0000011",
//         name: "노르웨이 회전 의자",
//         amount: 64900,
//         buyer_email: "gildong@gmail.com",
//         buyer_name: "홍길동",
//         buyer_tel: "010-4242-4242",
//         buyer_addr: "서울특별시 강남구 신사동",
//         buyer_postcode: "01181"
//     }, function (rsp) { // callback
//         if (rsp.success) {
//             ...,
//             // 결제 성공 시 로직,
//             ...
//         } else {
//             ...,
//             // 결제 실패 시 로직,
//             ...
//         }
//     });
// }



</script>