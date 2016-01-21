<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- start: Meta -->
<meta charset="utf-8">
<title>后台管理</title>
<!-- end: Meta -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
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
.add_productImg,.detail_productImg,.update_proImg{
padding: 5px 5px;
margin:0 0;
list-style: none;
}

.add_productImg li,.detail_productImg li,.update_proImg li{
float:left;
padding:5px 5px;
}
.add_productImg img,.detail_productImg img,.update_proImg img{
width:80px;
border:1px solid #ccc;
border-radius:3px;
}
#logopre img{
width:29px;
}
.add_productImg li:hover,.update_proImg li:hover{
border:1px solid #aaa;
cursor:pointer;
}
#detail_brandType .label{margin:0 5px;}
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
					<li><a href="#">品牌列表</a>
					</li>
				</ul>	
				<div class="row-fluid sortable">
					<!--功能区域-->
					<div class="box span12 brand">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon screenshot"></i><span class="break"></span>品牌列表
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
										<th >品牌名字</th>
										<th >拼音</th>
										<th >品牌类型</th>
										<th >返利比例</th>
										<th >佣金比例</th>
										<th >logo</th>
										<th >状态</th>
										<th >操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${brandList}" var="brand" varStatus="temp">
									<tr>
										<td style="font-weight:bold;font-size:15px">${temp.count}</td>
										<td>${brand.brandName }</td>
										<td>${brand.pinying }</td>
										<td>
										<c:if test="${brand.brandType!=null }">
											<c:forEach items="${brand.brandType}" var="type">
											<span class="label label-success"> ${type.name }</span>
											</c:forEach>
										</c:if>
										
										</td>
										<td><fmt:formatNumber maxIntegerDigits="2" value="${brand.rate*100 }" />%</td>
										<td>
										<c:if test="${not empty brand.brandRate}">
											<fmt:formatNumber maxIntegerDigits="2" value="${brand.brandRate*100 }" />%</td>
										</c:if>
										<td><img class="logo" src="${brand.imgPath }"/> </td>
										
										<td>${brand.status=="1"?"<span class='label label-success'>激活</span>":
										"<span class='label label-error'>冻结</span>" }</td>
										<td><a class="btn btn-warn btn-mini detail" brandId="${brand.brandId  }" href="#"> 
												<i class="halflings-icon white edit"></i> 详 细</a>
												<c:if test="${permit }">
											 <a class="btn btn-success editRole btn-mini update" brandId="${brand.brandId}" href="#"> 
												<i class="halflings-icon white edit"></i> 修 改</a> 
											<a class="btn btn-warn orange  btn-mini changeStatu" brandId="${brand.brandId  }" status="${brand.status }" href="#"> 
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
	<div class="modal hide fade" id="myModal" style="width:950px;  margin-left: -450px;">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>品牌管理</h3>
		</div>
		<div class="modal-body">
			<div id="myTabContent" class="tab-content">
				<!-- 修改tab -->
				<div class="tab-pane fade in active text-left" id="edit">
					<p class="text-success">--增加品牌 <small >产品负责人，用户名以及密码均初始化为该用户的手机号码</small></p>
					<table class="addBrand" style="width:98%;margin:5px 1%;" >
					<tr>
					<td><div class="input-prepend" title="品牌名字">
					<span class="add-on"><i class="halflings-icon pencil"></i> 品牌名称 </span>
					<input class="input-large span2"  type="text"  id="add_brandName" placeholder="请输入品牌名称" maxlength="10" >
					</div></td>
					<td><div class="input-prepend" title="返利比例">
					<span class="add-on"><i class="halflings-icon globe"></i> 返利比例 </span>
					<input class="input-large span2"  type="text" value="0.02" id="add_rate" placeholder="请输入返利比例" maxlength="5"/>
					</div></td>
					<td><div class="input-prepend" title="佣金比例">
					<span class="add-on"><i class="halflings-icon globe"></i> 佣金比例 </span>
					<input class="input-large span2"  type="text" value="0.10" id="add_brandRate" placeholder="请输入佣金比例" maxlength="5"/>
					</div></td>
					</tr>
					
					<tr>
					<td><div class="input-prepend" title="logo">
						<span class="add-on"><i class="halflings-icon globe"></i> logo </span>
					<input style="width:80px" class="input-file uniform_on" id="add_logoImg"  type="file" accept="image/*"/>
					<span id="logopre"></span></div></td>
					
					<td colspan="2" style="width:340px;"><div class="input-prepend" title="logo">
					<div class="input-prepend" title="品牌类型">
						<span class="add-on"><i class="halflings-icon globe"></i> 品牌类型 </span>
						<select multiple class="roleSelect" name="add_brandType" id="add_brandType" data-placeholder="请选择品牌类型" style="width:200px;">
							<c:forEach items="${brandTypeList }" var="temp">
								<option value="${temp.brandTypeId }">${temp.name }</option>
							</c:forEach>
						</select>
					</div></td></tr>
					
					<tr><td colspan="3" style="border-bottom:1px solid #ccc;color:#888;padding-top:5px">品牌负责人：</td></tr>
					<tr>
					<td><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 电&nbsp;话 </span>
					<input class="input-large span2" id="add_phone" type="text" placeholder="请输入产品负责人电话" maxlength="11"/>
					<span class="add-on" style="display:none;"> <i class="halflings-icon pencil"></i></span>
				
					</div></td>
					<td><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 名&nbsp;字 </span>
					<input class="input-large span3" id="add_username" type="text"  placeholder="请输入产品负责人名字" maxlength="40"/>
					</div></td>
					<td><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 微&nbsp;信 </span>
					<input class="input-large span3" id="add_wechatId" type="text"  placeholder="请输入产品负责人微信" maxlength="20"/>
					</div></td>
					</tr>
					<tr><td colspan="3" style="border-bottom:1px solid #ccc;color:#888;padding-top:5px">品牌介绍：</td></tr>
					<tr><td colspan="3">
					<textarea style="width:95%;height:60px;" placeholder="请输入产品介绍" id="add_descript"></textarea>
					</div></td>
					</tr>
					<tr><td colspan="3" style="border-bottom:1px solid #ccc;color:#888;padding-top:5px">
					<label for="add_proImg">产品图  <i class="halflings-icon plus"> </i>
					</label><input type="file" style="display: none;"  name="add_proImg" id="add_proImg" accept="image/*"/></tr>
					<tr>
					<td colspan="3" style="height:80px;">
					<ul class="add_productImg">
					</ul>
					</td></tr>
					</table>
				</div>					
			</div>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">关闭</a> <a href="#"
				class="btn btn-primary addBrandBtn">确认</a>
		</div>
	</div>
	<!-- 详细 -->
	<div class="modal hide fade" id="detailModel" style="width:950px;  margin-left: -450px;">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>品牌管理</h3>
		</div>
		<div class="modal-body">
			<div id="myTabContent" class="tab-content">
				<!-- 修改tab -->
				<div class="tab-pane fade in active text-left" id="edit">
					<p class="text-success">--品牌详细 </p>
					<table class="addBrand" style="width:98%;margin:5px 1%;" >
					<tr>
					<td><div class="input-prepend" title="品牌名字">
					<span class="add-on"><i class="halflings-icon pencil"></i> 品牌名称 </span>
					<input class="input-large span3"  type="text"  id="detail_brandName" placeholder="请输入品牌名称"  readonly="readonly" >
					</div></td>
					<td><div class="input-prepend" title="返利比例">
					<span class="add-on"><i class="halflings-icon globe"></i> 返利比例 </span>
					<input class="input-large span2"  type="text"  id="detail_rate"  readonly="readonly" />
					</div></td>
					<td ><div class="input-prepend" title="返利比例">
					<span class="add-on"><i class="halflings-icon globe"></i> 拼音 </span>
					<input class="input-large span2"  type="text"  id="detail_pinying"  readonly="readonly" />
					</div></td>
					</tr>
					<tr>
						<td style="width:340px;">
						<div class="input-prepend" title="logo">
						<span class="add-on"><i class="halflings-icon globe"></i> logo </span>
						<span id="detail_logo"></span>
						
						<div class="input-prepend" title="浏览量">
						<span class="add-on"><i class="halflings-icon globe"></i> 浏览量 </span>
						<input id="detail_scanNum" class="input-large span1" type="text" readonly="readonly"/>
						</div>
						
						</td>
					<td  style="width:340px;"><div class="input-prepend" title="品牌类型">
					<div class="input-prepend" title="品牌类型">
						<span class="add-on"><i class="halflings-icon globe"></i> 品牌类型 </span>
						<span id="detail_brandType"></span>
					</div>
					</div>
					</td>
					<td  style="width:340px;"><div class="input-prepend" title="佣金比例">
					<span class="add-on"><i class="halflings-icon globe"></i> 佣金比例 </span>
					<input class="input-large span2"  type="text"  id="detail_brandRate"  readonly="readonly" />
					</div>
					</td>
					</tr>
					<tr><td colspan="3" style="border-bottom:1px solid #ccc;color:#888;padding-top:5px">品牌负责人：</td></tr>
					<tr>
					<td><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 电&nbsp;话 </span>
					<input class="input-large span2" id="detail_phone" type="text"  readonly="readonly"/>
					<span class="add-on" style="display:none;"> <i class="halflings-icon pencil"></i></span>
					</div></td>
					<td ><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 名&nbsp;字 </span>
					<input class="input-large span3" id="detail_username" type="text"  readonly="readonly"/>
					</div></td>
					<td><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 微&nbsp;信 </span>
					<input class="input-large span3" id="detail_wechatId" type="text" readonly="readonly" maxlength="20"/>
					</div></td>
					</tr>
					<tr><td colspan="3" style="color:#888;padding-top:5px">品牌介绍：</td></tr>
					<tr><td colspan="3">
					<div style="border:1px solid #aaa;padding:5px 5px;width:98%;min-height:50px;max-height:100px;overflow:auto"  id="detail_descript" readonly="readonly" ></div>
					</div></td>
					</tr>
					<tr><td colspan="3" style="color:#888;padding-top:5px">
					<label>产品图
					</label>
					<tr>
					<td colspan="3" style="height:80px;">
					<ul class="detail_productImg">
					</ul>
					</td></tr>
					</table>
				</div>					
			</div>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">关闭</a>
		</div>
	</div>
	
	<!-- 修改 -->
	<div class="modal hide fade" id="updateModel" style="width:950px;  margin-left: -450px;">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>品牌管理</h3>
		</div>
		<div class="modal-body">
			<div id="myTabContent" class="tab-content">
				<!-- 修改tab -->
				<div class="tab-pane fade in active text-left" id="edit">
					<p class="text-success">--品牌更新 </p>
					<table class="addBrand" style="width:98%;margin:5px 1%;" >
					<tr>
					<td><div class="input-prepend" title="品牌名字">
					<span class="add-on"><i class="halflings-icon pencil"></i> 品牌名称 </span>
					<input class="input-large span3"  type="hidden"  id="update_brandId"/>
					<input class="input-large span3"  type="text"  id="update_brandName" placeholder="请输入品牌名称" maxlength="10"  >
					</div></td>
					<td><div class="input-prepend" title="返利比例">
					<span class="add-on"><i class="halflings-icon globe"></i> 返利比例 </span>
					<input class="input-large span2"  type="text" value="0.02" id="update_rate" maxlength="4"/>
					</div></td>
					<td ><div class="input-prepend" title="返利比例">
					<span class="add-on"><i class="halflings-icon globe"></i> 拼音 </span>
					<input class="input-large span2"  type="text"  id="update_pinying"  maxlength="20"/>
					</div></td>
					</tr>
					<tr>
					<td style="width:340px;"><div class="input-prepend" title="logo">
					<span class="add-on"><i class="halflings-icon globe"></i> logo </span>
					<span id="update_logo"></span>
					
					<div class="input-prepend" title="浏览量" style="float:right;">
						<span class="add-on"><i class="halflings-icon globe"></i> 浏览量 </span>
						<input id="update_scanNum" class="input-large span1" type="text"/>
						</div>
					<label style="float:right;margin:10px 10px;" for="update_logoImg"><i class="halflings-icon plus"> </i>
					<input type="file" style="display: none;" id="update_logoImg" accept="image/*"/>
					</label>
						
					</td>
					<td style="width:340px;"><div class="input-prepend" title="logo">
					<div class="input-prepend" title="品牌类型">
						<span class="add-on"><i class="halflings-icon globe"></i> 品牌类型 </span>
						<select multiple class="roleSelect" name="update_brandType" id="update_brandType" data-placeholder="请选择品牌类型" style="width:200px;">
							<c:forEach items="${brandTypeList }" var="temp">
								<option value="${temp.brandTypeId }">${temp.name }</option>
							</c:forEach>
						</select>
					</div></td>
					<td ><div class="input-prepend" title="佣金比例">
					<span class="add-on"><i class="halflings-icon globe"></i> 佣金比例 </span>
					<input class="input-large span2"  type="text"  id="update_brandRate"  maxlength="5"/>
					</div></td>
					</tr>
					
					
					
					<tr><td colspan="3" style="border-bottom:1px solid #ccc;color:#888;padding-top:5px">品牌负责人：</td></tr>
					<tr>
					<td><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 电&nbsp;话 </span>
					<input class="input-large span2" id="update_phone" type="text" maxlength="11"/>
					<span class="add-on" style="display:none;"> <i class="halflings-icon pencil"></i></span>
					</div></td>
					<td ><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 名&nbsp;字 </span>
					<input class="input-large span3" id="update_username" type="text" maxlength="5"/>
					</div></td>
					<td ><div class="input-prepend" title="品牌负责人">
					<span class="add-on"><i class="halflings-icon globe"></i> 微&nbsp;信 </span>
					<input class="input-large span3" id="update_wechatId" type="text" maxlength="20"/>
					</div></td>
					</tr>
					<tr><td colspan="3" style="color:#888;padding-top:5px">品牌介绍：</td></tr>
					<tr><td colspan="3">
					<textarea style="border:1px solid #aaa;padding:5px 5px;width:98%;min-height:50px;max-height:100px;overflow:auto"  id="update_descript" ></textarea>
					</div></td>
					</tr>
					<tr><td colspan="3" style="border-bottom:1px solid #ccc;color:#888;padding-top:5px">
					<label for="update_proImg">产品图  <i class="halflings-icon plus"> </i>
					</label><input type="file" style="display: none;"  name="update_proImg" id="update_proImg" accept="image/*"/></tr>
					<tr>
					<td colspan="3" style="height:80px;">
					<ul class="update_proImg">
					</ul>
					</td></tr>
					</table>
				</div>					
			</div>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">关闭</a>
			<a href="#"
				class="btn btn-primary updateBrandBtn">确认</a>
		</div>
	</div>
	<div class="clearfix">
    </ul>
	
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
	
	<script type="text/javascript">
	$(".roleSelect").chosen();
	$("input:file.uniform_on").uniform();
		$(function() {
			$(".brand .add").on("click",function(){
				$("#myModal").modal("show");
			});
		});
	//处理增加表单的事件
	(function(){
		var formdate;//表单对象
		var proImg=new Array();
	 	if (window.FormData) {
	  		formdata = new FormData();
		}
		$("#add_logoImg").on("change",function(){
			var file=this.files[0];
			if (!!file.type.match(/image.*/)) {
				if(file.size>500000){
					layer.msg("图片尺寸太大，不要超过500KB！");
			 		return;
				}
				if ( window.FileReader ) {
					reader = new FileReader();
					reader.onloadend = function (e) { 
						$("#logopre").empty();
						$("#logopre").append($("<img>").attr("src",e.target.result));
					};
					reader.readAsDataURL(file);
				}
				formdata.append("logo",file);
			}	
		});
		//添加产品图
		$("#add_proImg").on("change",function(){
			var file=this.files[0];
			if (!!file.type.match(/image.*/)) {
				if(file.size>500000){
					layer.msg("图片尺寸太大，不要超过500KB！");
			 		return;
				}
				if ( window.FileReader ) {
					reader = new FileReader();
					reader.onloadend = function (e) { 
						var $li=$("<li>").append($("<img title='双击删除'>").attr("src",e.target.result));
						$(".add_productImg").append($li);
					};
					reader.readAsDataURL(file);
				}
				proImg.push(file);
			}
		});
		//删除产品图
		$(".add_productImg").on("dblclick","li",function(){
			var index=$(this).index();
			//从数组中删掉
			var temp=new Array();
			for(var i=0;i<proImg.length;i++){
				if(i!==index){
				temp.push(proImg[i]);
				}
			}
			proImg=temp;
			$(this).remove();
		});
		//品牌电话验证
		$("#add_phone").on("blur",function(){
			var phone=$(this).val();
			 var reg = /^1[3|4|5|8][0-9]\d{8}$/;
	 		 if(!reg.test($.trim(phone))){
	 			 layer.msg("手机号码有误！");
	 			return;
	 		 }
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
						$("#add_wechatId").removeAttr("readonly");
					}
				}
			});
		});
		$(".addBrandBtn").on("click",function(){
			var _this=this;
			var brandName=$("#add_brandName").val();//品牌的名字
			var rate=$("#add_rate").val();//返利比例
			var brandRate=$("#add_brandRate").val();//返利比例
			var logo=$("#add_logoImg").get(0).files[0];//logo
			var descript=$("#add_descript").val();//产品介绍
			var phone=$("#add_phone").val();
			var username=$("#add_username").val();//店长名字
			var wechatId=$("#add_wechatId").val();//店长微信号
			var userId=$("#add_username").attr("userId");
			//生成品牌类型字符串
			var brandTypeId=$("#add_brandType").val()+"";
			//开始验证
			if(!$.trim(brandName)){
				layer.msg("品牌名称不能为空！");
				return;
			}else if(!$.trim(rate)){
				layer.msg("返利比例不能为空！");
				return;
			}else if(!$.trim(brandRate)){
				layer.msg("佣金比例不能为空！");
				return;
			}else if(!logo){
				layer.msg("logo不能为空！");
				return;
			}else if(!brandTypeId){
				layer.msg("品牌类型不能为空！");
				return;
			}else if(!descript){
				layer.msg("产品介绍不能为空");
				return;
			}else if(!phone){
				layer.msg("品牌联系人电话不能为空");
				return;
			}else if(!username){
				layer.msg("产品负责人名字不能为空");
				return;
			}else if(proImg.length==0){
				layer.msg("产品图不能为空");
				return;
			}else{
				 var reg = /^1[3|4|5|8][0-9]\d{8}$/;
		 		 if(!reg.test($.trim(phone))){
		 			 layer.msg("手机号码有误！");
		 			return;
		 		 }
				//验证产品名字
				var isExist=false;
				$.ajax({
					url: "index.html",
					type: "POST",
					async:false,
					data: {"brandName":brandName},
					dataType:"json",
					success: function (res) {
						if(res.status=="1"){ 
							isExist=true;//有存在的
						}else{
							isExist=false;//没有存在的
						}
					}
				});
				if(isExist){
					layer.msg("品牌名字已存在！");
					$(_this).removeAttr("disabled");
					return;
				}
				
				 var strP=/^0(\.\d+)?$/; 
					if(!strP.test($.trim(rate))){
						layer.msg("返利比例必须为0-1之间的小数");
						return;
					}
					if(!strP.test($.trim(brandRate))){
						layer.msg("佣金比例必须为0-1之间的小数");
						return;
					}
			}
			$(this).attr("disabled","disabled");
			formdata.append("rate",rate);
			formdata.append("brandRate",brandRate);
			formdata.append("brandName",brandName);
			formdata.append("descript",descript);
			formdata.append("username",username);
			formdata.append("brandTypeIds",brandTypeId);
			formdata.append("phone",phone);
			formdata.append("wechatId",wechatId);
			if(userId){
				formdata.append("userId",userId);
			}
			for(var i=0;i<proImg.length;i++){
			formdata.append("images[]",proImg[i]);
			}
			$.ajax({
				url: "saveOrUpdate.html",
				type: "POST",
				data: formdata,
				processData: false,
				contentType: false,
				success: function (res) {
					layer.msg("添加成功");
						window.location.reload();
				}
			});
		});
		
	})();
	//绑定详细事件
	$(".brand").on("click",".detail",function(){
		var brandId=$(this).attr("brandId");
		var param={};
		param.brandId=brandId;
		$.post("list.html",param,function(brand){
			$("#detailModel").modal("show");
			$("#detail_brandName").val(brand.brandName);
			$("#detail_rate").val(brand.rate);
			$("#detail_brandType").empty();
			$("#detail_pinying").val(brand.pinying);
			$("#detail_brandRate").empty();
			$("#detail_brandRate").val(brand.brandRate);
			$(brand.brandType).each(function(){
				var $span=$("<span>").addClass("label label-success").text(this.name);
				$("#detail_brandType").append($span);
			});
			$("#detail_logo").empty();
			$("#detail_logo").append($("<img>").attr("src",brand.imgPath).css("width","29px"));
			$("#detail_scanNum").val(brand.scanNum);
			$("#detail_descript").text(brand.introduce);
			$("#detail_username").val(brand.user.userName);
			$("#detail_wechatId").val(brand.user.userId);
			$("#detail_phone").val(brand.user.phone);
			$(".detail_productImg").empty();
			$(brand.proImgList).each(function(){
				var $li=$("<li>").append($("<img >").attr("src",this));
				$(".detail_productImg").append($li);
			});
		},"json");
	});
	
	//绑定修改事件
	$(".brand").on("click",".update",function(){
		var brandId=$(this).attr("brandId");
		var param={};
		param.brandId=brandId;
		$.post("list.html",param,function(brand){
			$("#updateModel").modal("show");
			$("#update_brandId").val(brand.brandId);
			$("#update_brandName").val(brand.brandName).attr("bak",brand.brandName);
			$("#update_rate").val(brand.rate).attr("bak",brand.rate);
			
			$("#update_scanNum").val(brand.scanNum).attr("bak",brand.scanNum);

			$("#update_brandRate").val(brand.brandRate).attr("bak",brand.brandRate);
			$("#update_pinying").val(brand.pinying).attr("bak",brand.pinying);
			
			$("#update_logo").empty();
			$("#update_logo").append($("<img>").attr("src",brand.imgPath).css("width","29px"));
			$("#update_descript").text(brand.introduce).attr("bak",brand.introduce);
			
			$("#update_username").removeAttr("bak");
			$("#update_username").removeAttr("readonly");
			$("#update_username").val(brand.user.userName).attr("bak",brand.user.userName);
			
			$("#update_phone").removeAttr("bak");
			$("#update_phone").removeAttr("readonly");
			$("#update_phone").val(brand.user.phone).attr("bak",brand.user.phone);
			
			$("#update_wechatId").removeAttr("bak");
			$("#update_wechatId").removeAttr("readonly");
			$("#update_wechatId").val(brand.user.wechatId).attr("bak",brand.user.wechatId);
			
			$(".update_proImg").empty();
			$(brand.proImgList).each(function(){
				var $li=$("<li>").append($("<img >").attr("src",this));
				$(".update_proImg").append($li);
			});
			//处理标签
			$("#update_brandType option").removeAttr("selected");
			$("#update_brandType option").each(function(){
				var _this=this;
				$(brand.brandType).each(function(){
					if(this.brandTypeId==$(_this).val()){
						$(_this).attr("selected","selected");
					}
				});
			});
			$("#update_brandType").trigger("liszt:updated");
			
		},"json");
	});
	//处理更新表单
	(function(){
		var formdate;//表单对象
		var proImg=new Array();
	 	if (window.FormData) {
	  		formdata = new FormData();
		}
		$("#update_logoImg").on("change",function(){
			var file=this.files[0];
			if (!!file.type.match(/image.*/)) {
				if(file.size>500000){
					layer.msg("图片尺寸太大，不要超过500KB！");
			 		return;
				}
				if ( window.FileReader ) {
					reader = new FileReader();
					reader.onloadend = function (e) { 
						$("#update_logo").empty();
						$("#update_logo").append($("<img >").attr("src",e.target.result).css("width","29px"));
					};
					reader.readAsDataURL(file);
				}
			}	
		});
		//添加产品图
		$("#update_proImg").on("change",function(){
			var file=this.files[0];
			if (!!file.type.match(/image.*/)) {
				if(file.size>500000){
					layer.msg("图片尺寸太大，不要超过500KB！");
			 		return;
				}
				if ( window.FileReader ) {
					reader = new FileReader();
					reader.onloadend = function (e) { 
						var $li=$("<li>").append($("<img title='双击删除'>").attr("src",e.target.result))
						.addClass("temp");
						$(".update_proImg").append($li);
					};
					reader.readAsDataURL(file);
				}
				proImg.push(file);
			}
		});
		//删除产品图
		$(".update_proImg").on("dblclick","li",function(){
			
			if($(this).hasClass("temp")){
			//从数组中删掉
			var index=$(this).index(".update_proImg .temp");
			var temp=new Array();
			for(var i=0;i<proImg.length;i++){
				if(i!==index){
				temp.push(proImg[i]);
				}
			}
			proImg=temp;
			}
			$(this).remove();
		});
		//品牌电话验证
		$("#update_phone").on("blur",function(){
			var phone=$(this).val();
			 var reg = /^1[3|4|5|8][0-9]\d{8}$/;
	 		 if(!reg.test($.trim(phone))){
	 			 layer.msg("手机号码有误！");
	 			return;
	 		 }
	 		var _this=this;
	 		$(this).next(".add-on").hide();
	 		//当检测到值改变了，采取校验
				$.ajax({
					url: "index.html",
					type: "POST",
					async:false,
					data: {"phone":phone},
					dataType:"json",
					success: function (res) {
						if(res.status=="1"&&$(_this).attr("bak")!=phone){
							$(_this).next(".add-on").show();
							$("#update_username").val(res.data.userName);
							$("#update_username").attr("readonly","readonly");
							$("#update_wechatId").val(res.data.wechatId);
							$("#update_wechatId").attr("readonly","readonly");
							$("#update_username").attr("userId",res.data.systemUserId);
							
						}else{
							$("#update_username").removeAttr("readonly");
							$("#update_username").removeAttr("userId");
							$("#update_wechatId").removeAttr("readonly");
						}
					}
					
				});
		});
		$(".updateBrandBtn").on("click",function(){
			var _this=this;
			var brandName=$("#update_brandName").val();//品牌的名字
			var rate=$("#update_rate").val();//返利比例
			var brandRate=$("#update_brandRate").val();//返利比例
			var logo=$("#update_logoImg").get(0).files[0];//logo
			var descript=$("#update_descript").val();//产品介绍
			var phone=$("#update_phone").val();
			var username=$("#update_username").val();
			var wechatId=$("#update_wechatId").val();
			var userId=$("#update_username").attr("userId");
			var brandTypeId=$("#update_brandType").val()+"";
			var pinying=$("#update_pinying").val();
			var scanNum=$("#update_scanNum").val();
			//开始验证
			if(!$.trim(brandName)){
				layer.msg("品牌名称不能为空！");
				return;
			}else if(!brandTypeId){
				layer.msg("品牌类型不能为空！");
				return;
			}else if(!$.trim(scanNum)){
				layer.msg("浏览量不能为空！");
				return;				
			}else if(!$.trim(rate)){
				layer.msg("返利比例不能为空！");
				return;
			}else if(!$.trim(brandRate)){
				layer.msg("佣金比例不能为空！");
				return;
			}else if(!descript){
				layer.msg("产品介绍不能为空");
				return;
			}else if(!phone){
				layer.msg("品牌联系人电话不能为空");
				return;
			}else if(!username){
				layer.msg("产品负责人名字不能为空");
				return;
			}else if(!$(".update_proImg img").get(0)){
				layer.msg("产品图不能为空");
				return;
			}else{
				var reg = /^1[3|4|5|8][0-9]\d{8}$/;
		 		 if(!reg.test($.trim(phone))){
		 			 layer.msg("手机号码有误！");
		 			return;
		 		 }
				//验证产品名字
				if($("#update_brandName").attr("bak")!=brandName){
					var isExist=false;
					$.ajax({
						url: "index.html",
						type: "POST",
						async:false,
						data: {"brandName":brandName},
						dataType:"json",
						success: function (res) {
							if(res.status=="1"){ 
								isExist=true;//有存在的
							}else{
								isExist=false;//没有存在的
							}
						}
					});
					if(isExist){
						layer.msg("品牌名字已存在！");
						$(_this).removeAttr("disabled");
						return;
					}
				}
				 var strP=/^0(\.\d+)?$/; 
					if(!strP.test($.trim(rate))){
						layer.msg("返利比例必须为0-1之间的小数");
						return;
					}
					if(!strP.test($.trim(brandRate))){
						layer.msg("佣金比例必须为0-1之间的小数");
						return;
					}
					if(!/^\d{1,11}$/.test(scanNum)){
						layer.msg("浏览量为1-11位整数");
						return;
					}
			}
			//开始检测改变的值并更新
			formdata.append("brandId",$("#update_brandId").val());
			formdata.append("brandTypeIds",brandTypeId);
			if($("#update_brandName").attr("bak")!=brandName){
				formdata.append("brandName",brandName);
			}
			if($("#update_rate").attr("bak")!=rate){
				formdata.append("rate",rate);
			}
			if($("#update_brandRate").attr("bak")!=rate){
				formdata.append("brandRate",brandRate);
			}
			if($("#update_descript").attr("bak")!=descript){
				formdata.append("descript",descript);
			}
			if($("#update_scanNum").attr("bak")!=scanNum){
				formdata.append("scanNum",scanNum);
			}
			//检测拼音改变
			if($("#update_pinying").attr("bak")!=pinying){
				formdata.append("pinying",pinying);
			}
			if(logo){
				formdata.append("logo",logo);
			}
			if($("#update_phone").attr("bak")!=phone){
				formdata.append("phone",phone);
				if(userId){
					formdata.append("userId",userId);
				}
			}
			//人换了。
			if($("#update_username").attr("bak")!=username||($("#update_phone").attr("bak")!=phone&&!userId)){
				formdata.append("username",username);
			}
			//人换了。
			if($("#update_wechatId").attr("bak")!=wechatId||($("#update_phone").attr("bak")!=phone&&!userId)){
				formdata.append("wechatId",wechatId);
			}
			//处理产品图
			$(".update_proImg img").each(function(){
				if(!$(this).parent().hasClass("temp")){
					formdata.append("oldProImg",$(this).attr("src"));
				}
			});
			for(var i=0;i<proImg.length;i++){
				formdata.append("images[]",proImg[i]);
			}
		
			$.ajax({
				url: "saveOrUpdate.html",
				type: "POST",
				data: formdata,
				processData: false,
				contentType: false,
				success: function (res) {
					layer.msg("更新成功");
					window.location.reload();
					
				}
			});
		});
		
	})();
	
	//转换状态
	$(".brand").on("click",".changeStatu",function(){
		var status=$(this).attr("status");
		var brandId=$(this).attr("brandId");
		var param={};
		param.brandId=brandId;
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
