
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/myTag" prefix="my" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>导购 | ${toguide.name}</title>
     <meta name="viewport" content="width=321">
      <meta name="format-detection" content="telephone=no">
     <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	 <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	 <META HTTP-EQUIV="Expires" CONTENT="0">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
     <style type="text/css">
     #chatui .chatarea li.li-tips{padding-top:0px 0px 5px 0px;;font-size:12px;color:#ce304e;text-align:center;word-spacing:9px; letter-spacing: 2px;}
     #chatui .chatarea li.li-tips.loadPage{word-spacing:5px; letter-spacing: 1px;text-decoration: underline;}
     .chatnotice a{color:#ce304e}

     </style>
     
</head>
<body class="bg_white with_topbar">
	<input type="hidden" id="notips-unreview" />
	
	<input type="hidden" id="imgUrl" value="${imgUrl }"/>
	
	<input type="hidden" id="toId" value="${toUser.getMoreId }"/>
	<input type="hidden" id="pageSize" value="${pageSize }"/>
	<input type="hidden" id="pageIndex" value="${pageIndex }"/>
	<input type="hidden" id="totalPage" value="${totalPage }"/>
		<div class="topbar bar_red navback">
			<c:choose>
				<c:when test="${empty backUrl }">
					<a href="center.html"><i class="icon-cross"></i></a>
				</c:when>
				<c:otherwise>
					<a href="http://${backUrl }"><i class="icon-cross"></i></a>
				</c:otherwise>
			</c:choose>
			<div class="centertitle">
			<c:if test="${check==0 }">
			 <button class="addGuideBtn" href="getGuide.html?guideId=${toguide.guideId }"><i class="icon-plus"></i>添加为我的导购</button>
			</c:if>
			 </div>
			<div class="rightele">
				<i class="icon-users withlabel morechat">
					<!-- <span class="number_chat"></span> -->
				</i>
			</div>
		</div>
		<c:if test="${check==0 }">
		<!--  -->	<div class="chatnotice anime_l">
			该导购员不是您的品牌专属导购，如需保持联系，请 
			<a href="getGuide.html?guideId=${toguide.guideId }"> <i class="icon-plus"></i>添加TA为您的品牌导购</a>
			</div>
		</c:if>
		<div id="chatui">
		<ul class="chatarea" id="talking-container">

		</ul>
		<div class="tools">
			<div class="input">
				<form action="#" id="talkform">
					<input type="text" id="talk-content" maxlength="200" name="words"> 
					<i class="icon-circle-plus"></i>
					<button type="submit">
						发送
					</button>
				</form>
			</div>
			<div class="toolbox grid-container hide">
				<div class="row">
					<div class="col-3">
						<div class="add_img item">
							<i class="icon-image"></i>
							<strong>图片</strong>
						</div>
					</div>
				</div>
			</div>
			
			
		</div>
		
		</div>
	



		<div class="chatselect anime">
		<div class="nocontents" style="display:none;">
				<div class="icon">
					<i class="icon-bubble2"></i>
				</div>
				<div class="info">暂无新消息</div>
			</div>
			
			<div class="row">
			</div>

			<div class="close">
				<i class="icon-arrow_drop_up"></i>
			</div>
		</div>
		
		<div class="olay_dark overlay hide"></div>

<script src="js/jquery.min.js"></script>
<script src="../js/socket/socket.io-1.3.4.js"></script>
<script src="../js/socket/p-talk.js"></script>
<script src="js/main.js"></script>
<script src="js/we_chat.js?v=2"></script>
 <!-- 微信sdk -->
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" charset="utf-8"></script>
<script>
	$(document).ready(function() {
		
		$(function(){
		     wx.config({
		    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		    appId: '${appId}', // 必填，公众号的唯一标识
		    timestamp:${timestamp}, // 必填，生成签名的时间戳
		    nonceStr: '${nonceStr}', // 必填，生成签名的随机串
		    signature: '${signature}',// 必填，签名，见附录1
		    jsApiList: ['chooseImage','uploadImage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			}); 
	    });
		
		var toolbox = $('.toolbox');
		$('.input').on('focus', 'input', function(event) {
			$('.input i').removeClass('icon-circle-minus');
			toolbox.addClass('hide');
			$('.chatarea').css({
					bottom: '70px'
			});
		});
		$('.input').on('click', 'i', function(event) {
			event.preventDefault();
			$(this).toggleClass('icon-circle-minus');
			toolbox.toggleClass('hide');
			if(toolbox.is(":visible")){
				$('.chatarea').css({
					bottom: '160px'
				});
			} else {
				$('.chatarea').css({
					bottom: '70px'
				});
			}
		});
		
		$('.morechat').on('click', '', function(event) {
			var number=$(this).find("span.number_chat")[0];
			if(!number){//如果有，则显示
				$(".nocontents").show();
			}else{
				$(".nocontents").remove();
			}
			$('.chatselect').toggleClass('shown');
			event.preventDefault();
		});

		$('.chatselect').on('click', '.close', function(event) {
			event.preventDefault();
			$('.chatselect').removeClass('shown');
		});

		if($('.chatnotice')[0]){
			$('.chatnotice').addClass('shown');
			setTimeout(function(){$('.chatnotice').removeClass('shown').css("zIndex","-1")}, 5000);
		}
		
		//导购头像跳转
		$("#talking-container").on("click",".speakPhoto",function(){
			var toId=$("#toId").val();
			var param={};
			param.userId=toId;
			$.post("getGuideByUserId.html",param,function(json){
				if(json.status==1){
					window.location.href="getGuide.html?guideId="+json.data;
				}
			},"json")
		});
		
		$(".addGuideBtn").on("click",function(){
			var href=$(this).attr("href");
			if(href){
				window.location.href=href;
			}
		});
		
	});	
</script>
</body>
</html>