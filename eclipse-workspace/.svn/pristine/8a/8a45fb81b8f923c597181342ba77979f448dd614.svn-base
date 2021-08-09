<%@page import="dto.QnaDTO"%>
<%@page import="dao.QnaDAO"%>
<%@page import="Utility.Utility"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
            <%-- ■■■■■■■■■글쓰기 처리페이지■■■■■■■--%>

        
<%@include file="/security/login_check.jspf" %>
<%-- ▶비로그인자가 접근시 에러페이지로 이동하게하는 것 --%>     
     
<%
	//1. 비정상적인 요청에 대한 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장 - 각각 초기값 0을 저장
	int ref=Integer.parseInt(request.getParameter("ref"));
	int re_Step=Integer.parseInt(request.getParameter("re_Step"));
	int re_Level=Integer.parseInt(request.getParameter("re_Level"));
	String pageNum=request.getParameter("pageNum");
	//전달값에서 태그 관련 기호를 회피(Escape)문자로 변환하여 저장 - XSS 공격에 대한 방법
	String subject=Utility.escapeTag(request.getParameter("q_title"));
	int status=0;//전달값이 없는 경우 : 일반글 - 0(초기값)
	if(request.getParameter("secret")!=null) {//전달값이 있는 경우 : 비밀글 - 1 
		status=Integer.parseInt(request.getParameter("secret"));
	}
	String content=Utility.escapeTag(request.getParameter("q_content"));
	
	//QNA_SEQ 시퀀스 객체의 다음값을 검색하여 반환하는 DAO 클래스의 메소드 호출
	int num=QnaDAO.getDAO().selectNextQna(); 
	            

	//새글과 답글을 구분하여 QNA 테이블의 컬럼값으로 저장될 변경값을 변경
	//답글과 새글 초기값에 0저장
	if(ref==0) { //새글
		ref=num; 
	}else {       //답글
		QnaDAO.getDAO().AddQna_Ans(ref, re_Step);
	
		//답글의 REF 컬럼값은 부모글의 전달값이 저장된 ref 변수값과 동일한 값 저장
		re_Step++;
		re_Level++;
	}
	
	
	//DTO 인스턴스를 생성하고 필드값 변경
	QnaDTO qna=new QnaDTO();
	qna.setQ_no(num); 
	qna.setId(loginUsers.getId()); 
	qna.setQ_writer(loginUsers.getName()); 
	qna.setQ_title(subject); 
	qna.setRef(ref); 
	qna.setRe_Step(re_Step); 
	qna.setRe_Level(re_Level); 
	qna.setQ_content(content); 
	qna.setQ_state(status); 
	
	
	
	//게시글을 전달받아 QNA 테이블에 저장하는 DAO 클래스의 메소드 호출
	QnaDAO.getDAO().insertQna(qna);
	
	
	//게시글 목록 출력 페이지 이동 - 페이지 번호 전달(사용자 편의성)
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=qna&work=qna_list&pageNum="+pageNum+"';");
	out.println("</script>");

%>