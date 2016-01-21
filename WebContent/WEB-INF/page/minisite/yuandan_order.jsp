<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>吉盛伟邦迎新大促订单提交系统</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<link rel="apple-touch-icon" href="apple-touch-icon.png">
<link rel="stylesheet" href="css/fonts.css">
<link rel="stylesheet" href="css/main.css">
<style>
#orderjswb header {
	position: fixed;
	left: 0px;
	right: 0px;
	top: 0px;
	z-index: 10;
}

#orderjswb .formarea {
	margin: 0px 0%;
	margin-top: 110px;
	padding-top: 30px;
	position: relative;
	padding-bottom: 55px;
	background-image: url('images/jswb2016/orderjswb_bg.jpg');
	background-size: cover;
	background-position: center;
	overflow-y: auto;
	-webkit-overflow-scrolling: touch;
}

#orderjswb .bottombar {
	background-color: white;
	padding: 0px;
	text-align: center;
}

#orderjswb .bottombar img {
	display: inline-block;
	width: 60%;
}

.outline {
	position: relative;
	background: rgba(0, 0, 0, 0.1);
	box-shadow: inset 1px 1px 0 rgba(0, 0, 0, 0.1);
	padding: 5px;
	border-radius: 5px;
	margin: auto;
	margin-bottom: 8px;
}

.outline i {
	position: absolute;
	left: 0px;
	top: 0px;
	display: inline-block;
	width: 38px;
	text-align: center;
	font-size: 20px;
	line-height: 20px;
	margin: 8px;
	margin-top: 13px;
	margin-left: 5px;
	padding: 4px 8px 3px 8px;
	border-right: 1px solid #444;
	color: #444;
}

.noticeinfo {
	padding: 10px;
	color: white;
	font-size: 12px;
	background-color: rgba(0, 0, 0, 0.7);
	border-radius: 3px;
	margin: 0px 4px;
	margin-bottom: 10px;
}

#orderjswb input,#orderjswb select {
	-webkit-appearance: none;
	border-radius: 0;
	box-shadow: 1px 1px rgba(0, 0, 0, 0.1), -1px 1px rgba(0, 0, 0, 0.1), 0 0
		1px 1px rgba(0, 0, 0, 0.1);
	background-color: rgba(255, 255, 255, 0.9) !important;
	margin: 0px;
	border-radius: 3px;
	width: 100%;
	border: 0px;
	height: 45px;
	font-size: 17px;
	line-height: 17px;
	padding: 5px 10px;
	color: #444;
	padding-left: 45px;
}

#orderjswb label {
	background-color: rgba(255, 255, 255, 0.9) !important;
	border-radius: 3px;
}

.orderinfo {
	background-color: #DA2531;
	color: white;
	border-radius: 3px;
	text-align: center;
	font-weight: bold;
	padding: 10px;
	font-size: 18px;
	margin: 20px 4px 8px 4px;
}

.final {
	padding: 5px;
}

.total {
	font-size: 28px;
}

#orderjswb .submit {
	margin: 0px 4px;
}

