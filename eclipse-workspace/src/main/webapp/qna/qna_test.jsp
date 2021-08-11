<%@page import="dao.QnaDAO"%>
<%@page import="dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
                          <%-- ■■■■테스트■■■■■ --%>
<%-- BOARD 테이블에 새글을 500개 저장하는 JSP 문서 - 테스트 프로그램 --%>    
<%
	for(int i=1;i<=20;i++) {
		QnaDTO qna=new QnaDTO();
		int testnum=QnaDAO.getDAO().selectNextQna();
		qna.setQ_no(testnum);
		qna.setId("괴물");
		qna.setQ_writer("홍길동");
		qna.setQ_title("테스트-"+i);
		qna.setRef(testnum);
		qna.setQ_content("테스트"+i);
		QnaDAO.getDAO().insertQna(qna);
	}
%>      
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>500개의 테스트 게시글을 저장 하였습니다.</h1>
</body>
</html>