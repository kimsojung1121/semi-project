<%@page import="dao.ReviewDAO"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>
<%
	String id = loginUsers.getId(); 
	List<ReviewDTO> reviewList=ReviewDAO.getDAO().selectReview_Id(id);
%>

<%-- CSS --%>
<link type="text/css" rel="stylesheet" href="css/admin.css"/>

<div id="container">
	<div id="contents">
		<div class="sub_content">
			<div class="join_base_wrap">
				<jsp:include page="home.jsp"/>
			
				<h2 style="font-size: 24px; margin-top: 20px; margin-bottom: 40px;" align="center">나의 상품후기</h2>
				<table class="mypage_table">
					<tr>
						<th style="width: 90%;">제목</th>
						<th style="width: 20%;">작성날짜</th>
					</tr>
					<%-- System.out.println(reviewList); --%>
					<% if(reviewList==null) { %>
					<tr>
					<td colspan="2">작성한 상품후기가 없습니다.</td>
					</tr>
					<% } else {%>
						<% for(ReviewDTO review:reviewList) { %>
							<tr>
								<td>
									<a href="<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_detail&r_no=<%=review.getR_no()%>">
										<%=review.getR_title() %>
									</a>
								</td>
								<td><%=review.getR_date() %></td>
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
