<%@page import="dao.NoticeDAO"%>
<%@page import="dto.NoticeDTO"%>
<%@page import="Utility.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>      
<%
	//비정상적인 요청에 대한 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장
	int n_no=Integer.parseInt(request.getParameter("n_no"));
	String pageNum=request.getParameter("pageNum");
	String n_title=Utility.escapeTag(request.getParameter("n_title"));
	int n_state=0;//전달값이 없는 경우 : 일반글 - 0(초기값)
	String n_content=Utility.escapeTag(request.getParameter("n_content"));
	
	//DTO 인스턴스를 생성하고 필드값 변경
	NoticeDTO notice=new NoticeDTO();
	notice.setN_no(n_no);
	notice.setN_title(n_title);
	notice.setN_content(n_content);
	notice.setN_state(n_state);
	
	//공지사항 글을 전달받아 Notice 테이블에 저장된 게시글을 변경하는 DAO 클래스의 메소드 호출
	NoticeDAO.getDAO().ModifyNotice(notice);
	
	
	//공지사항 상세 출력페이지 이동 - 페이지 번호와 검색 관련 정보 전달
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()
		+"/home.jsp?workgroup=notice&work=notice_detail&n_no="+n_no
		+"&pageNum="+pageNum+"';");
	out.println("</script>");
%> 
