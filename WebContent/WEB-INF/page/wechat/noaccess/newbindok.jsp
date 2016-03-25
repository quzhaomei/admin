<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>推荐人绑定成功</title>
     <meta name="viewport" content="width=321">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="gray new" id="successpage">
	
		<div class="icon bg_gray">
			<img src="images/logofull.png" alt="">
		</div>

		<div class="warning">
				您好<strong>${sessionScope['loginUser'].userName }</strong><br>欢迎您成为<strong>凯特猫家装返利平台</strong>用户
			</div>
			<a href="center.html" class="redirect">进入个人中心<span class="time">5</span></a>
		

		

		

	





<script src="js/jquery.min.js"></script>
<script src="js/main.js"></script>
<script>
	jQuery(document).ready(function($) { 
		$('.bind').on('click', '', function(event) {
			$('.steps').addClass('done');
			
		});

		var time=5;
		var task=setInterval(function(){
			time--;
			$(".time").text(time);
			if(time==1){
				clearInterval(task);
				window.location.href="center.html";
			}
		}, 1000);

	});
</script>
</body>
</html>
