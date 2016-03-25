<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>佣金记录</title>
     <meta name="viewport" content="width=321">
     <meta name="format-detection" content="telephone=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="bg_white with_topbar">
		<div class="topbar bar_red navback">
			<a href="center.html"><i class="icon-arrow-left"></i>  返回个人中心</a>
			<div class="getlogo"><a href="http://guide.51getmore.cn"><img src="images/cathead.svg"></a></div>
		</div>
		<div id="rebateslist" class="wrap">
			<div class="tabs">
				<ul>
					<li class="active inprogress"><span>返利中</span></li>
					<li class="done"><span>已完成</span></li>
				</ul>
			</div>
			<div class="tabcontents">
				<ul class="anime active" id="inprogress">
					
					<c:forEach items="${pageResult.param}" var="temp">
					<c:if test="${empty temp.tempId }">
					<c:set var="inprogress" value="true"> </c:set>
					<li>
							<div class="avatar">
								<img src="${temp.headimgurl }" alt="">
							</div>
							<div class="contents">
								<div class="datetime">
									<fmt:formatDate value="${temp.createDate }" pattern="yyyy年MM月dd日"/>
								</div>
								<div class="nickname">
								${temp.nickname } <span>订单金额: <strong>
								<fmt:formatNumber value="${temp.hasPay }" type="currency" ></fmt:formatNumber>
								
								</strong></span>
								</div>
								<div class="brief">
									<span>比例: <strong><fmt:formatNumber value="${channel.rate*100 }" maxFractionDigits="2"></fmt:formatNumber>%</strong></span>
									<span>佣金: <strong> <fmt:formatNumber value="${channel.rate*temp.hasPay }"  type="currency" maxFractionDigits="2"></fmt:formatNumber></strong></span> 
									<span class="status">
									<c:choose>
										<c:when test="${temp.status=='1' }">
											凯特猫审核中
										</c:when>
										<c:when test="${temp.status=='2' }">
											品牌审核中
										</c:when>
										<c:when test="${temp.status=='2.5' }">
											凯特猫返利中
										</c:when>
										<c:when test="${temp.status=='4' }">
											审核退回
										</c:when>
										<c:when test="${temp.status=='3'&&empty temp.tempId }">
											渠道佣金结算中
										</c:when>
										<c:otherwise>
											佣金已结算
										</c:otherwise>
									</c:choose>
								</span>
								</div>
							
							</div>
					</li>
						</c:if>
						</c:forEach>
						<c:if test="${empty inprogress }">
						<div class="nocontents">
						<div class="icon">
						<i class="icon-repeat"></i>
						</div>
						<div class="info">暂无推荐客户有返利</div>
					</div>
						</c:if>
				</ul>
				
				<ul class="anime" id="done">
				<c:forEach items="${pageResult.param}" var="temp">
					<c:if test="${! empty temp.tempId }">
					<c:set var="done" value="true"></c:set>
					<li>
							<div class="avatar">
								<img src="${temp.headimgurl }" alt="">
							</div>
							<div class="contents">
								<div class="datetime">
									<fmt:formatDate value="${temp.createDate }" pattern="yyyy年MM月dd日"/>
								</div>
								<div class="nickname">
								${temp.nickname } <span>订单金额: <strong>
								<fmt:formatNumber value="${temp.hasPay }" type="currency" ></fmt:formatNumber>
								
								</strong></span>
								</div>
								<div class="brief">
									<span>比例: <strong><fmt:formatNumber value="${channel.rate*100 }" maxFractionDigits="2"></fmt:formatNumber>%</strong></span>
									<span>佣金: <strong> <fmt:formatNumber value="${channel.rate*temp.hasPay }"  type="currency" maxFractionDigits="2"></fmt:formatNumber></strong></span> 
									<span class="status">
									<c:choose>
										<c:when test="${temp.status=='6' }">
											退货
										</c:when>
										<c:otherwise>
											已返佣金
										</c:otherwise>
									</c:choose>
								</span>
								</div>
							
							</div>
					</li>
						</c:if>
						</c:forEach>
						<c:if test="${empty done }">
							<div class="nocontents">
						<div class="icon">
						<i class="icon-check2"></i>
						</div>
						<div class="info">暂无已返佣金记录</div>
					</div>
						</c:if>
					</ul>
			</div>
		</div>







<script src="js/jquery.min.js"></script>
<script src="../out/showMenuScript.html?getMoreId=${sessionScope.loginUser.getMoreId }"></script>
<script src="js/main.js"></script>
</body>
</html>

					
