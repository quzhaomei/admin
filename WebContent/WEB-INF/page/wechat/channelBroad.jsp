<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>好友推荐</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <meta name="format-detection" content="telephone=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body>
	<div class="bg_red with_topbar" id="rec_code">
		<div class="topbar bar_red navback">
			<a href="center.html"><i class="icon-arrow-left"></i> 返回个人中心</a>
			<div class="getlogo"><a href="http://guide.51getmore.cn"><img src="images/cathead.svg"></a></div>
		</div>
		<div class="qrcode pad_narrow">
			<h2>
			二维码分享
			<span class="eng">Share with qrcode</span>
			</h2>
			<div class="img">
				<img src="getCode.html?code=${channel.code }" style="width:100%;"/>
			</div>
		</div>
		<div class="divider">
			<span></span>
		</div>
		<div class="code pad_narrow">
			<h2>
			您的邀请码
			<span class="eng">Your Invitation Code</span>
			</h2>
			
			<span class="code_num">${channel.code }</span>
		</div>
		
		<div class="notice">
				<div class="info">
					您可以通过以下方式将凯特猫返利平台推荐给您的朋友或客户，对方成功关注凯特猫后，他所有在凯特猫平台获得返利的订单，您都将得到订单金额相关比例的佣金
				</div>
				<ul>
					<li>直接在该页面选择微信分享，分享给您的微信好友或微信朋友圈</li>
					<li>线下扫描二维码，关注凯特猫平台</li>
					<li>将邀请码发给已经关注过凯特猫的朋友或客户，让他们在个人中心的推荐人页面填写</li>
				</ul>
			</div>

	</div>





<script src="js/jquery.min.js"></script>
<script src="../out/showMenuScript.html?getMoreId=${sessionScope.loginUser.getMoreId }"></script>
<script src="js/main.js"></script>
</body>
</html>