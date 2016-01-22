<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>个人中心::导购</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <meta name="format-detection" content="telephone=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="guider">
	<div class="bg_white">
		<div class="mini_info clearfix">
			<div class="avatar">
				<img src="${wechat.headimgurl }" class="rd">
			</div>
			<div class="info_contents">
				<div class="name">
					${wechat.nickname } <span class="fav"><i class="icon-heart4"></i> 23</span>
				</div>
				<div class="gm_number">
					<strong>凯特号:</strong> ${wechat.getMoreId }
				</div>
				<div class="identity">
					<!-- 不同状态请替换不同身份及class，审核通过后class替换为verified，文字改为xx品牌导购员／如导购同时为店长，文字改为xx品牌xx店店长-->
					<span class="${guide.status==1?'verified':'verifing' }">
					品牌导购
					<c:choose>
						<c:when test="${guide.status==0 }">
							审核中
						</c:when>
						<c:when test="${guide.status==1 }">
							审核通过
						</c:when>
						<c:otherwise>
							审核未通过
						</c:otherwise>
					</c:choose>
					</span>
				</div>
				
			</div>
		</div>

		<div class="mis_info">
			<div class="brand">
				品牌 <span>${guide.brand.brandName }</span>
			</div>
			<div class="shop">
				门店 <span>${guide.store.storeName }</span>
			</div>
		</div>
		
		<div class="listset">
			<div class="listitem arrowright">
				<a href="guideHistory.html"><i class="icon-wallet"></i> 导购记录 
				<span class="label label_red">${talkNum }</span></a>
			</div>
			<div class="listitem arrowright">
				<a href="guideCustom.html"><i class="icon-users"></i> 客户管理 
				<span class="label label_gray">${customNum }</span></a>
			</div>
			

		</div>

		<div class="title">
				<span class="divider">
					
				</span>
		</div>

		<div class="listset">
			
			<div class="listitem arrowright">
				<a href="perinfo_guider.html"><i class="icon-v-card"></i> 个人资料  <span class="info">信息更改后将重新审核</span></a>
			</div>
		</div>


	</div>


	<div class="navbttn">
		<i class="icon-plus"></i>
	</div>

<script src="js/jquery.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>