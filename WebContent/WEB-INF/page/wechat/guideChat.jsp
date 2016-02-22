<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/myTag" prefix="my" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>导购 :: ${empty toguide ?guide.name:toguide.name}</title>
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
			<a href="guide.html"><i class="icon-cross"></i></a>
			<div class="centertitle">导购 :: ${empty toguide ?guide.name:toguide.name}</div>
			<div class="rightele">
				<i class="icon-users withlabel morechat">
					<!-- <span class="number_chat"></span> -->
				</i>
			</div>
		</div>
		<c:if test="${not empty toguide&&check==0 }">
			<div class="chatnotice anime_l">
			该导购员不是您的品牌专属导购，只能向您主动发送2条信息，如需进一步咨询，请 
			<span class="addguider" guideId="${toguide.guideId }"> <i class="icon-plus"></i>添加TA为您的品牌导购</span>
			</div>
		</c:if>
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



		<div class="chatselect anime">
			<div class="row">
				<!-- <div class="col-3">
					<a href="">
					<img src="images/avatar.jpg" alt="">
					<span>王二麻子</span>
					<span class="count">
						3
					</span>
					</a>
				</div> -->
			</div>

			<div class="close">
				<i class="icon-arrow_drop_up"></i>
			</div>
		</div>


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
			var number=$(this).find("span.number_chat").text();
			if(number&&number.match(/^\d+$/)){
				number=parseInt(number, "10");
				if(number>0){//如果有，则显示
				event.preventDefault();
				$('.chatselect').toggleClass('shown');
				}
			}
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