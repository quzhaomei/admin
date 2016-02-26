<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>个人中心::普通用户</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
     
</head>
<body>
	<div class="bg_white">
		<div class="mini_info clearfix">
			<div class="avatar">
				<img src="${user.photo}" class="rd">
			</div>
			<div class="info_contents">
				<div class="name">
					${user.userName }
				</div>
				<div class="gm_number">
					<strong>凯特号:</strong> ${user.getMoreId }
				</div>
				<div class="identity">
					<!-- 不同状态请替换不同身份及class，审核通过后class替换为verified，文字改为凯特猫渠道商-->
					<span class="verified">普通用户</span>
				</div>
				
			</div>
		</div>

		<div class="mis_info">
			<div class="rec_number">
				订单数 <span>${orderCount }</span>
			</div>
			<div class="rebate">
				返利总额 <span>
				<fmt:formatNumber value="${totalPay }" maxFractionDigits="2"> </fmt:formatNumber>
				</span>
			</div>
		</div>
		
		<div class="listset">
			
			<div class="listitem arrowright">
				<a href="toOrder.html"><i class="icon-file-add"></i> 提交订单 </a>
			</div>
			<div class="listitem arrowright">
				<a href="myOrders.html"><i class="icon-wallet"></i> 返利订单记录 
				<c:choose>
					<c:when test="${orderCount==0 }">
					<span class="label">${orderCount}</span>
					</c:when>
					<c:otherwise>
					<span class="label label_red">${orderCount}</span>
					</c:otherwise>
				</c:choose>
				</a>
			</div>
		
		</div>

		<div class="title">
				<span class="divider">
					
				</span>
		</div>

		<div class="listset">
			
			
			<div class="listitem arrowright">
				<a href="myGuide.html"><i class="icon-users"></i> 我的导购 
				<c:choose>
					<c:when test="${guides==0 }">
					<span class="label">${guides}</span>
					</c:when>
					<c:otherwise>
					<span class="label label_red">${guides}</span>
					</c:otherwise>
				</c:choose>
				
				</a>
			</div>

			<div class="listitem arrowright">
				<a href="myQuestion.html"><i class="icon-bubble2"></i> 
				需求及咨询 
				<c:choose>
					<c:when test="${questionNum==0 }">
					<span class="label">${talkNum}</span>
					</c:when>
					<c:otherwise>
					<span class="label label_red">${questionNum}</span>
					</c:otherwise>
				</c:choose>
				</a>
			</div>
			<!--  
			<div class="listitem arrowright">
				<a href="my_fav.html"><i class="icon-heart4"></i> 我的收藏 </a>
			</div>-->
			

		</div>

		<div class="title">
				<span class="divider">
					
				</span>
		</div>

		<div class="listset">
			
			<div class="listitem arrowright">
				<a href="myInfo.html"><i class="icon-v-card"></i> 个人资料</a>
			</div>
			<div class="listitem arrowright">
				<a href="channelAccount.html"><i class="icon-credit-card"></i> 我的账号 
				<c:choose>
					<c:when test="${cards==0 }">
					<span class="label">${cards}</span>
					</c:when>
					<c:otherwise>
					<span class="label label_red">${cards}</span>
					</c:otherwise>
				</c:choose>
				</a>
			</div>
		<!--  	<div class="listitem arrowright">
				<a href=""><i class="icon-lock2"></i> 安全设置</a>
			</div>-->

	
		</div>


	</div>


	<!--  <div class="navbttn">
		<i class="icon-plus"></i>
	</div>-->

<script src="js/jquery.min.js"></script>

<script src="js/main.js"></script>
</body>
</html>