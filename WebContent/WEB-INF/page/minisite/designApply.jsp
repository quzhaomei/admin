<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/myTag" prefix="my" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>量房申请</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="mini_2/css/fonts.css">
     <link rel="stylesheet" href="mini_2/css/flaticon.css">
     <link rel="stylesheet" href="mini_2/css/main.css">
</head>
<body class="bg_white with_bottombar" id="apply">
	
		<header>
			<img src="mini_2/images/measure/head.jpg">
		</header>
		<div class="feature row">
			<div class="col-4"><i class="flaticon-businessman bg_green"><span class="free">免费</span></i><span>上门量房</span></div>
			<div class="col-4"><i class="flaticon-draft bg_red"><span class="free">免费</span></i><span>家装设计</span></div>
			<div class="col-4"><i class="flaticon-comments bg_orange"></i><span>在线咨询</span></div>
		</div>

		<div class="brandlist pad_10">
			<fieldset class="b_info">

			<h1>
			上海百强装修公司上门服务
			<span class="eng">
				报价透明  设计优秀  项目全程保障 
 
			</span>
			</h1>
			<div class="contents row">
					<div class="col-3"> <img src="mini_2/images/measure/01.jpg"> </div>
					<div class="col-3"><img src="mini_2/images/measure/02.jpg"></div>
					<div class="col-3"><img src="mini_2/images/measure/03.jpg"></div>
					<div class="col-3"><img src="mini_2/images/measure/04.jpg"></div>
					<div class="col-3"><img src="mini_2/images/measure/05.jpg"></div>
					<div class="col-3"><img src="mini_2/images/measure/06.jpg"></div>
					<div class="col-3"><img src="mini_2/images/measure/07.jpg"></div>
			</div>
			</fieldset>
		</div>
		
		
		<div class="formarea pad_narrow apply withicon">
			<fieldset class="b_info">
			<h1>
			免费家装设计申请
			<span class="eng">
				我们已为<strong>100000</strong>名用户提供服务
 
			</span>
			</h1>
			

			<div class="form_row">
				<i class="icon-user"></i>
				<input type="text" name="name" id="username" maxlength="10" placeholder="姓名">
			</div>
		
			
			<div class="form_row">
				<i class="icon-iphone"></i>
				<input type="text" name="tel" id="phone" maxlength="11" placeholder="请输入手机">
			</div>

				<div class="form_row">
				<i class="icon-map"></i>
				<select name="area" id="location">
				<option value="-1">您的所在区域</option>
				<option value="上海">上海</option>
				<option value="北京">北京</option>
				<option value="深圳">深圳</option>
				<option value="广州4">广州</option>
				</select>

			</div>

			<div class="form_row">
				<i class="icon-box"></i>
				<select name="square" id="size">
				<option value="-1">家居面积</option>
				<option value="一房二房">一房二房</option>
				<option value="三房四房">三房四房</option>
				<option value="复式别墅">复式别墅</option>
				</select>

			</div>


			
			</fieldset>


		
			

				
				<div class="notice">我们承诺：凯特猫家装提供该项免费服务，绝不产生任何费用，为了您的利益和我们的口碑，您的隐私我们将严格保密。</div>
				

			<div class="bottombar bg_red">
				 <button type="button" class="bttn_full" id="sub-btn">预约免费设计 领取礼包</button>
			</div>

		</div>


		
			
	


	<!-- <div id="navicon">
		
	</div> -->

	<!-- <div id="navmenu" class="olay_dark">
		
	</div> -->
	



<script src="mini_2/js/jquery.min.js"></script>
<script src="mini_2/js/main.js"></script>
<script>
	$(document).ready(function() {
		$("#sub-btn").on("click",function(){
			var username=$("#username").val();
			var phone=$("#phone").val();
			var location=$("#location").val();
			var size=$("#size").val();
			if(!username){
				alert("请输入您的姓名！");
				return;
			}else if(!phone){
				alert("请输入您的手机号码！");
				return;
			}else if(!/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(phone)){
				alert("请输入正确的手机号码");
				return;
			}else if(location=="-1"){
				alert("请选择您所在的区域！");
				return;
			}else if(size=="-1"){
				alert("请选择您的家居面积")
				return;
			}
			var _this=this;
			$(_this).attr("disabled","disabled");
			var param={};
			param.username=username;
			param.phone=phone;
			param.location=location;
			param.size=size;
			$.post("saveDesignApply.html",param,function(json){
				$(_this).removeAttr("disabled","disabled");
				if(json.status==0){
					alert(json.message);
				}else if(json.status==1){
					alert(json.message);
					window.location.reload();
				}
			},"json");
		});

	});
</script>
</body>
</html>