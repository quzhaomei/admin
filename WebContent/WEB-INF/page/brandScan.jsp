<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- start: Meta -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>后台管理</title>

<!-- start: Mobile Specific -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- end: Mobile Specific -->
<!-- start: CSS -->
<link id="bootstrap-style" href="../css/bootstrap.min.css" rel="stylesheet">
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
.modal-body{max-height: 580px;}
.wechatImg{width:60px;}
.label{cursor:pointer;}
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
					class="icon-bar"></span> </a> <a class="brand" href="index.html"><span>系统访问管理</span>
				</a>
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
				<!-- 	<li><a href="#">系统设置<i class="icon-angle-right"></i> </a> -->
					</li>
					<li><a href="#">品牌访问管理</a>
					</li>
				</ul>
				<div class="row-fluid sortable">
					<div class="box span12">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon user"></i><span class="break"></span>品牌访问管理
							</h2>
							<div class="box-icon">
							<c:if test="${!isBrand }">
								<a href="#" id="addScan"><i
									class="halflings-icon plus "></i> </a>  
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
						<form action="index.html" method="post" id="myform">
						品牌选择:<select rel="chosen" name="brandId" id="brandId">
								<c:forEach items="${brands }" var="brand">
									<option value="${brand.brandId }" ${brand.brandId eq brandId?"selected='selected'":"" } >${brand.brandName }</option>
								</c:forEach>
							</select> 
						<input name="pageIndex" id="pageIndex" type="hidden" value="${pageResult.pageIndex}"/>
						<input name="pageSize" type="hidden" value="${pageResult.pageSize}"/>
						</form>
							<table class="table table-striped table-bordered">
								<thead>
									<tr>
										<th>凯特号</th>
										<th>昵称</th>
										<th>品牌</th>
										<th>访问时间</th>
										<c:if test="${!isBrand }">
										<th>操作</th>
										</c:if>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${pageResult.param }" var="temp">
									<tr>
										<td>${temp.user.getMoreId }</td>
										<td>${temp.user.userName }</td>
										<td>${temp.brand.brandName }</td>
										<td>
										<fmt:formatDate value="${temp.seeDate }" pattern="yyyy-MM-dd"/>
										 </td>
										 <c:if test="${!isBrand }">
										 <td>
										 <span class="label label-success edit-scan" brandScanId="${temp.brandScanId }">修改</span>
										 <span class="label label-important delete-scan" brandScanId="${temp.brandScanId }">删除</span>
										 </td>
										 </c:if>
									</tr>
								</c:forEach>
								</tbody>
							</table>

							<!--分页控制  -->
							<div class="row-fluid">
								<div class="span12">
									<div class="dataTables_info text-left" style="padding-left:60px;" id="DataTables_Table_0_info">
										<table >
										<tr>
										<td>总共有  <span class="text-error">${pageResult.totalPage }</span> 页，当前显示的是第 
										 <span class="text-success">${pageResult.pageIndex } </span> 页,
										 跳转至 <i class="halflings-icon share-alt"></i> </td>
										<td>
										<select id="pageSelect" style='width:60px;'>
															<c:forEach begin="1" end="${pageResult.totalPage }" varStatus="index">
																<option  value="${index.count }" ${index.count==pageResult.pageIndex?"selected":"" }> ${index.count }</option>
															</c:forEach>
												</select>
												</td>
										<td> 页 </td>
										</tr>
										</table>
										
									</div>
								</div>
								<div class="span12 center">
									<div class="dataTables_paginate paging_bootstrap pagination">
										<ul id="page">
											<li index= ${pageResult.pageIndex-1>0?(pageResult.pageIndex-1):"'' class='disabled'" }><a href="#">上一页</a>
											</li>
											<c:forEach begin="1" end="${pageResult.totalPage }" varStatus="index">
											<li index="${pageResult.pageIndex!=index.count?index.count:"" }" class="${index.count==pageResult.pageIndex?"active":"" }"><a href="#">${index.count }</a>
											</li>
											</c:forEach>
											<li index=${pageResult.pageIndex+1<=pageResult.totalPage?pageResult.pageIndex+1:"'' class='disabled'" } class="next"><a href="#">下一页</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<!-- 数据展示结束 -->
						
					</div>
					<!--/span-->
				</div>

			</div>
			<!-- end: Content -->
		</div>
		<!--/#content.span10-->
	</div>
	<!--/fluid-row-->
	
	<div class="clearfix"></div>

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
	//下拉款美化
	$("#pageSelect").chosen();
	//跳转某页
	function toPage(index){
		$("#pageIndex").val(index);
		$("#myform").submit();
	}
	//事件绑定
	$(function(){
	$("#page li").click(function(){
		var index=$(this).attr("index");
		if(index){
			toPage(index);
		}
	});
	$("#pageSelect").on("change",function(){
		var index=$("#pageSelect").val();
		toPage(index);
	});
	
	$("#brandId").on("change",function(){
		$(this).parent("form").submit();
	});
	
	//新增
	$("#addScan").on("click",function(){
			$("#addModal").modal("show");
		});
	//保存
	$(".addSubmit").on("click",function(){
		var add_brandId=$("#brandId").val();
		var add_getMoreId=$("#add_getMoreId").val();
		var add_seeDate=$("#add_seeDate").val();
		if(!add_seeDate){
			layer.msg("请选择浏览时间");
			return;
		}else if(!add_getMoreId){
			layer.msg("请输入凯特号")
			return;
		}else if(!add_getMoreId.match(/\d+/)){
			layer.msg("凯特号为6-10位的数字")
			return;
		}
		var param={};
		param.brandId=add_brandId;
		param.getMoreId=add_getMoreId;
		param.seeDate=add_seeDate;
		param.operator="add";
		$.post("saveOrUpdate.html",param,function(json){
			if(json.status=="0"){
				layer.msg(json.message);
			}else if(json.status=="1"){
				layer.msg(json.message);
				$("#myform").submit();
			}
		},"json")
	});
	
	var scanId;
	//修改
	$(".edit-scan").on("click",function(){
		scanId=$(this).attr("brandScanId");
		var param={};
		param.scanId=scanId;
		param.operator="toUpdate";
		$.post("saveOrUpdate.html",param,function(json){
			$("#update_getMoreId").val(json.data.user.getMoreId);
			$("#update_seeDate").val(json.data.time);
			$("#updateModal").modal("show");
		},"json");
	 });
	
	//修改-
	$(".updateSubmit").on("click",function(){
		var update_getMoreId=$("#update_getMoreId").val();
		var update_seeDate=$("#update_seeDate").val();
		if(!update_seeDate){
			layer.msg("请选择浏览时间");
			return;
		}else if(!update_getMoreId){
			layer.msg("请输入凯特号")
			return;
		}else if(!update_getMoreId.match(/\d+/)){
			layer.msg("凯特号为6-10位的数字")
			return;
		}
		var param={};
		param.scanId=scanId;
		param.getMoreId=update_getMoreId;
		param.seeDate=update_seeDate;
		param.operator="update";
		$.post("saveOrUpdate.html",param,function(json){
			if(json.status=="0"){
				layer.msg(json.message);
			}else if(json.status=="1"){
				layer.msg(json.message);
				$("#myform").submit();
			}
		},"json");
	 });
	
	//删除
	$(".delete-scan").on("click",function(){
		var _this=this;
		layer.confirm("确定删除吗？", {
			title:"删除",
		    btn: ["确定","返回"], //按钮
		    shade: false //不显示遮罩
		}, function(){
			scanId=$(_this).attr("brandScanId");
			var param={};
			param.scanId=scanId;
			param.operator="delete";
			
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status=="0"){
					layer.msg(json.message);
				}else if(json.status=="1"){
					layer.msg(json.message);
					$("#myform").submit();
				}
			},"json");
		
		}, function(){
			
		});
		
		
	 });
	
	});
	</script>
