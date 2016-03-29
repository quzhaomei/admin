<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
</body>
</html>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>凯特猫 买家具从返利开始</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="gray" id="choosepage">
		
		<div class="icon bg_gray">
			<img src="images/logofull.png" alt="凯特猫">
		</div>
		<div class="confirm">
			<span class="hello">欢迎来到<strong>凯特猫家装返利平台</strong></span>
		</div>
		

		<button class="bttn_md enter" >开始返利之旅</button>
		<div class="append">您将自动成为平台普通用户</div>

		<div class="divider">
			<span></span>
		</div>

		<div class="otherchoice">
			<div class="info">
				角色身份选择后不能随意改变<br>
				如您想成为<strong>入驻品牌导购</strong>或<strong>特约渠道商</strong>,<br>请从以下入口进入提交申请
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
<script type="text/javascript">
$(function(){
	$(".enter").on("click",function(){
		window.location.href="toNormal.html";
	});
});
</script>
</body>
</html>