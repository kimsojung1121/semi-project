<%@page import="dao.ReviewDAO"%>
<%@page import="dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- => 비로그인 사용자이거나 게시글 작성자 또는 관리자가 아닌 경우 에러페이지 이동 --%>
<%@include file="/security/login_check.jspf" %>
<%
	//비정상적이 요청에 대한 처리
	if(request.getParameter("r_no")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;		
	}

	//전달값을 반환받아 저장
	int r_no=Integer.parseInt(request.getParameter("r_no"));
	
	//글번호를 전달받아 Review 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	ReviewDTO review=ReviewDAO.getDAO().selectReview_No(r_no);
	
	//검색된 게시글이 없거나 검색된 게시글이 삭제글인 경우 - 비정상적인 요청
	if(review==null || review.getR_state()==9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}
	
	//글번호를 전달받아 Review 테이블에 저장된 해당 글번호의 게시글을 삭제 처리하는 DAO 클래스의 메소드 호출
	ReviewDAO.getDAO().deleteReview_Ans(r_no);
	
	//게시글 목록 출력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=review&work=review_list'");
	out.println("</script>");
%>    
