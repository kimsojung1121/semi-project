<%@page import="dao.OrdersDAO"%>
<%@page import="dto.OrdersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%-- 로그인 상태의 관리자만 접근 가능 --%>
<%@include file="/security/admin_check.jspf"%>

<%
	/*
	//비정상적이 요청에 대한 처리
	if(request.getParameter("oNo")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;		
	}
	*/
	
	//전달값을 반환받아 저장
	int oNo=Integer.parseInt(request.getParameter("oNo"));
	String id=request.getParameter("id");
	int pNo=Integer.parseInt(request.getParameter("pNo"));
	String cLettering=request.getParameter("cLettering");
	String zipcode=request.getParameter("zipcode");
	String address1=request.getParameter("address1");
	String address2=request.getParameter("address2");
	String oDate=request.getParameter("oDate");
	int oState=Integer.parseInt(request.getParameter("oState"));
	
	//DTO 인스턴스 생성 및 전달값으로 필드값 변경
	OrdersDTO order=new OrdersDTO();
	order.setoNo(oNo);
	order.setId(id);
	order.setId(id);
	order.setcLettering(cLettering);
	order.setoZipcode(zipcode);
	order.setoAddress1(address1);
	order.setoAddress2(address2);
	order.setoDate(oDate);
	order.setoState(oState);
	
	
	//주문정보를 전달받아 ORDERS 테이블에 저장된 주문정보를 변경하는 DAO 클래스의 메소드 호출
	OrdersDAO.getDAO().updateOrder(order);
	
	//제품정보 상세 출력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=admin&work=order_detail&oNo="+oNo+"';");
	out.println("</script>");	
%>
