<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>2015吉盛伟邦外贸工厂(上海)联合展销会</title>
<link href="css/19style.css" rel="stylesheet" type="text/css">

<link href="minisite/css/grid.css" rel="stylesheet" />
<link href="minisite/css/style.css" rel="stylesheet" />
<link rel="shortcut icon" href="minisite/images/nologo.png">
<style>
body{
padding:0 0;
margin:0 0;
overflow: auto !important;
}
</style>
</head>
<body>
	
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
												<a href="index.html">凯特猫</a>
											</li>
											<li>
												<a href="index.html">签约商户</a>
											</li>
											<li>
												<a href="index.html">报名注册</a>
											</li>
											<li>
												<a href="19jia.html">精彩活动</a>
											</li>
										</ul>
									</nav>
								
								</div>
								
							</div>
							
						</div>
						
					</div>
					
				</div>
				
			</div>
	
	<div class="imgs">
		<img src="images/main_01.jpg" alt="">
		<img src="images/main_02.jpg" alt="">
		<img src="images/main_03.jpg" alt="">
		<img src="images/main_04.jpg" alt="">
		<img src="images/main_05.jpg" alt="">
		<img src="images/main_06.jpg" alt="">
		<img src="images/main_07.jpg" alt="">
		<img src="images/main_08.jpg" alt="">
		<img src="images/main_09.jpg" alt="">
		<img src="images/main_10.jpg" alt="">
				<img src="images/main2_01.jpg" alt="">

		<img src="images/main2_02.jpg" alt="">

		<img src="images/main2_03.jpg" alt="">

	</div>
	
	
	<div class="bottomstrip">
		<div class="container">
			<form action="#" method="post" id="nineteen">
				<label for="">真实姓名</label>
				<input type="text" name='relName' class="realname" maxlength="5"> 
				<label for="">手机号码</label>
				<input type="text" name='phone' class="mobile" maxlength="11"> 
				是否乘坐班车 <span class="yes"><input type="radio" name="takeBus" value="1">
					是</span> 
					<span class="yes"><input type="radio" name="takeBus" value="0" checked="checked"> 否</span> 
					<span class="submit nineteenBtn"><img src="images/submit.png" alt=""></span>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript" src="minisite/js/jquery2.1.1.min.js"></script>
<script type="text/javascript">
	//nineteen
	(function() {
		$(".nineteenBtn").on("click", function() {
			var relName = $("#nineteen input[name=relName]").val();
			var phone = $("#nineteen input[name=phone]").val();
			var takeBus = $("#nineteen input[name=takeBus]:checked").val();
			var source = "${source}";
			if (!relName) {
				alert("请填写真实姓名");
				return;
			} else if (!phone) {
				alert("请填写手机号");
				return;
			} else {
				var reg = /^1[3|4|5|8][0-9]\d{8}$/;
				if (!reg.test($.trim(phone))) {
					alert("手机号码有误！");
					return;
				}
				var isUse = false;
				$.ajax({
					url : "nineteen.html",
					type : "POST",
					async : false,
					data : {
						"phone" : phone
					},
					dataType : "json",
					success : function(res) {
						if (res.status == "0") {
							alert("手机号已报名");
							isUse = true;
						}
					}
				});
				if (!isUse) {
					var param = {};
					param.phone = phone;
					param.relName = relName;
					param.takeBus = takeBus;
					param.source = source;
					$.ajax({
						url : "nineteen.html",
						type : "POST",
						async : false,
						data : param,
						dataType : "json",
						success : function(res) {
							if (res.status == "1") {
								alert("报名成功");
								window.location.reload();
							}
						}
					});
				}
			}
		});
	})();
</script>
</html>