</body>
<!-- 新增modal -->
	<div class="modal hide fade" id="addModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>浏览记录管理</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">新建浏览记录</small></p>
				
				<form action="#" id="addForm">
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on"> * 凯特号  </span></td>
					<td><input class="input-large span3" id="add_getMoreId" name="add_getMoreId"  type="text" placeholder="请输入凯特号，为数字" maxlength="10" > 
					</td>
				</tr>
				<tr>
					<td><span class="add-on">访问时间</span></td>
					<td><input class="input-large span3 datepicker" id="add_seeDate" name="add_seeDate"  
					 type="text" placeholder="请选择访问时间"  />
					</td>
				</tr>
				</table>
				</form>
				<div>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary addSubmit">保存</a>
		</div>
	</div>
	
<!-- 修改modal -->
	<div class="modal hide fade" id="updateModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>浏览记录管理</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">修改浏览记录</small></p>
				
				<form action="#" id="addForm">
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on"> * 凯特号  </span></td>
					<td><input class="input-large span3" id="update_getMoreId" name="update_getMoreId"  type="text" placeholder="请输入凯特号，为数字" maxlength="10" > 
					</td>
				</tr>
				<tr>
					<td><span class="add-on">访问时间</span></td>
					<td><input class="input-large span3 datepicker" id="update_seeDate" name="update_seeDate"  
					 type="text" placeholder="请选择访问时间"  />
					</td>
				</tr>
				</table>
				</form>
				<div>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary updateSubmit">保存</a>
		</div>
	</div>
</html>
