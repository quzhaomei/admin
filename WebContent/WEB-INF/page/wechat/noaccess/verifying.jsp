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
<body class="noaccess gray" id="errorpage">
	
		<div class="icon bg_gray">
			<img src="images/cathead_gray.svg">
		</div>
		<div class="warning">
			您的身份
			<c:choose>
				<c:when test="${sessionScope['roleStatus']==0 }">
					还在审核中
				</c:when>
				<c:when test="${sessionScope['roleStatus']==2 }">
					审核未通过
				</c:when>
			</c:choose>
			<br>
			暂无权限查看该页面
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
			if(time==1){
				clearInterval(task);
				window.location.href="center.html";
			}
		}, 1000);
		
	});
</script>
</body>
</html>