<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- start: Meta -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>后台管理</title>
<!-- end: Meta -->

<!-- start: Mobile Specific -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- end: Mobile Specific -->
<!-- start: CSS -->
<link id="bootstrap-style" href="../css/bootstrap.min.css"
	rel="stylesheet">
<link href="../css/bootstrap-responsive.min.css" rel="stylesheet">
<link id="base-style" href="../css/style.css" rel="stylesheet">
<link id="base-style-responsive" href="../css/style-responsive.css"
	rel="stylesheet">
<!-- end: CSS -->

<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
	  	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<link id="ie-style" href="../css/ie.css" rel="stylesheet">
	<![endif]-->

<!--[if IE 9]>
		<link id="ie9style" href="../css/ie9.css" rel="stylesheet">
	<![endif]-->

<!-- start: 网站logo -->
<link rel="shortcut icon" href="../img/avatar.jpg">
<!-- end: Favicon -->
<style type="text/css">
.logo{
border:1px solid #ddd;
border-radius:10%;
width:60px;
}
.table.table-striped td,th{
vertical-align: middle !important;
text-align:center !important;
}
.addBrand .input-prepend{
margin-bottom: 2px !important;
height:30px !important;
}
.addBrand td{
vertical-align: middle;
}
.add_productImg,.detail_productImg{
padding: 5px 5px;
margin:0 0;
list-style: none;
}

.add_productImg li,.detail_productImg li{
float:left;
padding:5px 5px;
}
.add_productImg img,.detail_productImg img{
width:80px;
border:1px solid #ccc;
border-radius:3px;
}
#logopre img{
width:29px;
}
.add_productImg li:hover{
border:1px solid #aaa;
cursor:pointer;
}
</style>
</head>

