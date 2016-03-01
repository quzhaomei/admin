
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>权限出错提示</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="noaccess" id="errorpage">
	
		<div class="icon bg_gray">
			<img src="images/logo_cat.png" alt="">
		</div>
		<div class="warning">
			您不是<strong>
			<c:choose>
				<c:when test="${role=='normal' }">
					导购员
				</c:when>
				<c:when test="${role=='guide' }">
					导购
				</c:when>
				<c:when test="${role=='channel' }">
					渠道商
				</c:when>
			</c:choose>
			</strong><br>无权查看该页面
		</div>

		<a href="center.html" class="redirect">返回个人中心<span class="time">5</span></a>
<script src="js/jquery.min.js"></script>
<script src="js/main.js"></script>
<script type="text/javascript">
	$(function(){
		var time=5;
		var task=setInterval(function(){
			time--;
			$(".time").text(time);
			if(time==0){
				clearInterval(task);
				window.location.href="center.html";
			}
		}, 1000);
		
	});
</script>
</body>
</html>