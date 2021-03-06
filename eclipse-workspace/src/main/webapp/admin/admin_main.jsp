<%@page import="dto.OrdersDTO"%>
<%@page import="dao.OrdersDAO"%>
<%@page import="dao.ProductsDAO"%>
<%@page import="dto.ProductsDTO"%>
<%@page import="dao.UsersDAO"%>
<%@page import="dto.UsersDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 로그인 상태의 관리자만 접근 가능 --%>
<%@include file="/security/admin_check.jspf"%>

<%
	int countUser=UsersDAO.getDAO().selectTodayUserCount();
	List<UsersDTO> userList=UsersDAO.getDAO().selectTodayUsers();
	
	int totalProduct=ProductsDAO.getDAO().totalProductCount();
	List<ProductsDTO> productList=ProductsDAO.getDAO().selectAllProducts();
	
	int countOrder=OrdersDAO.getDAO().selectTodayOrderCount();
	List<OrdersDTO> orderList=OrdersDAO.getDAO().selectTodayOrderList();
%>

<%-- CSS --%>
<link type="text/css" rel="stylesheet" href="css/admin.css"/>


<%-- 주문 관리 --%>
<div class="baseContent">
	<div class="summary">
		<h3 class="summary_h">주문 관리</h3>
		<p class="summary_p">오늘 들어온 주문 : <span style="color:red;"><%=countOrder %></span> 건</p>
		<a href="home.jsp?workgroup=admin&work=orders">
			<button type="button">MORE ></button>
		</a>
	</div>
	<table class="user_table">
		<tr>
			<th>주문번호</th>
			<th>회원 ID</th>
			<th>상품번호</th>
			<th>레터링 문구</th>
			<th>주소지</th>
			<th>주문일</th>
			<th>배송상태</th>
		</tr>
		<% if(countOrder==0) { %>
		<tr>
		<td colspan="7">오늘 들어온 주문이 없습니다.</td>
		</tr>
		<% } else {%>
			<% for(OrdersDTO order:orderList) { %>
				<tr>
					<td><%=order.getoNo() %></td>
					<td><%=order.getId() %></td>
					<td><%=order.getpNo() %></td>
					<td><%=order.getcLettering() %></td>
					<td>[<%=order.getoZipcode() %>]<%=order.getoAddress1() %> <%=order.getoAddress2() %></td>
					<td><%=order.getoDate().substring(0,10) %></td>
					<% if(order.getoState()==1) { %>
						<td>주문확인</td>
					<% } else if(order.getoState()==2) { %>
						<td>배송준비</td>
					<% } else if(order.getoState()==3) { %>
						<td>배송중</td>
					<% } else if(order.getoState()==4) { %>
						<td>배송완료</td>
					<% } %>
				</tr>
			<% } %>
		<% } %>
	</table>
</div>


<%-- 회원 관리 --%>
<div class="baseContent">
	<div class="summary">
		<h3 class="summary_h">회원 관리</h3>
		<p class="summary_p">오늘 가입한 회원 : <span style="color:red;"><%=countUser %></span> 명</p>
		<a href="home.jsp?workgroup=admin&work=users">
			<button type="button">MORE ></button>
		</a>
	</div>
	<table class="user_table">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>이메일</th>
			<th>전화번호</th>
			<th>생년월일</th>
			<th>주소</th>
			<th>가입날짜</th>
			<th>상태</th>
		</tr>
		<% if(countUser==0) { %>
			<tr>
			<td colspan="8">오늘 가입한 회원이 없습니다.</td>
			</tr>
		<% } else { %>
			<% for(UsersDTO user:userList) { %>
				<tr>
					<td><%=user.getId() %></td>
					<td><%=user.getName() %></td>
					<td><%=user.getEmail() %></td>
					<td><%=user.getPhone() %></td>
					<td><%=user.getBirthday().substring(0, 10) %></td>
					<td>
						[<%=user.getZipcode() %>]<%=user.getAddress1() %> <%=user.getAddress2() %>
					</td>
					<td><%=user.getJoindate().substring(0,10) %></td>
					<td>
						<% if(user.getStatus()==0) { %> 
							탈퇴회원 
						<%} %>
						<% if(user.getStatus()==1) { %> 
							일반회원 
						<%} %>
						<% if(user.getStatus()==9) { %> 
							관리자 
						<%} %>
					</td>	
				</tr>
			<% } %>
		<% } %>
	</table>
