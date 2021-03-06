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
	<h2>상품변경</h2>
	
	<%-- 파일을 입력받아 전달하기 위해 form 태그의 method 속성값을 [post]로 설정하고 
	enctype 속성값을 [multipart/form-data]로 설정 --%>
	<form action="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=product_modify_action&pageNum=<%=pageNum %>"
		method="post" enctype="multipart/form-data" id="productForm">
		<input type="hidden" name="pNo" value="<%=product.getpNo()%>">
		<%-- 제품이미지를 변경하지 않을 경우 기존 제품이미지를 사용하기 위해 전달하거나
		제품이미지를 변경할 경우 기존 제품이미지 파일을 삭제하기 위해 전달 --%>
		<input type="hidden" name="currentpImage" value="<%=product.getpImage()%>">
		<table>
			<tr>
				<td>상품번호</td>
				<td>
					<input type="text" name="pNo" id="pNo" maxlength="20" value="<%=product.getpNo()%>" readonly>
				</td>
			</tr>
			<tr>
				<td>상품이름</td>
				<td>
					<input type="text" name="pName" id="pName" maxlength="20" value="<%=product.getpName()%>">
				</td>
			</tr>
			<tr>
				<td>상품가격</td>
				<td>
					<input type="text" name="pPrice" id="pPrice" maxlength="20" value="<%=product.getpPrice()%>">
				</td>
			</tr>
			<tr>
				<td>이미지</td>
				<td>
					<img src="<%=request.getContextPath()%>/images/cake_<%=product.getpNo()%>.jpg" width="500">
					<br>
					<span style="color: red;">이미지를 변경하지 않을 경우 입력하지 마세요.</span>
					<br>
					<input type="file" name="pImage" id="pImage">
				</td>
			</tr>
			
			<tr>
				<td colspan="2"><button type="submit">상품변경</button></td>
			</tr>
		</table>	
	</form>
	
	<div id="message" style="color: red;"></div>
</div>

<script type="text/javascript">
$("#productForm").submit(function() {
	if($("#pName").val()=="") {
		$("#message").text("상품이름을 입력해 주세요.");
		$("#pName").focus();
		return false;
	}
	
	if($("#pPrice").val()=="") {
		$("#message").text("상품가격을 입력해 주세요.");
		$("#pPrice").focus();
		return false;
	}
	
});

</script>