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
<br /> <br />
		<form name="yeepay" action='${requestURL }' method='POST'>
			<input type='hidden' name='p0_Cmd'   		value='${p0_Cmd}'>
			<input type='hidden' name='p1_MerId' 		value='${p1_MerId}'>
			<input type='hidden' name='p2_Order' 		value='${p2_Order}'>
			<input type='hidden' name='p3_Amt'   		value='${p3_Amt}'>
			<input type='hidden' name='p4_Cur'   		value='${p4_Cur}'>
			<input type='hidden' name='p5_Pid'   		value='${p5_Pid}'>
			<input type='hidden' name='p6_Pcat'  		value='${p6_Pcat}'>
			<input type='hidden' name='p7_Pdesc' 		value='${p7_Pdesc}'>
			<input type='hidden' name='p8_Url'   		value='${p8_Url}'>
			<input type='hidden' name='p9_SAF'   		value='${p9_SAF}'>
			<input type='hidden' name='pa_MP'    		value='${pa_MP}'>
			<input type='hidden' name='pd_FrpId' 		value='${pd_FrpId}'>
			<input type='hidden' name='pm_Period' 		value='${pm_Period}'>
			<input type='hidden' name='pn_Unit' 		value='${pn_Unit}'>
			<input type="hidden" name="pr_NeedResponse" value="${pr_NeedResponse}">
			<input type='hidden' name='hmac'     		value='${hmac}'>
		</form>

</c:if>
</body>
<script>
<c:if test="${fail==null}">
document.yeepay.submit();
</c:if>
</script>
</html>
