<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/myTag" prefix="my" %>
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
name,url{color:#d20;font-weight:bold;}
</style>
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
					<li><a href="#">手机号注册管理 <i class="icon-angle-right"></i> </a>
					</li>
					<li><a href="#">手机号注册</a>
					</li>
				</ul>	
				<p style="text-align: right;"><a href="list.html">下载数据</a></p>
				<div class="row-fluid sortable">
					<!--功能区域-->
					<div class="box span12 store">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon screenshot"></i><span class="break"></span>
								${empty activeName?"手机号注册":activeName }
							</h2>
							<div class="box-icon">
								<a href="#" class="add"><i
									class="halflings-icon plus add_register"></i> </a>  
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
						分类：<select  rel="chosen" name="status" id="chonseStatus" class="dateChange">
							<option value="-1" ${status=="-1"?"selected='selected'":""}>全部</option>
							<option value="0" ${status=="0"?"selected='selected'":"" }>发起中</option>
							<option value="2" ${status=="2"?"selected='selected'":"" }>短信中</option>
							<option value="1" ${status=="1"?"selected='selected'":"" }>已接收</option>
						</select> 
						
						预购时间：
						<input name="startTime" value="${startTime }" 
						autocomplete="off" type="text"  class="datepicker dateChange" 
						onkeyup="return false;" placeholder="请选择起始时间"/>
						~
						<input name="endTime" value="${endTime }" autocomplete="off" 
						type="text" class="datepicker dateChange" 
						onkeyup="return false;" placeholder="请选择结束时间"/>
						
						
						<input name="pageIndex" id="pageIndex"  type="hidden" value="${pageResult.pageIndex}"/>
						<input name="pageSize" type="hidden" value="${pageResult.pageSize}"/>
						</form>
						
							<table class="table table-striped table-hover ">
								<thead>
									<tr>
										<td width="5%">序列</td>
										<th width="10%">姓名</th>
										<th width="10%">电话号码</th>
										<th  width="15%">预购时间</th>
										<th  width="15%">发起时间</th>
										<th  width="10%">状态</th>
										<th width="25%">短信链接</th>
										<th width="10%">操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${pageResult.param}" var="temp" varStatus="status">
									<tr id="${temp.registerId }">
										<td style="font-weight:bold;font-size:15px">${(pageResult.pageIndex-1)*pageResult.pageSize+status.count}</td>
										<td>${temp.name }</td>
										<td>${temp.phone }</td>
										<td>
										<fmt:formatDate value="${temp.readyTime }" pattern="yyyy-MM-dd"/> 
										</td>
										<td>
										<fmt:formatDate value="${temp.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/> 
										</td>
										<td status="${temp.status}">
										<c:if test="${temp.status=='0' }">
										<span class="label">发起中</span>
										</c:if>
										<c:if test="${temp.status=='1'}">
										<span class="label label-success" >已接受</span>
										</c:if>
										<c:if test="${temp.status=='2'}">
										<span class="label label-important" >短信中</span>
										</c:if>
										</td>
										<td>
										${temp.shortUrl }
										</td>
										<td>
											<span class="label label-success editRegister" style="cursor:pointer;" registerId="${temp.registerId }">修改</span>
											<span class="label label-success toSend" 
											style="cursor:pointer;" 
											registerId="${temp.registerId }" >发送短信</span>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							<my:page pageIndex="${pageResult.pageIndex }"
									 pageSize="${pageResult.pageSize}" 
									 totalPage="${pageResult.totalPage}"></my:page>
							
						</div>
					</div>
					
				</div>	
			</div>
			<!-- end: Content -->
		</div>
		<!--/#content.span10-->
	</div>
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
	<script type="text/javascript">
	//跳转某页
	function toPage(index){
		$("#pageIndex").val(index);
		$("#myform").submit();
	}
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
	$(".dateChange").on("change",function(){
		toPage(1)//跳转第一页
	});
	
	$(function(){
		var msg="尊敬的<name>用户</name>,凯特猫家居返利，铁打的返利,详情点击链接 <url>url</url> -退订回复TD";
		var registerId;
		//发送短信
		$(".toSend").on("click",function(){
			registerId=$(this).attr("registerId");
			var status=$("#"+registerId).find("td:eq(5)").attr("status");//获取发送状态
			var phone=$("#"+registerId).find("td:eq(2)").text();
			if(status!="0"){//已经发送过，提示是否再次发送
				layer.confirm("确定再次向手机号为"+phone+"的用户再次发送短信吗？", {
						title:"再次发送",
					    btn: ["确定","返回"], //按钮
					    shade: false //不显示遮罩
					}, function(index){
						parseMsg(registerId);
						$("#msgContent").html(msg);
						$("#toSendModal").modal("show");
						layer.close(index);
					}, function(){
						
					});
			}else{
				parseMsg(registerId);
				$("#msgContent").html(msg);
				$("#toSendModal").modal("show");
			}
		});
		
		$(".sendSubmit").on("click",function(){
			msg=$("#msgContent").html();//替换模板
			var param={};
			param.operator="sendMsg";//发送短信
			param.registerId=registerId;
			param.content=msg;
			$.post("saveOrUpdate.html",param,function(json){
				if(json.isSuccess=="false"){
					layer.msg(json.info);
				}else{
					//发送成功，则更改状态
					$("#"+registerId).find("td:eq(5) span").text("发起中")
					.removeClass("label-important label-success");
					$("#"+registerId).find("td:eq(5)").attr("status","2");
					layer.msg(json.info);
					$("#toSendModal").modal("hide");
				}
			},"json");
		});
		//组装短信
		function parseMsg(registerId){
			var name=$("#"+registerId).find("td:eq(1)").text();
			var url=$("#"+registerId).find("td:eq(6)").text();
			msg=msg.replace(/<name>.+<\/name>/,"<name>"+name+"<\/name>")
			.replace(/<url>.+<\/url>/,"<url>"+url+"<\/url>");
		}
		
		$(".add_register").on("click",function(){
			$("#addModal").modal("show");
		});
		
		//保存操作
		$(".addSubmit").on("click",function(){
			var name=$("#add_name").val();
			var phone=$("#add_phone").val();
			if(!name){
				layer.msg("请输入姓名");
				return;
			}
			if(!phone){
				layer.msg("请输入手机");
				return;
			}
			var param={};
			param.operator="add";
			param.name=name;
			param.phone=phone;
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status==0){
					layer.msg(json.message);
				}else{
					layer.msg(json.message);
					window.location.reload();
				}
			},"json")
		});
		//修改操作
		$(".editRegister").on("click",function(){
			var registerId=$(this).attr("registerId");
			var param={};
				param.operator="findById";
				param.registerId=registerId;
				$.post("saveOrUpdate.html",param,function(html){
					if(html){
						$("#editContent").html(html);
						$("#editModal").modal("show");
						$('#editContent .datepicker').datepicker();
					}
				})
		});
		
		//保存修改
		$(".editSubmit").on("click",function(){
			var registerId=$("#edit_registerId").val();
			var name=$("#edit_name").val();
			var phone=$("#edit_phone").val();
			var readyTime=$("#edit_readyTime").val();
			var param={};
				param.operator="edit";
				param.registerId=registerId;
				if(!name){
					layer.msg("请输入姓名");
					return;
				}
				if(!phone){
					layer.msg("请输入手机");
					return;
				}
				var isChange=false;
				if(name!=$("#edit_name").attr("bak")){
					param.name=name;
					isChange=true;
				}
				if(phone!=$("#edit_phone").attr("bak")){
					param.phone=phone;
					isChange=true;
				}
				if(readyTime!=$("#edit_readyTime").attr("bak")){
					param.readyTime=readyTime;
					isChange=true;
				}
				if(!isChange){
					layer.msg("数据没有任何变化");
					return;
				}
				$.post("saveOrUpdate.html",param,function(json){
					if(json.status==0){
						layer.msg(json.message);
					}else{
						layer.msg(json.message);
						window.location.reload();
					}
				},"json");
		});
	});
	</script>
