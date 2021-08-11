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
//List<OrdersDTO> orderList = OrdersDAO.getDAO().selectAllOrders(loginUsers.getId());
	//if(orderList.size()==0)
	//	System.out.println("orderList가 없습니다.");
	
	//페이징 처리
    //pageNum : 페이지번호 [1][2][3]..
    int pageNum=1; 
    if(request.getParameter("pageNum")!=null) { //전달값이 있는 경우 해당 페이지 이동
 	                                           //전달값 없을 시 첫페이지로 이동
 	   pageNum=Integer.parseInt(request.getParameter("pageNum"));
    }
  
	//if(request.getParameter("orderSeq")==null) {
	//	orderSeq = 0;	
	//} else {
	//	orderSeq = pageNum-1;	
	//}
	//System.out.println(orderSeq);
	
    //pageSize : 페이지당 개시물 갯수 - 10개
    int pageSize=10; 
    
    //전체 게시글
    int totalOrders=OrdersDAO.getDAO().totalOrders(loginUsers.getId());//검색기능 포함

  
    //1페이지 시작으로 ~ 끝 즉, 전체 게시물 페이지
    int totalPage=(int)Math.ceil((double)totalOrders/pageSize);
  
    //[검증] 없는 페이지를 요청할 경우에 대한 방지
    if(pageNum<=0||pageNum>totalPage) {
   		pageNum=1; 
    }
    
    //게시글 시작행
    int startRow=(pageNum-1)*pageSize+1;
    //게시글 마지막행
    int endRow=pageNum*pageSize;
    //마지막 페이지에 게시물이 10개 이하일 경우 갯수에 해당하는 만큼 출력(비교)
    if(endRow>totalOrders) {
 		endRow=totalOrders;
    }
  
    //시작행 ~ 종료행 사이의 모든 게시물 출력
	List<OrdersDTO> orderList=OrdersDAO.getDAO().selectOrder_list(loginUsers.getId(), startRow, endRow);
	
    //최신순 게시물을 상위에 노출하기위한 것(게시글 순서에 글번호 계산하여 저장) - 글번호 기준 식별자
    int number=totalOrders-(pageNum-1)*pageSize; // number → 전역변수
  
 	//5페이지 단위 >> [1][2][3][4][5]
 	int blockSize = 5;

	//페이지 블럭 시작 페이지(즉, 1페이지 부터 보이기)
	int startPage = (pageNum - 1) / blockSize * blockSize + 1;

	//페이지 블럭 종료 페이지(즉, 페이지당 끝은 5, 10, 15 - 5단위)
	int endPage = startPage + blockSize - 1;

	//마지막 페이지 블럭 종료시 페이지 번호 맞춰서 종료
	//ex) [60][61] <<이렇게 끝날 수도 있음
	if (endPage > totalPage) {
		endPage = totalPage;
	}
	
	orderSeq = startRow;
%>

<link type="text/css" rel="stylesheet" href="css/cartnOrder.css"/>
<link type="text/css" rel="stylesheet" href="css/mypage_orders.css"/>

