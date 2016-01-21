<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/myTag" prefix="my" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>导购 :: ${guide.name }</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
      <meta name="format-detection" content="telephone=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="bg_white with_topbar">
	<input type="hidden" id="toId" value="${toId }"/>
	<input type="hidden" id="pageSize" value="${pageSize }"/>
	<input type="hidden" id="pageIndex" value="${pageIndex }"/>
	<input type="hidden" id="totalPage" value="${totalPage }"/>
		<div class="topbar bar_red navback">
			<a href="guide.html"><i class="icon-arrow-left"></i>  返回个人中心 </a>
		</div>
		<div id="chatui">
		<ul class="chatarea" id="talking-container">
			<!-- <li>
				<span class="avatar">
					<img src="images/avatar.jpg">
				</span>
					
				<span class="bubble b_left">
					请问有没有可以。<br>
					You can manage your dropdown position with the z-index property to bring it to front. Remember that the z-index property works with elements positioned relatively or absolutely. Also, is not correct semantically speaking to use a table to achieve layout results.
				</span>
				<div class="datetime">2016-01-03 23:30</div>
			</li>

			<li class="alt">
				
					
				<span class="bubble b_right">
					<img src="images/image.jpg">
				</span>
				<span class="avatar">
					<img src="images/avatar2.jpg">
				</span>
				<div class="datetime">今天 9:32</div>
			</li>


			<li>
				<span class="avatar">
					<img src="images/avatar.jpg">
				</span>
					
				<span class="bubble b_left">
					最近有没有优惠呢？
				</span>
				<div class="datetime">今天 10:32</div>

			</li>

			<li class="alt">
				
					
				<span class="bubble b_right">
					15号－16号我们在家具村有一场活动，会有比较有力的折扣呢
				</span>
				<span class="avatar">
					<img src="images/avatar2.jpg">
				</span>
				<div class="datetime">今天 9:32</div>
				
			</li>

			<li>
				<span class="avatar">
					<img src="images/avatar.jpg">
				</span>
					
				<span class="bubble b_left">
					能不能再多给些同类产品的建议？
				</span>
				<div class="datetime">今天 9:33</div>

			</li> -->


		</ul>
		<div class="tools">
			<div class="input">
				<form action="#" id="talkform">
					<input type="text" id="talk-content" maxlength="200" name="words"> 
					<c:if test="${!empty guide }">
					<i class="icon-circle-plus"></i>
					</c:if>
				</form>
				

			</div>
			<div class="toolbox grid-container hide">
				<div class="row">
					<div class="col-3">
						<div class="add_img item">
							<i class="icon-image"></i>
							<strong>图片</strong>
						</div>
					</div>
					<div class="col-3">
						<div class="add_namecard item">
							<i class="icon-head"></i>
							<strong>名片</strong>
						</div>
					</div>
					<div class="col-3">
						<div class="guide-location item">
							<i class="icon-location2"></i>
							<strong>店铺地址</strong>
						</div>
					</div>

					<div class="col-3">
						<div class="add_normal item">
							<label for="preword" class="preword">
								<i class="icon-bubble"></i>
								<strong>话术</strong>
								<select name="preword" id="preword">
									<option value="您可以到我们门店进一步挑选。">您可以到我们门店进一步挑选。</option>
									<option value="还有什么其他的需要呢？">还有什么其他的需要呢？</option>
									<option value="您大致打算在何时购买？">您大致打算在何时购买？</option>

								</select>
							</label>
							
						</div>
					</div>

				</div>
			</div>
			
		</div>
		
		</div>
	
<!-- 隐藏html -->
<div style="display:none">
	<!-- 导购 -->
	<div id="guide-namecard"><strong>我的名片</strong><br>姓名：${guide.name }<br>所属门店：${guide.brand.brandName }品牌${guide.store.storeName }店<br>电话：${guide.phone }</div>
	<!-- 导购信息 -->
	<div id="guide-location"><strong>${guide.brand.brandName }品牌${guide.store.storeName }店</strong><br>地址：${guide.store.address }${guide.store.doorCode }</div>
</div>




<script src="js/jquery.min.js"></script>
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
	
		
	});	
</script>
</body>
</html>