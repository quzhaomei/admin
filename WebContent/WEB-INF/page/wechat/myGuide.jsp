
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>我的导购</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="bg_white with_topbar">
	
		<div class="topbar bar_red navback">
			<a href="center.html"><i class="icon-arrow-left"></i>  返回个人中心 </a>
			<div class="getlogo"><a href="http://guide.51getmore.cn"><img src="images/cathead.svg"></a></div>
		</div>
		<div class="listset" id="friendslist">
		<c:if test="${empty guides }">
			<div class="nocontents">
						<div class="icon">
						<i class="icon-users"></i>
						</div>
						<div class="info">暂无专属导购</div>
			</div>
		</c:if>
			<c:forEach items="${guides }" var="guide">
				<div class="listitem clearfix">
				<div class="avatar left">
					<a href="customerChat.html?guideId=${guide.guideId}"><img src="${guide.getMoreUser.photo }"></a>
				</div>
				<div class="contents right">
					<div class="basicinfo">
						<span class="nickname">${guide.name }</span>
						<span class="ordernum"><i class="icon-star"></i> ${guide.brand.brandName }</span>
					</div>
					<div class="extendinfo">
						<span class="phone">
				<c:choose>
					<c:when test="${!empty guide.phone }">
						<i class="icon-iphone"></i> <a href="tel:${guide.phone }" >${guide.phone }</a>
					</c:when>
					<c:otherwise>
						<i class="icon-iphone"></i> <a href="#" >暂无</a>
					</c:otherwise>
				</c:choose>
							
						</span>
						<c:if test="${! empty guide.uncheckCount&&guide.uncheckCount!=0  }">
						<span class="chat">
						<a href="customerChat.html?guideId=${guide.guideId}">新: ${guide.uncheckCount }</a>
						</span>
						</c:if>
						
						<c:if test="${ empty guide.uncheckCount||guide.uncheckCount==0  }">
						<span class="chat nonew">
						<a href="customerChat.html?guideId=${guide.guideId}">进入咨询</a>
						</span>
						</c:if>

					</div>
				</div>
				</div>
			</c:forEach>
			
		<!-- 	<div class="listitem clearfix">
				<div class="avatar left">
					<a href="chat.html"><img src="images/avatar.jpg"></a>
				</div>
				<div class="contents right">
					<div class="basicinfo">
						<span class="nickname">王二麻子</span>
						<span class="ordernum"><i class="icon-star"></i> 19家</span>
					</div>
					<div class="extendinfo">
						<span class="phone">
							<i class="icon-iphone"></i> <a href="tel:13574562568" >13574562568</a>
						</span>
						<span class="chat"><a href="chat.html">新回答: 1</a></span>

					</div>
				</div>
			</div>

			<div class="listitem clearfix">
				<div class="avatar left">
					<a href="chat.html"><img src="images/avatar2.jpg"></a>
				</div>
				<div class="contents right">
					<div class="basicinfo">
						<span class="nickname">李大海</span>
						<span class="ordernum"><i class="icon-star"></i> 索菲妮</span>

						
					</div>
					<div class="extendinfo">
						<span class="phone">
							<i class="icon-iphone"></i> <a href="tel:13574562568" >18974562568</a>
						</span>
						<span class="chat nonew"><a href="chat.html">进入咨询</a></span>

					</div>	
				</div>
				
			</div>
			 -->

		</div>

	






<script src="js/jquery.min.js"></script>
<script src="../out/showMenuScript.html?getMoreId=${sessionScope.loginUser.getMoreId }"></script>
<script src="js/main.js"></script>
</body>
</html>