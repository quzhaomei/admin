<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/myTag" prefix="my" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>后台管理</title>

<c:import url="public/p-css.jsp"></c:import>

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
.modal.fade.in{
top:2%;
}
</style>
</head>

<body>
	<c:import url="public/p-header.jsp"></c:import>

	<div class="container-fluid-full">
		<div class="row-fluid">

			<!-- start: Main Menu -->
			<c:import url="menu_temp.jsp"></c:import>
			<!-- end: Main Menu -->

			<!-- start: Content -->
			<div id="content" class="span10">

				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="../welcome/index.html">首页</a> <i
						class="icon-angle-right"></i></li>
					<li><a href="#">系统用户管理</a>
					</li>
				</ul>
				<div class="row-fluid sortable">
					<div class="box span12">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon user"></i><span class="break"></span>系统用户管理
							</h2>
							<div class="box-icon">
								<a href="#" class="addUser"><i
									class="halflings-icon plus"></i> </a> <a href="#"
									class="btn-minimize"><i class="halflings-icon chevron-up"></i>
								</a> <a href="#" class="btn-close"><i
									class="halflings-icon remove"></i> </a>
							</div>
						</div>
						
						<!-- 数据展示 -->
						<div class="box-content">
						<!-- table框架 -->
						<form action="index.html" method="post" id="myform" rel="admin-form">
						
						<select  class="roleSelect" id="roleFilterSelect" rel="chosen" name="roleId" data-placeholder="角色筛选" style="width:200px;">
								<option value="-1">所有角色</option>
							<c:forEach items="${roles }" var="role">
								<option value="${role.roleId }" ${role.roleId==roleId?"selected":"" }>${role.roleName }</option>
							</c:forEach>
						</select> 
						<input name="pageIndex" id="pageIndex" type="hidden" value="${pageResult.pageIndex}"/>
						<input name="pageSize" type="hidden" value="${pageResult.pageSize}"/>
						
						</form>
							<table class="table table-striped table-bordered">
								<thead>
									<tr>
										<th style="width: 10%">用户名</th>
										<th style="width: 10%">登陆名</th>
										<th style="width: 10%">电话号码</th>
										<th style="width: 10%">邮箱</th>
										<th style="width: 10%">微信号</th>
										<th style="width: 10%">角色</th>
										<th style="width: 10%">状态</th>
										<th style="width: 30%">操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${pageResult.param }" var="user">
									<tr>
										<td>${user.userName }</td>
										<td>${user.loginname }</td>
										<td>${user.phone }</td>
										<td>${user.email }</td>
										<td>${user.wechatId }</td>
										<td>
											<c:forEach items="${user.rolesArr }" var="role">
												<span class="label">${role.roleName }</span>
											</c:forEach>
										</td>
										<td>${user.status=="1"?"<span class='label label-success'>激活</span>":
										"<span class='label label-error'>冻结</span>" }</td>
										<td>
											<a class="btn btn-success editRole btn-mini edit" userid="${user.systemUserId }" href="#"> 
												<i class="halflings-icon white edit"></i> 修 改</a> 
											<a class="btn btn-danger  btn-mini changeStatu" userid="${user.systemUserId }" status="0" href="#"> 
												<i class="halflings-icon trash white"></i> 删除</a>
											<a class="btn btn-warn orange  btn-mini changeStatu" userid="${user.systemUserId  }" status="${user.status }" href="#"> 
												<i class="halflings-icon refresh white"></i>状 态</a>
											
											<a class="btn btn-info  btn-mini reset" userid="${user.systemUserId  }"  href="#"> 
												<i class="halflings-icon  halflings-icon repeat white"></i>重置密码</a>
											
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							<my:page pageIndex="${pageResult.pageIndex }"
									 pageSize="${pageResult.pageSize}" 
									 totalPage="${pageResult.totalPage}"></my:page>
							
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
			<h3>系统用户管理</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">新建系统用户</small></p>
				
				<form action="#" id="addForm">
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on"> * 真实姓名  </span></td>
					<td><input class="input-large span3" id="add_userName" name="add_userName"  type="text" placeholder="请输入真实姓名" maxlength="5" > 
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td><span class="add-on"><i class="halflings-icon list"></i> 权限赋予  </span> </td>
					<td><select multiple class="roleSelect" rel="chosen" name="add_roleArr" id="add_roleArr" data-placeholder="请选择用户角色（可多选）" style="width:200px;">
					<c:forEach items="${roles }" var="role">
						<option value="${role.roleId }">${role.roleName }</option>
					</c:forEach>
					</select> 
					 </td>
				</tr>
				<tr>
					<td> <span class="add-on">* 登录名  </span></td>
					<td><input class="input-large span3" id="add_loginName"  name="add_loginName" type="text" placeholder="请输入登录名" maxlength="15" >
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td><span class="add-on"> * 电话号码  </span></td>
					<td><input class="input-large span3" id="add_phone" name="add_phone" type="text" placeholder="请输入电话号码" maxlength="11" /> 
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td><span class="add-on"> 微信号</span></td>
					<td><input class="input-large span3" id="add_wechatId" name="add_wechatId" type="text" placeholder="请输入微信号" maxlength="11" /> 
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td><span class="add-on">邮箱</span></td>
					<td><input class="input-large span3" id="add_email" rel="admin-email" name="add_email" type="text" placeholder="请输入角色邮箱"  maxlength="25"/>
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td><span class="add-on"> 备注</span></td>
					<td colspan="1"><textarea id="description" maxlength="100" cols="8" rows="3" style="width:95%;height:95%"></textarea></td>
				</tr>
				</table>
				</form>
				<div>
				<small class="text-error">新建用户的密码，初始化为该用户的手机号码,<span class="text-arror"> *</span> 为必填</small>
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
			<h3>系统用户管理</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">修改管理员</small></p>			
				<form action="#" id="editForm">
				<input type="hidden" id="edit_userId" />
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on"> 真实姓名  </span></td>
					<td><input class="input-large span3" id="edit_userName" name="edit_userName"  type="text" placeholder="请输入真实姓名" maxlength="5" > 
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td><span class="add-on"><i class="halflings-icon list"></i> 权限赋予  </span> </td>
					<td><select multiple class="roleSelect" rel="chosen" name="edit_roleArr" id="edit_roleArr" data-placeholder="请选择用户角色（可多选）" style="width:200px;">
							<c:forEach items="${roles }" var="role">
								<option value="${role.roleId }">${role.roleName }</option>
							</c:forEach>
					</select> 
					 </td>
				</tr>
				<tr>
					<td> <span class="add-on"> 登录名  </span></td>
					<td><input class="input-large span3 "  id="edit_loginName"  name="edit_loginName" type="text" placeholder="请输入登录名" maxlength="15" />
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td><span class="add-on"> 电话号码  </span></td>
					<td><input class="input-large span3  "  id="edit_phone" name="edit_phone" type="text" maxlength="11" /> 
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td><span class="add-on"> 微信号  </span></td>
					<td><input class="input-large span3 "  id="edit_wechatId" name="edit_phone" type="text" /> 
					<div class="errorDiv"></div>
					</td>
				</tr>
				<tr>
					<td><span class="add-on">邮箱</span></td>
					<td><input class="input-large span3" id="edit_email" rel="admin-email" name="edit_email" type="text" placeholder="请输入角色邮箱"  maxlength="25"/>
					<div class="errorDiv"></div>
					</td>
				</tr>
			
				<tr>
					<td><span class="add-on"> 备注</span></td>
					<td colspan="1"><textarea id="edit_description" maxlength="100" cols="8" rows="2" style="width:95%;height:95%"></textarea></td>
				</tr>
				</table>
				</form>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary updateSubmit">保存</a>
		</div>
	</div>
	
	<div class="clearfix"></div>

	<c:import url="public/p-footer.jsp"></c:import>
	
	<!-- start: JavaScript-->
	<c:import url="public/p-javascript.jsp"></c:import>
	<!-- end: JavaScript-->
	
	<script type="text/javascript" src="../js/admin/userManager.js"></script>
</body>
</html>
