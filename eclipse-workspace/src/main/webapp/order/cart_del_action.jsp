<%@page import="dao.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>    
<%
	int cNo = Integer.parseInt(request.getParameter("cNo"));
	CartDAO.getDAO().deleteCart(cNo);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=order&work=cart';");
	out.println("</script>");
%>

