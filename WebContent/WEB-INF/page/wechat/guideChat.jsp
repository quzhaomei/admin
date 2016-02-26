<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/myTag" prefix="my" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>导购 :: ${toUser.userName }</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
      <meta name="format-detection" content="telephone=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
     <style type="text/css">
     #chatui .chatarea li.li-tips{padding-top:0px 0px 5px 0px;;font-size:12px;color:#ce304e;text-align:center;word-spacing:9px; letter-spacing: 2px;}
     #chatui .chatarea li.li-tips.loadPage{word-spacing:5px; letter-spacing: 1px;text-decoration: underline;}
     </style>
     
</head>
<body class="bg_white with_topbar">
	<input type="hidden" id="toId" value="${toUser.getMoreId }"/>
	
	<input type="hidden" id="guideId" value="${guide.guideId }"/>
	<input type="hidden" id="pageSize" value="${pageSize }"/>
	<input type="hidden" id="pageIndex" value="${pageIndex }"/>
	<input type="hidden" id="totalPage" value="${totalPage }"/>
		<div class="topbar bar_red navback">
			<a href="center.html"><i class="icon-cross"></i></a>
			<div class="centertitle">导购 :: ${toUser.userName }</div>
			<div class="rightele">
				<i class="icon-users withlabel morechat">
					<!-- <span class="number_chat"></span> -->
				</i>
			</div>
		</div>
		<div id="chatui">
		<ul class="chatarea" id="talking-container">

		</ul>
		<div class="tools">
			<div class="input">
				<form action="#" id="talkform">
					<input type="text" id="talk-content" maxlength="200" name="words"> 
					<i class="icon-circle-plus"></i>
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
					<div class="col-3">
						<div class="add_namecard item">
							<i class="icon-head"></i>
							<strong>名片</strong>
						</div>
					</div>
					<div class="col-3">
						<div class="guide-location item">
							<i class="icon-location2"></i>
							<strong>店铺地址</strong>
						</div>
					</div>

					<div class="col-3">
						<div class="add_normal item">
							<label for="preword" class="preword">
								<i class="icon-bubble"></i>
								<strong>话术</strong>
								<select name="preword" id="preword">
									<option value="0">请选择话术</option>
									<option value="您可以到我们门店进一步挑选。">您可以到我们门店进一步挑选。</option>
									<option value="还有什么其他的需要呢？">还有什么其他的需要呢？</option>
									<option value="您大致打算在何时购买？">您大致打算在何时购买？</option>

								</select>
							</label>
							
						</div>
					</div>

				</div>
			</div>
			
		</div>
		
		</div>
	
<!-- 隐藏html -->
<div style="display:none">
	<!-- 导购 -->
	<div id="guide-namecard"><strong>我的名片</strong><br>姓名：${guide.name }<br>所属门店：${guide.brand.brandName }品牌${guide.store.storeName }店<br>电话：${guide.phone }</div>
	<!-- 导购信息 -->
	<div id="guide-location"><strong>${guide.brand.brandName }品牌${guide.store.storeName }店</strong><br>地址：${guide.store.address }${guide.store.doorCode }</div>
</div>



		<div class="chatselect anime">
			<div class="row">
			</div>

			<div class="close">
				<i class="icon-arrow_drop_up"></i>
			</div>
		</div>
		
		
	 <!-- 以下为02-23日新增，转单选择 -->

		<div class="chooseguider bg_red_l anime">
			<div class="title">
				选择其他导购
			</div>
			<div class="shopchoose">
				<select name="shopchoose" id="shopchoose">
					<option value="0">当前导购所属店铺名</option>
				</select>
			</div>

			<div class="guiderlist">
				<div class="row">
				<!--  <div class="col-3">
					<a href="#" id="uid_18763">
					<img src="images/avatar.jpg">
					<span>Claire</span>
					<i class="icon-check2"></i>
					</a>
				</div>-->
			</div>
			</div>
			<div class="actionbar">
				<button class="confirm bttn_md noborder" type="button">
					确认转单
				</button>
				<button class="close bttn_md noborder" type="button">
					取 消
				</button>
			</div>
			
		</div>
		
		<div class="bttn_c_guider">
			<i class="icon-reply"></i>
			转单
		</div>
		
		<div class="olay_dark overlay hide"></div>


