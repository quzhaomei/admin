<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
 %>
<!DOCTYPE html>
<html lang="en">

    <head>
	
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0"/> 
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	

        <link href="minisite/css/icons/fontawesome/font-awesome.min.css" rel="stylesheet" />
		
		<!-- CSS Files -->
		
		<link href="minisite/js/jquery.bxslider/jquery.bxslider.css" rel="stylesheet" />
		<link href="minisite/js/jquery.master/masterslider.css" rel="stylesheet" />
		<link href="minisite/js/jquery.magnificpopup/jquery.magnificpopup.css" rel="stylesheet" />
		<link href="minisite/js/jquery.master/style.css" rel="stylesheet" />
		
		
        <link href="minisite/css/grid.css" rel="stylesheet" />
        <link href="minisite/css/base.css" rel="stylesheet" />
        <link href="minisite/css/style.css" rel="stylesheet" />

        <title>GETMORE 凯特猫</title>
		<link rel="shortcut icon" href="minisite/images/nologo.png">
    </head>

    <body class="onepage">
       
			<!-- Navigation -->
	   
			<div class="ewf-full-width-section nospacing nav-height">
			
				<div class="ewf-row wrapper-nav">
					
					<div class="ewf-row">
						
						<div id="navigation">
							
							<div class="ewf-row">
								
								<div class="ewf-span3">
									
									<a id="logo" href="index.html"></a>
								
								</div>
								
								<div class="ewf-span9">
								
									<a id="mobile-menu-trigger" class="mobile-menu-closed" href="#">
										<i class="fa fa-bars"></i>
									</a>
									
									<nav>
										<ul id="menu" class="sf-menu sf-js-enabled">
											<li class="active">
												<a href="#getmore">软装返利</a>
											</li>
											<li>
												<a href="http://www.jzpaidan.com/minisite/designApply_to.html">家装设计</a>
											</li>
										</ul>
									</nav>
								
								</div>
								
							</div>
							
						</div>
						
					</div>
					
				</div>
				
			</div>
			
			<!-- Navigation - end -->
			
		
			
			
			<div id="getmore" class="ewf-section-nav">
			
			
			
			<div class="ewf-full-width-section nospacing"> 
			
				<div class="ewf-row section red no-glow">
				
					<div class="ewf-row section-space-100 space-rsp">
							
						<div class="ewf-row">
							
							<div class="ewf-span6 right center">
								
								<img src="minisite/css/images/back-orange-chair.png" alt="" class="chair-block"/>
								
							</div>
							
							<div class="ewf-span6">
							
								<h1 class="big-title">凯特猫会员招募!
								<br /> <strong>买家成交价后再返利<br>全上海100多家门店可返利</strong></h1>
								<p>
											
											<span><i class='fa fa-eye'></i> 关注—关注凯特猫微信即为注册，享受返利政策</span><br>
											
											<span><i class='fa fa-info'></i> 返利品牌—点击<strong>合作品牌</strong>，了解返利信息 </span><br>
											<span><i class='fa fa-shopping-cart'></i> 线下购买—至合作品牌指定门店购买 </span><br>
											<span><i class='fa fa-cloud-upload'></i> 上传订单—点击<strong>提交订单</strong>填写相关信息，了解返利金额 </span><br>
											<span><i class='fa fa-money'></i> 实现返利—审核无误后凯特猫实现返利 </span>
								</p>
								<a href="#contact" class="button dark">立即报名注册</a>
							
							</div>
							
						</div>
						
					</div>
				
				</div>
			
			</div>
			
			<div  id="service"  class="ewf-full-width-section nospacing"> 
			
					<div class="ewf-row section gold section-space-100 space-rsp">
				
					<div class="ewf-row">
						
						<div class="section-title">
							
							<div class="title-section b-space">
								<h1>签约商户信息</h1>
								<h3>...另有更多商家加盟中...</h3>
							</div>
						
								<c:forEach items="${brands }" var="brand" varStatus="statu">
									<c:if test="${statu.index%4==0 }">
											<div class="ewf-row">
										<div class="services-area">
									</c:if>
									<div class="ewf-span3">
										<div class="item-services">
											<img src="${brand.imgPath }" alt="" />
											<h2>${brand.brandName }</h2>
											
											<a href="#" class="button dark" id="${brand.pinying }">商户详情</a>
										</div>
									</div>
									<c:if test="${statu.index%4==3||statu.index%4!=3&&statu.count==fn:length(brands) }">
												</div>
												</div>
									</c:if>
								</c:forEach>
								
							
						
						
						</div>
						
					</div>
				
				
				</div>
			
			</div>
			
			</div>
			
			<!-- About - end -->
			
			
			
			
			
			
			
		
			
			<!-- Footer -->
			
			<div id="contact" class="ewf-section-nav">	
				
			<div class="ewf-full-width-section nospacing"> 
				
				<div class="ewf-row footer section-space-70 space-rsp">
				
					<div class="ewf-row">
						
						<div id="footer" class="fixed">
							
							<div class="ewf-span4">
								
								<div class="info">
									
									<h2>其他联系方式</h2>
									
									
									
									<p><strong>邮件:</strong> <a href="#">info@getmore.com.cn</a></p>
									
									<p><strong>电话:</strong> +86-123-4567-8900</p>
									
									
									
								</div>
								
							</div>
							
							<div class="ewf-span8">
								
								<div class="contact-form">
									<div class="info">
									
									<h2>立刻报名</h2>

									</div>
									<!-- <form action="#" method="post"> -->
										<div class="ewf-row">
											<div class="ewf-span6">
												<input placeholder="姓名" type="text" id="username" maxlength="8"/>
											</div>
											<div class="ewf-span6">
												<input placeholder="手机/电话" id="telphone" type="text" maxlength="11"/>
											</div>
											
										</div>
										<div class="ewf-row">
										<div class="ewf-span12 last">
												
												<select id="buyTime" style="position:absolute;top:5px;width:100%;opacity:0.0;">
													<option value="-1">预计购买时间</option>
													<option value="3个月内">3个月内</option>
													<option value="3-6个月">3-6个月</option>
													<option value="1年内">1年内</option>
												</select>
												<input placeholder="预计购买时间" id="buyTime_input" type="text" />
											</div>
											</div>
										
										
										<div class="text-right">
											<a href="javascript:;" class="button white addBtn">报名注册</a>
										</div>
									<!-- </form> -->
									
								
								</div>
								
							</div>
							
						</div>
						
					</div>
				
				</div>
			
			</div>
			
			<div class="ewf-full-width-section nospacing"> 
				
				<div class="ewf-row cp-area">
				
					<div class="ewf-row">
						
						<div class="copyright-area">
						
							<span>&copy;2014 凯特猫版权所有 <a href="#">GETMORE</a></span>
						<br/>
						<span>备案号：沪ICP备15019371号</span>
						<br/>
						<span>备案号：沪ICP备15019371号-1</span>
						</div>
						
					</div>
				
				</div>
			
			</div>
			
			</div>



			<div class="overlay">
				
			</div>

			<div class="brandinfo">
			<c:forEach items="${brands }" var="brand">
				<div class="${brand.pinying }">
					<table>
					<c:forEach items="${brand.stores }" var="store">
						<tr>
							<th>${store.storeName }</th>
							<td>${store.address }</td>
						</tr>
					 </c:forEach>
					</table>
				</div>
			 </c:forEach>
			
				<i class="fa fa-times closemodal"></i>
			</div>
			
			<!-- Footer - end -->
			
			<!-- Scripts -->
			
			<script type="text/javascript" src="minisite/js/jquery2.1.1.min.js"></script> 
			<script type="text/javascript" src="minisite/js/jquery-ui1.11.0.min.js"></script> 
			<script type="text/javascript" src="minisite/js/waypoints2.0.3.min.js"></script> 
			
			<script type="text/javascript" src="minisite/js/jquery.viewport/jquery.viewport.js"></script>
			<script type="text/javascript" src="minisite/js/jquery.easypiechart/jquery.easypiechart.min.js"></script> 
			<script type="text/javascript" src="minisite/js/jquery.bxslider/jquery.bxslider.js"></script>
			<script type="text/javascript" src="minisite/js/jquery.nav/jquery.nav.js"></script>
			<script type="text/javascript" src="minisite/js/jquery.magnificpopup/jquery.magnificpopup.min.js"></script>
			<script type="text/javascript" src="minisite/js/jquery.counter/jquery.counterup.min.js"></script>
			<script type="text/javascript" src="minisite/js/jquery.master/masterslider.min.js"></script>
			<script type="text/javascript" src="minisite/js/jquery.isotope/imagesloaded.pkgd.min.js"></script>
			<script type="text/javascript" src="minisite/js/jquery.isotope/isotope.pkgd.min.js"></script>
			
			<script src="minisite/js/custom.js"></script>
			
			<script>
				$(document).ready(function(){
					$('#service').on('click', '.button', function(event) {
						event.preventDefault();
						var targetDiv = this.id;
						$('.brandinfo .'+targetDiv).addClass('shown');
						$('.brandinfo').fadeIn();
						$('.overlay').show();
						$('.closemodal').one('click', function(event) {
							$(this).parent('.brandinfo').fadeOut();
							$('.brandinfo .shown').removeClass('shown');
							$('.overlay').hide();
						});

					});
				$("#buyTime").on("change",function(){
					$("#buyTime_input").val($("#buyTime option:selected").text());
				});
				//报名事件绑定
				$(".addBtn").on("click",function(){
					var param={};
					 	param.telphone=$("#telphone").val();
					 	param.username=$("#username").val();
					 	param.buyTime=$("#buyTime").val();
					 	if(!param.username){
					 		alert("用户名不能为空！");
					 		return;
					 	}else if(!$.trim(param.telphone)){
					 		alert("手机号码不能为空！");
					 		return;
					 	}else if(param.buyTime=="-1"){
					 		alert("请选择预计购买时间");
					 		return;
					 	}else{	
					 		 var reg = /^1[3|4|5|8][0-9]\d{8}$/;
					 		 if(!reg.test($.trim(param.telphone))){
					 			 alert("手机号码有误！");
					 			return;
					 		 }
					 	}
					 	alert("报名成功");
					 	window.location.reload();
				});
				});
				
				
			</script>
    </body>
	
</html>

 