<%@page import="java.io.File"%>
<%@page import="dao.ProductsDAO"%>
<%@page import="dto.ProductsDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 로그인 상태의 관리자만 접근 가능 --%>
<%@include file="/security/admin_check.jspf"%>

<%
	//비정상적인 요청에 대한 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}

	//전달된 파일(제품이미지)을 저장하기 위한 서버 디렉토리의 시스템 경로를 반환받아 저장
	// => WorkSpace 디렉토리가 아닌 WebApps 디렉토리의 시스템 경로 반환
	String saveDirectory=request.getServletContext().getRealPath("/product_image");
	System.out.println("saveDirectory : "+saveDirectory);
	
	//cos 라이브러리의 MultipartRequest 클래스로 인스턴스 생성
	// => MultipartRequest 인스턴스를 생성하면 모든 전달파일을 서버 디렉토리에 자동으로 업로드 처리하여 저장
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	//전달값과 업로드 파일명을 반환받아 저장
	int pNo=Integer.parseInt(multipartRequest.getParameter("pNo"));	
	String pName=multipartRequest.getParameter("pName");
	int pPrice=Integer.parseInt(multipartRequest.getParameter("pPrice"));
	String pImage=multipartRequest.getFilesystemName("pImage");
	
	//DTO 인스턴스 생성 및 전달값으로 필드값 변경
	ProductsDTO product=new ProductsDTO();
	product.setpNo(pNo);
	product.setpName(pName);
	product.setpPrice(pPrice);
	product.setpImag(pImage);
	
	
	//제품정보를 전달받아 PRODUCTS 테이블에 제품정보를 삽입하여 저장하는 DAO 클래스의 메소드 호출
	ProductsDAO.getDAO().insertProduct(product);
	
	//제품목록 출력페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=admin&work=products';");
	out.println("</script>");
%>