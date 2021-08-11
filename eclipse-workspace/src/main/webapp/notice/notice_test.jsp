<%@page import="dao.NoticeDAO"%>
<%@page import="dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
                          <%-- ■■■■테스트■■■■■ --%>
<%-- BOARD 테이블에 새글을 500개 저장하는 JSP 문서 - 테스트 프로그램 --%>    
<%
	for(int i=1;i<=20;i++) {
		NoticeDTO notice=new NoticeDTO();
		int testnum=NoticeDAO.getDAO().selectNextNotice();
		notice.setN_no(testnum);
		notice.setId("leoleo613");
		notice.setN_title("테스트-"+i);
		notice.setN_content("테스트"+i);
		NoticeDAO.getDAO().insertNotice(notice);
	}
%>      
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>테스트요</h1>
</body>
</html>