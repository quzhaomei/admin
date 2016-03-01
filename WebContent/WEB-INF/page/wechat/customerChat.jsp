
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/myTag" prefix="my" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>导购 :: ${toguide.name}</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
      <meta name="format-detection" content="telephone=no">
     <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	 <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	 <META HTTP-EQUIV="Expires" CONTENT="0">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
     <style type="text/css">
     #chatui .chatarea li.li-tips{padding-top:0px 0px 5px 0px;;font-size:12px;color:#ce304e;text-align:center;word-spacing:9px; letter-spacing: 2px;}
     #chatui .chatarea li.li-tips.loadPage{word-spacing:5px; letter-spacing: 1px;text-decoration: underline;}
     .chatnotice a{color:#ce304e}

     </style>
     
</head>
<body class="bg_white with_topbar">
	<input type="hidden" id="imgUrl" value="${imgUrl }"/>

	<input type="hidden" id="toId" value="${toUser.getMoreId }"/>
	<input type="hidden" id="pageSize" value="${pageSize }"/>
	<input type="hidden" id="pageIndex" value="${pageIndex }"/>
	<input type="hidden" id="totalPage" value="${totalPage }"/>
		<div class="topbar bar_red navback">
			<c:choose>
				<c:when test="${empty backUrl }">
					<a href="center.html"><i class="icon-cross"></i></a>
				</c:when>
				<c:otherwise>
					<a href="http://${backUrl }"><i class="icon-cross"></i></a>
				</c:otherwise>
			</c:choose>
			<div class="centertitle">导购 :: ${toguide.name}</div>
			<div class="rightele">
				<i class="icon-users withlabel morechat">
					<!-- <span class="number_chat"></span> -->
				</i>
			</div>
		</div>
		<c:if test="${check==0 }">
			<div class="chatnotice anime_l"><!-- 只能向您主动发送2条信息， -->
			该导购员不是您的品牌专属导购，如需保持联系，请 
			<a href="getGuide.html?guideId=${toguide.guideId }"> <i class="icon-plus"></i>添加TA为您的品牌导购</a>
			</div>
		</c:if>
		<div id="chatui">
		<ul class="chatarea" id="talking-container">

		</ul>
		<div class="tools">
			<div class="input">
				<form action="#" id="talkform">
					<input type="text" style="width:100%;" id="talk-content" maxlength="200" name="words"> 
				</form>
				

			</div>
		</div>
		
		</div>
	



		<div class="chatselect anime">
		<div class="nocontents" style="display:none;">
				<div class="icon">
					<i class="icon-bubble2"></i>
				</div>
				<div class="info">暂无新消息</div>
			</div>
			
			<div class="row">
			</div>

			<div class="close">
				<i class="icon-arrow_drop_up"></i>
			</div>
		</div>
		
		<div class="olay_dark overlay hide"></div>

<script src="js/jquery.min.js"></script>
<script src="../js/socket/socket.io-1.3.4.js"></script>
<script src="../js/socket/p-talk.js"></script>
<script src="js/main.js"></script>
<script src="js/we_chat.js"></script>
<script>
	$(document).ready(function() {
		
		var toolbox = $('.toolbox');
		$('.input').on('focus', 'input', function(event) {
			$('.input i').removeClass('icon-circle-minus');
			toolbox.addClass('hide');
			$('.chatarea').css({
					bottom: '70px'
			});
		});
		$('.input').on('click', 'i', function(event) {
			event.preventDefault();
			$(this).toggleClass('icon-circle-minus');
			toolbox.toggleClass('hide');
			if(toolbox.is(":visible")){
				$('.chatarea').css({
					bottom: '160px'
				});
			} else {
				$('.chatarea').css({
					bottom: '70px'
				});
			}
		});
		
		$('.morechat').on('click', '', function(event) {
			var number=$(this).find("span.number_chat")[0];
			if(!number){//如果有，则显示
				$(".nocontents").show();
			}else{
				$(".nocontents").remove();
			}
			$('.chatselect').toggleClass('shown');
			event.preventDefault();
		});

		$('.chatselect').on('click', '.close', function(event) {
			event.preventDefault();
			$('.chatselect').removeClass('shown');
		});

		if($('.chatnotice')[0]){
			$('.chatnotice').addClass('shown');

			setTimeout(function(){$('.chatnotice').removeClass('shown')}, 5000);
		}
		
	});	
</script>
</body>
</html>