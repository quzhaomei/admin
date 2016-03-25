<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>推荐人绑定确认</title>
     <meta name="viewport" content="width=321px">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="gray" id="choosepage">
	
		<div class="icon bg_gray">
			<img src="images/logofull.png" alt="凯特猫">
		</div>
		<div class="confirm">
			<span class="hello">欢迎来到<strong>凯特猫家装返利平台</strong></span><br>
			确认 <strong>${channel.userDTO.userName }</strong> 为您的推荐人<br>您将成为凯特猫的用户会员
		</div>
		

		<button type="button" id="getChannel" class="bttn_md bind">是的，成为用户会员</button>

		<div class="divider">
			<span></span>
		</div>

		<div class="otherchoice">
			<div class="info">
				如您想成为<strong>入驻品牌导购</strong>或<strong>特约渠道商</strong>,<br>可从以下入口提交申请
			</div>
			<div class="iconguider">
				<a href="toGuide.html">
				<i class="icon-shop"></i>
				<span>成为品牌导购</span>
				</a>
			</div>
			<div class="icondistri">
				<a href="toChannel.html">
				<i class="icon-megaphone"></i>
				<span>成为渠道商</span>
				</a>
			</div>
			
		</div>
		
		

		

		

	





<script src="js/jquery.min.js"></script>
<script src="js/main.js"></script>
<script>
	jQuery(document).ready(function($) { 
		$('.bind').on('click', '', function(event) {
			$('.steps').addClass('done');
			
		});
		
		$("#getChannel").on("click",function(){
			var param={};
			param.channelCode="${channel.code}";
			$.post("bindCode.html",param,function(json){
				if(json.status==1){
					window.location.href="newbindok.html";
				}
			},"json");
		});
	});
</script>
</body>
</html>