<%@page import="dao.CartDAO"%>
<%@page import="dto.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<% 

    String id = loginUsers.getId();
	int pNo=Integer.parseInt(request.getParameter("pNo"));
	String cLettering = request.getParameter("cLettering");
	

	CartDTO cart=new CartDTO();
	cart.setId(id);
	cart.setpNo(pNo);
	cart.setcLettering(cLettering);
	
	
	CartDAO.getDAO().insertCart(cart);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=order&work=cart'");
	out.println("</script>");
	


%>


