<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/myTag" prefix="my" %>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- start: Meta -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>后台管理</title>

<!-- start: Mobile Specific -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<c:import url="public/p-css.jsp"></c:import>
<!-- start: 网站logo -->
<link rel="shortcut icon" href="../img/avatar.jpg">
<!-- end: Favicon -->
<style type="text/css">
.modal-body{max-height: 580px;}

.layui-layer-content{
padding:5px 5px;
}
.status{
text-align: center;
margin:5px 0;
}
.status a{
margin:3px 8px;
}
.statuInfo{
margin:0px 20px;
width:90%;
height:95px;
}
.stLine{
margin:10px 20px;
padding-bottom:5px;
border-bottom:1px solid #aaa;
font-weight: bold;
}
.modal-footer a.btn{
position: relative !important;
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

			<!-- start: Content -->
			<div id="content" class="span10">

				<ul class="breadcrumb">
					<li><i class="icon-home"></i> <a href="index.html">首页</a> <i
						class="icon-angle-right"></i></li>
				<!-- 	<li><a href="#">系统设置<i class="icon-angle-right"></i> </a> -->
					</li>
					<li><a href="#">订单统计</a>
					</li>
				</ul>
				<div class="row-fluid sortable">
					<div class="box span12">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon user"></i><span class="break"></span>订单统计
							</h2>
							<div class="box-icon">
								 <a href="#"
									class="btn-minimize"><i class="halflings-icon chevron-up"></i>
								</a> <a href="#" class="btn-close"><i
									class="halflings-icon remove"></i> </a>
							</div>
						</div>
						
						<!-- 数据展示 -->
						<div class="box-content" id="order">
						<c:if test="${isGetMore||isSuper }">
						<a href="load-excel.html" style="float:right;color:red;margin-right:20px;" id="load-excel">下载订单数据</a>
						</c:if>
						<!-- table框架 -->
						<form action="index.html" id="myform" method="post" rel="admin-form">
						状态：<select id="stateSelect" name="status" style="width:150px;">
							<option value="-1" ${status=='-1'?'selected':'' } >全部</option>
							<option value="0" ${status=='0'?'selected':'' }>确定支付方式中</option>
							<option value="1" ${status=='1'?'selected':'' }>凯特猫审核中</option>
							<option value="2" ${status=='2'?'selected':'' }>品牌审核中</option>
							<option value="2.5" ${status=='2.5'?'selected':'' }>返利中</option>
							<option value="3" ${status=='3'?'selected':'' }>已返利</option>
							<option value="4" ${status=='4'?'selected':'' }>审核退回</option>
							<option value="5" ${status=='5'?'selected':'' }>个人删除</option>
							</select>
						<input name="pageIndex" id="pageIndex" type="hidden" value="${pageResult.pageIndex}"/>
						<input name="pageSize" type="hidden" value="${pageResult.pageSize}"/>
						</form>
							<table class="table table-striped table-bordered">
								<thead>
									<tr>
										<th style="width:50px;">姓名</th>
										<th style="width:80px;">电话</th>
										<th style="width:50px;">品牌</th>
										<th style="width:80px">店铺</th>
										<th style="width:50px">总费用</th>
										<th style="width:50px">已支付</th>
										<c:if test="${!isBrand }">
										<th style="width:50px">返利比例</th>
										<th style="width:50px">需返还</th>
										</c:if>
										<th style="width:50px">返利方式</th>
										<th style="width:30px">佣金比例</th>
										<th style="width:30px">佣金金额</th>
										<th style="width:80px">订单日期</th>
										<th >订单图片</th>
										<th style="width:80px">申请日期</th>
										<th >状态</th>
										<th  style="width:80px">备注</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${pageResult.param }" var="temp">
									<tr>
										<td>${temp.username }</td>
										<td>${temp.phone }</td>
										<td>${temp.brand.brandName }</td>
										<td>${temp.store.storeName }</td>
										<td>${temp.fare }</td>
										<td>${temp.hasPay }</td>
										<c:if test="${!isBrand }">
										<td><fmt:formatNumber value="${temp.brand.rate*100 }" maxFractionDigits="2"/>%</td>
										<td>
											￥<fmt:formatNumber value="${temp.hasPay*temp.brand.rate }" maxFractionDigits="2" /> 
										</td>
										</c:if>
										<td>${temp.backType==0?"微信":"网银" }</td>
										
											<td>
										<c:if test="${not empty temp.brand.brandRate }">
										<fmt:formatNumber value="${temp.brand.brandRate*100 }" maxFractionDigits="2"/>%
										</c:if>
										<c:if test="${empty temp.brand.brandRate }">
										
										</c:if>
										</td>
										<td>
										<c:if test="${not empty temp.brand.brandRate }">
										<fmt:formatNumber value="${temp.brand.brandRate*temp.hasPay }" maxFractionDigits="2"/>
										</c:if>
										</td>
										<td>
											<fmt:formatDate value="${temp.buyDate }" pattern="yyyy-MM-dd HH:mm:ss"/> 
										</td>
										
										<td><img class="imgShow" src="${temp.orderImg }" style="width:60px;"/></td>
										<td>
											<fmt:formatDate value="${temp.createDate }" pattern="yyyy-MM-dd"/> 
										</td>
										<td><c:choose >
											<c:when test="${temp.status=='0'}">
											<span class="label">确定支付方式中</span>
											</c:when>
											<c:when test="${temp.status=='1'}">
											<span class="label">凯特猫审核中</span>
											</c:when>
											<c:when test="${temp.status=='2'}">
											<span class="label">品牌审核中</span>
											</c:when>
											<c:when test="${temp.status=='2.5'}">
											<span class="label">返利中</span>
											</c:when>
											<c:when test="${temp.status=='3'}">
											<span class="label">返利已完成</span>
											</c:when>
											<c:when test="${temp.status=='4'}">
											<span class="label">审核退回</span>
											</c:when>
											<c:when test="${temp.status=='5'}">
											<span class="label">个人已删除</span>
											</c:when>
										 </c:choose>
										  </td>
										 <td>
										 <c:choose>
										 	<c:when test="${temp.info!=null&&fn:length(temp.info)>10 }">
										 		${fn:substring(temp.info,0,10) }…
										 		<br/><a class="red temp-info"  title="${temp.info }" href="#">[详细]</a>
										 	</c:when>
										 	<c:otherwise>
												${temp.info }
										 	</c:otherwise>
										 </c:choose>
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

	
	<!-- 图片放大 -->
	<!-- 新增modal -->
	<div class="modal hide fade" id="bigImg">
		<div class="modal-body">
			<img class="tempImg" style="max-width:100%;"/>			
		</div>
		
	</div>
	
	<div class="clearfix"></div>

	<c:import url="public/p-footer.jsp"></c:import>
	
	<!-- start: JavaScript-->
	<c:import url="public/p-javascript.jsp"></c:import>
	<!-- end: JavaScript-->
	<script type="text/javascript">
	//下拉款美化
	$("#stateSelect").chosen();
	//跳转某页
	function toPage(index){
		$("#pageIndex").val(index);
		$("#myform").submit();
	}
	//事件绑定
	$(function(){
	$("#stateSelect").on("change",function(){
		$("#pageIndex").val(1);
		reset();
	});
	$(".imgShow").on("click",function(){
		$("#bigImg .tempImg").attr("src",this.src);
		$("#bigImg").modal("show");
	});
	
	$(".temp-info").on("click",function(){
		var _this=this;
		layer.msg($(_this).attr("title"), {time: 5000, icon:5});
	});
	
	
	
});
	
	//刷新页面
	function reset(){
		$("#myform").submit();
	}
						
	
	</script>
</body>
</html>
