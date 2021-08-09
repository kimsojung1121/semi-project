<%@page import="dao.UsersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 로그인 상태의 관리자만 접근 가능 --%>
<%@include file="/security/admin_check.jspf"%>

<%
	//비정상적인 요청에 대한 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"home.jsp?workgroup=error&work=error400';");
		out.println("</script>");
		return;
	}

	//체크박스에 의해 선택되어 전달된 값들을 반환받아 저장 
	// => 하나의 이름으로 여러 개의 값이 전달되므로 getParameterValues() 메소드 호출  
	String[] checkId=request.getParameterValues("checkId");
	
	//배열에 저장된 요소값(아이디)를 반복적으로 제공받아 삭제 처리
	for(String id:checkId) {
		//아이디를 전달받아 USERS 테이블에 저장된 해당 아이디의 회원상태를 탈퇴회원으로 변경하는 DAO 클래스의 메소드 호출
		UsersDAO.getDAO().updateUsersStatus(id);
	}
	
	//회원목록 출력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"home.jsp?workgroup=admin&work=users';");
	out.println("</script>");
%>