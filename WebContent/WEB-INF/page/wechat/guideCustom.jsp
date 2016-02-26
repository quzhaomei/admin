<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/myTag" prefix="my" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>我的客户</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <meta name="format-detection" content="telephone=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="bg_white with_topbar">
	
		<div class="topbar bar_red navback">
			<a href="center.html"><i class="icon-arrow-left"></i>  返回个人中心 </a>
		</div>
		<div class="listset" id="friendslist">
			<c:forEach items="${guideCustom }" var="custom">
				<div class="listitem clearfix">
				<div class="avatar left">
					<a href="guideChat.html?toId=${custom.getMoreId}"><img src="${custom.headimgurl }"></a>
				</div>
				<div class="contents right">
					<div class="basicinfo">
						<span class="nickname">${custom.nickname }</span>
						<c:choose>
							<c:when test="${(empty custom.orderCount)||(custom.orderCount==0) }">
									<span class="ordernum"><i class="icon-file"></i> 未下单</span>
							</c:when>
							<c:otherwise>
								<span class="ordernum"><i class="icon-file"></i> <strong>${custom.orderCount }</strong>单</span>
								<span class="amount"><i class="icon-coin-yen"></i> <strong>
								<fmt:formatNumber value="${custom.totalPay }" maxFractionDigits="2"> </fmt:formatNumber></strong>元</span>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="extendinfo">
					<c:if test="${!empty custom.phone}">
						<span class="phone">
							<c:choose>
								<c:when test="${!empty custom.phone}">
								<i class="icon-iphone"></i> <a href="tel:${custom.phone }" >${custom.phone }</a>
								</c:when>
							</c:choose>
							
						</span>
					</c:if>
						<c:if test="${custom.uncheckCount>0 }">
							<span class="chat"><a href="guideChat.html?toId=${custom.getMoreId}">
							新问询: ${custom.uncheckCount }
							</a></span>
						</c:if>
						<c:if test="${empty custom.uncheckCount||custom.uncheckCount==0 }">
							<span class="chat nonew"><a href="guideChat.html?toId=${custom.getMoreId}">进入导购</a></span>
						</c:if>
					</div>
				</div>
				</div>	
			</c:forEach>
			

			<!-- <div class="listitem clearfix">
				<div class="avatar left">
					<a href="chat.html"><img src="images/avatar2.jpg"></a>
				</div>
				<div class="contents right">
					<div class="basicinfo">
						<span class="nickname">李大海</span>
						<span class="ordernum"><i class="icon-file"></i> 未下单</span>
						
					</div>
					<div class="extendinfo">
						<span class="phone">
							<i class="icon-iphone"></i> <a href="tel:13574562568" >18974562568</a>
						</span>
						<span class="chat nonew"><a href="chat.html">进入导购</a></span>

					</div>	
				</div>
				
			</div> -->
			

		</div>

	






<script src="js/jquery.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>