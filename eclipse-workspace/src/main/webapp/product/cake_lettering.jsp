<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.ProductsDTO"%>
<%@page import="dao.ProductsDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<ProductsDTO> productList = ProductsDAO.getDAO().selectAllProducts();
	
%>


<!doctype html>
<html>

<!-- Mirrored from www.ranicake.com/goods/goods_list.php?cateCd=003 by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 19 Jul 2021 09:29:17 GMT -->
<!-- Added by HTTrack --><meta http-equiv="content-type" content="text/html;charset=UTF-8" /><!-- /Added by HTTrack -->
<head>
	<meta name="naver-site-verification" content="3998196be4c52d13e17a936c90fb8f5661e5fec8" />
	<meta name="facebook-domain-verification" content="z4mctnmll1tabg1qe79qf564z4ozlw" />
	<!-- ë³ê²½ ì½ë Google Tag Manager -->
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
    <meta name="author" content="ë¼ëì¼ì´í¬" />
    <meta name="description" content="ëë§ì ë¬¸êµ¬ë¡ ë§ë  í¹ë³í ë í°ë§ ì¼ì´í¬ì ë¹ì¼ë°°ì¡ì¼ë¡ ì ë¬¼íì¸ì" />
    <meta name="keywords" content="ë í°ë§ì¼ì´í¬, ìì¼ì¼ì´í¬, ì¼ì´í¬ì ë¬¼, ëìì¸ì¼ì´í¬, ìì ì¼ì´í¬, ê¸°ëì¼ì ë¬¼, ê¸°ëì¼ì¼ì´í¬" />
    <meta name="csrf-token" content="MTYyNjY4Njk1ODE0MTk3ODY0MDA3MDE2MTMyNjQ3NzI2ODY3MzU3ODg0" />


    <meta property="og:type" content="website">
    <meta property="og:title" content="RANI CAKE | ë¼ëì¼ì´í¬">
    <meta property="og:url" content="https://www.ranicake.com/goods/goods_list.php?cateCd=003">
    <meta property="og:description" content="RANI CAKE | ë¼ëì¼ì´í¬">
    <meta property="og:locale" content="ko_KR">
    <meta name="twitter:card" content="summary">
    <meta name="twitter:title" content="RANI CAKE | ë¼ëì¼ì´í¬">
    <meta name="twitter:description" content="RANI CAKE | ë¼ëì¼ì´í¬">


    <link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/reset.css?ts=1600409189">
    <link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/common/common.css?ts=1617777224">
    <link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/common/layer/layer.css?ts=1600409189">
    <link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/layout/layout.css?ts=1600409189">
    <link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/goods/list.css?ts=1600409189">
	<link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/button.css?ts=1600409189">
    <link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/goods/goods.css?ts=1605839631" />
    <link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/js/jquery/chosen/chosen.css?ts=1600409189" />
    <link type="text/css" rel="stylesheet" href="https://www.ranicake.com/data/skin/front/jeonyul_200918/css/custom.css?ts=1600673727" />


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
        // ê³ ëëª°5 íµíì ì±
        var gdCurrencyDecimal = 0;
        var gdCurrencyDecimalFormat = '0';
        var gdCurrencyCode = 'KRW';
        var gdCurrencyAddDecimal = 0;
        var gdCurrencyAddDecimalFormat = '';
        var gdCurrencyAddCode = '';
        var gdLocale = 'ko';
        var gdCurrencySymbol = '';
        var gdCurrencyString = 'ì';

        // íì¨ë³í ì ì±
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

    <style type="text/css">
        body {
        }

        /* body > #wrap > #header_warp : ìë¨ ìì­ */
        #header_warp {
        }

        /* body > #wrap > #container : ë©ì¸ ìì­ */
        #container {
        }

        /* body > #wrap > #footer_wrap : íë¨ ìì­ */
        #footer_wrap {
        }
    </style>

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
        <link rel="canonical" href="https://www.ranicake.com:443/goods/goods_list.php?cateCd=003">


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
<!-- <link rel="stylesheet" href="https://www.ranicake.com/skin/front/jeonyul/urban/fonts/fonts.css">./css/fonts.css -->


</head>

<body class="body-goods body-goods-list pc"  >
	<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-N4JJPB4"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
	<!-- Channel Plugin Scripts -->

