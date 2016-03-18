<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>返利订单记录</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="bg_white with_topbar">
		<div class="topbar bar_red navback">
			<a href="center.html"><i class="icon-arrow-left"></i>  返回个人中心</a>
			<div class="getlogo"><a href="http://guide.51getmore.cn"><img src="images/cathead.svg"></a></div>
		</div>
		<div id="orderlist" class="wrap">
			<div class="tabs">
				<ul>
					<li class="active inprogress"><span>返利中</span></li>
					<li class="done"><span>已完成</span></li>
					<li class="cancel"><span>无效订单</span></li>
				</ul>
			</div>
			<div class="tabcontents">
				<ul class="anime active" id="inprogress">
				 <c:forEach items="${orders }" var="order" varStatus="status">
				 <c:if test="${order.status=='0'||order.status=='1'||order.status=='2'||order.status=='2.5' }">
					 <c:set var="active" value="true"></c:set>
					<li>
							<div class="avatar">
								<img src="${order.brand.imgPath }">
								<i class="icon-file-add"></i>
							</div>
							
							<div class="contents">
								<div class="datetime">
									<fmt:formatDate value="${order.createDate }" pattern="yyyy年	MM月dd日"/>
								</div>
								
								<div class="nickname">
								返利: ¥<fmt:formatNumber value="${order.brand.rate*order.hasPay }"  maxFractionDigits="2"/>
								 <span>订单金额: <strong>¥<fmt:formatNumber value="${order.fare }"  maxFractionDigits="2"/></strong></span>
								</div>

								<div class="brief">
									<span>比例: <strong><fmt:formatNumber value="${order.brand.rate*100 }"  maxFractionDigits="2"/>%</strong></span>
									<span>实付金额: <strong>¥<fmt:formatNumber value="${order.hasPay }"  maxFractionDigits="2"/></strong></span> 
									<span class="status">审核中</span>
								</div>
							
							</div>
						
					</li>
					</c:if>
				 </c:forEach>
				 <c:if test="${empty active }">
				 	<div class="nocontents">
							<div class="icon">
							<i class="icon-repeat"></i>
							</div>
							<div class="info">暂无返利中的订单</div>
						</div>
				 </c:if>
					<!--  li>
							<div class="avatar">
								<img src="images/placeholder.png">
								<i class="icon-file-add"></i>
							</div>
							
							<div class="contents">
								<div class="datetime">
									2015年12月25日
								</div>
								
								<div class="nickname">
								返利: ¥120 <span>订单金额: <strong>¥12,000</strong></span>
								</div>

								<div class="brief">
									<span>比例: <strong>1%</strong></span><span>实付金额: <strong>¥6000</strong></span> <span class="status">审核中</span>
								</div>


								
							
							</div>
						
					</li>
					<li>
							<div class="avatar pending">
								<img src="images/placeholder.png">
								<i class="icon-file-add"></i>
							</div>
							
							<div class="contents">
								<div class="datetime">
									2015年12月25日
								</div>
								
								<div class="nickname">
								返利: ¥120 <span>订单金额: <strong>¥12,000</strong></span>
								</div>

								<div class="brief">
									<span>比例: <strong>1%</strong></span><span>实付金额: <strong>¥6000</strong></span> <span class="status pending">待审核</span>
								</div>


								
							
							</div>
						
						
					</li>
					<li>
							<div class="avatar pending">
								<img src="images/placeholder.png">
								<i class="icon-file-add"></i>
							</div>
							
							<div class="contents">
								<div class="datetime">
									2015年12月25日
								</div>
								
								<div class="nickname">
								返利: ¥120 <span>订单金额: <strong>¥12,000</strong></span>
								</div>

								<div class="brief">
									<span>比例: <strong>1%</strong></span><span>实付金额: <strong>¥6000</strong></span> <span class="status pending">待审核</span>
								</div>


								
							
							</div>
						
						
					</li-->
					
				
				
				</ul>

				<ul class="anime" id="done">
				 <c:forEach items="${orders }" var="order" varStatus="status">
				 <c:if test="${order.status=='3'||order.status=='6' }">
				 <c:set var="done" value="true"></c:set>
				 	<li>
							<div class="avatar">
								<img src="${order.brand.imgPath }">
							</div>
							<div class="contents">
								<div class="datetime">
									<fmt:formatDate value="${order.createDate }" pattern="yyyy年	MM月dd日"/>
								</div>
								<div class="nickname">
								${order.username } <span>订单金额: <strong>¥<fmt:formatNumber value="${order.fare }"  maxFractionDigits="2"/></strong></span>
								</div>
								<div class="brief">
									<span>比例: <strong><fmt:formatNumber value="${order.brand.rate*100 }"  maxFractionDigits="2"/>%</strong></span>
									<span>佣金: <strong>¥<fmt:formatNumber value="${order.brand.rate*order.hasPay }"  maxFractionDigits="2"/></strong></span> 
									<c:choose>
										<c:when test="${order.status==3 }">
											<span class="status">已返佣金</span>
										</c:when>
										<c:when test="${order.status==6 }">
											<span class="status refute">退货</span>
										</c:when>
									</c:choose>
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
							<div class="info">暂无已完成的订单</div>
						</div>
				 </c:if>
					<!--  li>
						
							<div class="avatar">
								<img src="images/avatar.jpg" alt="">
							</div>
							<div class="contents">
								<div class="datetime">
									2015年12月25日
								</div>
								<div class="nickname">
								飞翔的鸟 <span>订单金额: <strong>¥12,000</strong></span>
								</div>
								<div class="brief">
									<span>比例: <strong>1%</strong></span><span>佣金: <strong>¥120</strong></span> <span class="status">已返佣金</span>
								</div>
							
							</div>
						
					</li>
					<li>
							<div class="avatar">
								<img src="images/avatar2.jpg" alt="">
							</div>
							<div class="contents">
								<div class="datetime">
									2015年12月24日
								</div>
								<div class="nickname">
								Claire SUN <span>订单金额: <strong>¥20,000</strong></span>
								</div>
								<div class="brief">
									<span>比例: <strong>1%</strong></span><span>佣金: <strong>¥200</strong></span> <span class="status refute">退货</span>
								</div>
							</div>
						
						
					</li-->
					</ul>
					<ul class="anime" id="cancel">
					 <c:forEach items="${orders }" var="order" varStatus="status">
				 <c:if test="${order.status=='4'}">
				 <c:set var="cancel" value="true"></c:set>
				 	<li>
							<div class="submit_again">
								<a href="toOrder.html">重新提交</a>
							</div>
							<div class="contents">
								<div class="datetime">
									<fmt:formatDate value="${order.createDate }" pattern="yyyy年	MM月dd日"/>
									<span class="brand"><i class="icon-star"></i> ${order.brand.brandName }</span>
								</div>
								
								<div class="reason">
								原因: ${order.info }
								</div>

								<div class="brief">
									<span>订单金额: <strong>¥<fmt:formatNumber value="${order.fare }"  maxFractionDigits="2"/></strong></span>
									<span>返利: <strong>¥<fmt:formatNumber value="${order.brand.rate*order.hasPay }"  maxFractionDigits="2"/></strong></span>
								</div>

							</div>

					</li>
				 </c:if>
				 </c:forEach>
				  <c:if test="${empty cancel }">
				 	<div class="nocontents">
							<div class="icon">
							<i class="icon-file-add"></i>
							</div>
							<div class="info">暂无无效的订单</div>
						</div>
				 </c:if>
				 
					
					<!-- li>
						
							<div class="avatar">
								<img src="images/avatar.jpg" alt="">
							</div>
							<div class="contents">
								<div class="datetime">
									2015年12月25日
								</div>
								<div class="nickname">
								飞翔的鸟 <span>订单金额: <strong>¥12,000</strong></span>
								</div>
								<div class="brief">
									<span>比例: <strong>1%</strong></span><span>佣金: <strong>¥120</strong></span> <span class="status">已返佣金</span>
								</div>
							
							</div>
						
					</li>
					<li>
							<div class="avatar">
								<img src="images/avatar2.jpg" alt="">
							</div>
							<div class="contents">
								<div class="datetime">
									2015年12月24日
								</div>
								<div class="nickname">
								Claire SUN <span>订单金额: <strong>¥20,000</strong></span>
								</div>
								<div class="brief">
									<span>比例: <strong>1%</strong></span><span>佣金: <strong>¥200</strong></span> <span class="status refute">退货</span>
								</div>
							</div>
						
						
					</li-->
					</ul>
			</div>
		</div>







<script src="js/jquery.min.js"></script>
<script src="../out/showMenuScript.html?getMoreId=${sessionScope.loginUser.getMoreId }"></script>
<script src="../js/socket/socket.io-1.3.4.js"></script>
<script src="../js/socket/p-talk.js"></script>
<script src="js/main.js"></script>
</body>
</html>