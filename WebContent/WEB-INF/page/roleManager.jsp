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
					<li><a href="#">系统设置<i class="icon-angle-right"></i> </a>
					</li>
					<li><a href="#">角色管理</a>
					</li>
				</ul>

				<div class="row-fluid sortable">
					<div class="box span12">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon user"></i><span class="break"></span>系统角色管理
							</h2>
							<div class="box-icon">
								<a href="#" class="addRole"><i
									class="halflings-icon plus"></i> </a> <a href="#"
									class="btn-minimize"><i class="halflings-icon chevron-up"></i>
								</a> <a href="#" class="btn-close"><i
									class="halflings-icon remove"></i> </a>
							</div>
						</div>
						
						<!-- 数据展示 -->
						<div class="box-content">
						<!-- table框架 -->
						<form action="index.html" method="post" id="myform">
						<input name="pageIndex" id="pageIndex" type="hidden" value="${pageResult.pageIndex}"/>
						<input name="pageSize" type="hidden" value="${pageResult.pageSize}"/>
						</form>
							<table class="table table-striped table-bordered">
								<thead>
									<tr>
										<th >角色名</th>
										<th >创建时间</th>
										<th >创建者</th>
										<th >更新时间</th>
										<th >更新者</th>
										<th >状态</th>
										<th >操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${pageResult.param }" var="role">
									<tr>
										<td>${role.roleName }</td>
										<td><fmt:formatDate value="${role.createDate}"  pattern="yyyy-MM-dd HH:mm:ss" /> </td>
										<td>${role.createUser.userName }</td>
										<td><fmt:formatDate value="${role.updateDate}"   pattern="yyyy-MM-dd HH:mm:ss" /> </td>
										<td>${role.updateUser.userName }</td>
										<td>${role.status=="1"?"<span class='label label-success'>激活</span>":
										"<span class='label label-error'>冻结</span>" }</td>
										<td>
											<a class="btn btn-success editRole btn-mini" roleid="${role.roleId }" href="#"> 
												<i class="halflings-icon white edit"></i>修 改</a> 
											<a class="btn btn-danger changeStatu btn-mini" roleid="${role.roleId }" status="${role.status }" href="#"> 
												<i class="halflings-icon refresh white"></i>状 态</a>
										</td>
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
	<!-- 新增modal -->
	<div class="modal hide fade" id="addModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>系统角色管理</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">新建管理员</small></p>
				<div class="input-prepend" title="菜单名字">
				<div class="alert alert-error alert-dismissable" style="display:none">
						 <span class="content" ></span>
				</div>
				<span class="add-on"><i class="halflings-icon user"></i> 名 称 </span>
				<input class="input-large span5" id="add_menuName"  type="text" placeholder="请输入角色名称" maxlength="10" >
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
			<h3>系统角色管理</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">修改管理员</small></p>			
					<div class="alert alert-error alert-dismissable" style="display:none">
						 <span class="content" ></span>
					</div>
					<table>
					<tr>
					<td>
						<span class="add-on"><i class="halflings-icon user"></i> 名 称 </span>
						<input type="hidden" id="roleId" >
					</td>
					<td>
						<input class="input-large span5" id="roleName"  type="text" placeholder="请输入角色名称" maxlength="10" >
					</td>
					</tr>
					<tr>
						<td>
							<span class="add-on"><i class="halflings-icon user"></i> 状态 </span>
						</td>
						<td>
							<label class="label" for="close">冻结：</label> <input type="radio" name="status" class="roleStatus"  id="close" value="0"/>
							<label class="label label-success" for="open">激活：</label> <input type="radio" name="status" class="roleStatus"  id="open" value="1"/>
						</td>
					</tr>
					</table>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary updateSubmit">保存</a>
		</div>
	</div>
	
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
	});

	//切换状态
	$(".changeStatu").click(function(){
		var status=$(this).attr("status");
		var roleId=$(this).attr("roleid");
		var param={};
		param.roleId=roleId;
		param.operator="update";
		var tip="";
		if(status=="0"){//激活
			param.status="1";
			tip="确认激活吗?";
		}else if(status=="1"){//冻结
			param.status="0";
			tip="确认冻结吗";
		}
		layer.confirm(tip, {
			title:"状态切换",
		    btn: ["确定","返回"], //按钮
		    shade: false //不显示遮罩
		}, function(){
			$.post("saveOrUpdate.html",param,function(data){
			if(data.status=="ok"){
				layer.msg("更新成功",{ icon: 1,time: 1000 },function(){
					reset();
				});
			}else{
				layer.msg("更新失败");
			}
		},"json");
		
		}, function(){
			
		});
		
		
	});
	
	//增加
	$(".addRole").click(function(){
		$("#add_menuName").val("");//重置名字
		$("#addModal .alert").hide();//隐藏提示框
		$("#addModal").modal("show");//展示modal
	});
	//提交新增
	$(".addSubmit").on("click",
	function(){
		$("#addModal .alert").hide();
		var param={};
		param.operator="add";
		param.roleName=$("#add_menuName").val();
		if(!param.roleName||$.trim(param.roleName)==""){
			$("#addModal .alert").removeClass("alert-success").addClass("alert-error");//错误信息
			$("#addModal .alert .content").text("角色名不能为空");//提示信息
			$("#addModal .alert").fadeIn("fast");
			return;
		}
		$.post("saveOrUpdate.html",param,function(data){
			if(data.status=="ok"){
				$("#addModal .alert").removeClass("alert-error").addClass("alert-success");//成功信息
				$("#addModal .alert .content").text("新增成功");//提示信息
				$("#addModal .alert").fadeIn("fast");
				setTimeout(reset, 1500);
			}else{
				$("#addModal .alert").removeClass("alert-success").addClass("alert-error");//成功信息
				$("#addModal .alert .content").text("新增失败");//提示信息
				$("#addModal .alert").fadeIn("fast");
				setTimeout(reset, 1500);
			}
		},"json");
		}
	);
	
	//修改
	$(".editRole").click(function(){
		$("#updateModal .alert").hide();//隐藏提示框
		var roleId=$(this).attr("roleId");
		if(roleId){
		$.post("list.html",{"roleId":roleId},function(data){
			$("#roleName").val(data.roleName);
			$("#roleId").val(data.roleId);
			$(".roleStatus").each(function(){
				if($(this).val()==data.status){
					$(this).attr("checked","checked");
				}
			});
			$("#updateModal").modal("show");
		},"json");		
		}
	});
	
	//提交更新
	$(".updateSubmit").click(
	function(){
		var param={};
		param.operator="update";
		param.roleName=$("#roleName").val();
		param.roleId=$("#roleId").val();
		param.status=$(".roleStatus:checked").val();
		$.post("saveOrUpdate.html",param,function(data){
			if(data.status=="ok"){
				$("#updateModal .alert").removeClass("alert-error").addClass("alert-success");//成功信息
				$("#updateModal .alert .content").text("更新成功");//提示信息
				$("#updateModal .alert").fadeIn("fast");
				setTimeout(reset, 1500);
			}else{
				$("#updateModal .alert").removeClass("alert-success").addClass("alert-error");//成功信息
				$("#updateModal .alert .content").text("更新失败");//提示信息
				$("#updateModal .alert").fadeIn("fast");
				setTimeout(reset, 1500);
			}
			
		},"json");
	}
	);
	
	//刷新页面
	function reset(){
		$("#myform").submit();
	}
	</script>
</body>
</html>
