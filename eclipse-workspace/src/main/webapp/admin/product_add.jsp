<%@page import="dto.ProductsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 로그인 상태의 관리자만 접근 가능 --%>
<%@include file="/security/admin_check.jspf"%>

<%
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}

	
	ProductsDTO product=(ProductsDTO)session.getAttribute("product");
	if(product!=null) {
		session.removeAttribute("product");
	}
%>
<%-- CSS --%>
<link type="text/css" rel="stylesheet" href="css/admin.css"/>

<div class="baseContent">
	<h2>제품등록</h2>
	
	<%-- 파일을 입력받아 전달하기 위해 form 태그의 method 속성값을 [post]로 설정하고 
	enctype 속성값을 [multipart/form-data]로 설정 --%>
	<form action="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=product_add_action"
		method="post" enctype="multipart/form-data" id="productForm">
		<table>
			<tr>
				<td>상품번호</td>
				<td>
					<input type="text" name="pNo" id="pNo" maxlength="20" 
					<% if(product!=null) { %>value="<%=product.getpNo()%>" <% } %> 
					>
				</td>
			</tr>
			<tr>
				<td>상품이름</td>
				<td>
					<input type="text" name="pName" id="pName" maxlength="20" <% if(product!=null) { %>value="<%=product.getpName()%>" <% } %>>
				</td>
			</tr>
			<tr>
				<td>상품가격</td>
				<td>
					<input type="text" name="pPrice" id="pPrice" <% if(product!=null) { %>value="<%=product.getpPrice()%>" <% } %>>
				</td>
			</tr>
			<tr>
				<td>상품이미지</td>
				<td>
					<input type="file" name="pImage" id="pImage">
				</td>
			</tr>
			
			<tr>
				<td colspan="2"><button type="submit">상품등록</button></td>
			</tr>
		</table>	
			<div id="message1" style="color: red;"><%=message %></div>
	</form>
	
	
</div>

<script type="text/javascript">

$("#productForm").submit(function() {
	if($("#pNo").val()=="") {
		$("#message1").text("상품번호를 입력해 주세요.");
		$("#pNo").focus();
		return false;
	}
	
	if($("#pName").val()=="") {
		$("#message1").text("상품이름을 입력해 주세요.");
		$("#pName").focus();
		return false;
	}
	
	if($("#상품가격").val()=="") {
		$("#message1").text("상품가격 입력해 주세요.");
		$("#상품가격").focus();
		return false;
	}
	
	if($("#pImage").val()=="") {
		$("#message1").text("상품이미지를 입력해 주세요.");
		$("#pImage").focus();
		return false;
	}
	
});

</script>