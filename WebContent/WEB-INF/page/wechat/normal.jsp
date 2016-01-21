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
				<img src="${wechat.headimgurl }" class="rd">
			</div>
			<div class="info_contents">
				<div class="name">
					${wechat.nickname }
				</div>
				<div class="gm_number">
					<strong>凯特号:</strong> ${wechat.getMoreId }
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
				<a href="order.html"><i class="icon-file-add"></i> 提交订单 </a>
			</div>
			<div class="listitem arrowright">
				<a href="my_rebates_c.html"><i class="icon-wallet"></i> 返利订单记录 <span class="label label_red">10</span></a>
			</div>
		
		</div>

		<div class="title">
				<span class="divider">
					
				</span>
		</div>

		<div class="listset">
			
			
			<div class="listitem arrowright">
				<a href="my_guiders.html"><i class="icon-users"></i> 我的导购 <span class="label label_red">3</span></a>
			</div>

			<div class="listitem arrowright">
				<a href="my_needs.html"><i class="icon-bubble2"></i> 需求及咨询 <span class="label label_gray">10</span></a>
			</div>

			<div class="listitem arrowright">
				<a href="my_fav.html"><i class="icon-heart4"></i> 我的收藏 </a>
			</div>
			

		</div>

		<div class="title">
				<span class="divider">
					
				</span>
		</div>

		<div class="listset">
			
			<div class="listitem arrowright">
				<a href="perinfo_customer.html"><i class="icon-v-card"></i> 个人资料</a>
			</div>
			<div class="listitem arrowright">
				<a href="my_account.html"><i class="icon-credit-card"></i> 我的账号 <span class="label">2</span></a>
			</div>
			<div class="listitem arrowright">
				<a href=""><i class="icon-lock2"></i> 安全设置</a>
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