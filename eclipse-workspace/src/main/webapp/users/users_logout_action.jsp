<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그아웃 처리 후 메인페이지로 이동 처리 페이지 --%>
<%
	//로그아웃 처리 : 세션에 저장된 권한 관련 정보 제거
	session.invalidate();
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=main&work=main';");
	out.println("</script>");
%>