</div>


<%-- 상품 관리 --%>
<div class="baseContent">
	<div class="summary">
		<h3 class="summary_h">상품 관리</h3>
		<p class="summary_p">총 상품 개수 : <span style="color:red;"><%=totalProduct %></span> 개</p>
		<a href="home.jsp?workgroup=admin&work=products">
			<button type="button">MORE ></button>
		</a>
	</div>
	<table class="user_table">
		<tr>
			<th>상품번호</th>
			<th>상품이름</th>
			<th>상품가격</th>
			<th>이미지</th>
		</tr>
		
		<% if(totalProduct==0) { %>
			<tr>
			<td colspan="4">등록된 상품이 없습니다.</td>
			</tr>
		<% } else { %>
			<% for(ProductsDTO product:productList) { %>
				<tr>
					<td><%=product.getpNo() %></td>
					<td><%=product.getpName() %></td>
					<td><%=product.getpPrice() %></td>
					<td><%=product.getpImage() %></td>
				</tr>
			<% } %>
		<% } %>
	</table>
</div>



<%-- [미구현] --%>
<%-- Q&A 관리 --%>
<%-- 
<div class="baseContent">
	<div class="summary">
		<h3 class="summary_h">QnA 관리</h3>
		<p class="summary_p">미답변 QnA : <span style="color:red;">0</span> 개</p>
		<a href="#">
			<button type="button">MORE ></button>
		</a>
	</div>
	<table class="user_table">
		<tr>
			<th>주문번호</th>
			<th>회원 ID</th>
			<th>상품번호</th>
			<th>레터링 여부</th>
			<th>레터링 문구</th>
			<th>주소</th>
			<th>수량</th>
			<th>주문일</th>
			<th>배송상태</th>
		</tr>
		<tr>
		<td colspan="9">등록된 QnA가 없습니다.</td>
		</tr>
	</table>
</div>
--%>

<%-- [미구현] --%>
<%-- 리뷰 관리 --%>
<%-- 
<div class="baseContent">
	<div class="summary">
		<h3 class="summary_h">리뷰 관리</h3>
		<a href="#">
			<button type="button">MORE ></button>
		</a>
	</div>
	<table class="user_table">
		<tr>
			<th>주문번호</th>
			<th>회원 ID</th>
			<th>상품번호</th>
			<th>레터링 여부</th>
			<th>레터링 문구</th>
			<th>주소</th>
			<th>수량</th>
			<th>주문일</th>
			<th>배송상태</th>
		</tr>
		<tr>
		<td colspan="9">등록된 리뷰가 없습니다.</td>
		</tr>
	</table>
</div>
--%>

<%-- [미구현] --%>
<%-- 공지사항 관리 --%>
<%-- 
<div class="baseContent">
	<div class="summary">
		<h3 class="summary_h">공지사항 관리</h3>
		<a href="#">
			<button type="button">MORE ></button>
		</a>
	</div>
	<table class="user_table">
		<tr>
			<th>주문번호</th>
			<th>회원 ID</th>
			<th>상품번호</th>
			<th>레터링 여부</th>
			<th>레터링 문구</th>
			<th>주소</th>
			<th>수량</th>
			<th>주문일</th>
			<th>배송상태</th>
		</tr>
		<tr>
		<td colspan="9">등록된 공지사항이 없습니다.</td>
		</tr>
	</table>
</div>
--%>