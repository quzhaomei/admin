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
label.error{
	display: inline-block;
	*display: inline;
	*zoom:1;
	margin-left:15px;
	color:#2D89EF;
	background: #e2e2e2;
	padding:5px 10px;
	}
label.error:before{
  content:"×";
  color:#2D89EF;
}
.errorDiv{
display: inline-block;
	*display: inline;
	*zoom:1;
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
			<form action="index.html" id="myform"></form>
			
			<!-- start: Content -->
			<div id="content" class="span10">

				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="index.html">首页</a> <i
						class="icon-angle-right"></i></li>
				<!-- 	<li><a href="#">系统设置<i class="icon-angle-right"></i> </a> -->
					</li>
					<li><a href="#">凯特猫参数设置<i class="icon-angle-right"></i> </a>
					</li>
					<li><a href="#">家具系统参数</a>
					</li>
				</ul>
				
				<!-- 品牌类型 -->
				<div class="row-fluid sortable ">
					<!-- 类型 -->
					<div class="box span12 brandType">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon leaf"></i><span class="break"></span>品牌类型
							</h2>
							<div class="box-icon">
								<a href="#" class="add"><i
									class="halflings-icon plus"></i> </a> <a href="#"
									class="btn-minimize"><i class="halflings-icon chevron-up"></i>
								</a> <a href="#" class="btn-close"><i
									class="halflings-icon remove"></i> </a>
							</div>
						</div>
						
						<!-- 数据展示 -->
						<div class="box-content">
						<!-- table框架 -->
							<table class="table table-striped table-bordered bootstrap-datatable datatable">
								<thead>
									<tr>
										<th>类型名称</th>
										<th>icon</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${brandTypeList }" var="brandType">
									<tr>
										<td>${brandType.name }</td>
										<td>${brandType.html }</td>
										<td>
											<a class="btn btn-success editRole btn-mini edit" brandTypeId="${brandType.brandTypeId }" href="#"> 
												<i class="halflings-icon white edit"></i> 修 改</a> 
											<a class="btn btn-danger  btn-mini del" brandTypeId="${brandType.brandTypeId }" status="0" href="#"> 
												<i class="halflings-icon trash white"></i> 删除</a>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				
				<div class="row-fluid sortable">
					<!--功能区域-->
					<div class="box span6 zone">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon screenshot"></i><span class="break"></span>功能区域
							</h2>
							<div class="box-icon">
								<a href="#" class="add"><i
									class="halflings-icon plus"></i> </a> <a href="#"
									class="btn-minimize"><i class="halflings-icon chevron-up"></i>
								</a> <a href="#" class="btn-close"><i
									class="halflings-icon remove"></i> </a>
							</div>
						</div>
						
						<!-- 数据展示 -->
						<div class="box-content">
						<!-- table框架 -->
							<table class="table table-striped table-bordered bootstrap-datatable datatable">
								<thead>
									<tr>
										<th >功能区域</th>
										<th >创建时间</th>
										<th >操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${zoneList}" var="zone">
									<tr>
										<td>${zone.zoneName }</td>
										<td><fmt:formatDate value="${zone.createDate }"   pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td>
											<a class="btn btn-success editRole btn-mini edit" zoneid="${zone.zoneId }" href="#"> 
												<i class="halflings-icon white edit"></i> 修 改</a> 
											<a class="btn btn-danger  btn-mini del" zoneid="${zone.zoneId }" status="0" href="#"> 
												<i class="halflings-icon trash white"></i> 删除</a>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					
					<!--家具品类-->
					<div class="box span6 type">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon list"></i><span class="break"></span>家具品类
							</h2>
							<div class="box-icon">
								<a href="#" class="add"><i
									class="halflings-icon plus"></i> </a> <a href="#"
									class="btn-minimize"><i class="halflings-icon chevron-up"></i>
								</a> <a href="#" class="btn-close"><i
									class="halflings-icon remove"></i> </a>
							</div>
						</div>
						
						<!-- 数据展示 -->
						<div class="box-content">
						<!-- table框架 -->
							<table class="table table-striped table-bordered bootstrap-datatable datatable">
								<thead>
									<tr>
										<th >家具品类</th>
										<th >创建时间</th>
										<th style="width: 150px;">功能区域</th>
										<th >操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${typeList }" var="type">
									<tr>
										<td>${type.typeName }</td>
										<td><fmt:formatDate value="${type.createDate }"   pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td>
											<c:forEach items="${type.zones }" var="zone">
												<span class="label">${zone.zoneName }</span>
											</c:forEach>
										</td>
										<td>
											<a class="btn btn-success editRole btn-mini edit" typeid="${type.typeId }" href="#"> 
												<i class="halflings-icon white edit"></i> 修 改</a> 
											<a class="btn btn-danger  btn-mini del" typeid="${type.typeId }" status="0" href="#"> 
												<i class="halflings-icon trash white"></i> 删除</a>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				<div class="row-fluid sortable ">
					<!-- 风格 -->
					<div class="box span6 style">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon leaf"></i><span class="break"></span>风格
							</h2>
							<div class="box-icon">
								<a href="#" class="add"><i
									class="halflings-icon plus"></i> </a> <a href="#"
									class="btn-minimize"><i class="halflings-icon chevron-up"></i>
								</a> <a href="#" class="btn-close"><i
									class="halflings-icon remove"></i> </a>
							</div>
						</div>
						
						<!-- 数据展示 -->
						<div class="box-content">
						<!-- table框架 -->
							<table class="table table-striped table-bordered bootstrap-datatable datatable">
								<thead>
									<tr>
										<th >风格</th>
										<th >创建时间</th>
										<th >操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${styleList }" var="style">
									<tr>
										<td>${style.styleName }</td>
										<td><fmt:formatDate value="${style.createDate }"   pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td>
											<a class="btn btn-success editRole btn-mini edit" styleid="${style.styleId }" href="#"> 
												<i class="halflings-icon white edit"></i> 修 改</a> 
											<a class="btn btn-danger  btn-mini del" styleid="${style.styleId }" status="0" href="#"> 
												<i class="halflings-icon trash white"></i> 删除</a>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<!-- 购买预算 -->
					<div class="box span6 budget">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon shopping-cart"></i><span class="break"></span>购买预算
							</h2>
							<div class="box-icon">
								<a href="#" class="add"><i
									class="halflings-icon plus"></i> </a> <a href="#"
									class="btn-minimize"><i class="halflings-icon chevron-up"></i>
								</a> <a href="#" class="btn-close"><i
									class="halflings-icon remove"></i> </a>
							</div>
						</div>
						
						<!-- 数据展示 -->
						<div class="box-content">
						<!-- table框架 -->
							<table class="table table-striped table-bordered bootstrap-datatable datatable">
								<thead>
									<tr>
										<th >最少 <span class="label">万元</span></th>
										<th >最多 <span class="label">万元</span></th>
										<th >创建时间</th>
										<th >操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${budgetList }" var="budget">
									<tr>
										<td>${budget.startNum } </td>
										<td>${budget.endNum } </td>
										<td><fmt:formatDate value="${budget.createDate }"   pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td>
											<a class="btn btn-success editRole btn-mini edit" budgetId="${budget.budgetId }" href="#"> 
												<i class="halflings-icon white edit"></i> 修 改</a> 
											<a class="btn btn-danger  btn-mini del" budgetId="${budget.budgetId }" status="0" href="#"> 
												<i class="halflings-icon trash white"></i> 删除</a>
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
	<!-- 品牌类型新增modal -->
	<div class="modal hide fade" id="addBrandType">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>品牌类型参数</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">新增品牌类型</small></p>
				<form action="#" class="dataForm">
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on"> * 类型名称  </span></td>
					<td><input class="input-large span3" id="add_name" 
					name="add_name"  type="text" placeholder="请输入品牌名称" maxlength="10" > 
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td style="width:90px"><span class="add-on"> * html代码  </span></td>
					<td><input class="input-large span3" id="add_html" 
					name="add_html"  type="text" placeholder="请输入html" maxlength="40" > 
					<div class="errorDiv"></div>
					</td>
				</tr>
				</table>
				</form>
				<div>
				<small class="text-error" style="margin-left:20px"> *  为必填</small>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary submit">保存</a>
		</div>
	</div>
	
		<!-- 品牌类型修改modal -->
	<div class="modal hide fade" id="updateBrandType">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>品牌类型参数</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">修改品牌类型</small></p>
				<form action="#" class="dataForm">
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on"> * 类型名称  </span></td>
					<input id="update_id"   type="hidden"  /> 
					<td><input class="input-large span3" id="update_name" 
					name="update_name"  type="text" placeholder="请输入品牌名称" maxlength="10" > 
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td style="width:90px"><span class="add-on"> * html代码  </span></td>
					<td><input class="input-large span3" id="update_html" 
					name="update_html"  type="text" placeholder="请输入html" maxlength="40" > 
					<div class="errorDiv"></div>
					</td>
				</tr>
				</table>
				</form>
				<div>
				<small class="text-error" style="margin-left:20px"> *  为必填</small>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary submit">保存</a>
		</div>
	</div>
	
	
	<!-- 功能区域新增modal -->
	<div class="modal hide fade" id="addZone">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>家具系统参数</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">新增功能区域</small></p>
				<form action="#" class="dataForm">
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on"> * 区域名称  </span></td>
					<td><input class="input-large span3" id="add_zoneName" 
					name="add_zoneName"  type="text" placeholder="请输入功能区域名称" maxlength="10" > 
					<div class="errorDiv"></div>
					</td>
				</tr>
				</table>
				</form>
				<div>
				<small class="text-error" style="margin-left:20px"> *  为必填</small>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary submit">保存</a>
		</div>
	</div>
	
	<!-- 功能区域修改modal -->
	<div class="modal hide fade" id="updateZone">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>家具系统参数</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">修改功能区域</small></p>			
				<form action="#" class="dataForm">
				<input type="hidden" id="edit_zoneId" />
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on">* 区域名称  </span></td>
					<td><input class="input-large span3" id="edit_zoneName" name="edit_zoneName"  type="text" placeholder="请输入功能区域名称" maxlength="10" > 
					<div class="errorDiv"></div>
					</td>
				</tr>				
				</table>
				</form>
				<div><small class="text-error" style="margin-left:20px"> *  为必填</small></div>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary submit">保存</a>
		</div>
	</div>
	
	<!-- 品类新增modal -->
	<div class="modal hide fade" id="addType">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>家具系统参数</h3>
		</div>
		<div class="modal-body" style="min-height:400px">
			<p><small class="text-success">新增家具品类</small></p>
				<form action="#" class="dataForm">
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on"> * 品类名称  </span></td>
					<td><input class="input-large span3" id="add_typeName" 
					name="add_typeName"  type="text" placeholder="请输入品类名称" maxlength="10" > 
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td style="width:90px"><span class="add-on"> * 功能区域  </span></td>
					<td>
						<select class="select" multiple  id="add_zones" name="add_zones" data-placeholder="请选择功能（可多选）">
						<c:forEach items="${zoneList }" var="zone">
							<option value="${zone.zoneId }">${zone.zoneName }</option>
						</c:forEach>
						</select>
					<div class="errorDiv"></div>
					</td>
				</tr>
				</table>
				</form>
				<div>
				<small class="text-error" style="margin-left:20px"> *  为必填</small>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary submit">保存</a>
		</div>
	</div>	

	<!-- 品类修改modal -->
	<div class="modal hide fade" id="updateType">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>家具系统参数</h3>
		</div>
		<div class="modal-body" style="min-height:400px">
			<p><small class="text-success">修改家具品类</small></p>
				<form action="#" class="dataForm">
				<table class="table table-bordered">
				<tr>
					<input type="hidden"  id="edit_typeId"/>
					<td style="width:90px"><span class="add-on"> * 品类名称  </span></td>
					<td><input class="input-large span3" id="edit_typeName" 
					name="edit_typeName"  type="text" placeholder="请输入品类名称" maxlength="10" > 
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td style="width:90px"><span class="add-on"> * 功能区域  </span></td>
					<td>
						<select class="select" multiple  id="edit_zones" name="edit_zones" data-placeholder="请选择功能（可多选）">
						<c:forEach items="${zoneList }" var="zone">
							<option value="${zone.zoneId }">${zone.zoneName }</option>
						</c:forEach>
						</select>
					<div class="errorDiv"></div>
					</td>
				</tr>
				</table>
				</form>
				<div>
				<small class="text-error" style="margin-left:20px"> *  为必填</small>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary submit">保存</a>
		</div>
	</div>	
	
	<!-- 风格新增modal -->
	<div class="modal hide fade" id="addStyle">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>家具系统参数</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">新增家具风格</small></p>
				<form action="#" class="dataForm">
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on"> * 风格名称  </span></td>
					<td><input class="input-large span3" id="add_styleName" 
					name="add_styleName"  type="text" placeholder="请输入风格名称" maxlength="10" > 
					<div class="errorDiv"></div>
					</td>
				</tr>
				</table>
				</form>
				<div>
				<small class="text-error" style="margin-left:20px"> *  为必填</small>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary submit">保存</a>
		</div>
	</div>
	
	<!-- 风格修改modal -->
	<div class="modal hide fade" id="updateStyle">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>家具系统参数</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">修改家具风格</small></p>
				<form action="#" class="dataForm">
				<table class="table table-bordered">
				<input type="hidden" id="edit_styleId"/>
				<tr>
					<td style="width:90px"><span class="add-on"> * 风格名称  </span></td>
					<td><input class="input-large span3" id="edit_styleName" 
					name="edit_styleName"  type="text" placeholder="请输入风格名称" maxlength="10" > 
					<div class="errorDiv"></div>
					</td>
				</tr>
				</table>
				</form>
				<div>
				<small class="text-error" style="margin-left:20px"> *  为必填</small>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary submit">保存</a>
		</div>
	</div>
	
	<!-- 预算新增modal -->
	<div class="modal hide fade" id="addBudget">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>家具系统参数</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">新增家具预算</small></p>
				<form action="#" class="dataForm">
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on"> * 最低  </span></td>
					<td><input class="input-large span2" id="add_startNum" 
					name="add_startNum"  type="text" placeholder="请输入最低预算" maxlength="10" > 
					<span class="label ">万元</span>
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td style="width:90px"><span class="add-on"> * 最高  </span></td>
					<td><input class="input-large span2" id="add_endNum" 
					name="add_endNum"  type="text" placeholder="请输入最高预算" maxlength="10" > 
					<span class="label ">万元</span>
					<div class="errorDiv"></div>
					</td>
				</tr>
				</table>
				</form>
				<div>
				<small class="text-error" style="margin-left:20px"> *  为必填，单位为 万元</small>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary submit">保存</a>
		</div>
	</div>
	
	<!-- 修改家具预算 -->
	<div class="modal hide fade" id="updateBudget">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>家具系统参数</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">新增家具预算</small></p>
				<form action="#" class="dataForm">
				<table class="table table-bordered">
				<input type="hidden" id="edit_budgetId"/>
				<tr>
					<td style="width:90px"><span class="add-on"> * 最低  </span></td>
					<td><input class="input-large span2" id="edit_startNum" 
					name="edit_startNum"  type="text" placeholder="请输入最低预算" maxlength="10" > 
					<span class="label ">万元</span>
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td style="width:90px"><span class="add-on"> * 最高  </span></td>
					<td><input class="input-large span2" id="edit_endNum" 
					name="edit_endNum"  type="text" placeholder="请输入最高预算" maxlength="10" > 
					<span class="label ">万元</span>
					<div class="errorDiv"></div>
					</td>
				</tr>
				</table>
				</form>
				<div>
				<small class="text-error" style="margin-left:20px"> *  为必填，单位为 万元</small>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary submit">保存</a>
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
	 $.ajaxSetup({ async: false });
	//下拉款美化
	$(".select").chosen();
	

	//事件绑定
	$(function(){
	/**品牌类型设置**/
	//添加
	$(".brandType").on("click",".add",function(){
		$("#addBrandType").modal("show");
	});
	$("#addBrandType .dataForm").validate({
		rules:{
			add_name:{
				required:true
			},
			add_html:{
				required:true
			}
		},
		messages:{
			add_name:{
				required:"请输入名称",
				maxlength:"值太大"
			},
			add_html:{
				required:"请输入html代码",
				maxlength:"值太大"
			}
		},
		errorPlacement: function(error, element) {  
   		 error.appendTo(element.parent().find("div.errorDiv"));  
		}
	});
	//保存操作
	$("#addBrandType .submit").on("click",function(){
		if($("#addBrandType .dataForm").valid()){
			$("#addBrandType .submit").unbind("click");//接触添加事件
			var param={};
			param.operator="addBrandType";
			param.name=$("#add_name").val();
			param.html=$("#add_html").val();
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status=="ok"){
					layer.msg("添加成功！",{ icon: 1,time: 1000 },function(){
						reset();
					});
				}
			},"json");
		}
	});
	//修改操作
	$(".brandType").on("click",".edit",function(){
		var brandTypeId=$(this).attr("brandTypeId");
		var param={};
		param.operator="findbrandTypeById";
		param.brandTypeId=brandTypeId;
		if(brandTypeId){
			$.post("list.html",param,function(json){
				if(json){
					$("#update_id").val(json.brandTypeId);
					$("#update_name").val(json.name).attr("bak",json.name);
					$("#update_html").val(json.html).attr("bak",json.html);
					$("#updateBrandType").modal("show");
				}
			},"json");
		}
	});
	$("#updateBrandType .dataForm").validate({
		rules:{
			update_name:{
				required:true
			},
			update_html:{
				required:true
			}
		},
		messages:{
			update_name:{
				required:"请输入名称",
				maxlength:"值太大"
			},
			update_html:{
				required:"请输入html代码",
				maxlength:"值太大"
			}
		},
		errorPlacement: function(error, element) {  
   		 error.appendTo(element.parent().find("div.errorDiv"));  
		}
	});
	//修改操作
	$("#updateBrandType .submit").on("click",function(){
		if($("#updateBrandType .dataForm").valid()){
			$("#updateBrandType .submit").unbind("click");//接触添加事件
			var param={};
			param.operator="updateBrandType";
			param.brandTypeId=$("#update_id").val();
			
			var name=$("#update_name").val();
			var html=$("#update_html").val();
			if(name!=$("#update_name").attr("bak")){
				param.name=name;
			}
			if(html!=$("#update_html").attr("bak")){
				param.html=html;
			}
			
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status=="ok"){
					layer.msg("更新成功！",{ icon: 1,time: 1000 },function(){
						reset();
					});
				}
			},"json");
		}
	});
	//功能区域删除
	$(".brandType").on("click",".del",function(){//功能区域删除
		var brandTypeId=$(this).attr("brandTypeId");
		if(brandTypeId){
			layer.confirm("确定删除吗？", {
				title:"删除提示",
			    btn: ["确定","返回"], //按钮
			    shade: false //不显示遮罩
			}, function(){
				var param={};
				param.operator="updateBrandType";
				param.brandTypeId=brandTypeId;
				param.status="0";//删除
					$.post("saveOrUpdate.html",param,function(json){
						if(json.status=="ok"){
							layer.msg("删除成功！",{ icon: 1,time: 1000 },function(){
								reset();
							});
						}
					},"json");
			
			}, function(){
				
			});
		}
	});
	
	
	/**家具预算设置**/	
	//添加
	$(".budget").on("click",".add",function(){
		$("#addBudget").modal("show");
	});
	$("#addBudget .submit").on("click",function(){
		if($("#addBudget .dataForm").valid()){
			$("#addBudget .submit").unbind("click");//接触添加事件
			var param={};
			param.operator="addBudget";
			param.startNum=$("#add_startNum").val();
			param.endNum=$("#add_endNum").val();
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status=="ok"){
					layer.msg("添加成功！",{ icon: 1,time: 1000 },function(){
						reset();
					});
				}
			},"json");
		}
	});
	
	$("#addBudget .dataForm").validate({
		rules:{
			add_startNum:{
				required:true,
				number:true
			},
			add_endNum:{
				required:true,
				number:true,
				compareTo:"#add_startNum"
			}
		},
		messages:{
			add_startNum:{
				required:"请输入最低预算",
				maxlength:"值太大",
				number:"请输入一个数值"
			},
			add_endNum:{
				required:"请输入最高预算",
				maxlength:"值太大",
				number:"请输入一个数值",
				compareTo:"不能比最低预算小"
			}
		},
		errorPlacement: function(error, element) {  
   		 error.appendTo(element.parent().find("div.errorDiv"));  
		}
	});
	$.validator.addMethod("compareTo", function(value, element,param) { 
		var startNum=$(param).val();
		startNum=parseFloat(startNum,"10");
		value=parseFloat(value,"10");
	   	 return this.optional(element) || startNum<value;
		});
	//修改
	$(".budget").on("click",".edit",function(){
		var budgetId=$(this).attr("budgetId");
		var param={};
		param.operator="findBudgetById";
		param.budgetId=budgetId;
		if(budgetId){
			$.post("list.html",param,function(json){
				if(json){
					$("#edit_budgetId").val(json.budgetId);
					$("#edit_startNum").val(json.startNum);
					$("#edit_endNum").val(json.endNum);
					$("#updateBudget").modal("show");
				}
			},"json");
		}
	});
	$("#updateBudget .submit").on("click",function(){
		if($("#updateBudget .dataForm").valid()){
			$("#updateBudget .submit").unbind("click");
			var param={};
			param.operator="updateBudget";
			param.budgetId=$("#edit_budgetId").val();
			param.startNum=$("#edit_startNum").val();
			param.endNum=$("#edit_endNum").val();
			
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status=="ok"){
					layer.msg("修改成功！",{ icon: 1,time: 1000 },function(){
						reset();
					});
				}
			},"json");
		}
	});
	//修改家具品类数据验证
	$("#updateBudget .dataForm").validate({
		rules:{
			edit_startNum:{
				required:true,
				number:true
			},
			edit_endNum:{
				required:true,
				number:true,
				compareTo:"#edit_startNum"
			}
		},
		messages:{
			edit_startNum:{
				required:"请输入最低预算",
				maxlength:"值太大",
				number:"请输入一个数值"
			},
			edit_endNum:{
				required:"请输入最高预算",
				maxlength:"值太大",
				number:"请输入一个数值",
				compareTo:"不能比最低预算小"
			}
		},
		errorPlacement: function(error, element) {  
   		 error.appendTo(element.parent().find("div.errorDiv"));  
		}
	});
	//功能区域删除
	$(".budget").on("click",".del",function(){//功能区域删除
		var budgetId=$(this).attr("budgetId");
		if(budgetId){
			layer.confirm("确定删除吗？", {
				title:"删除提示",
			    btn: ["确定","返回"], //按钮
			    shade: false //不显示遮罩
			}, function(){
				var param={};
				param.operator="updateBudget";
				param.budgetId=budgetId;
				param.status="0";//删除
					$.post("saveOrUpdate.html",param,function(json){
						if(json.status=="ok"){
							layer.msg("删除成功！",{ icon: 1,time: 1000 },function(){
								reset();
							});
						}
					},"json");
			
			}, function(){
				
			});
		}
	});
	
	
	/**家具品类操作**/
	//添加
	$(".type").on("click",".add",function(){
		$("#addType").modal("show");
	});
	$("#addType .submit").on("click",function(){
		if($("#addType .dataForm").valid()){
			$("#addType .submit").unbind("click");//接触添加事件
			var param={};
			param.operator="addType";
			param.typeName=$("#add_typeName").val();
			if($("#add_zones").val()){
				param.zoneIds=$("#add_zones").val().join(",");
			}
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status=="ok"){
					layer.msg("添加成功！",{ icon: 1,time: 1000 },function(){
						reset();
					});
				}
			},"json");
		}
	});
	
	$("#addType .dataForm").validate({
		rules:{
			add_typeName:{
				required:true
			},
			add_zones:{
				required:true
			}
		},
		messages:{
			add_typeName:{
				required:"请输入家具品类名字",
				maxlength:"字数过多"
			},
			add_zones:{
				required:"至少要有一个功能区域"
			}
		},
		errorPlacement: function(error, element) {  
   		 error.appendTo(element.parent().find("div.errorDiv"));  
		}
	});
	//修改
	$(".type").on("click",".edit",function(){
		var typeId=$(this).attr("typeid");
		var param={};
		param.operator="findTypeById";
		param.typeId=typeId;
		if(typeId){
			$.post("list.html",param,function(json){
				if(json){
					$("#edit_typeId").val(json.typeId);
					$("#edit_typeName").val(json.typeName);
					$("#edit_zones option").each(function(){
						$(this).removeAttr("selected");//初始化
						var _this=this;
						$(json.zones).each(function(){
							if($(_this).val()==this.zoneId){
								$(_this).attr("selected","selected");
							}
						});
					});
					$("#edit_zones").trigger("liszt:updated");
					$("#updateType").modal("show");
				}
			},"json");
		}
	});
	$("#updateType .submit").on("click",function(){
		if($("#updateType .dataForm").valid()){
			$("#updateType .submit").unbind("click");
			var param={};
			param.typeId=$("#edit_typeId").val();
			param.operator="updateType";
			param.typeName=$("#edit_typeName").val();
			if($("#edit_zones").val()){
				param.zoneIds=$("#edit_zones").val().join(",");
			}
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status=="ok"){
					layer.msg("修改成功！",{ icon: 1,time: 1000 },function(){
						reset();
					});
				}
			},"json");
		}
	});
	//修改家具品类数据验证
	$("#updateType .dataForm").validate({
		rules:{
			edit_typeName:{
				required:true
			}
		},
		messages:{
			edit_typeName:{
				required:"请输入家具品类名字",
				maxlength:"字数过多"
			}
		},
		errorPlacement: function(error, element) {  
   		 error.appendTo(element.parent().find("div.errorDiv"));  
		}
	});
	//功能区域删除
	$(".type").on("click",".del",function(){//功能区域删除
		var typeId=$(this).attr("typeId");
		if(typeId){
			layer.confirm("确定删除吗？", {
				title:"删除提示",
			    btn: ["确定","返回"], //按钮
			    shade: false //不显示遮罩
			}, function(){
				var param={};
				param.operator="updateType";
				param.typeId=typeId;
				param.status="0";//删除
					$.post("saveOrUpdate.html",param,function(json){
						if(json.status=="ok"){
							layer.msg("删除成功！",{ icon: 1,time: 1000 },function(){
								reset();
							});
						}
					},"json");
			
			}, function(){
				
			});
		}
	});
	
	
	/**功能区域操作事件**/
	$(".zone").on("click",".add",function(){//功能区域添加
		$("#addZone").modal("show");
	});
	$("#addZone .submit").on("click",function(){//功能区域添加保存
		var zoneName=$("#add_zoneName").val();
		if($("#addZone .dataForm").valid()){
			$("#addZone .submit").unbind("click");//解绑
			var param={};
			param.operator="addZone";
			param.zoneName=zoneName;
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status=="ok"){
					layer.msg("添加成功！",{ icon: 1,time: 1000 },function(){
						reset();
					});
				}
			},"json");
		}
	});
	//新增功能区域的数据验证
	$("#addZone .dataForm").validate({
		rules:{
			add_zoneName:{
				required:true
			}
		},
		messages:{
			add_zoneName:{
				required:"请输入功能区域名字",
				maxlength:"字数过多"
			}
		},
		errorPlacement: function(error, element) {  
   		 error.appendTo(element.parent().find("div.errorDiv"));  
		}
	});
	
	$(".zone").on("click",".edit",function(){//功能区域修改
		var zoneId=$(this).attr("zoneid");
		var param={};
		param.operator="findZoneById";
		param.zoneId=zoneId;
		if(zoneId){
			$.post("list.html",param,function(json){
				if(json){
					$("#edit_zoneId").val(json.zoneId);
					$("#edit_zoneName").val(json.zoneName);
				}
			},"json");
		}
		$("#updateZone").modal("show");
	});
	$("#updateZone .submit").on("click",function(){//功能区域修改
		var zoneName=$("#edit_zoneName").val();
		var zoneId=$("#edit_zoneId").val();
		if($("#updateZone .dataForm").valid()){
			$("#updateZone .submit").unbind("click");//解绑
			var param={};
			param.operator="updateZone";
			param.zoneName=zoneName;
			param.zoneId=zoneId;
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status=="ok"){
					layer.msg("修改成功！",{ icon: 1,time: 1000 },function(){
						reset();
					});
				}
			},"json");
		}
	});
	
	//修改功能区域
	//新增功能区域的数据验证
	$("#updateZone .dataForm").validate({
		rules:{
			edit_zoneName:{
				required:true
			}
		},
		messages:{
			edit_zoneName:{
				required:"请输入功能区域名字",
				maxlength:"字数过多"
			}
		},
		errorPlacement: function(error, element) {  
   		 error.appendTo(element.parent().find("div.errorDiv"));  
		}
	});
	//功能区域删除
	$(".zone").on("click",".del",function(){//功能区域删除
		var zoneId=$(this).attr("zoneId");
		if(zoneId){
			layer.confirm("确定删除吗？", {
				title:"删除提示",
			    btn: ["确定","返回"], //按钮
			    shade: false //不显示遮罩
			}, function(){
				var param={};
				param.operator="updateZone";
				param.zoneId=zoneId;
				param.status="0";//删除
					$.post("saveOrUpdate.html",param,function(json){
						if(json.status=="ok"){
							layer.msg("删除成功！",{ icon: 1,time: 1000 },function(){
								reset();
							});
						}
					},"json");
			
			}, function(){
				
			});
		}
	});
	
	/**家具风格操作**/
	$(".style").on("click",".add",function(){//功能区域添加
		$("#addStyle").modal("show");
	});
	$("#addStyle .submit").on("click",function(){//功能区域添加保存
		var styleName=$("#add_styleName").val();
		if($("#addStyle .dataForm").valid()){
			$("#addStyle .submit").unbind("click");//解绑
			var param={};
			param.operator="addStyle";
			param.styleName=styleName;
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status=="ok"){
					layer.msg("添加成功！",{ icon: 1,time: 1000 },function(){
						reset();
					});
				}
			},"json");
		}
	});
	//新增功能区域的数据验证
	$("#addStyle .dataForm").validate({
		rules:{
			add_styleName:{
				required:true
			}
		},
		messages:{
			add_styleName:{
				required:"请输入功能区域名字",
				maxlength:"字数过多"
			}
		},
		errorPlacement: function(error, element) {  
   		 error.appendTo(element.parent().find("div.errorDiv"));  
		}
	});
	
	$(".style").on("click",".edit",function(){//功能区域修改
		var styleId=$(this).attr("styleid");
		var param={};
		param.operator="findStyleById";
		param.styleId=styleId;
		if(styleId){
			$.post("list.html",param,function(json){
				if(json){
					$("#edit_styleId").val(json.styleId);
					$("#edit_styleName").val(json.styleName);
				}
			},"json");
		}
		$("#updateStyle").modal("show");
	});
	$("#updateStyle .submit").on("click",function(){//功能区域修改
		var styleName=$("#edit_styleName").val();
		var styleId=$("#edit_styleId").val();
		if($("#updateStyle .dataForm").valid()){
			$("#updateStyle .submit").unbind("click");//解绑
			var param={};
			param.operator="updateStyle";
			param.styleName=styleName;
			param.styleId=styleId;
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status=="ok"){
					layer.msg("修改成功！",{ icon: 1,time: 1000 },function(){
						reset();
					});
				}
			},"json");
		}
	});
	
	//修改家具风格
	//家具跟个修改的数据验证
	$("#updateStyle .dataForm").validate({
		rules:{
			edit_styleName:{
				required:true
			}
		},
		messages:{
			edit_styleName:{
				required:"请输入功能区域名字",
				maxlength:"字数过多"
			}
		},
		errorPlacement: function(error, element) {  
   		 error.appendTo(element.parent().find("div.errorDiv"));  
		}
	});
	//家具风格删除
	$(".style").on("click",".del",function(){//功能区域删除
		var styleId=$(this).attr("styleId");
		if(styleId){
			layer.confirm("确定删除吗？", {
				title:"删除提示",
			    btn: ["确定","返回"], //按钮
			    shade: false //不显示遮罩
			}, function(){
				var param={};
				param.operator="updateStyle";
				param.styleId=styleId;
				param.status="0";//删除
					$.post("saveOrUpdate.html",param,function(json){
						if(json.status=="ok"){
							layer.msg("删除成功！",{ icon: 1,time: 1000 },function(){
								reset();
							});
						}
					},"json");
			
			}, function(){
				
			});
		}
	});
	
});
	
	//刷新页面
	function reset(){
		$("#myform").submit();
	}
	</script>
</body>
</html>