<script>
  function parsePureNumber(number) {
    return parseFloat(number.replace(/[^0-9\.]+/g, '')) || 0
  }
  var settings = {
    "pluginKey": "371352af-6a1f-48e7-a0d2-771fc1dc3c25"
  };
  (function() {
    var w = window;
    if (w.ChannelIO) {
      return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
    }
    var d = window.document;
    var ch = function() {
      ch.c(arguments);
    };
    ch.q = [];
    ch.c = function(args) {
      ch.q.push(args);
    };
    w.ChannelIO = ch;
    function l() {
      if (w.ChannelIOInitialized) {
        return;
      }
      w.ChannelIOInitialized = true;
      var s = document.createElement('script');
      s.type = 'text/javascript';
      s.async = true;
      s.src = '../../cdn.channel.io/plugin/ch-plugin-web.js';
      s.charset = 'UTF-8';
      var x = document.getElementsByTagName('script')[0];
      x.parentNode.insertBefore(s, x);
    }
    if (document.readyState === 'complete') {
      l();
    } else if (window.attachEvent) {
      window.attachEvent('onload', l);
    } else {
      window.addEventListener('DOMContentLoaded', l, false);
      window.addEventListener('load', l, false);
    }
  })();
  if (settings && settings.memberId && settings.memberId.indexOf('=gSess.memId') >= 0) {
    console.error('You do not using godomall 5. please visit https://developers.channel.io/docs/guide-for-famous-builders and find correct one');
  } else {
    ChannelIO('boot', settings);
  }
</script>
<!-- End Channel Plugin -->
<div class="top_area"></div>
<div id="wrap" class="jd">


	<!-- ê²ì í¼ ë ì´ì´ -->
	<div class="search_section" id="search_mask">
    <div class="search_bg"></div>
    <div class="searchWrap">
        <p class="txt">PRODUCT SEARCH</p>
		<div class="top_search">
    <form name="frmSearchTop" id="frmSearchTop" action="https://www.ranicake.com/goods/goods_search.php" method="get">
        <fieldset>
            <legend>ê²ìí¼</legend>
            <div class="top_search_cont">
                <div class="top_text_cont">
                    <input type="text" id="search_form" name="keyword" class="top_srarch_text" title=""  placeholder="" autocomplete="off">
                    <button type="submit" class="btn_mask_search">ê²ì</button>
                </div>
                <!-- //top_text_cont -->
                <div class="search_cont" style="display:none;">
                    <input type="hidden" name="recentCount" value="10" />

                    <script type="text/javascript">
    $(function(){

        /* ìë¨ ê²ì */
        $('.top_search_cont input[name="keyword"]').on({
            'focus':function(){
                $(this).parents().find('.search_cont').show();
            },
            'blur':function(){
                $('body').click(function(e){
                    if (!$('.search_cont').has(e.target).length && e.target.name != 'keyword') {
                        $(this).parents().find('.search_cont').hide();
                    }
                });
                $('.btn_top_search_close').click(function(){
                    $(this).parents().find('.search_cont').hide();
                });
            }
        });

        if($("input[name=recentCount]").val() > 0) {
            $('.js_recom_box').removeClass('recom_box_only').addClass('recom_box');
        }else{
            $('.js_recom_box').removeClass('recom_box').addClass('recom_box_only');
        }

    });
</script>
<div class="js_recom_box ">
    <dl>
        <dt>ì¶ì²ìí</dt>
        <dd>
            <div class="recom_item_cont">
                <!-- //recom_icon_box -->
                <div class="recom_tit_box">
                    <a href="https://www.ranicake.com/goods/goods_view.php?goodsNo=">
                    </a>
                </div>
                <!-- //recom_tit_box -->
                <div class="recom_money_box">
                </div>
                <!-- //recom_money_box -->
                <div class="recom_number_box">
                </div>
                <!-- //recom_number_box -->
            </div>
            <!-- //recom_item_cont -->
        </dd>
    </dl>
</div>

                    <!-- //recom_box -->

                    <div class="recent_box">
                        <dl class="js_recent_area">
                            <dt>ìµê·¼ê²ìì´</dt>
                            <dd>ìµê·¼ ê²ìì´ê° ììµëë¤.</dd>
                        </dl>
                    </div>
                    <!-- //recent_box -->
                    <div class="seach_top_all">
                        <button type="button" class="btn_top_search_close"><strong>ë«ê¸°</strong></button>
                    </div>
                    <!-- //seach_top_all -->

                </div>
                <!-- //search_cont -->
                
            </div>
            <!-- //top_search_cont -->
        </fieldset>
    </form>
</div>
<!-- //top_search -->
		<!-- ì¸ê¸° ê²ìì´ -->
		<div class="hit_keyword">
			<span class="tit">ì¸ê¸° ê²ìì´ : </span>
		</div>
		<!--// ì¸ê¸° ê²ìì´ ë -->
    </div>
</div>
	<!--// ê²ì í¼ ë ì´ì´ ë -->
