<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.ProductsDAO"%>
<%@page import="dto.ProductsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 로그인 상태의 관리자만 접근 가능 --%>
<%@include file="/security/admin_check.jspf"%>

<%
	//비정상적이 요청에 대한 처리
	if(request.getParameter("pNo")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장
	int pNo=Integer.parseInt(request.getParameter("pNo"));
	String pageNum=request.getParameter("pageNum");

	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품번호의 제품정보를 검색하여 
	//반환하는 DAO 클래스의 메소드 호출
	ProductsDTO product=ProductsDAO.getDAO().selectProductsInfo(pNo);
%>

<%-- CSS --%>
<link type="text/css" rel="stylesheet" href="css/admin.css"/>

<div class="baseContent">
	<h2>제품상세정보</h2>
	<div id="productForm">
	<table>
		<tr>
			<td class="title">상품번호</td>
			<td class="value"><%=product.getpNo() %></td>
		</tr>
		<tr>
			<td class="title">상품이름</td>
			<td class="value"><%=product.getpName() %></td>
		</tr>
		<tr>
			<td class="title">상품가격</td>
			<td class="value"><%=DecimalFormat.getCurrencyInstance().format(product.getpPrice()) %></td>
		</tr>
		<tr>
			<td class="title">이미지</td>
			<td class="value">
				<img src="<%=request.getContextPath()%>/product_image/<%=product.getpNo()%>.jpg" width="500">
			</td>
		</tr>
		
	</table>
	</div>
	<div style="padding-bottom: 50px;">
	<button type="button" class="removeBtn" id="removeProductBtn">상품정보 삭제</button>
	<button type="button" class="modifyBtn" id="modifyProductBtn">상품정보 변경</button>
	<button type="button" class="modifyBtn" id="listBtn" style="background-color:#dcdcdc;">목록으로</button>
	</div>
</div>

<script type="text/javascript">
$("#modifyProductBtn").click(function() {
	location.href="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=product_modify&pNo=<%=product.getpNo() %>&pageNum=<%=pageNum %>";
});

$("#removeProductBtn").click(function() {
	if(window.confirm("제품정보를 삭제 하겠습니까?")) {
		location.href="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=product_remove_action&pNo=<%=product.getpNo() %>";
	}
});

$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=products&pageNum=<%=pageNum %>";
});
</script>