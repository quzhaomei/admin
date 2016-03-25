<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>个人中心 | 渠道商</title>
     <meta name="viewport" content="width=321">
     <meta name="format-detection" content="telephone=no">
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
					 ${channel.name }
				</div>
				<div class="gm_number">
					<strong>凯特号:</strong> ${user.getMoreId }
				</div>
				<div class="identity">
					<!-- 不同状态请替换不同身份及class，审核通过后class替换为verified，文字改为凯特猫渠道商-->
					
					<c:choose>
						<c:when test="${channel.status==0 }">
							<span class="verifing">凯特猫渠道商 审核中</span>
						</c:when>
						<c:when test="${channel.status==1 }">
							<span class="verified">凯特猫渠道商</span>
						</c:when>
						<c:otherwise>
							<span class="verifing">凯特猫渠道商 审核退回</span>
						</c:otherwise>
					</c:choose>
					
				</div>
				
			</div>
		</div>

		<div class="mis_info">
			<div class="rec_number">
				已推荐人数 <span>${empty peoples?0:peoples }</span>
			</div>
			<div class="rebate">
				返利总额 <span>
				<c:if test="${ empty channel.totalPay }">
					0
				</c:if>
				<fmt:formatNumber value="${channel.totalPay }" maxFractionDigits="2"> </fmt:formatNumber>
				 </span>
			</div>
		</div>
		
		<div class="listset">
			
			<div class="listitem">
				<a href="${channel.status==1?'channelBroad.html':'#' }"><i class="icon-thumbs-o-up"></i> 推荐给好友 </a>
			</div>
			<div class="listitem">
				<a href="${channel.status==1?'channelHistory.html':'#' }"><i class="icon-wallet"></i> 佣金记录 
						<span class="label label_gray">${total }</span>
				</a>
			</div>
				<div class="listitem">
				<a href="${channel.status==1?'channelFriend.html':'#' }"><i class="icon-users"></i> 我的推荐好友 
						<span class="label label_gray">${count }</span>
				</a>
			</div>

		</div>

		<div class="title">
				<span class="divider">
					
				</span>
		</div>

		<div class="listset">
			
			<div class="listitem">
				<a href="channelInfo.html"><i class="icon-user2"></i> 个人资料  <span class="info">信息更改后将重新审核</span></a>
			</div>
			<div class="listitem">
				<a href="channelAccount.html"><i class="icon-credit-card"></i> 
				我的账号 
						<span class="label label_gray">${accounts }</span>
				</a>
			</div>
			<!--  <div class="listitem">
				<a href="#"><i class="icon-lock2"></i> 安全设置</a>
			</div>-->
			

		</div>


	</div>
	



<script src="js/jquery.min.js"></script>
<script src="../out/showMenuScript.html?getMoreId=${sessionScope.loginUser.getMoreId }"></script>
<script src="js/main.js"></script>
</body>
</html>