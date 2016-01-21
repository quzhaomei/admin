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
				<p style="text-align: right;">
				<a href="#" class="btn btn-mini green" id="sendMsg">发送短信</a>
				<a href="list.html">下载数据</a></p>
				<div class="row-fluid sortable">
					<!--功能区域-->
					<div class="box span12 store">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon screenshot"></i><span class="break"></span>
								${empty activeName?"手机号注册":activeName }
							</h2>
							<div class="box-icon">
								
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
						
						
						<input name="pageIndex" id="pageIndex"  type="hidden" value="${pageResult.pageIndex}"/>
						<input name="pageSize" type="hidden" value="${pageResult.pageSize}"/>
						</form>
						
							<table class="table table-striped table-hover ">
								<thead>
									<tr>
										<td width="5%">序列</td>
										<th width="10%">姓名</th>
										<th width="10%">电话号码</th>
										<th  width="15%">报名时间</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${pageResult.param}" var="temp" varStatus="status">
									<tr id="${temp.registerId }">
										<td style="font-weight:bold;font-size:15px">${(pageResult.pageIndex-1)*pageResult.pageSize+status.count}</td>
										<td>${temp.name }</td>
										<td>${temp.phone }</td>
										
										<td>
										<fmt:formatDate value="${temp.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/> 
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
		var msg="尊敬的会员，吉盛伟邦家具村年终大促，成交价再立减百分之十五，立即查看 http://dwz.cn/2qSW8A，回复ＴＤ退订";
		//发送短信
		$("#sendMsg").on("click",function(){
			$("#msgPhone").val("");
				$("#msgContent").html(msg);
				$("#toSendModal").modal("show");
		});
		
		$(".sendSubmit").on("click",function(){
			msg=$("#msgContent").html();//替换模板
			var phone=$("#msgPhone").val();
			if(!phone){
				alert("请输入手机");
				return;
			}else if(!/^1[3|4|5|8|7][0-9]\d{4,8}$/.test(phone)){
				alert("请输入正确的手机号码");
				return;
			}
			
			var param={};
			param.operator="sendMsg";//发送短信
			param.phone=phone;
			param.content=msg;
			$.post("saveOrUpdate.html",param,function(json){
				if(json.isSuccess=="false"){
					layer.msg(json.info);
				}else{
					layer.msg(json.info);
					$("#toSendModal").modal("hide");
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
			<div style="width:90%;margin:0 3%;">
			手机号码：
			<input type="text" maxlength="11" id="msgPhone" placeholder="请输入手机号码"/>
			</div>
			<div contentEditable=true id="msgContent"
			style="width:90%;margin:0 3%;height:100px;border:1px solid #aaa;padding:5px 5px;font-size:12px;color:#888;"></div>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary sendSubmit">发送</a>
		</div>
	</div>	
	
</html>