<div id="container">
	<div id="contents">
		<div class="sub_content">
			<div class="join_base_wrap">
				
				<jsp:include page="home.jsp"/>
			
				<br><br>
				<div class="cart">
					<h2 align="center">주문 정보</h2>
				</div>
				<br><br>
				
				<div class="cart">
					<% if(orderList==null) {%>
						<table id="cartTable">
							<tr height="30px" style="background: RGB(254,199,158);">
								<th class="colName">구분</th>
								<th class="colName">주문일자</th>
								<th class="colName">결제 금액</th>
								<th class="colName">케이크 & 레터링</th>
								<th class="colName">배송 상태</th>
							</tr>
							
							<tr>
								<td colspan="5">주문내역이 없습니다.</td>
							</tr>
						
						</table>
					<% } else {%>	
						<% for(OrdersDTO order : orderList) { %>
							<%
							ProductsDTO product = ProductsDAO.getDAO().selectProductsInfo(order.getpNo());
							int state = order.getoState();			
							%>
			
							<br><br>
							
							<table id="cartTable" style="width: 1500px;">
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
								<table id="cartTable" style="width: 1500px;">
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
									
									<% //System.out.println(order.getoNo()); %>
								</tr>
								
								<tr>
									<td colspan="1" class="orderList">주문자 ID</td>
									<td class="orderListVal" colspan="4"><span class="orderValue"><%=loginUsers.getId()%></span></td>
									<% //System.out.println(loginUsers.getId()); %>
								</tr>
								
								<tr>
									<td colspan="1" class="orderList">주문 상품</td>
									
									<td class="orderListVal" colspan="4"><span class="orderValue"><%=product.getpName()%></span></td>
									<% //System.out.println(product.getpName()); %>
								</tr>
								
								<tr>
									<td colspan="1" class="orderList">결제 금액</td>
									
									<td class="orderListVal" colspan="4"><span class="orderValue"><%=DecimalFormat.getInstance().format(product.getpPrice())%>원</span></td>
									<% //System.out.println(product.getpName()); %>
								</tr>
								
								<tr>
									<td class="orderList" colspan="1">레터링</td>
									<td class="orderListVal" colspan="4"><span class="orderValue"><%=order.getcLettering()%></span></td>
									<% //System.out.println(order.getoLettering()); %>
								</tr>
								
								<tr>
									<td class="orderList" colspan="1">배송지</td>
									<td class="orderListVal" colspan="4"><span class="orderValue">
									[<%=order.getoZipcode()%>]&nbsp;<%=order.getoAddress1()%>&nbsp;&nbsp;<%=order.getoAddress2() %></span>
									<% //System.out.println(order.getoAddress2()); %>
									</td>
								</tr>
								
								<tr>
									<td class="orderList" colspan="1">주문일자</td>
									<td class="orderListVal" colspan="4"><span class="orderValue"><%=order.getoDate()%></span></td>
									<% //System.out.println(order.getoDate()); %>
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
					<% } %>
				</div>
			</div>
		<!-- //member_cont -->
		</div>
	<!-- //join_base_wrap -->
	</div>
<!-- //content_box -->
</div>


<div class="cart" id="cartTable" align="center">
	<% if(totalPage>5) { %>
		<% //[처음][이전]...[다음][마지막] + 검색기능(식별자 : 작성자 / 제목 / 내용 포함)
	 	 if(startPage>blockSize) { %>
			<a href="<%=request.getContextPath()%>/home.jsp?workgroup=mypage&work=mypage_orders&pageNum=1&"><span class="pageMove">&lt;&lt;처음</span></a>
			<a href="<%=request.getContextPath()%>/home.jsp?workgroup=mypage&work=mypage_orders&pageNum=<%=startPage-blockSize%>"><span class="pageMove">&lt;이전</span></a>
		<% } else { %>
			<span class="pageMove">&lt;&lt;처음</span>
			<span class="pageMove">&lt;이전 </span>
		<% } %>
	<% } %>
	
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) { %>
			<a href="<%=request.getContextPath()%>/home.jsp?workgroup=mypage&work=mypage_orders&pageNum=<%=i%>">
				<span class="pageNumber"><%=i %></span>
			</a>
		<% } else { %>
			<span class="pageNumber" id="nowPage"><%=i %></span>
		<% } %>
	<% } %>
	
	<% if(totalPage>5) { %>
		<% if(endPage!=totalPage) { %>
			<a href="<%=request.getContextPath()%>/home.jsp?workgroup=mypage&work=mypage_orders&pageNum=<%=startPage+blockSize%>"><span class="pageMove">다음&gt;</span></a>
			<a href="<%=request.getContextPath()%>/home.jsp?workgroup=mypage&work=mypage_orders&pageNum=<%=totalPage%>"><span class="pageMove">마지막&gt;&gt;</span></a>
		<% } else { %>
			<span class="pageMove">다음&gt;</span>
			<span class="pageMove">마지막&gt;&gt;</span>
		<% } %>
	<% } %>
</div>


<script type="text/javascript">

function shownHideDetail(value) {
	
	//$(".details").each(function() {
	//	$(this).toggle();
	//});
	
	$("."+value+"").toggle();
	
	//$("#details").toggle();
// 	var shownHide = document.getElementById("details"+num);
// 	if(shownHide.style.display=="none") {
// 		shownHide.style.display="";
// 	} else {
// 		shownHide.style.display=="none";
// 	}
}
</script>
