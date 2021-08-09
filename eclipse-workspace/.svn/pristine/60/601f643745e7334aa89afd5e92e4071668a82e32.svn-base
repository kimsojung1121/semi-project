<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.ProductsDAO"%>
<%@page import="java.util.List"%>
<%@page import="dto.ProductsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int pNo = Integer.parseInt(request.getParameter("pNo"));
	ProductsDTO product = ProductsDAO.getDAO().selectProductsInfo(pNo);
%>

<link type="text/css" rel="stylesheet" href="css/product_detail.css"/>

<form method="post" id="cartad" >
<input type="hidden" name="pNo" value="<%=product.getpNo()%>">

<div class="toptop">
<img src="<%=request.getContextPath()%>/images/cake_<%=product.getpNo()%>.jpg" width="450" alt="name" title="<%=product.getpName() %>" class="photo">
<div class="item_box">
	<div class="item_tit_detail_cont">
		<div class="item_detail_tit">
			<h2><%=product.getpName()%></h2>
			<br>
			<br>
			<br>
			<br>
			<br>
		</div>
		<div class="item_detail_list">
			<dl class="item_price">
				
				<dt><strong>가격</strong></dt>
				<dd>
					<span>&nbsp;&nbsp;<%=DecimalFormat.getInstance().format(product.getpPrice())%></span>원

				</dd>
			</dl>
			<div class="delivery_set_wrap">
				<dl>
					
					<dt><strong>식품의 유형</strong></dt>
					<dd>
						<span>&nbsp;&nbsp;케이크</span>
					</dd>
				</dl>
				

					<dl>
					<dt><strong>보관방법</strong></dt>
						<dd>
						<span>&nbsp;&nbsp;냉동보관(영하18도)</span>
						</dd>
					
					</dl>
					<dl>
					<dt><strong>유통기한</strong></dt>
						<dd>
						<span>&nbsp;&nbsp;제조일로부터 3개월</span>
						</dd>
					
					</dl>
					<dl>
					<dt><strong>레터링 </strong></dt>
						<dd>
						<div id="letterMsg" class="error">반드시 레터링 문구를 입력해 주세요.</div>
                       <span><input type="text" name="cLettering" id="rname" placeholder="숫자,영어,한글 20 글자만 가능합니다." maxlength="20"/></span>

						</dd>
					
					</dl>
					
			</div>
		</div>
            <br>
			<br>
		<dl>
			<dt style="color: red;">수제 레터링 케이크 특성 상 주문수량 최대 1개까지 가능합니다.&nbsp;</dt>
			<dt style="color: red;">&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;1개 이상 주문은 별도 문의 주세요&nbsp;</dt>
			
			
		</dl>
	</div>
</div>
</div>
</form>

	<div class="bt">
		<button type="button" class="btn_add_wish"
			onclick="location.href='home.jsp?workgroup=product&work=cake_lettering';">처음으로</button>
		<button type="button" id="add_cart" class="btn_add_order">장바구니 추가</button>
	</div>


