<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta http-equiv="expires" content="0"> 
    
    <title>GETMORE 凯特猫</title>
    <!-- Path to Framework7 Library CSS-->
    <link rel="stylesheet" href="../css/framework7.min.css">
    <link rel="stylesheet" type="text/css" href="css/slick.css"/>

    <link rel="stylesheet" type="text/css" href="css/slick-theme.css"/>
    <!-- Path to your custom app styles-->
    <link rel="stylesheet" href="css/my-app.css">
    <link rel="stylesheet" href="../css/fontello.css">
    <link rel="stylesheet" href="../css/flaticon.css">
    <link rel="shortcut icon" href="../minisite/images/nologo.png">
    <!-- 微信sdk -->
	<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" charset="utf-8"></script>
	<style type="text/css">
	.alphadiv{
		background-color: rgba(108, 108, 108, 0.75);
	}
	.alphadiv span{
		cursor: pointer;
	}
	.alphadiv span.noitem{
		cursor: default;
	}
	.alphadiv span.live{
		background-color:#CF000E;
	}
	.alphadiv span.noitem:hover{
		background-color:#CF000E;
	}
	.popup-overlay{
	display: none;
	}
	
	.infinite-scroll-preloader {
  margin-top:-20px;
  margin-bottom: 10px;
  text-align: center;
}
.infinite-scroll-preloader .preloader {
  width:34px;
  height:34px;
} 
.layui-layer-germore .layui-layer-title{
background-color: #CF000E;
color:#fff;
}
.layui-layer-germore .layui-layer-content{
color:#CF000E;  font-size: 17px;
}
.layui-layer-germore .layui-layer-btn a{
background-color: #CF000E;
color:#fff;
}
	</style>
	<script type="text/javascript">
	 window.onerror = function(errorMessage, scriptURI, lineNumber,columnNumber,errorObj) {
	      alert("错误信息："+ errorMessage+
	        ",出错文件：" +scriptURI+","+lineNumber+","+columnNumber+","+errorObj);
	     }
	     
    var loadTag=${uri==null?false:true};
	var index=0;
	function setText(){
		index++;
		index=index%4;
		var context=" 页面加载中";
		for(var i=0;i<index;i++){
			context+=".";
		}
		document.getElementById("loadText").innerHTML=context;
	}
	var bgtask=setInterval(setText,200);
      var cracksound = new Audio('audio/sound.mp3');
      cracksound.loop = false;
       function loadAudio(){

       cracksound.play();
       cracksound.pause();
       document.getElementById('fakeclick').style.display = 'none';
    } 
    </script>
  </head>
  <body>
    <!-- Status bar overlay for fullscreen mode-->
    <div class="statusbar-overlay"></div>
    <!-- Panels overlay-->
    <div class="panel-overlay"></div>
    <!-- Left panel with reveal effect-->
    <div class="panel panel-left panel-reveal">
      <div class="content-block-title">
        返利商户
      </div>
      <div class="list-block">
      <ul>
      <li><a href="help.html" class="close-panel item-link">
      <div class="item-content">
      <div class="item-media"><i class="icon icon-f7 icon-info"></i></div>
      <div class="item-inner">
      <div class="item-title">返利流程</div>
      </div>
      </div></a>
      </li>
      <li><a href="#index" class="close-panel item-link">
      <div class="item-content">
      <div class="item-media"><i class="icon icon-f7 icon-heart-1"></i></div>
      <div class="item-inner">
      <div class="item-title">返利品牌</div>
      </div>
      </div></a></li>
      <li><a href="shake.html" class="close-panel item-link">
      <div class="item-content">
      <div class="item-media"><i class="icon icon-f7 icon-mobile-2"></i></div>
      <div class="item-inner">
      <div class="item-title">摇一摇附近品牌</div>
      </div>
      </div></a></li>
      <li><a href="#" class="close-panel item-link" onclick="window.location.href='http://mp.weixin.qq.com/s?__biz=MzAwMzMyNTAyMw==&mid=208129761&idx=1&sn=4fa0991db1d9d3732e31be38ac84701c&scene=18#wechat_redirect'" >
      <div class="item-content">
      <div class="item-media"><i class="icon icon-f7 icon-magic"></i></div>
      <div class="item-inner">
      <div class="item-title">精彩活动</div>
      </div>
      </div></a></li>
      </ul>
      </div>

      <div class="content-block-title">
        资深导购
      </div>
      <div class="list-block">
      <ul>
      <li><a href="addrequirement.html" class="close-panel item-link">
      <div class="item-content">
      <div class="item-media"><i class="icon icon-f7 icon-plus-1"></i></div>
      <div class="item-inner">
      <div class="item-title">提交需求</div>
      </div>
      </div></a></li>
      <li><a href="myplan.html" class="close-panel item-link">
      <div class="item-content">
      <div class="item-media"><i class="icon icon-f7 icon-doc-text"></i></div>
      <div class="item-inner">
      <div class="item-title">我的方案</div>
      </div>
      </div></a></li>
      
      </ul>
      </div>

       <div class="content-block-title">
        我的返利
      </div>
      <div class="list-block">
      <ul>
      <li><a href="addorder.html" class="close-panel item-link" >
      <div class="item-content">
      <div class="item-media"><i class="icon icon-f7 icon-basket-1"></i></div>
      <div class="item-inner">
      <div class="item-title">提交订单</div>
      </div>
      </div></a></li>
      <li><a href="myorders.html" class="close-panel item-link">
      <div class="item-content">
      <div class="item-media"><i class="icon icon-f7 icon-wallet"></i></div>
      <div class="item-inner">
      <div class="item-title">我的返利</div>
      </div>
      </div></a></li>
      <li><a href="userCard.html" class="close-panel item-link">
      <div class="item-content">
      <div class="item-media"><i class="icon icon-f7 icon-money"></i></div>
      <div class="item-inner">
      <div class="item-title">我的银行卡号</div>
      </div>
      </div></a></li>
      
      </ul>
      </div>
      
       <div class="content-block-title">
        	信息管理
      </div>
      <div class="list-block">
      <ul>
      <li><a href="center.html" class="close-panel item-link external" >
      <div class="item-content">
      <div class="item-media"><i class="icon icon-f7 icon-basket-1"></i></div>
      <div class="item-inner">
      <div class="item-title">个人中心</div>
      </div>
      </div></a></li>
      </ul>
      </div>

    </div>
    
    <!-- Views-->
    <div class="views">
     <div id="preloading">
        <img src="images/getmore.png" alt="">  
        <span id="loadText" style="text-align:left;margin-left:40%"> 页面加载中</span>
      </div>
      
      <!-- Your main view, should have "view-main" class-->
      <div class="view view-main" data-page="index">
        <!-- Top Navbar-->
        <div class="navbar">
          <!-- Navbar inner for Index page-->
          <div data-page="index" class="navbar-inner">
            <!-- We have home navbar without left link-->
            <div class="center sliding">返利品牌</div>
            <div class="right">
              <!-- Right link contains only icon - additional "icon-only" class--><a href="#" class="link icon-only open-panel"> <i class="icon icon-menu-1"></i></a>
            </div>
          </div>
         
        </div>
        <!-- Pages, because we need fixed-through navbar and toolbar, it has additional appropriate classes-->
        <div class="pages navbar-through toolbar-through">
          <!-- Index Page-->
          <div data-page="index" class="page" id="index">
            
            <!-- Scrollable page content-->
            <div class="page-content">
           <!--  <div class="slides" id="indexSlide">
              <div><img src="images/slide1.jpg" alt=""></div>
              <div><img src="images/slide2.jpg" alt=""></div>
              <div><img src="images/slide3.jpg" alt=""></div>
            </div> -->
             <div>
                <form action="javascript:;" class="searchbar-init searchbar searchbar-active" data-search-list=".list-block-search" data-search-in=".brandname"
                data-found=".searchbar-found" data-not-found=".searchbar-not-found" >
                  <div class="searchbar-input" style="position:relative;">
                  <div class="searchbar-not-found" 
                  style="width:95%;position:absolute;height:28px;line-height:28px;color:rgb(169, 169, 169);font-size:15px; text-align:right;vertical-align: middle">暂无结果</div>
                  <input type="search" placeholder="品牌搜索" id="searchInput">
                  <a href="#" class="searchbar-clear"></a>
                  </div>
                  <a href="#" class="searchbar-cancel" style="margin-right: 0px;">取消</a>
                  </form>
              </div>
              <div class="content-block-title">最近浏览</div>
              <div class="content-block" id="latest">
                <div class="content-block-inner">
                <c:if test="${empty scanHistory}">
                	<div>无</div>
                </c:if>
                <c:forEach items="${scanHistory}" var="scan">
                <c:if test="${scan.brand.status!='0' }">
                	<div id="${scan.brand.brandId }"><a href="brandDetail.html?brandId=${scan.brand.brandId }" class="item-link"><img src="${scan.brand.imgPath }" alt="" class="white"></a></div>
                </c:if>
                </c:forEach>
                </div>
              </div>
             
              <div class="list-block list-block-search" id="brandlist">
              
             	 <c:set var="word" value="-1" ></c:set>
              <c:forEach items="${brands}" var="brand">
              	<c:if test="${word!=brand.indexWord&&brand.status=='1' }">
              	 <c:set var="word" value="${brand.indexWord }" ></c:set>
              		<div class="alpha-title"><a name="pa">${word }</a></div>
              	 	<ul>
              	 		 <c:forEach items="${brands}" var="temp">
              	 		 	<c:if test="${temp.indexWord==word&&temp.status=='1' }">
              	 		 		<li><a href="brandDetail.html?brandId=${temp.brandId }" class="item-link">
			                      <div class="item-content">
			                        <div class="item-inner"> 
			                          <div class="item-title"><img class="white" src="${temp.imgPath }" alt=""> 
			                          <span class="brandname">${temp.brandName }</span>
			                           <span class="type"><!-- <i class="flaticon-queen6"></i> -->
			                            <c:if test="${temp.brandType!=null }">
			                            	<c:forEach items="${temp.brandType}" var="brandType">
			                            		${brandType.html }
			                            	</c:forEach>
			                            </c:if>
			                           </span></div>
			                        </div>
			                      </div></a>
			                     </li>
              	 		 	</c:if>
              	 		 </c:forEach>
              	 	</ul>
              	 
              	</c:if>
              </c:forEach>
              </div>
            </div>
            
  			 <div class="alphadiv">
              <span id="pa" data="A" class="noitem">a</span>
              <span id="pb" data="B" class="noitem">b</span>
              <span id="pc" data="C" class="noitem">c</span>
              <span id="pd" data="D" class="noitem">d</span>
              <span id="pe" data="E" class="noitem">e</span>
              <span id="pf" data="F" class="noitem">f</span>
              <span id="pg" data="G" class="noitem">g</span>
              <span id="ph" data="H" class="noitem">h</span>
              <span id="pi" data="I" class="noitem">i</span>
              <span id="pj" data="J" class="noitem">j</span>
              <span id="pk" data="K" class="noitem">k</span>
              <span id="pl" data="L" class="noitem">l</span>
              <span id="pm" data="M" class="noitem">m</span>
             <span id="pn" data="N" class="noitem">n</span>
              <span id="po" data="O" class="noitem">o</span>
             <span id="pp" data="P" class="noitem">p</span>
              <span id="pq" data="Q" class="noitem">q</span>
              <span id="pr" data="R" class="noitem">r</span>
               <span id="ps" data="S" class="noitem">s</span>
                <span id="pt" data="T" class="noitem">t</span>
                <span id="pu" data="U" class="noitem">u</span>
                <span id="pv" data="V" class="noitem">v</span>
                <span id="pw" data="W" class="noitem">w</span>
                <span id="px" data="X" class="noitem">x</span>
                <span id="py" data="Y" class="noitem">y</span>
                <span id="pz" data="Z" class="noitem">z</span>
            </div>
            
          </div>
          
         
          
        </div>
        
      </div>
      
      
  
 
   
	<a id="fakeclick" ontouchstart="javascript:loadAudio();"></a>
    <script src="../js/jquery.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="../js/framework7.min.js" charset="utf-8"></script>
     <script type="text/javascript" src="js/my-app.js?version=1" charset="utf-8"></script> 
     <script type="text/javascript" src="../js/layer/layer.js" charset="utf-8"></script>
    <script src="../js/slick.min.js" charset="utf-8"></script>
  	<script src="js/shake.js" charset="utf-8"></script>
	<!-- 家具功能区域对应 -->
	<script src="allZoneAndType.html?param=zoneArr" charset="utf-8"></script>
	
	
	
    <script>
    //--微信sdk调用 --
    $(function(){
	     wx.config({
	    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	    appId: '${appId}', // 必填，公众号的唯一标识
	    timestamp:${timestamp} , // 必填，生成签名的时间戳
	    nonceStr: '${nonceStr}', // 必填，生成签名的随机串
	    signature: '${signature}',// 必填，签名，见附录1
	    jsApiList: ['chooseImage','uploadImage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		}); 
    });
    var zoneArr;
   
      $(document).ready(function(){
 	  <c:if test="${uri!=null}">
    	 myApp.views[0].router.loadPage('${uri}');
  	 </c:if>
	   <c:if test="${uri==null}">
		   //清除掉加载页面
		   	setTimeout(function(){
		   		$("#preloading").remove();
		   		clearInterval(bgtask);
		   		bgtask=null;
		   	},800);
	   </c:if>
   		

      var cracksound = new Audio('audio/sound.mp3');
      cracksound.loop = false;
      
      var myShakeEvent = new Shake({
          threshold: 15, 
          timeout: 1000 
      });
      myShakeEvent.start();
		
      window.addEventListener('shake', shakeEventDidOccur, false);

      function shakeEventDidOccur(){
    	  if(!$('.shakeresults ul')[0]){
    		  return;
    	  }
    	  $('.shakeresults').addClass('hide');//隐藏上次结果
    	  $('.shakeresults ul').empty();//清空上次结果
    	  
          cracksound.play();
          $('.shakeicon').addClass('shaking');
    	 getLocation();	
      } 

    });
      function getLocation(){
        if (navigator.geolocation){
          navigator.geolocation.getCurrentPosition(showPosition);
          }
       }
    
      function showPosition(position){
    	  var param={};
    	  param.lat=position.coords.latitude;
    	  param.lng=position.coords.longitude;
    	  
    	  $.post("nearStore.html",param,function(json){
  			if(json.status=="ok"){
  				 $('.shakeresults ul').empty();
                
  				 //初始化数据
  			    $(json.data).each(function(){
                var html= '<li class="accordion-item">'+
                   '<a href="#" class="item-link item-content">'+
                   '<div class="item-media"><img src="'+this.brand.imgPath+'" width="44" class="white"></div>'+
                   '<div class="item-inner">'+
                   '<div class="item-title-row">'+
                   '<div class="item-title">'+this.storeName+'</div>'+
                   '</div>'+
                   '</div>'+
                  ' </a>'+
                    '<div class="accordion-item-content">'+
                     '<div class="content-block intend">'+
                        '<p><strong>门店地址:'+this.address+'</strong><br>'+ 
                        '<strong>店铺展位号:'+this.doorCode+'</strong><br>'+
                        "<strong>店长电话:</strong> <a class='tel' ontouchstart=\"window.location.href='tel:"+this.user.phone+"'\" href='#'>"+this.user.phone+"</a>"+
                        '<br/><strong>店长微信号:</strong> <a class="tel" href="#">'+this.user.wechatId+'</a>'+
                        '<a href="brandDetail.html?brandId='+this.brand.brandId+'" class="item-link more">更多店铺信息</a>'+
                        '</p>'+
                     '</div>'+
                     '</div>'+
                   '</li>';
  					$('.shakeresults ul').append(html);
  				 });
  				 
  	            setTimeout(function(){
  	              $('.shakeicon').removeClass('shaking');
  	            $('.shakeresults').removeClass('hide');//显示
  	            }, 1000);
  			}else if(json.status="no"){
  				layer.msg('3000米以内没有结果');
  			}
  		},"json");
    	  
        }
    </script>
  </body>


</html>