<%@page import="java.io.File"%>
<%@page import="dao.ProductsDAO"%>
<%@page import="dto.ProductsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 로그인 상태의 관리자만 접근 가능 --%>
<%@include file="/security/admin_check.jspf"%>

<%
	
	//전달값을 반환받아 저장
	int pNo=Integer.parseInt(request.getParameter("pNo"));
	
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품번호의 제품정보를 검색하여 
	//반환하는 DAO 클래스의 메소드 호출
	ProductsDTO product=ProductsDAO.getDAO().selectProductsInfo(pNo);
	
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품번호의 제품정보를 삭제하는 DAO 클래스의 메소드 호출
	ProductsDAO.getDAO().deleteProduct(pNo);
	
	//삭제 처리된 제품에 대한 이미지 파일 삭제
	String saveDirectory=request.getServletContext().getRealPath("/product_image");
	new File(saveDirectory,product.getpImage()).delete();
	
	//제품목록 출력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=admin&work=products';");
	out.println("</script>");	
%>