<div class="item_goods_sec">
	<div id="detail">
		<div class="item_goods_tab">
			<ul>
				<li class="on"><a href="#detail">상품상세정보</a></li>
				<li><a href="#delivery">배송안내</a></li>
				<li><a href="#exchange">교환 및 반품안내</a></li>
				<li><a href="#reviews">상품후기</a></li>
                <li><a href="#qna">상품문의</a></li>
			</ul>
		</div>
		<!-- //item_goods_tab -->
		<div class="detail_cont">
			<!--<h3>상품상세정보</h3>-->
			<div class="detail_explain_box">
				<div class="image-manual">
					<!-- 이미지 -->
				</div>
				<div class="txt-manual">
					<!-- 상품상세 공통정보 관리를 상세정보 상단에 노출-->

					<p>&nbsp;</p>
					
					<p>
						<img src="<%=request.getContextPath()%>/images/<%=product.getpNo()%>1.jpg"
							
							alt="1_rarecheesecake_123406.jpg" class="js-smart-img"><br
							style="clear: both;"> 
						<img
							src="images/detail1.jpg"
							
							alt="2_rarecheesecake_123406.jpg" class="js-smart-img"><br
							style="clear: both;"> 
						 
						
					</p>

				</div>
			</div>
		
			<h3>상품필수 정보</h3>
			<div class="detail_info_box">
				<div class="datail_table">
					<table class="left_table_type">
						<colgroup>
							<col />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th style="width: 20%">제품명</th>
								<td colspan="3" style="width: 80%"><%=product.getpName()%></td>
							</tr>
							<tr>
								<th style="width: 20%">식품의 유형</th>
								<td colspan="3" style="width: 80%">빵류 (케이크류)</td>
							</tr>
							<tr>
								<th style="width: 20%">보관방법</th>
								<td colspan="3" style="width: 80%">냉동보관 (영하18도)</td>
							</tr>
							<tr>
								<th style="width: 20%">원재료명</th>
								<td colspan="3" style="width: 80%">피칸분태, 카놀라유, 설탕, 전란, 당근,
									박력분, 계피가루, 소금, 베이킹파우더, 베이킹소다, 크림치즈, 분당, 생크림, 다크럼, 레몬쥬스</td>
							</tr>
							<tr>
								<th style="width: 20%">알레르기 물질 함유</th>
								<td colspan="3" style="width: 80%">계란, 생크림, 우유 함유</td>
							</tr>
							<tr>
								<th style="width: 20%">유통기한</th>
								<td colspan="3" style="width: 80%">제조일로부터 3개월</td>
							</tr>
							<tr>
								<th style="width: 20%">포장재질</th>
								<td colspan="3" style="width: 80%">종이</td>
							</tr>
							<tr>
								<th style="width: 20%">주의사항</th>
								<td colspan="3" style="width: 80%">* 이 제품은 우유, 계란, 생크림을 사용한
									제품과 같은 시설에서 제조합니다. * 본 제품은 공정거래위원회 고시 소비자 분쟁해결 기준에 의거 교환 또는 보상을
									받을 수 있습니다. 유통기한 이내라도 개봉 이후 최대한 빠른 시일 내에 드시기 바랍니다. 부정 불량 식품 신고는
									국번없이 1399</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			

		</div>
	
	</div>

	<div id="delivery">
		<div class="item_goods_tab">
			<ul>
				<li><a href="#detail">상품상세정보</a></li>
				<li class="on"><a href="#delivery">배송안내</a></li>
				<li><a href="#exchange">교환 및 반품안내</a></li>
				<li><a href="#reviews">상품후기</a></li>
                <li><a href="#qna">상품문의</a></li>
			</ul>
		</div>
		<!-- //item_goods_tab -->
		<div class="delivery_cont">
			<h3>배송안내</h3>
			<div class="admin_msg">
				<p>- 배송비 : 기본 배송료는 3,500원입니다. (도서,산간,오지 일부지역은 배송이 불가합니다.)
					40,000원 이상 구매시 무료배송입니다.</p>
				<p>- 택배배송은 주문시점, 배송지에 따라 상이합니다. (서울지역만 당일택배배송이 가능합니다.)</p>
				<p>&nbsp;</p>
				<p>[서울 당일택배배송]</p>
				<p>월요일~금요일 배송 (토요일, 일요일 휴무)</p>
				<p>서울 당일택배배송의 경우 정확한 시간 지정은 어려우며, 우천시 다소 늦어질 수 있습니다.</p>
				<p>&nbsp;</p>
				<p>[전국 우체국택배배송]</p>
				<p>화요일~금요일 배송 (일요일, 월요일 휴무)</p>
				<p>택배배송의 특성상 받는 시간대는 미리 알 수 없는 점 미리 말씀드립니다.</p>
				<img
					src="images/detail2.jpg"
					
					alt="3_rarecheesecake_123406.jpg" class="js-smart-img"><br
					style="clear: both;">
				<img
						src="images/detail3.jpg"
						
						alt="4_rarecheesecake_134725.jpg" class="js-smart-img">
					
			</div>
		</div>
		<!-- //delivery_cont -->
	</div>
	<!-- //#delivery -->
	<div id="exchange">
		<div class="item_goods_tab">

			<ul>
				<li><a href="#detail">상품상세정보</a></li>
				<li><a href="#delivery">배송안내</a></li>
				<li class="on"><a href="#exchange">교환 및 반품안내</a></li>
				<li ><a href="#reviews">상품후기</a></li>
                <li><a href="#qna">상품문의</a></li>
			</ul>
		</div>
		<!-- //item_goods_tab -->
		<div class="exchange_cont">
			<h3>환불안내</h3>
			<div class="admin_msg">
				<br><br>
				<p>- 케이크는 식품 특성상 주문 요청에 의해 제작되기 때문에 단순 변심, 임의 반품에 의한 교환(재배송) 환불이
					불가한 점 양해 부탁드립니다.</p><br>
				<p>- 고객님의 사정으로 인한 주소지 불충분 및 수취지연 시 발생되는 제품의 파손이나 변질에 대해 책임지지
					않습니다.</p><br>
				<p>- 파손/ 변질된 제품 사진을 접수하지 않는 경우 교환(재배송) 환불이 불가합니다.</p><br>
				<p>- 잘못 기재된 레터링에 제품의 경우 교환(재배송) 환불이 불가합니다.</p><br>
				<p>- 핸드메이드 레터링 케이크 특성상 같은 제품이라도 각기 세부 모양이 다를수 있습니다. 제품모양에 따른 환불은 불가합니다. </p><br>
				<p>- 배송된 상품의 신선도나 구성품 누락 시 IMOCAKE의 책임인 경우 새로운 구성으로 교환해드립니다. (문의
					02-512-8189)</p><br>
				
			</div>
		</div>
		 <div id="reviews">
        <div class="item_goods_tab">
            <ul>
                <li><a href="#detail">상품상세정보</a></li>
                <li><a href="#delivery">배송안내</a></li>
                <li><a href="#exchange">교환 및 반품안내</a></li>
                <li class="on"><a href="#reviews">상품후기</a></li>
                <li><a href="#qna">상품문의</a></li>
            </ul>
        </div>
            <h3>PRODUCT REVIEW</h3>
               <div class="pr">
                <br><br>
                <a href="<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_list">상품후기 전체보기</a>
                &nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/home.jsp?workgroup=review&work=review_write" id="pr">상품후기 글쓰기</a>
              </div>
    <div id="qna">
        <div class="item_goods_tab">
            <ul>
                <li><a href="#detail">상품상세정보</a></li>
                <li><a href="#delivery">배송안내</a></li>
                <li><a href="#exchange">교환 및 반품안내</a></li>
                <li><a href="#reviews">상품후기</a></li>
                <li class="on"><a href="#qna">상품문의</a></li>
            </ul>
        </div>
        
            <h3>PRODUCT Q&amp;A</h3>
                <div class="pqa">
                <br><br>
                <a href="<%=request.getContextPath()%>/home.jsp?workgroup=qna&work=qna_list">상품문의 전체보기</a>
                &nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/home.jsp?workgroup=qna&work=qna_write" id="pqa">상품문의 글쓰기</a>
                </div>
     
</div>

	</div>
</div>
</div>

<script type="text/javascript">
$("#add_cart").click(function() {
		<%if(session.getAttribute("loginUsers") == null){%>
			alert("로그인 사용자만 이용 가능합니다. ");
			<%}else{%>
			if(confirm("장바구니에 담으시겠습니까?")) {
				if($("#rname").val()=="") {
					$("#letterMsg").css("display","block");
					return false;
				}
				$("#cartad").attr("action", "<%=request.getContextPath()%>/home.jsp?workgroup=order&work=cart_insert");
				$("#cartad").submit();
			}
			<%}%>			
});



$("#pr").click(function() {
	<%if(session.getAttribute("loginUsers") == null){%>
	alert("로그인 사용자만 이용 가능합니다. ");
	<%}%>
});
$("#pqa").click(function() {
	<%if(session.getAttribute("loginUsers") == null){%>
	alert("로그인 사용자만 이용 가능합니다. ");
	<%}%>
});


</script>













    