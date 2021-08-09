
<%@page import="dao.QnaDAO"%>
<%@page import="dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
                      <%-- ■■■■■■게시글 삭제 처리 페이지■■■■■■ --%>
<%-- => 비로그인 사용자이거나 게시글 작성자 또는 관리자가 아닌 경우 에러페이지 이동 --%>
<%@include file="/security/login_check.jspf" %>
<%
	//비정상적이 요청에 대한 처리
	if(request.getParameter("q_no")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;		
	}

	//전달값을 반환받아 저장
	int q_no=Integer.parseInt(request.getParameter("q_no"));
	
	//글번호를 전달받아 Q&A 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	QnaDTO qna=QnaDAO.getDAO().selectQna_No(q_no);
	
	//검색된 게시글이 없거나 검색된 게시글이 삭제글인 경우 - 비정상적인 요청
	if(qna==null || qna.getQ_state()==9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}
	
	//글번호를 전달받아 Q&A 테이블에 저장된 해당 글번호의 게시글을 삭제 처리하는 DAO 클래스의 메소드 호출
	QnaDAO.getDAO().deleteQna_Ans(q_no);
	
	//게시글 목록 출력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=qna&work=qna_list'");
	out.println("</script>");
%>    