<body>
	<!-- start: Header -->
	<div class="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="btn btn-navbar" data-toggle="collapse"
					data-target=".top-nav.nav-collapse,.sidebar-nav.nav-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span> </a> <a class="brand" href="index.html"><span>系统后台管理</span>
				</a>

				<!-- start: 鏍囬鑿滃崟 -->
				<div class="nav-no-collapse header-nav">
					<ul class="nav pull-right">
						<!-- start: User Dropdown -->
						<li class="dropdown"><a class="btn dropdown-toggle"
							data-toggle="dropdown" href="#"> <i
								class="halflings-icon white user"></i> ${sessionScope.user.userName } <span class="caret"></span>
						</a>
							<ul class="dropdown-menu">
								<li class="dropdown-menu-title"><span>操作</span></li>
								<li><a href="#" id="updateUserPsw"><i class="halflings-icon edit"></i>
										修改密码</a>
								</li>
								<li><a href="../login/toLogin.html"><i class="halflings-icon user"></i>
										切换用户</a>
								</li>
								<li><a href="../login/toLogin.html"><i class="halflings-icon off"></i>
										安全退出</a>
								</li>
							</ul></li>
						<!-- end: User Dropdown -->
					</ul>
				</div>
				<!-- end: Header Menu -->

			</div>
		</div>
	</div>
	<!-- start: Header -->

	<div class="container-fluid-full">
		<div class="row-fluid">

			<!-- start: Main Menu -->
			<c:import url="menu_temp.jsp"></c:import>
			<!-- end: Main Menu -->

			<noscript>
				<div class="alert alert-block span10">
					<h4 class="alert-heading">Warning!</h4>
					<p>
						You need to have <a href="http://en.wikipedia.org/wiki/JavaScript"
							target="_blank">JavaScript</a> enabled to use this site.
					</p>
				</div>
			</noscript>

			<!-- start: Content -->
			<div id="content" class="span10">

				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="index.html">首页</a> <i
						class="icon-angle-right"></i></li>
					<li><a href="#">品牌管理 <i class="icon-angle-right"></i> </a>
					</li>
					<li><a href="#">店铺管理</a>
					</li>
				</ul>	
				<div class="row-fluid sortable">
					<!--功能区域-->
					<div class="box span12 store">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon screenshot"></i><span class="break"></span>店铺管理
							</h2>
							<div class="box-icon">
							<c:if test="${permit }">
								<a href="#" class="add"><i
									class="halflings-icon plus"></i> </a>  
								</c:if>	
									<a href="#"
									class="btn-minimize"><i class="halflings-icon chevron-up"></i>
								</a> <a href="#" class="btn-close"><i
									class="halflings-icon remove"></i> </a>
							</div>
						</div>
						
						<!-- 数据展示 -->
						<div class="box-content">
						<!-- table框架 -->
							<table class="table table-striped table-hover table-bordered bootstrap-datatable datatable">
								<thead>
									<tr>
										<td>序列</td>
										<th >商场名称</th>
										<th >品牌名称</th>
										<th >店铺地址</th>
										<th >店长</th>
										<th >店长手机</th>
										<th >店铺状态</th>
										<th >操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${stores}" var="store" varStatus="temp">
									<tr>
										<td style="font-weight:bold;font-size:15px">${temp.count}</td>
										<td>${store.brand.brandName }</td>
										<td>${store.storeName }</td>
										<td>${store.address }</td>
										<td>${store.user.userName }</td>
										<td>${store.user.phone }</td>
										<td>${store.status=="1"?"<span class='label label-success'>激活</span>":
										"<span class='label label-error'>冻结</span>" }</td>
										<td><a class="btn btn-warn btn-mini detail" storeId="${store.storeId  }" href="#"> 
												<i class="halflings-icon white edit"></i> 详 细</a>
												<c:if test="${permit }">
											 <a class="btn btn-success btn-mini update" storeId="${store.storeId  }" href="#"> 
												<i class="halflings-icon white edit"></i> 修 改</a> 
											<a class="btn btn-warn orange  btn-mini changeStatu" storeId="${store.storeId }" status="${store.status }" href="#"> 
												<i class="halflings-icon refresh white"></i>状 态</a>
												</c:if>
												</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					
				</div>	
			</div>
			<!-- end: Content -->
		</div>
		<!--/#content.span10-->
	</div>
	<!--/fluid-row-->
	<!-- 新增 -->
	<div class="modal hide fade" id="myModal" style="width:850px;  margin-left: -450px;">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>店铺管理</h3>
		</div>
		<div class="modal-body">
			<div id="myTabContent" class="tab-content">
				<!-- 修改tab -->
				<div class="tab-pane fade in active text-left" id="edit">
					<p class="text-success">--增加店铺 <small >店长，用户名以及密码均初始化为该用户的手机号码</small></p>
					<table style="width:98%;margin:5px 1%;" >
					<tr>
					<td ><div class="input-prepend" title="店铺名称 ">
					<span class="add-on"><i class="halflings-icon pencil"></i> 商场名称 </span>
					<input class="input-large span2"  type="text"  id="add_storeName" placeholder="请输入店铺名称" maxlength="30" >
					</div></td>
					<td><div class="input-prepend" title="店铺品牌">
					<span class="add-on"><i class="halflings-icon globe"></i> 品牌名称 </span>
					<span style="margin:0px 10px">
					<select class="add_storeSelect" name="add_roleArr" id="add_brandId" data-placeholder="请选择用户角色（可多选）" style="width:100px;">
							<option value="-1">-请选择-</option>
						<c:forEach items="${brands }" var="brand">
							<option value="${brand.brandId }">${brand.brandName }</option>
						</c:forEach>
					</select>
					</span>
					</div></td>
					<td><div class="input-prepend" title="门牌号码">
					<span class="add-on"><i class="halflings-icon pencil"></i> 门牌号码 </span>
					<input class="input-large span2"  type="text"  id="add_doorCode" placeholder="请输入店铺门牌号码" maxlength="30" >
					</div></td>
					</tr>
					<tr>
					<td colspan="3" style="border-bottom:1px solid #ccc;color:#888;padding-top:5px">店长：</td></tr>
					<tr>
					<td><div class="input-prepend" title="店长">
					<span class="add-on"><i class="halflings-icon globe"></i> 电&nbsp;话 </span>
					<input class="input-large span2" id="add_phone" type="text"  placeholder="请输入店长电话" maxlength="11"/>
					<span class="add-on" style="display:none;"> <i class="halflings-icon pencil"></i></span>
					</div></td>
					<td><div class="input-prepend" title="店长">
					<span class="add-on"><i class="halflings-icon globe"></i> 名&nbsp;字 </span>
					<input class="input-large span2" id="add_username" type="text"  placeholder="请输入店长名字" maxlength="5"/>
					</div></td>
					<td><div class="input-prepend" title="店长">
					<span class="add-on"><i class="halflings-icon globe"></i> 微&nbsp;信 </span>
					<input class="input-large span2" id="add_wechatId" type="text"  placeholder="请输入店长微信" maxlength="20"/>
					</div></td>
					</tr>
					<tr>
					<td colspan="3" style="border-bottom:1px solid #ccc;color:#888;padding-top:5px">地址</td></tr>
					<tr>
					<tr><td colspan="3"><div class="input-prepend" title="店铺地址">
					<span class="add-on"><i class="halflings-icon globe"></i> 店铺地址 </span>
					<input class="input-large span5" id="add_address" type="text"  placeholder="请输入店铺地址" maxlength="40"/>
					</div></td>
					</tr>
					<tr>
					<td colspan="3">
					<div style="border:1px solid #aaa;padding:5px 5px;width:98%;height:120px;"  id="add_address_map"  ></div>
					</td>
					</div>
					<tr>
					
					</table>
				
				</div>					
			</div>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">关闭</a> <a href="#"
				class="btn btn-primary addStoreBtn">确认</a>
		</div>
	</div>
	
	<!-- 详细 -->
	<div class="modal hide fade" id="detailModel" style="width:950px;  margin-left: -450px;">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>店铺管理</h3>
		</div>
		<div class="modal-body">
			<div id="myTabContent" class="tab-content">
				<!-- 修改tab -->
				<div class="tab-pane fade in active text-left" id="edit">
					<p class="text-success">--店铺详细 </p>
					<table class="addBrand" style="width:98%;margin:5px 1%;" >
					<tr>
					<td><div class="input-prepend" title="店铺品牌">
					<span class="add-on"><i class="halflings-icon pencil"></i> 商场名称 </span>
					<input class="input-large span2"  type="text"  id="detail_brandName"   readonly="readonly" >
					</div></td>
					<td><div class="input-prepend" title="店铺名称">
					<span class="add-on"><i class="halflings-icon globe"></i> 品牌名称 </span>
					<input class="input-large span2"  type="text"  id="detail_storeName" readonly="readonly" >
					</div></td>
					<td style="width:340px;"><div class="input-prepend" title="展位号">
					<span class="add-on"><i class="halflings-icon globe"></i>展位号  </span>
					<input class="input-large span2"  type="text"  id="detail_doorCode" readonly="readonly" >
					</div></td></tr>
					<tr><td colspan="3" style="border-bottom:1px solid #ccc;color:#888;padding-top:5px">店长：</td></tr>
					<tr>
					<td><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 电&nbsp;话 </span>
					<input class="input-large span2" id="detail_phone" type="text" readonly="readonly"/>
					<span class="add-on" style="display:none;"> <i class="halflings-icon pencil"></i></span>
				
					</div></td>
					<td><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 名&nbsp;字 </span>
					<input class="input-large span2" id="detail_username" type="text"  readonly="readonly"/>
					</div></td>
					<td><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 微&nbsp;信 </span>
					<input class="input-large span2" id="detail_wechatId" type="text"  readonly="readonly"/>
					</div></td>
					</tr>
					<tr><td colspan="3" style="color:#888;padding-top:5px">店铺地址：<span id="detail_address_1"></span></td></tr>
					<tr><td colspan="3">
					<div style="border:1px solid #aaa;padding:5px 5px;width:98%;height:200px;"  id="detail_address"  ></div>
					</div></td>
					
					</table>
				
				</div>					
			</div>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">关闭</a>
		</div>
	</div>
	<!-- 详细 结束-->
	
	<!-- 修改 -->
	<div class="modal hide fade" id="updateModel" style="width:950px;  margin-left: -450px;">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>店铺管理</h3>
		</div>
		<div class="modal-body">
			<div id="myTabContent" class="tab-content">
				<!-- 修改tab -->
				<div class="tab-pane fade in active text-left" id="edit">
					<p class="text-success">--店铺修改 </p>
					<table class="addBrand" style="width:98%;margin:5px 1%;" >
					<tr>
					<td><div class="input-prepend" title="店铺品牌">
					<span class="add-on"><i class="halflings-icon pencil"></i> 商场名称 </span>
					<input class="input-large span2"  type="hidden"  id="update_storeId">
					<span style="margin:0px 10px">
					<select class="add_storeSelect" id="update_brandId" data-placeholder="品牌" style="width:100px;">
						<c:forEach items="${brands }" var="brand">
							<option value="${brand.brandId }">${brand.brandName }</option>
						</c:forEach>
					</select>
					</span>
					</div></td>
					<td><div class="input-prepend" title="店铺名称">
					<span class="add-on"><i class="halflings-icon globe"></i> 品牌名称 </span>
					<input class="input-large span2"  type="text"  id="update_storeName" >
					</div></td>
					<td style="width:340px;"><div class="input-prepend" title="展位号">
					<span class="add-on"><i class="halflings-icon globe"></i>展位号  </span>
					<input class="input-large span2"  type="text"  id="update_doorCode">
					</div></td></tr>
					<tr><td colspan="3" style="border-bottom:1px solid #ccc;color:#888;padding-top:5px">店长：</td></tr>
					<tr>
					<td><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 电&nbsp;话 </span>
					<input  id="update_userId" type="hidden"/>
					<input class="input-large span2" id="update_phone" maxlength="11" type="text"/>
					<span class="add-on" style="display:none;"> <i class="halflings-icon pencil"></i></span>
				
					</div></td>
					<td><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 名&nbsp;字 </span>
					<input class="input-large span2" id="update_username" type="text" maxlength="8" />
					</div></td>
					<td><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 微&nbsp;信 </span>
					<input class="input-large span2" id="update_wechatId" type="text" maxlength="15"/>
					</div></td>
					</tr>
					<tr><td colspan="3" style="color:#888;padding-top:5px">店铺地址：
					<input class="input-large span5" id="update_address" type="text"  placeholder="请输入店铺地址" maxlength="40"/>
					</td></tr>
					<tr><td colspan="3">
					<div style="border:1px solid #aaa;padding:5px 5px;width:98%;height:200px;"  id="update_address_map"  ></div>
					</div></td>
					
					</table>
				
				</div>					
			</div>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">关闭</a>
			 <a href="#" class="btn btn-primary updateStoreBtn">确认</a>
		</div>
	</div>
	<!-- 修改 结束-->
	
	
	<div class="clearfix">
	
	</div>

	<footer>
		<p>
			<span style="text-align:left;float:left">&copy; 2015 <a
				href="http://jiji262.github.io/Bootstrap_Metro_Dashboard/"
				alt="Bootstrap_Metro_Dashboard">quzhaomei@com</a> </span>
		</p>
	</footer>

	<!-- start: JavaScript-->
		<c:import url="javascript.jsp"></c:import>
	<!-- end: JavaScript-->
	<!-- 引入百度地图 -->
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=z4WyBb4Qv0R7MsZNHLNiqRY0"></script>
	
	<script type="text/javascript">
		$(function() {
			$(".store .add").on("click",function(){
				$("#myModal").modal("show");
			});
		});
		$(".add_storeSelect").chosen();
		
	var map;//详细
	var addMap;//增加
	var updateMap;//增加
	(function(){// 百度地图API功能	
		try{
		map = new BMap.Map("detail_address"); // 创建Map实例,设置地图允许的最小/大级别
		map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
		map.enableScrollWheelZoom(true); 
		map.centerAndZoom("上海",10);      // 初始化地图,用城市名设置地图中心点
		
		addMap = new BMap.Map("add_address_map"); // 创建Map实例,设置地图允许的最小/大级别
		addMap.addControl(new BMap.MapTypeControl());   //添加地图类型控件
		addMap.enableScrollWheelZoom(true); 
		addMap.centerAndZoom("上海",10);      // 初始化地图,用城市名设置地图中心点
		
		updateMap = new BMap.Map("update_address_map"); // 创建Map实例,设置地图允许的最小/大级别
		updateMap.addControl(new BMap.MapTypeControl());   //添加地图类型控件
		updateMap.enableScrollWheelZoom(true); 
		updateMap.centerAndZoom("上海",10);      // 初始化地图,用城市名设置地图中心点
		
		}catch (e){
			
		}
	})();
	//处理增加表单的事件
	(function(){
		//电话重复性检测
		$("#add_phone").on("change",function(){
			var phone=$(this).val();
		/* 	var reg = /^1[3|4|5|8][0-9]\d{8}$/;
	 		 if(!reg.test($.trim(phone))){
	 			 layer.msg("手机号码有误！");
	 			return;
	 		 } */
	 		//品牌电话验证
	 		$("#add_phone").on("blur",function(){
	 			var phone=$(this).val();
	 			/*  var reg = /^1[3|4|5|8][0-9]\d{8}$/;
	 	 		 if(!reg.test($.trim(phone))){
	 	 			 layer.msg("手机号码有误！");
	 	 			return;
	 	 		 } */
	 	 		var _this=this;
	 	 		$(this).next(".add-on").hide();
	 			$.ajax({
	 				url: "index.html",
	 				type: "POST",
	 				async:false,
	 				data: {"phone":phone},
	 				dataType:"json",
	 				success: function (res) {
	 					if(res.status=="1"){
	 						$(_this).next(".add-on").show();
	 						$("#add_username").val(res.data.userName).attr("readonly","readonly");
	 						$("#add_wechatId").val(res.data.wechatId).attr("readonly","readonly");
	 						$("#add_username").attr("userId",res.data.systemUserId);
	 						
	 					}else{
	 						$("#add_username").removeAttr("readonly").removeAttr("userId");
	 						
	 						$("#add_username").removeAttr("userId");
	 						$("#add_wechatId").removeAttr("readonly");
	 					}
	 				}
	 			});
	 		});
		});
		//地址定位
		$("#add_address").on("change",function(){
			var _this=this;
			var address=$(this).val();
			if(!address){
				layer.msg("地址不能为空！");
				return;
			}
			var location=null;
			$.ajax({
				url: "index.html",
				type: "POST",
				async:false,
				data: {"address":address},
				dataType:"json",
				success: function (data) {
					if(data.status=="1"){ 
						layer.msg("地址错误");
						$(_this).removeAttr("lng");
						$(_this).removeAttr("lat");
					}else{
						location=data.result.location;
						$(_this).attr("lng",location.lng);
						$(_this).attr("lat",location.lat);
					}
				}
			});
			if(location){
				addMap.setZoom(10);
				addMap.clearOverlays(); 
				var new_point = new BMap.Point(location.lng,location.lat);
				var marker = new BMap.Marker(new_point);  // 创建标注
				addMap.addOverlay(marker); 
				addMap.panTo(new_point); 
					setTimeout(function(){
						addMap.setZoom(14);
						},1000);
					}
		});
		//增加事件
		$(".addStoreBtn").on("click",function(){
			var storeName=$("#add_storeName").val();
			var brandId=$("#add_brandId").val();
			var userId=$("#add_username").attr("userId");
			var address=$("#add_address").val();
			var lng=$("#add_address").attr("lng");
			var lat=$("#add_address").attr("lat");
			var doorCode=$("#add_doorCode").val();
			var phone=$("#add_phone").val();
			var username=$("#add_username").val();
			var wechatId=$("#add_wechatId").val();
			var param={};
			//数据校验
			if(!storeName){
				layer.msg("店铺名字不能为空！");
				return;
			}else if(brandId=="-1"){
				layer.msg("请选择所属品牌");
				return;
			}else if(!address){
				layer.msg("请输入地址");
				return;
			}else if(!lng||!lat){
				layer.msg("店铺地址不正确");
				return;
			}  else if(!phone){
				layer.msg("店长号码不能为空");
				return;
			}else if(!username){
				layer.msg("店长名字不能为空");
				return;
			} else{
			/* 	var reg = /^1[3|4|5|8][0-9]\d{8}$/;
		 		 if(!reg.test($.trim(phone))){
		 			 layer.msg("手机号码有误！");
		 			return;
		 		 } */
			} 
			param.storeName=storeName;
			param.brandId=brandId;
			param.address=address;
			param.lng=lng;
			param.lat=lat;
			param.doorCode=doorCode;
			param.username=username;
			param.phone=phone;
			param.wechatId=wechatId;
			if(userId){
				param.userId=userId;
			}
			$.post("saveOrUpdate.html",param,function(data){
				layer.msg("添加成功");
				window.location.reload();
			},"json");
			
		});
		
	})();
	
	//绑定详细事件
	(function(){
		$(".store").on("click",".detail",function(){
			var storeId=$(this).attr("storeId");
			$.post("list.html",{storeId:storeId},function(store){
				$("#detail_storeName").val(store.storeName);
				$("#detail_brandName").val(store.brand.brandName);
				
				$("#detail_username").val(store.user.userName);
				$("#detail_phone").val(store.user.phone);
				
				$("#detail_address_1").text(store.address);
				$("#detail_doorCode").val(store.doorCode);
				$("#detail_wechatId").val(store.user.wechatId);
				//初始化地图
				$("#detailModel").modal("show");
				if(map){
				$("#detailModel").on("shown.bs.modal", function () {
					map.setZoom(10);
					map.clearOverlays(); 
				var new_point = new BMap.Point(store.lng,store.lat);
				var marker = new BMap.Marker(new_point);  // 创建标注
					map.addOverlay(marker); 
					map.panTo(new_point); 
					setTimeout(function(){
						map.setZoom(14);
						},1000);
					});
				}
			},"json");
		});
		
		})();
	
	//修改事件
	(function(){
		$(".store").on("click",".update",function(){
			var storeId=$(this).attr("storeId");
			$.post("list.html",{storeId:storeId},function(store){
				$("#update_storeId").val(store.storeId);
				
				$("#update_storeName").val(store.storeName).attr("bak",store.storeName);
				$("#update_doorCode").val(store.doorCode).attr("bak",store.doorCode);
				
				$("#update_brandId").attr("bak",store.brand.brandId)
				$("#update_brandId option").each(function(){
					var value=$(this).val();
					if(value==store.brand.brandId){
						$(this).attr("selected","selected");
					}
				});
				
			$("#update_brandId").trigger("liszt:updated");
			
				$("#update_userId").removeAttr("bak").removeAttr("readonly");
				$("#update_userId").val(store.user.systemUserId).attr("bak",store.user.systemUserId);
				
				$("#update_username").removeAttr("bak").removeAttr("readonly");
				$("#update_username").val(store.user.userName).attr("bak",store.user.userName);
				
				$("#update_phone").removeAttr("bak").removeAttr("readonly");
				$("#update_phone").val(store.user.phone).attr("bak",store.user.phone);
				
				$("#update_wechatId").removeAttr("bak").removeAttr("readonly");
				$("#update_wechatId").val(store.user.wechatId).attr("bak",store.user.wechatId);
				
				$("#update_address").val(store.address).attr("bak",store.address);
				$("#update_address").attr("lng",store.lng);
				$("#update_address").attr("lat",store.lat);
				//初始化地图
				$("#updateModel").modal("show");
				if(updateMap){
				$("#updateModel").on("shown.bs.modal", function () {
					updateMap.setZoom(10);
					updateMap.clearOverlays(); 
				var new_point = new BMap.Point(store.lng,store.lat);
				var marker = new BMap.Marker(new_point);  // 创建标注
					updateMap.addOverlay(marker); 
					updateMap.panTo(new_point); 
					setTimeout(function(){
						updateMap.setZoom(14);
						},1000);
					});
				}
			},"json");
			//品牌电话验证
	 		$("#update_phone").on("blur",function(){
	 			var phone=$(this).val();
	 		/* 	 var reg = /^1[3|4|5|8][0-9]\d{8}$/;
	 	 		 if(!reg.test($.trim(phone))){
	 	 			 layer.msg("手机号码有误！");
	 	 			return;
	 	 		 } */
	 	 		var _this=this;
	 	 		$(this).next(".add-on").hide();
	 			$.ajax({
	 				url: "index.html",
	 				type: "POST",
	 				async:false,
	 				data: {"phone":phone},
	 				dataType:"json",
	 				success: function (res) {
	 					if(res.status=="1"){
	 						$(_this).next(".add-on").show();
	 						$("#update_username").val(res.data.userName).attr("readonly","readonly");
	 						$("#update_wechatId").val(res.data.wechatId).attr("readonly","readonly");
	 						$("#update_userId").val(res.data.systemUserId);
	 						
	 					}else{
	 						$("#update_username").removeAttr("readonly").removeAttr("userId");
	 						
	 						$("#update_userId").val("");
	 						$("#update_wechatId").removeAttr("readonly");
	 					}
	 				}
	 			});
	 		});
	 		//地址定位
			$("#update_address").on("change",function(){
			var _this=this;
			var address=$(this).val();
			if(!address){
				layer.msg("地址不能为空！");
				return;
			}
			var location=null;
			$.ajax({
				url: "index.html",
				type: "POST",
				async:false,
				data: {"address":address},
				dataType:"json",
				success: function (data) {
					if(data.status=="1"){ 
						layer.msg("地址错误");
						$(_this).removeAttr("lng");
						$(_this).removeAttr("lat");
					}else{
						location=data.result.location;
						$(_this).attr("lng",location.lng);
						$(_this).attr("lat",location.lat);
					}
				}
			});
			if(location){
				updateMap.setZoom(10);
				updateMap.clearOverlays(); 
				var new_point = new BMap.Point(location.lng,location.lat);
				var marker = new BMap.Marker(new_point);  // 创建标注
				updateMap.addOverlay(marker); 
				updateMap.panTo(new_point); 
					setTimeout(function(){
						updateMap.setZoom(14);
						},1000);
					}
			});
	 		
		});
		//提交修改结果
		$("#updateModel .updateStoreBtn").on("click",function(){
			var storeId=$("#update_storeId").val();//店铺ID
			var brandId=$("#update_brandId").val();//品牌Id
			var storeName=$("#update_storeName").val();//店铺名字
			var doorCode=$("#update_doorCode").val();//店铺展位号
			var address=$("#update_address").val();//地址
			var lng=$("#update_address").attr("lng");
			var lat=$("#update_address").attr("lat");
			
			var phone=$("#update_phone").val();
			var username=$("#update_username").val();
			var wechatId=$("#update_wechatId").val();
			var userId=$("#update_userId").val();
			
			//数据验证
			if(!storeName){
				layer.msg("店铺名字不能为空！");
				return;
			}else if(brandId=="-1"){
				layer.msg("请选择所属品牌");
				return;
			}else if(!address){
				layer.msg("请输入地址");
				return;
			}else if(!lng||!lat){
				layer.msg("店铺地址不正确");
				return;
			}  else if(!phone){
				layer.msg("店长号码不能为空");
				return;
			}else if(!username){
				layer.msg("店长名字不能为空");
				return;
			} else{
			/* 	var reg = /^1[3|4|5|8][0-9]\d{8}$/;
		 		 if(!reg.test($.trim(phone))){
		 			 layer.msg("手机号码有误！");
		 			return;
		 		 } */
			} 
			//处理变动数据
			var param={};
			param.storeId=storeId;//店铺ID
			if(brandId!=$("#update_brandId").attr("bak")){
				param.brandId=brandId;//品牌ID
			}
			if(storeName!=$("#update_storeName").attr("bak")){
				param.storeName=storeName;//店铺名字
			}
			if(doorCode!=$("#update_doorCode").attr("bak")){
				param.doorCode=doorCode;//展位号
			}
			if(address!=$("#update_address").attr("bak")){
				param.address=address;//地址
			}
			if(userId){//只传一个userId【换人】，传一个userId与name【更新】，
				param.userId=userId;//后台每次更新userId
				if(userId==$("#update_userId").attr("bak")&&phone==$("#update_phone").attr("bak")){//更新userId下的name
					if(username!=$("#update_username").attr("bak")){
						param.username=username;//名字
					}
					if(wechatId!=$("#update_wechatId").attr("bak")){
						param.wechatId=wechatId;//微信
					}
				}
			}else{
				//只传name【添加】，
				param.username=username;//名字
				param.wechatId=wechatId;
				param.phone=phone;//微信
			}	
			$.post("saveOrUpdate.html",param,function(data){
				if(data.status=="ok"){
					layer.msg("更新成功");
					window.location.reload();
				}
			},"json");
		});
		})();
	
	//转换状态
	$(".store").on("click",".changeStatu",function(){
		var status=$(this).attr("status");
		var storeId=$(this).attr("storeId");
		var param={};
		param.storeId=storeId;
		var tip="";
		if(status=="0"){//激活操作
			param.status="1";
			tip="确认激活吗？";
		}else if(status=="1"){//冻结操作
			param.status="0";
			tip="确认冻结吗？";
		}
		layer.confirm(tip, {
			title:"状态切换",
		    btn: ["确定","返回"], //按钮
		    shade: false //不显示遮罩
		}, function(){
			$.post("saveOrUpdate.html",param,function(data){
				layer.msg("更新成功",{ icon: 1,time: 1000 },function(){
					window.location.reload();
				});
		},"json");
		
		}, function(){
			
		});
	});
	</script>
</body>
</html>
