<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- start: Meta -->
<meta charset="utf-8">
<title>易支付，支付结果</title>
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

<style>
	body {
		font-family: 'Microsoft Yahei', sans-serif;
	}
	.errormsg {
		padding: 30px;
		width: 300px;
		height: 100px;
		border: 1px solid #CCCCCC;
		border-radius: 10px;
		text-align: center;
		margin: auto;
		margin-top: 15%;
	}

	.errormsg a {
		color: #CF000E;
		text-decoration: none;

	}
</style>
</head>
<body>
<div class="errormsg">
	
<c:if test="${status=='ok' }">
<a href="#" style="color:red;padding:50px 50px;">支付成功。3s后返回页面.....</a>
</c:if>
<c:if test="${status=='no' }">
<a href="#" style="color:red;padding:50px 50px;">支付失败(${error })。3s后返回页面.....</a>
</c:if>
</div>
</body>
<script>
setTimeout(function(){
	if(window.parent.reset){
		window.parent.reset();
	}
	if(window.opener.reset){
		window.opener.reset();
	}
	if(window.opener.parent.reset){
		window.opener.parent.reset();
	}
	window.close();
	},2000);
</script>
</html>
