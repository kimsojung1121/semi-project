<%@page import="java.util.ArrayList"%>
<%@page import="dao.OrdersDAO"%>
<%@page import="dto.OrdersDTO"%>
<%@page import="dao.CartDAO"%>
<%@page import="dto.CartDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
 <%
 	String id = loginUsers.getId();
 	String zipcode = request.getParameter("zipcode");
 	String address1 = request.getParameter("address1");
 	String address2 = request.getParameter("address2");
 	
 	//System.out.println(id);
 	
 
 	List<CartDTO> cartList = CartDAO.getDAO().selectAllCart(id);

 	//System.out.println("selectAllCart");
 	List<OrdersDTO> orderList = new ArrayList<OrdersDTO>();
 	
 	for(CartDTO cart : cartList) {
		OrdersDTO order = new OrdersDTO();
		order.setId(id);
	 	//System.out.println(order.getId());
	 	
		order.setpNo(cart.getpNo());
	 	//System.out.println(order.getpNo());
	 	
		order.setcLettering(cart.getcLettering());
	 	//System.out.println(order.getoLettering());
	 	
		order.setoZipcode(zipcode);
	 	//System.out.println(order.getoZipcode());
	 	
		order.setoAddress1(address1);
	 	//System.out.println(order.getoAddress1());
	 	
		order.setoAddress2(address2);
	 	//System.out.println(order.getoAddress2());
	 	
		orderList.add(order);
	 	//System.out.println("add");
 	}
 	
 	
 	OrdersDAO.getDAO().insertOrders(orderList);
	 	//System.out.println("insertOrders");
 	CartDAO.getDAO().deleteUserCart(id);
	 	//System.out.println("deleteUserCart");
 	
 	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=order&work=order_detail';");
	out.println("</script>");
 	
 	//구글에 최
 
 %>
 