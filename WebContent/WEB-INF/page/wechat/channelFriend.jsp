<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>我的推荐好友</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <meta name="format-detection" content="telephone=no">
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
		<c:if test="${empty weList }">
			<div class="nocontents">
						<div class="icon">
						<i class="icon-users"></i>
						</div>
						<div class="info">暂无推荐好友</div>
					</div>
		</c:if>
			<c:forEach items="${weList }" var="temp">
				<div class="listitem">
					<span class="avatar">
					<img src="${temp.headimgurl }" alt=""></span> 
					<span class="nickname">${temp.nickname }</span>
					<c:choose>
						<c:when test="${temp.count==0 }">
						<span class="status noorder">
							未下单
						</span>
						</c:when>
						<c:when test="${temp.count>0 }">
						<span class="status ">
							已下单
						</span>
						</c:when>
					</c:choose>
				</div>
			</c:forEach>
		</div>

<script src="js/jquery.min.js"></script>
<script src="../out/showMenuScript.html?getMoreId=${sessionScope.loginUser.getMoreId }"></script>
<script src="js/main.js"></script>
</body>
</html>