<%@page import="dao.UsersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="css/users_join_success.css"/>  
<%-- USERS 테이블에 저장된 로그인 사용자의 회원정보를 삭제하고 회원탈퇴 완료 페이지 출력 --%>
<%-- => 비로그인 사용자가 JSP 문서를 요청한 경우 비정상적인 요청으로 에러페이지 이동 --%>
<%@include file="/security/login_check.jspf" %> 
<%
	//비정상적인 요청에 대한 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}

	//아이디를 전달받아 USERS 테이블에 저장된 해당 아이디의 회원상태를 0(탈퇴)으로 변경하는 DAO 클래스의 메소드 호출
	UsersDAO.getDAO().updateUsersStatus(loginUsers.getId());
	
	//로그아웃 처리페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=users&work=users_logout_action'");
	out.println("</script>");
%>	
