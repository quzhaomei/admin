
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>推荐人绑定成功</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="gray" id="successpage">
	
		<div class="icon bg_gray">
			<img src="${channel.userDTO.photo }" alt="">
		</div>

		<div class="steps">
		<div class="stepone anime">
			<div class="confirm">
			确认<strong >${channel.userDTO.userName }</strong><br>为您的绑定推荐人

			</div>
			<button class="bttn_md bind">是的，TA是我的推荐人</button>
		</div>




		<div class="steptwo anime">
			<div class="warning">
				您已和<strong >${channel.userDTO.userName }</strong><br>建立了推荐绑定关系
			</div>

			<a href="center.html" class="redirect">返回个人中心<span class="time">5</span></a>
		</div>
		</div>

<script src="js/jquery.min.js"></script>
<script src="js/main.js"></script>
<script>
	jQuery(document).ready(function($) { 
		$('.bind').on('click', '', function(event) {
			var channelCode="${channel.code}";
			var param={};
			param.channelCode=channelCode;
			if(channelCode){
				$.post("bindCode.html",param,function(json){
					if(json.status!="1"){
						$(".warning").text(json.message);
						}
						$('.steps').addClass('done');
						var time=5;
						var task=setInterval(function(){
							time--;
							$(".time").text(time);
							if(time==1){
								clearInterval(task);
								window.location.href="center.html";
							}
						}, 1000);
				},"json");
			}
		});


	});
</script>
</body>
</html>