
<%@page import="dao.ReviewDAO"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="Utility.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
	int r_no=Integer.parseInt(request.getParameter("r_no"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	String r_title=Utility.escapeTag(request.getParameter("r_title"));
	int r_state=0;//전달값이 없는 경우 : 일반글 - 0(초기값)
	if(request.getParameter("secret")!=null) {//전달값이 있는 경우 : 비밀글 - 1 
		r_state=Integer.parseInt(request.getParameter("secret"));
	}
	String r_content=Utility.escapeTag(request.getParameter("r_content"));
	
	//DTO 인스턴스를 생성하고 필드값 변경
	ReviewDTO review=new ReviewDTO();
	review.setR_no(r_no);
	review.setR_title(r_title);
	review.setR_content(r_content);
	review.setR_state(r_state);
	
	//게시글을 전달받아 Review 테이블에 저장된 게시글을 변경하는 DAO 클래스의 메소드 호출
	ReviewDAO.getDAO().ModifyReview_Ans(review);
	
	
	//게시글 상세 출력페이지 이동 - 페이지 번호와 검색 관련 정보 전달
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()
		+"/home.jsp?workgroup=review&work=review_detail&r_no="+r_no
		+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
	out.println("</script>");
%> 
