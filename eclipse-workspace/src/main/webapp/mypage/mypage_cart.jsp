<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="/security/login_check.jspf" %>

<div id="container">
	<div id="contents">
		<div class="sub_content">
			<div class="join_base_wrap">
			<jsp:include page="home.jsp"/>
			<jsp:include page="../order/cart.jsp"/>
			</div>
		<!-- //member_cont -->
		</div>
	<!-- //join_base_wrap -->
	</div>
<!-- //content_box -->
</div>

