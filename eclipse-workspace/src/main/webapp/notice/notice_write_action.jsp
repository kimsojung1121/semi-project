<%@page import="dao.NoticeDAO"%>
<%@page import="dto.NoticeDTO"%>
<%@page import="Utility.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
                      <%--■■■■■■글 변경, 수정 처리페이지■■■■■■ --%>
                      
<%-- => 비로그인 사용자이거나 게시글 작성자 또는 관리자가 아닌 경우 JSP 문서 요청시 에러페이지 이동 --%>
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
	String pageNum=request.getParameter("pageNum");
	//System.out.println(pageNum);
	String n_title=Utility.escapeTag(request.getParameter("n_title"));
	//System.out.println(n_title);
	int n_state=0;//전달값이 없는 경우 : 일반글 - 0(초기값)
	String n_content=Utility.escapeTag(request.getParameter("n_content"));
	//System.out.println(n_content);
	

	int n_seq=NoticeDAO.getDAO().selectNextNotice();
	
	//DTO 인스턴스를 생성하고 필드값 변경
	NoticeDTO notice=new NoticeDTO();
	notice.setN_title(n_title);
	notice.setN_content(n_content);
	notice.setN_state(n_state);
	notice.setN_no(n_seq);
	
	
	//공지글을 전달받아 공지사항(NOTICE) 테이블에 저장된 게시글을 변경하는 DAO 클래스의 메소드 호출
	NoticeDAO.getDAO().insertNotice(notice);
	
	//공지글 상세 출력페이지 이동 - 페이지 번호와 검색 관련 정보 전달
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=notice&work=notice_list&pageNum="+pageNum+"';");
	out.println("</script>");
%> 
