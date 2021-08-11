<%@page import="dao.ProductsDAO"%>
<%@page import="dto.ProductsDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 로그인 상태의 관리자만 접근 가능 --%>
<%@include file="/security/admin_check.jspf"%>

<%
	//페이징 기능
	int pageNum=1; //페이지 번호 1로 초기화
  	if(request.getParameter("pageNum")!=null) { //전달값이 있는 경우
	   	pageNum=Integer.parseInt(request.getParameter("pageNum"));
  	}
  
	//pageSize : 페이지당 개시물 개수 - 5개
  	int pageSize=5; 
	
	//행의 개수를 구하는 DAO 메소드 호출
  	int totalProduct=ProductsDAO.getDAO().totalProductCount();
	
	//전체 페이지
  	int totalPage=(int)Math.ceil((double)totalProduct/pageSize);
	
	//pageNum이 0보다 작거나 전체 페이지보다 큰 경우 1페이지로 이동
  	if(pageNum<=0||pageNum>totalPage) {
 		pageNum=1; 
  	}
	
	//시작행
	int startRow=(pageNum-1)*pageSize+1;
	//끝행
  	int endRow=pageNum*pageSize;

 	if(endRow>totalProduct) {
		endRow=totalProduct;
  	}
  
  	//시작행부터 끝행까지의 제품 정보를 검색하여 반환하는 DAO 메소드 호출
	List<ProductsDTO> productList=ProductsDAO.getDAO().selectProductList(startRow, endRow); 
  
	//페이지에 출력될 게시글에 대한 글번호 시작값을 계산하여 저장
  	int number=totalProduct-(pageNum-1)*pageSize;

	int blockSize = 5;

	int startPage = (pageNum - 1) / blockSize * blockSize + 1;
	int endPage = startPage + blockSize - 1;

	if (endPage > totalPage) {
		endPage = totalPage;
	}
%>

<%-- CSS --%>
<link type="text/css" rel="stylesheet" href="css/admin.css"/>

<div class="baseContent">
<table class="user_table">
	<tr>
		<th>상품번호</th>
		<th>상품이름</th>
		<th>상품가격</th>
		<th>이미지</th>
	</tr>
	<% if(productList.isEmpty()) { %>
		<tr>
			<td colspan="4">등록된 제품이 없습니다.</td>
		</tr>
	<% } else { %>
		<% for(ProductsDTO product:productList) { %>
		<tr onclick="location.href='<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=product_detail&pNo=<%=product.getpNo() %>&pageNum=<%=pageNum %>'" class="productList">
			<td>
				<%=product.getpNo() %>
			</td>
			<td>
				<%=product.getpName() %>
			</td>
			<td>
				<%=product.getpPrice() %>
			</td>
			<td>
				<img src="<%=request.getContextPath()%>/product_image/<%=product.getpNo()%>.jpg" width="100">
			</td>
		</tr>
		<% } %>
	<% } %>
</table>
<button type="button" class="btn" id="addProductBtn">상품 추가</button>
</div>

<!-- 페이징 -->
<div class="page" align="center">
	
	<% for(int i=startPage;i<=endPage;i++) { %>
			<a href="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=products&pageNum=<%=i%>">
				<span><%=i %></span>
			</a>
	<% } %>

</div>

<script type="text/javascript">
	$("#addProductBtn").click(function() {
		location.href="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=product_add";
	});
	
</script>