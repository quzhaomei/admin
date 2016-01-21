<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<link id="bootstrap-style" href="<%=basePath %>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath %>/css/bootstrap-responsive.min.css" rel="stylesheet">
<link id="base-style" href="<%=basePath %>/css/style.css" rel="stylesheet">
<link id="base-style-responsive" href="<%=basePath %>/css/style-responsive.css" rel="stylesheet">
<link id="base-style-responsive" href="<%=basePath %>/css/admin.css" rel="stylesheet">
<!-- start: 网站logo -->
<link rel="shortcut icon" href="<%=basePath %>/img/avatar.jpg">
<!-- end: Favicon -->