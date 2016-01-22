<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/myTag" prefix="my" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>导购记录</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="bg_white with_topbar">
	
		<div class="topbar bar_red navback">
			<a href="guide.html"><i class="icon-arrow-left"></i>  返回个人中心 </a>
		</div>

		
		<div class="listset" id="friendslist">
			<c:forEach items="${guideHistory }" var="history">
			<div class="listitem clearfix">
				<div class="avatar left">
					<a href="chat.html"><img src="images/avatar.jpg"></a>
				</div>
				<div class="contents right">
					<div class="basicinfo">
						<span class="nickname">李莫愁</span>
						<span class="customer"><i class="icon-heart4"></i></span>
						<span class="chat"><a href="chat.html">新问询: 5</a></span>
					</div>
					<div class="extendinfo">
						<span class="lasttime">
							<i class="icon-clock4"></i> 最近更新: 2016-01-22 10:35</a>
						</span>
					</div>
				</div>
			</div>
			</c:forEach>
			


			<!--  div class="listitem clearfix">
				<div class="avatar left">
					<a href="chat.html"><img src="images/avatar.jpg"></a>
				</div>
				<div class="contents right">
					<div class="basicinfo">
						<span class="nickname">王二麻子</span>
						<span class="chat"><a href="chat.html">新问询: 5</a></span>
					</div>
					<div class="extendinfo">
						<span class="lasttime">
							<i class="icon-clock4"></i> 最近更新: 2016-01-22 10:35</a>
						</span>
					</div>
				</div>
			</div>

			<div class="listitem clearfix">
				<div class="avatar left">
					<a href="chat.html"><img src="images/avatar2.jpg"></a>
				</div>
				<div class="contents right">
					<div class="basicinfo">
						<span class="nickname">李莫愁</span>
						<span class="customer"><i class="icon-heart4"></i></span>
						<span class="chat nonew"><a href="chat.html">历史消息</a></span>
					</div>
					<div class="extendinfo">
						<span class="lasttime">
							<i class="icon-clock4"></i> 最近更新: 2016-01-22 10:35</a>
						</span>
					</div>
				</div>
				
			</div-->
			

		</div>

	






<script src="js/jquery.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>