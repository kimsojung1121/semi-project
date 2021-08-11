<%@page import="dao.UsersDAO"%>
<%@page import="dto.UsersDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 로그인 상태의 관리자만 접근 가능 --%>
<%@include file="/security/admin_check.jspf"%>
<%
	String searchId=request.getParameter("searchId");
	if(searchId==null) {
		searchId="";
	}
	
	String searchName=request.getParameter("searchName");
	if(searchName==null) {
		searchName="";
	}
	
	//페이징 기능
	int pageNum=1; //페이지 번호 1로 초기화
    if(request.getParameter("pageNum")!=null) { //전달값이 있는 경우
 	   pageNum=Integer.parseInt(request.getParameter("pageNum"));
    }
    
	//pageSize : 페이지당 개시물 갯수 - 20개
    int pageSize=20; 
	
	//행의 개수를 구하는 DAO 메소드 호출
    int totalUser=UsersDAO.getDAO().selectUserCount(searchId, searchName);
	
	//전체 페이지
    int totalPage=(int)Math.ceil((double)totalUser/pageSize);
	
	//pageNum이 0보다 작거나 전체 페이지보다 큰 경우 1페이지로 이동
    if(pageNum<=0||pageNum>totalPage) {
   		pageNum=1; 
    }
	
	//시작행
	int startRow=(pageNum-1)*pageSize+1;
	//끝행
    int endRow=pageNum*pageSize;

    if(endRow>totalUser) {
 		endRow=totalUser;
    }
    
    //시작행부터 끝행까지의 회원 정보를 검색하여 반환하는 DAO 메소드 호출
	List<UsersDTO> userList=UsersDAO.getDAO().selectUserList(searchId, searchName, startRow, endRow); 
    
	//페이지에 출력될 게시글에 대한 글번호 시작값을 계산하여 저장
    int number=totalUser-(pageNum-1)*pageSize;
  
 	int blockSize = 5;

	int startPage = (pageNum - 1) / blockSize * blockSize + 1;
	int endPage = startPage + blockSize - 1;

	if (endPage > totalPage) {
		endPage = totalPage;
	}

%>

<%-- CSS --%>
<link type="text/css" rel="stylesheet" href="css/admin.css"/>

<%-- 회원 정보 검색 기능 --%>
<div class="search_user">
	<%-- ID 검색 --%>
	<form action="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=users" method="post" style="display: inline-block;">
		<input type="text" placeholder="회원 ID" onfocus="this.placeholder=''" onblur="this.placeholder='회원 ID'" 
		name="searchId">
		<%-- <button type="button" id="searchIdBtn">검색</button> --%>
		<button type="submit">검색</button>
	</form>
	<%-- 이름 검색 --%>
	<form action="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=users" method="post" style="display: inline-block;">
		<input type="text" placeholder="회원 이름" onfocus="this.placeholder=''" onblur="this.placeholder='회원 이름'" 
		name="searchName">
		<%-- <button type="button" id="searchNameBtn">검색</button> --%>
		<button type="submit">검색</button>
	</form>
	<!-- 메세지 출력 -->
	<div id="searchMsg" style="display: inline-block; color:red;"></div>
</div>


<form name="userForm" class="baseContent" id="userForm">
	<table class="user_table">
		<tr>
			<th><input type="checkbox" id="allCheck"></th>
			<th>아이디</th>
			<th>이름</th>
			<th>이메일</th>
			<th>전화번호</th>
			<th>생년월일</th>
			<th>주소</th>
			<th>가입날짜</th>
			<th>상태</th>
		</tr>
		<% for(UsersDTO user:userList) { %>
			<% if(user.getStatus()==9) { %>
				<tr style="font-weight:bold;">
					<td>관리자</td>
					<td><%=user.getId() %></td>
					<td><%=user.getName() %></td>
					<td><%=user.getEmail() %></td>
					<td><%=user.getPhone() %></td>
					<td><%=user.getBirthday().substring(0, 10) %></td>
					<td>
						[<%=user.getZipcode() %>]<%=user.getAddress1() %> <%=user.getAddress2() %>
					</td>
					<td><%=user.getJoindate().substring(0,10) %></td>
					<td>관리자</td>
				</tr>
			<% } else { %>
				<tr>
					<td><input type="checkbox" name="checkId" value="<%=user.getId()%>" class="check"></td>
					<td><%=user.getId() %></td>
					<td><%=user.getName() %></td>
					<td><%=user.getEmail() %></td>
					<td><%=user.getPhone() %></td>
					<td><%=user.getBirthday().substring(0, 10) %></td>
					<td>
						[<%=user.getZipcode() %>]<%=user.getAddress1() %> <%=user.getAddress2() %>
					</td>
					<td><%=user.getJoindate().substring(0,10) %></td>
					<td>일반회원</td>
				</tr>
			<% } %>
		<% } %>
	</table>
	<div><button type="button" class="btn" id="removeBtn">선택회원 삭제</button></div>
	<div id="message"></div>


	<!-- 페이징 -->
	<div class="page" align="center">
		
		<% for(int i=startPage;i<=endPage;i++) { %>
				<a href="<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=users&pageNum=<%=i%>&searchId=<%=searchId%>&searchName=<%=searchName%>">
					<span><%=i %></span>
				</a>
		<% } %>
	
	</div>
</form>






<script type="text/javascript">
$("#allCheck").change(function() {
		if($(this).is(":checked")) {
			$(".check").prop("checked",true);
		} else {
			$(".check").prop("checked",false);
		}
});

$("#removeBtn").click(function() {
	if($(".check").filter(":checked").length==0) {
		$("#message").text("회원을 선택해 주세요.");
		return;
	}
	
	$("#userForm").attr("method", "post");
	$("#userForm").attr("action", 
		"<%=request.getContextPath()%>/home.jsp?workgroup=admin&work=user_remove_action");
	$("#userForm").submit();
});

<!--
$("#searchIdBtn").click(function() {
	if($("#searchId").length==0) {
		$("#searchMsg").text("ID를 입력해 주세요.");
		return false;
	} else {
		$("#searchIdBtn").submit();
		return true;
	}
});

$("#searchNameBtn").click(function() {
	if($("#searchName").length==0) {
		$("#searchMsg").text("이름을 입력해 주세요.");
		return;
	}
	$("#searchNameBtn").submit();
});
-->

</script>
	