#orderjswb .bttn_full {
	background-color: #DA2531;
	font-size: 20px;
	border-bottom: 2px solid #C2212C;
}
</style>
</head>
<body class="bg_white with_bottombar" id="orderjswb">
	<header>
		<img src="images/jswb2016/orderjswb_head.png" alt="">
	</header>
	<div class="formarea pad_narrow withicon">


		<div class="orderinfo">返利门店 吉盛伟邦国际家具村</div>

		<div class="outline">
			<i class="icon-user"></i> <input type="text" name="name"
				id="username" maxlength="10" placeholder="姓名">
		</div>
		<div class="outline">
			<i class="icon-iphone"></i> <input type="text" name="phone"
				id="phone" maxlength="11" placeholder="手机号">
		</div>
		<div class="outline">
			<i class="icon-calendar"></i> <select name="date" id="buyDate">
				<option value="0">请选择订单日期</option>
				<option value="2015-01-01">1月1日</option>
				<option value="2015-01-02">1月2日</option>
				<option value="2015-01-03">1月3日</option>
			</select>

		</div>

		<div class="orderinfo">返利比例：2%</div>

		<div class="outline">
			<i class="icon-coin-yen"></i> <input type="number" name="amount"
				id="fare" placeholder="消费金额／元">
		</div>
		<div class="outline">
			<i class="icon-credit-card"></i> <input type="number" name="paid"
				id="hasPay" placeholder="已付金额／元">
		</div>

		<div class="orderinfo final">
			返利金额 <span class="total" id="hasPay_pre">¥0</span>
		</div>

		<div class="outline">
			<label for="orderimg" class="orderimg upload"> <!--   <input type="file" capture="camera" accept="image/*" id="orderimg" /> -->
				<img src="images/jswb2016/orderupload_gray.png" id="orderimg" alt="">
			</label>
		</div>

		<div class="noticeinfo">
			所填手机号，订单日期，订单金额，已付金额等信息需与购买时的订单信息一致，否则将无法通过我们的后台审核</div>

		<div class="submit">
			<button type="submit" id="submitOrder" class="bttn_full">提交订单</button>
		</div>







	</div>



	<div class="bottombar">
		<img src="images/jswb2016/orderlogo.png" alt="">
	</div>







	<!-- <div id="navicon">
		
	</div> -->

	<!-- <div id="navmenu" class="olay_dark">
		
	</div> -->




	<script src="js/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script type="text/javascript" src="../js/layer/layer.js" charset="utf-8"></script>
	<!-- 微信sdk -->
	<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"
		charset="utf-8"></script>
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
     var index;
 	$(document).ajaxStart(function(){
 		index=layer.load();
 	});
 	$(document).ajaxStop(function(){
 		layer.close(index);
 	});
});
	$(document).ready(function() {
		var fileTempId;//照片对象
		var storeId="store1451368718492628";//选定的店铺ID
		$("#orderimg").on("click",function(){
			wx.chooseImage({
			    count: 1, // 默认9
			    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
			    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
			    success: function (res) {
			        var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
					$("#orderimg").get(0).src=localIds[0];
					fileTempId=localIds[0];
			    }
			});
		});
		$("#hasPay").on("blur",function(){
			var hasPay=$(this).val();
				hasPay=parseFloat(hasPay);
			if(hasPay){
				$("#hasPay_pre").html("￥"+(hasPay*0.02).toFixed(2));
			}
		});
		$("#submitOrder").on("click",function(){
			if(!$("#username").val()){
				alert("请填写姓名");
				return;
			}else if(!$("#phone").val()){
				alert("请填写电话号码");
				return;
			}else if(!$("#buyDate").val()||$("#buyDate").val()=="0"){
				alert("请选择购买时间");
				return;
			}else if(!$("#fare").val()){
				alert("请填写消费金额");
				return;
			}else if(!$("#hasPay").val()){
				alert("请填写已付金额");
				return;
			}else if(eval($("#hasPay").val()+"-"+$("#fare").val())>0){
				alert("消费金额不能大于已付金额");
				return;
			}else if(!fileTempId){
				alert("请上传订单图片");
				return;
			}else{
				 var reg = /^1[3|4|5|8|7][0-9]\d{8}$/;
		 		 if(!reg.test($.trim($("#phone").val()))){
		 			alert("手机号码有误！");
		 			return;
		 		 }
			}
			$("#submitOrder").attr("disabled","disabled");
			//上传图片到微信服务器
			wx.uploadImage({
			    localId: fileTempId, // 需要上传的图片的本地ID，由chooseImage接口获得
			    isShowProgressTips: 1, // 默认为1，显示进度提示
			    success: function (res) {
			        var param={};
			        param.cacheTag=new Date();
			        param.wechatImgId=res.serverId;
			        param.buyDate=$("#buyDate").val();
			        param.username=$("#username").val();
			        param.phone=$("#phone").val();
			        param.storeId=storeId;
			        param.fare=$("#fare").val();
			        param.hasPay=$("#hasPay").val();
			   
			        //返利方式为红包支付
			        param.backType="0";
					$("#submitOrder").attr("disabled","disabled");
					$.post("saveOrder.html?"
							,param,function(json){
							if(json.status=="1"){//提交成功
								alert("订单上传成功！");
								window.location.reload();
							}else if(json.status=="0"){
								alert("订单上传失败！");
							}
						},"json");
			    }
			});
		});
		});
</script>
</body>
</html>