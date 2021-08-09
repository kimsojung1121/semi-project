<%@page import="dao.ReviewDAO"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="Utility.Utility"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

        <%--비로그인자 접근제한--%>
<%@include file="/security/login_check.jspf" %>
    
     
<%
	//비정상적인 요청에 대한 처리
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
	String r_title=Utility.escapeTag(request.getParameter("r_title"));
	int r_state=0;//전달값이 없는 경우 : 일반글 - 0(초기값)
	if(request.getParameter("secret")!=null) {//전달값이 있는 경우 : 비밀글 - 1 
		r_state=Integer.parseInt(request.getParameter("secret"));
	}
	String r_content=Utility.escapeTag(request.getParameter("r_content"));
	
	//시퀀스 객체의 다음값을 검색하여 반환하는 DAO 클래스의 메소드 호출
	int r_no=ReviewDAO.getDAO().selectNextReview(); 
	            

	//새글과 답글을 구분하여 Review 테이블의 컬럼값으로 저장될 변경값을 변경
	//답글과 새글 초기값에 0저장
	if(ref==0) { //새글
		ref=r_no; 
	}else {       //답글
		ReviewDAO.getDAO().AddReview_Ans(ref, re_Step);
	
		//답글의 REF 컬럼값은 부모글의 전달값이 저장된 ref 변수값과 동일한 값 저장
		re_Step++;
		re_Level++;
	}
	
	
	//DTO 인스턴스를 생성하고 필드값 변경
	ReviewDTO review=new ReviewDTO();
	review.setR_no(r_no); 
	review.setId(loginUsers.getId()); 
	review.setR_writer(loginUsers.getName()); 
	review.setR_title(r_title);
	review.setRef(ref); 
	review.setRe_step(re_Step); 
	review.setRe_level(re_Level); 
	review.setR_content(r_content); 
	review.setR_state(r_state); 
	
	
	
	//게시글을 전달받아 Review 테이블에 저장하는 DAO 클래스의 메소드 호출
	ReviewDAO.getDAO().insertReview(review);
	
	
	//게시글 목록 출력 페이지 이동 - 페이지 번호 전달(사용자 편의성)
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/home.jsp?workgroup=review&work=review_list&pageNum="+pageNum+"';");
	out.println("</script>");

%>