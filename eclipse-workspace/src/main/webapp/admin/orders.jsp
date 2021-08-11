<%@page import="dao.OrdersDAO"%>
<%@page import="dto.OrdersDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 로그인 상태의 관리자만 접근 가능 --%>
<%@include file="/security/admin_check.jspf"%>

<%-- 검색 기능 --%>
<%
	String searchUser=request.getParameter("searchUser");
	if(searchUser==null) {
		searchUser="";
	}
	
	String searchProduct=request.getParameter("searchProduct");
	if(searchProduct==null) {
		searchProduct="";
	}
	
	//페이징 기능
	int pageNum=1; //페이지 번호 1로 초기화
    if(request.getParameter("pageNum")!=null) { //전달값이 있는 경우
 	   pageNum=Integer.parseInt(request.getParameter("pageNum"));
    }
    
	//pageSize : 페이지당 개시물 갯수 - 20개
    int pageSize=20; 
	
	//행의 개수를 구하는 DAO 메소드 호출
    int totalOrder=OrdersDAO.getDAO().totalOrderCount(searchUser, searchProduct);
	
	//전체 페이지
    int totalPage=(int)Math.ceil((double)totalOrder/pageSize);
	
	//pageNum이 0보다 작거나 전체 페이지보다 큰 경우 1페이지로 이동
    if(pageNum<=0||pageNum>totalPage) {
   		pageNum=1; 
    }
	
	//시작행
	int startRow=(pageNum-1)*pageSize+1;
	//끝행
    int endRow=pageNum*pageSize;

    if(endRow>totalOrder) {
 		endRow=totalOrder;
    }
    
    //시작행부터 끝행까지의 회원 정보를 검색하여 반환하는 DAO 메소드 호출
	List<OrdersDTO> orderList=OrdersDAO.getDAO().selectOrderList(searchUser, searchProduct, startRow, endRow);
    
	//페이지에 출력될 게시글에 대한 글번호 시작값을 계산하여 저장
    int number=totalOrder-(pageNum-1)*pageSize;
  
 	int blockSize = 5;

	int startPage = (pageNum - 1) / blockSize * blockSize + 1;
	int endPage = startPage + blockSize - 1;

	if (endPage > totalPage) {
		endPage = totalPage;
	}

%>

<%-- CSS --%>
<link type="text/css" rel="stylesheet" href="css/admin.css"/>

<%-- 주문 정보 검색 기능 --%>
<div class="search_user">
	<%-- 회원ID 검색 --%>
	<form action="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=orders" method="post" style="display: inline-block;">
		<input type="text" placeholder="회원 ID" onfocus="this.placeholder=''" onblur="this.placeholder='회원 ID'" 
		name="searchUser">
		<%-- <button type="button" id="searchIdBtn">검색</button> --%>
		<button type="submit">검색</button>
	</form>
	<%-- 제품번호 검색 --%>
	<form action="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=orders" method="post" style="display: inline-block;">
		<input type="text" placeholder="제품 번호" onfocus="this.placeholder=''" onblur="this.placeholder='제품 번호'" 
		name="searchProduct">
		<%-- <button type="button" id="searchNameBtn">검색</button> --%>
		<button type="submit">검색</button>
	</form>
	<!-- 메세지 출력 -->
	<div id="searchMsg" style="display: inline-block; color:red;"></div>
</div>

<div class="baseContent">
<table class="user_table">
	<tr>
		<th>주문번호</th>
		<th>회원ID</th>
		<th>상품번호</th>
		<th>레터링문구</th>
		<th>주소</th>
		<th>주문날짜</th>
		<th>배송상태</th>
	</tr>
	<% if(orderList.isEmpty()) { %>
		<tr>
			<td colspan="7">주문이 없습니다.</td>
		</tr>
	<% } else { %>
		<% for(OrdersDTO order:orderList) { %>
		<tr onclick="location.href='<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=order_detail&oNo=<%=order.getoNo() %>&pageNum=<%=pageNum %>'" class="productList">
			<td>
				<%=order.getoNo() %>
			</td>
			<td>
				<%=order.getId() %>
			</td>
			<td>
				<%=order.getpNo() %>
			</td>
			<td>				
				<%=order.getcLettering() %>
			</td>
			<td>
				[<%=order.getoZipcode() %>]<%=order.getoAddress1() %> <%=order.getoAddress2() %>
			</td>
			<td>
				<%=order.getoDate() %>
			</td>
			<td>
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
		<% } %>
	<% } %>
</table>
</div>
<!-- 페이징 -->
<div class="page" align="center">
	
	<% for(int i=startPage;i<=endPage;i++) { %>
			<a href="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=orders&pageNum=<%=i%>&searchUser=<%=searchUser%>&searchProduct=<%=searchProduct%>">
				<span><%=i %></span>
			</a>
	<% } %>

</div>