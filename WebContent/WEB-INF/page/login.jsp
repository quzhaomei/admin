<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	
	<!-- start: Meta -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>用户登录</title>
	<meta name="description" content="Bootstrap Metro Dashboard">
	<meta name="author" content="Dennis Ji">
	<meta name="keyword" content="Metro, Metro UI, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
	<!-- end: Meta -->
	
	<!-- start: Mobile Specific -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- end: Mobile Specific -->
	
	<!-- start: CSS -->
	<link id="bootstrap-style" href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/bootstrap-responsive.min.css" rel="stylesheet">
	<link id="base-style" href="../css/style.css" rel="stylesheet">
	<link id="base-style-responsive" href="../css/style-responsive.css" rel="stylesheet">
	<!-- end: CSS -->
	

	<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<link id="ie-style" href="../css/ie.css" rel="stylesheet">
	<![endif]-->
	
	<!--[if IE 9]>
		<link id="ie9style" href="../css/ie9.css" rel="stylesheet">
	<![endif]-->
		
	<!-- start: Favicon -->
	<link rel="shortcut icon" href="../img/favicon.ico">
	<!-- end: Favicon -->
	<style type="text/css">
			body { background: url(../img/bg-login.jpg) !important; }
		</style>
		
</head>

<body>
		<div class="container-fluid-full">
		<div class="row-fluid">
					
			<div class="row-fluid">
				<div class="login-box">
					<div class="box-header" style="padding:20px 25px;margin-bottom:50px;">
						<a href="#">后台登录</a>
					</div>
					<form class="form-horizontal" action="index.html" method="post" id="loginForm">
						<fieldset>
							<!-- 错误提示 -->
							<div class="alert alert-error" style="margin:10px 10px;${info==null?"display:none":""}">
								<button type="button" class="close" data-dismiss="alert">×</button>
								<span class="content">${info }</span>
							</div>
							<div class="input-prepend" title="Username">
								<span class="add-on"><i class="halflings-icon user"></i> </span>
								<input class="input-large span10" name="loginname" id="loginname" type="text" placeholder="请输入用户名" maxlength="15"/>
							</div>
							<div class="clearfix"></div>

							<div class="input-prepend" title="Password">
								<span class="add-on"><i class="halflings-icon lock"></i> </span>
								<input class="input-large span10" name="password" id="password" type="password" placeholder="请输入密码" maxlength="25"/>
							</div>
							<div class="clearfix"></div>
							<div class="button-login">	
								<button class="btn btn-primary btn_submit">登录</button>
							</div>
							<div class="clearfix"></div>
					</form>
					<hr>
					<!-- <h3>找回密码</h3> -->
				</div><!--/span-->
			</div><!--/row-->
			

	</div><!--/.fluid-container-->
	
		</div><!--/fluid-row-->
	
	<!-- start: JavaScript-->
	<c:import url="javascript.jsp"></c:import>
	<!-- end: JavaScript-->
	<script type="text/javascript">
		$("#btn_submit").click(function(){
			var loginname=$("#loginname").val();
			var password=$("#password").val();
			if(loginname&&loginname.length>5&&password&&password.length>5){
				$("#loginForm").submit();
			}else{
				$(".alert .content").text("请输入正确的密码以及账号！");
				$(".alert").fadeIn("fast");
			}
		});
	</script>
</body>
</html>
