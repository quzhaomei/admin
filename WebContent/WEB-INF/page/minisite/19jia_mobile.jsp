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
	<meta name="viewport" content="initial-scale=1, width=device-width, maximum-scale=1, minimum-scale=1, user-scalable=no"> 
	<link href="css/19style.css" rel="stylesheet" type="text/css">

</head>
<body>
	<div class="topstrip">
	<form action="#" method="post" id="nineteen">
		<div class="container">
			<div class="row"><label for="">真实姓名</label><input type="text" name='relName'  maxlength="5" class="realname"></div>
		<div class="row"><label for="">手机号码</label><input type="number" name='phone' class="mobile" maxlength="11" ></div>
		
		<span class="submit nineteenBtn" ><img src="images/submit.png" alt=""></span><span class="text">报名还可享受<br>2%返现</span>
		</div>
	</form>	
	</div>
	<div class="mobileimgs">
		<img src="images/main2_01.png" alt="">
		<img src="images/main2_02.png" alt="">
		<img src="images/main2_03.png" alt="">
		<img src="images/main2_04.png" alt="">
		<img src="images/main2_05.png" alt="">
		<img src="images/main2_06.png" alt="">
		<img src="images/main2_07.jpg" alt="">
		<img src="images/main2_08.jpg" alt="">
		<img src="images/main2_09.jpg" alt="">
		<img src="images/main2_10.jpg" alt="">
		<img src="images/main2_11.jpg" alt="">
		<img src="images/main2_12.png" alt="">
		
	</div>
</body>
<script type="text/javascript" src="minisite/js/jquery2.1.1.min.js"></script>
<script type="text/javascript">
	//nineteen
	(function() {
		$(".nineteenBtn").on("click", function() {
			var relName = $("#nineteen input[name=relName]").val();
			var phone = $("#nineteen input[name=phone]").val();
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
					param.takeBus = 0;
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
