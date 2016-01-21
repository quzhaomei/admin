<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>汽车财经网站系统后台管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- start: CSS -->
<link id="bootstrap-style" href="../css/bootstrap.min.css"
	rel="stylesheet">
<link href="../css/bootstrap-responsive.min.css" rel="stylesheet">
<link id="base-style" href="../css/style.css" rel="stylesheet">
<link id="base-style-responsive" href="../css/style-responsive.css"
	rel="stylesheet">

<!-- end: CSS -->
<!-- start: 网站logo -->
<link rel="shortcut icon" href="../img/avatar.jpg">
<!-- end: Favicon -->
</head>
<style>
.condition {
	font-weight: bold;
	vertical-align: middle;
}
.table td.condition{text-align:right;}
 span.label{cursor: pointer;margin-left: 2px;}
</style>
<body>
	<div class="container-fluid-full">
		<div class="row-fluid">
			<!-- start: Content -->
			<div id="content" style="margin:0 0% !important;width:100%;">
				<div class="row-fluid">
						<!-- 条件选择 -->
						<div class="box-content">

							<form id="select_artical" action="fillTop.html" style="margin: 0 20px;">
								<fieldset>
								<input type="hidden" name="operator" value="toAdd"/>
								<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
								<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }"/>
								</fieldset>
							</form>
							<table class="table table-bordered" style="width:85%;margin:0 50px;">
							<caption>发送短信</caption>
							<tr><td width="20%" >信息</td><td><textarea style="width:800px;height:50px;resize:none;"></textarea></td>
							</tr>
							<tr><td>发送至 </td><td>
							<span id="toUser"></span>
							 <i class="halflings-icon plus" id="addUser" 
							 style="cursor:pointer" title="增加联系人"></i>
							 </td>
							</tr>
							</table>
					</div>
					<!--/span-->
					<div class="box span12" style="padding:0 10px; ">
						<!-- 数据展示 -->
						<div class="box-content">
							<table class="table table-striped table-bordered table-bordered bootstrap-datatable datatable">
								<thead>
									<tr>
										<th style="width:20%;">姓名</th>
										<th style="width:25%;">电话</th>
										<th style="width:30%;">角色</th>
										<th style="width:15%;">操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${allUser }" var="user">
								<tr>
									<td style="width:20%;">${user.userName }</td>
										<td style="width:25%;">${user.phone }</td>
										<td style="width:30%;">
											<c:forEach items="${user.rolesArr }" var="role">
												<span class="label">${role.roleName }</span>
											</c:forEach>
									</td>
										<td style="width:15%;">
										<span class="label label-success" 
										onclick="addOrRemoveUser('${user.phone }','${user.userName }',this)"
										>增加</span>
										</td>
										</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!--/row-->
				<!--/span-->
			</div>

		</div>

	</div>
	</div>

	<div class="clearfix"></div>
	<!-- start: JavaScript-->
	<c:import url="javascript.jsp"></c:import>
	<!-- end: JavaScript-->
	<script type="text/javascript" src=""></script>
	<script>
	layer.config({
	    extend: 'extend/layer.ext.js'
	});  
	$("#addUser").on("click",function(){
		layer.prompt({
		    title: '输入电话号码',
		    formType: 0 ,
		    maxlength: 11
		}, function(pass,index){
			if(pass.match(/\d{11}/)){
		    	 addOrRemoveUser(pass,pass);
		    	 layer.close(index);
			}else{
				layer.msg("请输入正确格式的手机号码！");
			}
		});
	});
	function addOrRemoveUser(phone,name,obj){
		if(obj){//从表格转过来的
			if($("#phone"+phone)[0]){//如果存在，则移除
				$("#phone"+phone).remove();
				$(obj).addClass("label-success").text("增加")
			}else{
				$("#toUser").append(
						$("<span>").addClass("label lable-success").
						text(name).attr("id","phone"+phone).on("click",function(){
							addOrRemoveUser(phone,name,obj);
						}).attr("title","单击取消").attr("phone",phone)
						);
				$(obj).removeClass("label-success").text("取消");
			}
		}else{//手动输入
			$("#toUser").append(
					$("<span>").addClass("label lable-success").
					text(phone).on("click",function(){
						$(this).remove();
					}).attr("title","单击取消").attr("phone",phone)
					);
			
		}
	
	}
	</script>
</body>
</html>