<script src="js/jquery.min.js"></script>
<script src="../js/socket/socket.io-1.3.4.js"></script>
<script src="../js/socket/p-talk.js"></script>
<script src="js/main.js"></script>
<script src="js/we_chat.js"></script>
 <!-- 微信sdk -->
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" charset="utf-8"></script>
<script>
	$(document).ready(function() {
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
			var number=$(this).find("span.number_chat").text();
			if(number&&number.match(/^\d+$/)){
				number=parseInt(number, "10");
				if(number>0){//如果有，则显示
				event.preventDefault();
				$('.chatselect').toggleClass('shown');
				}
			}
		});

		$('.chatselect').on('click', '.close', function(event) {
			event.preventDefault();
			$('.chatselect').removeClass('shown');
		});

		if($('.chatnotice')[0]){
			$('.chatnotice').addClass('shown');

			setTimeout(function(){$('.chatnotice').removeClass('shown')}, 5000);
		}
		
		var chatselect = $('.chatselect');
		var guiderChoose = $('.chooseguider');
		var guiderList = $('.guiderlist');
		var bttnGuider = $('.bttn_c_guider');
		
		var storeName;
		
		bttnGuider.on('click', '', function(event) {
			event.preventDefault();
			//后台调取所有该品牌下的所有店铺
			$.post("guideShop.html",function(json){
				if(json.status=="1"){
				$("#shopchoose")[0].options.length=1;
				$(json.data).each(function(){
					$("#shopchoose")[0].options.add(new Option(this.storeName,this.storeId));
				});
					guiderChoose.addClass('shown');
					chatselect.removeClass('shown');
				}
			},"json");
		});

		//选择店铺
		$("#shopchoose").on("change",function(){
			var storeId=this.value;
			
			storeName=$("#shopchoose option:selected").text();
			$(".guiderlist .row").empty();
			if(storeId!=0){
				$.post("../out/getGuideByStore.html",{"storeId":storeId},function(json){
					if(json.status==1){
						var has=false;
						$(json.data).each(function(){
							if(this.guideId!=$("#guideId").val()){
								$(".guiderlist .row").append(
									[	'<div class="col-3">',
										'<a guideId="'+this.guideId+'" guideName="'+this.name+'" href="#" >',
										'<img src="'+this.photo+'" alt="">',
										'<span>'+this.name+'</span>',
										'<i class="icon-check2"></i>',
										'</a>',
									'</div>	'	
								].join("")
								);
								has=true;
							}
						});
						if(!has){
							$(".guiderlist .row").append("该品牌无其他导购");
						}
					}
				},"json");
			}
		});

			
		guiderChoose.on('click', '.close', function(event) {
			event.preventDefault();
			guiderChoose.removeClass('shown');
		});
			
		guiderList.on('click', 'a', function(event) {
			event.preventDefault();
			$('.guiderlist a').removeClass('selected');
			$(this).addClass('selected');
			
		});
		
		guiderChoose.on('click', '.confirm', function(event) {
			var $a=$(".guiderlist a.selected");
			if(!$a[0]){
				alert("请选择相应的导购");return;
			}
			var guideId=$a.attr("guideId");
			var guideName=$a.attr("guideName");
			event.preventDefault();
			var html="为您推荐另一位来自于 "+storeName+" 的资深导购 <a href='customerChat.html?guideId="+guideId+"'>"+guideName+" [开始咨询]</a>";
			chat.sendHtml(html,this);
			guiderChoose.removeClass('shown');
		});
		
		
	});	
</script>
</body>
</html>