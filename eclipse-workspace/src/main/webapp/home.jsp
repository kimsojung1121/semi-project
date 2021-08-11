<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	//Content 영역에 포함되는 모든 JSP 문서의 POST 방식의 전달값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("utf-8");
	
	String workgroup=request.getParameter("workgroup");
	if(workgroup==null) workgroup="main";
	
	String work=request.getParameter("work");
	if(work==null) work="main";
	
	String headerPath="header.jsp";
	if(workgroup.equals("admin")) {
		headerPath="admin/header.jsp";
	}
	
	String contentPath=workgroup+"/"+work+".jsp";	
%>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IMO CAKE</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
a#MOVE_TOP_BTN {
    position: fixed;
    right: 2%;
    bottom: 50px;
    display: none;
    z-index: 999;
}
</style>
<link href="css/home.css" rel="stylesheet">

<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/reset.css?ts=1600409189">
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/common/common.css?ts=1617777224">
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/common/layer/layer.css?ts=1600409189">
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/layout/layout.css?ts=1600409189">
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/goods/list.css?ts=1600409189">
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/button.css?ts=1600409189">
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/goods/goods.css?ts=1605839631" />
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/jquery/chosen/chosen.css?ts=1600409189" />
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/custom.css?ts=1600673727" />
<meta name="naver-site-verification" content="3998196be4c52d13e17a936c90fb8f5661e5fec8" />
	<meta name="facebook-domain-verification" content="z4mctnmll1tabg1qe79qf564z4ozlw" />
	<!-- 변경 코드 Google Tag Manager -->
