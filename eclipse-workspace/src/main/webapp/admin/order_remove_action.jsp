<%@page import="dao.OrdersDAO"%>
<%@page import="dto.OrdersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 로그인 상태의 관리자만 접근 가능 --%>
<%@include file="/security/admin_check.jspf"%>

<%
	
	//전달값을 반환받아 저장
	int oNo=Integer.parseInt(request.getParameter("oNo"));
	String pageNum=request.getParameter("pageNum");
	
	//주문정보를 전달받아 ORDERS 테이블에 저장된 해당 주문번호의 주문정보를 검색하여 
	//반환하는 DAO 클래스의 메소드 호출
	OrdersDTO order=OrdersDAO.getDAO().selectOrderNoRow(oNo);
	
	//주문번호를 전달받아 ORDERS 테이블에 저장된 해당 주문번호의 주문상태를 0(주문취소)로 변경하는 DAO 클래스의 메소드 호출
	OrdersDAO.getDAO().updateOrderState(oNo);
	
	//제품목록 출력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=admin&work=orders';");
	out.println("</script>");	
%>