</body>
<!-- 发送短信modal -->
<div class="modal hide fade" id="toSendModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>发送短信</h3>
		</div>
		<div class="modal-body" >
			<h3 style="text-align:center;"><small class="text-success">编辑内容</small></h3>
			<div contentEditable=true id="msgContent"
			style="width:90%;margin:0 3%;height:100px;border:1px solid #aaa;padding:5px 5px;font-size:12px;color:#888;"></div>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary sendSubmit">发送</a>
		</div>
	</div>
	
<div class="modal hide fade" id="addModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>手机注册管理</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">新建记录</small></p>
				<table class="table" style="width:100%;">
				<tr>
				<td width="20%"><label>姓名:</label></td>
				<td width="80%"><input type="text" id="add_name" maxlength="10" placeholder="请输入姓名"></td>
				</tr>
				<tr>
				<td><label>手机:</label></td>
				<td><input type="text" id="add_phone" maxlength="11" placeholder="请输入手机号">
				</td></tr>
				<tr>
				<td><label>预购时间:</label></td>
				<td><input type="text" id="add_readyTime" class="datepicker"  placeholder="请输入预购时间">
				</td></tr>
				</table>	
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary addSubmit">保存</a>
		</div>
	</div>

<!-- 修改modal -->
<div class="modal hide fade" id="editModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>手机注册修改</h3>
		</div>
		<div class="modal-body" id="editContent">
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary editSubmit">保存</a>
		</div>
	</div>	
	
</html>