<script>(function(w,d,s,l,i,j){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:j+'.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'../../www.googletagmanager.com/gtm5445.html?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-N4JJPB4','gtm');</script>
<!-- End Google Tag Manager -->
	<meta name="google-site-verification" content="onuwB2uuXotksjCOlJ1cnS_JAT0wXOCFPhnFB1mu8zQ" />
    <title>IMOCAKE</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="author" content="라니케이크" />
    <meta name="description" content="나만의 문구로 만든 특별한 레터링 케이크을 당일배송으로 선물하세요" />
    <meta name="keywords" content="레터링케이크, 생일케이크, 케이크선물, 디자인케이크, 수제케이크, 기념일선물, 기념일케이크" />
    <meta name="csrf-token" content="MTYyNjY4NjkwNDQwNDc2ODMzNjY5NDc0MDY0MTEyMzY3OTk2NzkwMTU3" />


    <meta property="og:type" content="website">
    <meta property="og:title" content="RANI CAKE | 라니케이크">
    <meta property="og:url" content="https://www.ranicake.com/goods/goods_list.php?cateCd=002">
    <meta property="og:description" content="RANI CAKE | 라니케이크">
    <meta property="og:locale" content="ko_KR">
    <meta name="twitter:card" content="summary">
    <meta name="twitter:title" content="RANI CAKE | 라니케이크">
    <meta name="twitter:description" content="RANI CAKE | 라니케이크">

    <script type="text/javascript">
        var json_locale_data = "var json_locale_data = {\"domain\":\"messages\",\"locale_data\":{\"messages\":{\"\":{\"lang\":\"ATF\",\"plural-forms\":\"nplurals=1; plural=0\"}}}}"
    </script>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/gd_gettext.js?ts=1600409189"></script>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/jquery/jquery.min.js?ts=1600409189"></script>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/underscore/underscore-min.js?ts=1600409189"></script>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/jquery/validation/jquery.validate.min.js?ts=1600409189"></script>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/jquery/validation/additional-methods.min.js?ts=1600409189"></script>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/numeral/numeral.min.js?ts=1600409189"></script>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/global/accounting.min.js?ts=1600409189"></script>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/global/money.min.js?ts=1600409189"></script>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/jquery/chosen/chosen.jquery.min.js?ts=1600409189"></script>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/jquery/placeholder/placeholders.jquery.min.js?ts=1600409189"></script>
    <![if gt IE 8]>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/copyclipboard/clipboard.min.js?ts=1600409189"></script>
    <![endif]>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/jquery/vticker/jquery.vticker.js?ts=1600409189"></script>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/gd_ui.js?ts=1600409189"></script>


    <script type="text/javascript">
        // 고도몰5 통화정책
        var gdCurrencyDecimal = 0;
        var gdCurrencyDecimalFormat = '0';
        var gdCurrencyCode = 'KRW';
        var gdCurrencyAddDecimal = 0;
        var gdCurrencyAddDecimalFormat = '';
        var gdCurrencyAddCode = '';
        var gdLocale = 'ko';
        var gdCurrencySymbol = '';
        var gdCurrencyString = '원';

        // 환율변환 정책
        fx.base = "KRW";
        fx.settings = {
            from : "KRW",
            to : gdCurrencyCode
        };
        fx.rates = {
            "KRW" : 1,
            "USD" : 0,
            "CNY" : 0,
            "JPY" : 0,
            "EUR" : 0,
        }
    </script>

    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/gd_common.js?ts=1600409189"></script>

    <!-- Add script : start -->
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/jquery/jquery-cookie/jquery.cookie.js"></script>
    <script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/gd_bandwagon.js"></script>
    <!-- Add script : end -->


    <script type="text/javascript" src="../../wcs.naver.net/wcslog.js"></script>
	<script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/naver/naverCommonInflowScript.js?Path=/goods/goods_list.php&amp;Referer=https://www.ranicake.com:443&amp;AccountID=s_1d3fac9129a7&amp;Inflow=ranicake.com" id="naver-common-inflow-script"></script>
<!-- Facebook Pixel Code -->
        <script>
        !function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
        n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
        n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
        t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
        document,'script','../../connect.facebook.net/en_US/fbevents.js');
        fbq('init', '622636961691545', {}, {'agent':'plgodo'});
        fbq('track', 'PageView');
        </script>
        <noscript><img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=622636961691545&amp;ev=PageView&amp;noscript=1"/></noscript>
        <!-- DO NOT MODIFY -->
        <!-- End Facebook Pixel Code --><script type="text/javascript" charset="UTF-8" src="../../t1.daumcdn.net/adfit/static/kp.js"></script>
        <script type="text/javascript">
            kakaoPixel('3024910781678046380').pageView();
        </script>
        <link rel="canonical" href="https://www.ranicake.com:443/goods/goods_list.php?cateCd=002">


<!-- urbanskin -->
<script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/urban/js/urban.js?ts=1600409189"></script>
<script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/urban/js/swiper.min.js?ts=1600409189"></script>
<script type="text/javascript" src="https://www.ranicake.com/data/skin/front/jeonyul_200918/urban/js/popup.js?ts=1600409189"></script>
<link rel="stylesheet" href="../../cdn.jsdelivr.net/npm/xeicon%402.3.3/xeicon.min.css" />
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/urban/css/urban.css?ts=1605838738" />
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/urban/css/swiper.min.css?ts=1600409189" />
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/urban/css/layout/header.css?ts=1600409189" />
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/urban/css/layout/footer.css?ts=1600409189" />
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/urban/css/main.css?ts=1610696401" />
<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/urban/css/popup.css?ts=1600409189" />
<link  rel="stylesheet" href="https://www.ranicake.com/skin/front/jeonyul/urban/fonts/fonts.css"><!-- ./css/fonts.css -->

<script>
    $(function() {
        $(window).scroll(function() {
            if ($(this).scrollTop() > 500) {
                $('#MOVE_TOP_BTN').fadeIn();
            } else {
                $('#MOVE_TOP_BTN').fadeOut();
            }
        });
        
        $("#MOVE_TOP_BTN").click(function() {
            $('html, body').animate({
                scrollTop : 0
            }, 400);
            return false;
        });
    });
</script>

</head>
<body class="body-main body-index pc">
   
   <!-- header -->
    <div style="margin: 50px; padding: 0 auto;">>
		<%-- <jsp:include page="header.jsp"/> --%>
		<jsp:include page="<%=headerPath %>"/>
	</div>
   
   <!-- content -->
    <div style="margin: 50px; padding: 0 auto;">
    	<jsp:include page="<%=contentPath %>"/>
    	<a id="MOVE_TOP_BTN" href="#"><img src="images/top.png" style="width: 40px;"></a>
    </div>
    
    <!-- footer -->
   	<div style="margin: 50px; padding: 0 auto;">
   		<jsp:include page="footer.jsp"/>
   	</div>

</body>
</html>
