<%@page import="dto.UsersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 로그인 사용자와 비로그인 사용자를 구분하여 응답 처리 --%>
<%
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	UsersDTO loginUsers=(UsersDTO)session.getAttribute("loginUsers");
%>

 <div id="wrap" class="jd">
            <div id="JD-Header">
	           <div class="headerWrap"> 
                   <ul class="navi">
                      <li><a href="home.jsp?workgroup=main&work=brand">BRAND</a></li>
                      <li><a href="home.jsp?workgroup=product&work=cake_lettering">CAKE</a></li>
                        <li><a href="#none">COMMUNITY</a>
                            <ul class="sub">
                                <li><a href='home.jsp?workgroup=qna&work=qna_list'>Q&amp;A</a></li>
                                <li><a href="home.jsp?workgroup=review&work=review_list">REVIEW</a></li>
                                <li><a href="home.jsp?workgroup=notice&work=notice_list">NOTICE</a></li>
                            </ul>
                        </li>
                    </ul>
  
                    <div class="logo">
					 	<span>
			            	<a href="home.jsp?workgroup=main&work=main" ><img src="images/mainlogo.jpg"></a>
			            </span>
			         </div>
                   
                   
                    <div class="section_right">
                        <div class="member">
                            <ul class="menu_mem">
                            	<% if(loginUsers==null) {//비로그인 사용자인 경우 %>
	                                <li><a href="home.jsp?workgroup=users&work=users_login&state=1">LOGIN</a></li>
									<li><a href="home.jsp?workgroup=users&work=users_join_agree">JOIN</a></li>
								<% } else {//로그인 사용자인 경우 %>
									<li><a href="home.jsp?workgroup=users&work=users_logout_action">LOGOUT</a></li>
	                                <li><a href="home.jsp?workgroup=order&work=cart">CART</a></li>
									<li><a href="home.jsp?workgroup=mypage&work=mypage_orders">MYPAGE</a></li>
	                                <% if(loginUsers.getStatus()==9) {//로그인 사용자가 관리자인 경우 %>
											<li><a href="home.jsp?workgroup=admin&work=admin_main">ADMIN</a></li>
									<% } %>
								<% } %>
                                
                            </ul>
                        </div>
                    </div> 
                </div>  
        </div>        
    </div>        