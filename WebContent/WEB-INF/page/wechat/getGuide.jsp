<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>添加导购 :: 导购信息</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="guider with_bottombar" id="personalinfo">
	<div class="bg_white">
		<div class="mini_info clearfix">
			<div class="avatar">
				<img src="${user.photo }" class="rd">
			</div>
			<div class="info_contents">
				<div class="name">
					 ${guide.name } <span class="fav"><i class="icon-heart4"></i> ${customNum }</span>
				</div>
				<div class="gm_number">
					<strong>凯特号:</strong> ${user.getMoreId }
				</div>
				<div class="identity">
					<!-- 不同状态请替换不同身份及class，审核通过后class替换为verified，文字改为xx品牌导购员／如导购同时为店长，文字改为xx品牌xx店店长-->
					<c:choose>
						<c:when test="${guide.job=='店长' }">
							<c:set var="nick" value="${guide.brand.brandName } ${guide.store.storeName } 店长"> </c:set>
						</c:when>
						<c:otherwise>
							<c:set var="nick" value="${guide.brand.brandName }导购员"></c:set>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${guide.status==0 }">
							<span class="verifing">${nick }</span>
						</c:when>
						<c:when test="${guide.status==1 }">
							<span class="verified">${nick }</span>
						</c:when>
					</c:choose>
					
					
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
			
			<div class="listitem">
				<div class="nolink"><i class="icon-user"></i>姓名 <span class="right info">${guide.name }</span></div>
			</div>
			<div class="listitem">
				<div class="nolink"><i class="icon-male"></i>性别 <span class="right info">${guide.sex==0?'女':'男' }</span></div>
			</div>
			<div class="listitem">
				<a href="tel:${guide.phone }"><i class="icon-iphone"></i>手机号 <span class="right info">${guide.phone }</span></a>
			</div>
			<div class="listitem">
				<a href="#"><i class="icon-star"></i>所属品牌 <span class="right info">${guide.brand.brandName }</span></a>
			</div>
			<div class="listitem">
				<a href="#"><i class="icon-shop"></i>品牌门店 <span class="right info">${guide.store.storeName }</span></a>
			</div>

			<div class="listitem">
				<a href="#"><i class="icon-user-tie"></i>店内职位 <span class="right info">${guide.job }</span></a>
			</div>
			
		</div>

		
		

		
		
	</div>
	<c:if test="${count==0 }">
		<div class="bottombar bg_grayl">
			<button type="button" guideId="${guide.guideId }" class="addguider bttn_full">确认添加TA为我的导购</button>
		</div>
	</c:if>
	<c:if test="${count>0 ">
		<div class="bottombar bg_grayl">
			<button type="button" guideId="${guide.guideId }" class="toguider bttn_full">联系该导购</button>
		</div>
	</c:if>



<script src="js/jquery.min.js"></script>
<script src="js/main.js"></script>
<script src="../out/showMenuScript.html?getMoreId=${sessionScope.loginUser.getMoreId }"></script>
<script type="text/javascript">
$(function(){
	$(".addguider").on("click",function(){
		var guideId=$(this).attr("guideId");
		var param={};
		param.guideId=guideId;
		$(this).attr("disabled","disabled");
		$.post("getSaveGuide.html",param,function(json){
			if(json.status==1){
				alert(json.message);
				window.location.href="customerChat.html?guideId="+guideId;
			}else{
				alert(json.message);
			}
			
		},"json");
	});
	
	$(".toguider").on(function(){
		var guideId=$(this).attr("guideId");
		window.location.href="customerChat.html?guideId="+guideId;
	});
	
	
});
</script>
</body>
</html>