</div>
<!--// #JD-Header END -->
    <!-- //header_warp -->

    <div id="container">
        <div id="contents">
        <!-- ë³¸ë¬¸ ìì -->

            <!-- //location_wrap -->

            <div class="sub_content">

                <!-- //side_cont -->


<div align="center" class="goods_list_item_tit">
	<br><br>
	<h2>LETTERING CAKE</h2>
</div>

<!-- ì¤ë¬¸ì¡°ì¬ ë°°ë --><!-- ì¤ë¬¸ì¡°ì¬ ë°°ë -->


<div class="content">
    <div class="location_wrap">
        <div class="location_cont">
            <em><a href="#" class="local_home">HOME</a> &nbsp;</em>
            <span>&gt; </span>
            <div class="location_select">
                <div class="location_tit"><a href="#"><span>LETTERING CAKE</span></a></div>
                <ul style="display:none;">
                    <li><a href="https://www.ranicake.com/goods/goods_list.php?cateCd=002"><span>PREMIUM CAKE</span></a></li>
                    <li><a href="goods_list05b5.html?cateCd=003"><span>LETTERING CAKE</span></a></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- //location_wrap -->

    <div class="goods_list_item">




        <div class="goods_list">
            <div class="goods_list_cont">
                <!-- ìí ë¦¬ì¤í¸ -->
<div class="item_gallery_type">
    <ul>
    	<%
    	for(ProductsDTO product : productList) {
    	%>
	        <li>
	            <div class="item_cont" style="border: none;">
	                <div class="item_photo_box" style="border: none;" >
	                	
	                    <a href="<%=request.getContextPath()%>/home.jsp?workgroup=product&work=cake_detail&pNo=<%=product.getpNo()%>">
	                        <img src="<%=request.getContextPath()%>/product_image/<%=product.getpNo()%>.jpg" width="450" alt="" title="" class="middle"/>
	                    </a>
	                </div>
	                <!-- //item_photo_box -->
	                <div class="item_info_cont">
	                    <div class="item_tit_box">
	                        <a href="<%=request.getContextPath()%>/home.jsp?workgroup=product&work=cake_<%=product.getpNo()%>">
	                         <!--<a href="home.jsp?workgroup=product&work=cake_1001">-->
	                            <p class="item_name"><%=product.getpName() %></p>
	                        </a>
	
	                    </div>
	                    <!-- //item_tit_box -->
	                    <div class="item_money_box">
	                        <p class="item_price">
	                            <span><%=DecimalFormat.getInstance().format(product.getpPrice()) %>원</span>
	                        </p>
	                    </div>
	                    <!-- //item_money_box -->
	                    <!-- //item_number_box -->
	                    <div class="item_icon_box">
	                        
	                    </div>
	                    <!-- //item_icon_box -->
	                </div>
	                <!-- //item_info_cont -->
	
					<!-- percent -->
					<!--// percent END -->
	
	            </div>
	            <!-- //item_cont -->
	        </li>
	        
        <% } %>
    </ul>
</div>
<!-- //item_gallery_type -->
            </div>
        </div>

        <div class="pagination">
            <div class="pagination"><ul><li class="on"><span>1</span></li></ul></div>
        </div>

    </div>
    <!-- //goods_list_item -->
	<script type="text/javascript">
		$(document).ready(function () {

			$('form[name=frmList] select[name=pageNum]').change(function() {
				$('form[name=frmList]').get(0).submit();
			});

			$('form[name=frmList] input[name=sort]').click(function() {
				$('form[name=frmList]').get(0).submit();
			});

			$(':radio[name="sort"][value=""]').prop("checked","checked")
			$(':radio[name="sort"][value=""]').next().addClass('on');

		});
	</script>
</div>
            </div>
        </div>
    </div>
    <div class="scroll_wrap">
    </div>
</div>

<div id="layerDim" class="dn">&nbsp;</div>
<iframe name="ifrmProcess" src='https://www.ranicake.com/blank.php' style="display:none" width="100%" height="0" bgcolor="#000"></iframe>

<!-- Enliple Tracker Start -->
<script type="text/javascript">
		(function(a,g,e,n,t){a.enp=a.enp||function(){(a.enp.q=a.enp.q||[]).push(arguments)};n=g.createElement(e);n.async=!0;n.defer=!0;n.src="../../cdn.megadata.co.kr/dist/prod/enp_tracker_godomall_rent.min.js";t=g.getElementsByTagName(e)[0];t.parentNode.insertBefore(n,t)})(window,document,"script");
    enp('create', 'common', 'onemoment', { device: 'W' });    
    enp('send', 'common', 'onemoment');
</script>
<!-- Enliple Tracker End -->
</body>
</html>