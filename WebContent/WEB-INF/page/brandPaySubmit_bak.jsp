<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- start: Meta -->
<meta charset="utf-8">
<title>易支付，订单确认</title>
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
.info{
text-align:center;
padding:200px 0;
font-size: 25px;
color:#107929;
}
</style>
</head>
<body>
<c:if test="${fail!=null}">
<p class="info">
${msg!=null?msg:"您的商户信息不完整，请联系凯特猫管理员" }
</p>
</c:if>
<c:if test="${fail==null}">
<table width="70%" border="0" align="center" cellpadding="5" cellspacing="0" 
							style="word-break:break-all; border:solid 1px #107929">
			<tr>
		  		<th align="center" height="30" colspan="3" bgcolor="#6BBE18">
					订单支付结果
				</th>
		  	</tr>

			<tr>
				<td width="15%" align="left">&nbsp;商户编号</td>
				<td width="5%"  align="center"> : </td> 
				<td width="60%" align="left">${payParam.customernumber}</td>
			</tr>

			<tr>
				<td width="15%" align="left">&nbsp;商户订单号</td>
				<td width="5%"  align="center"> : </td> 
				<td width="60%" align="left"> ${payParam.requestid} </td>
			</tr>

			<tr>
				<td width="15%" align="left">&nbsp;易宝流水号</td>
				<td width="5%"  align="center"> : </td> 
				<td width="60%" align="left">${payParam.externalid} </td>
			</tr>

			<tr>
				<td width="15%" align="left">&nbsp;订单金额</td>
				<td width="5%"  align="center"> : </td> 
				<td width="60%" align="left"> ${payParam.amount} </td>
			</tr>
			<tr>
				<td width="15%" align="left" rowspan="6">&nbsp;支付链接</td>
				<td width="5%"  align="center" rowspan="6"> : </td> 
				<td width="60%" align="left" rowspan="6"> 
					<a href="${payParam.payurl}" style="text-decoration:none" target="_blank"> 
						点此支付该订单
					</a> 
				</td>
			</tr>

		</table>
</c:if>
</body>
<script>
<c:if test="${fail==null}">
document.yeepay.submit();
</c:if>
</script>
</html>
