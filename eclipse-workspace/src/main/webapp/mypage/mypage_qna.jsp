<%@page import="dao.QnaDAO"%>
<%@page import="dto.QnaDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>
<%
	String id = loginUsers.getId(); 
	List<QnaDTO> qnaList=QnaDAO.getDAO().selectQna_Id(id);
%>

<%-- CSS --%>
<link type="text/css" rel="stylesheet" href="css/admin.css"/>

<div id="container">
	<div id="contents">
		<div class="sub_content">
			<div class="join_base_wrap">
				<jsp:include page="home.jsp"/>
				
				
				<h2 style="font-size: 24px; margin-top: 20px; margin-bottom: 40px;">나의 Q&A</h2>
				<table class="mypage_table">
					<tr>
						<th style="width: 80%;">제목</th>
						<th style="width: 10%;">조회수</th>
						<th style="width: 10%;">작성날짜</th>
					</tr>
					<% if(qnaList==null) { %>
					<tr>
					<td colspan="3">작성한 QnA가 없습니다.</td>
					</tr>
					<% } else {%>
						<% for(QnaDTO qna:qnaList) { %>
							<tr>
								<td>
									<a href="<%=request.getContextPath()%>/home.jsp?workgroup=qna&work=qna_detail&q_no=<%=qna.getQ_no()%>">
										<%=qna.getQ_title() %>
									</a>
								</td>
								<td><%=qna.getReadcount() %></td>
								<td><%=qna.getQ_date() %></td>
							</tr>
						<% } %>
					<% } %>
				</table>
				
				
			</div>
		<!-- //member_cont -->
		</div>
	<!-- //join_base_wrap -->
	</div>
<!-- //content_box -->
</div>

