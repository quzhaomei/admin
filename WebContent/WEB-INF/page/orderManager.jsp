<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- start: Meta -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>后台管理</title>

<!-- start: Mobile Specific -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- end: Mobile Specific -->
<!-- start: CSS -->
<link id="bootstrap-style" href="../css/bootstrap.min.css" rel="stylesheet">
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
					<li><a href="#">家具订单管理</a>
					</li>
				</ul>
				<div class="row-fluid sortable">
					<div class="box span12">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon user"></i><span class="break"></span>家具订单管理
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
						<!-- table框架 -->
						<form action="index.html" method="post" id="myform">
						<input name="pageIndex" id="pageIndex" type="hidden" value="${pageResult.pageIndex}"/>
						<input name="pageSize" type="hidden" value="${pageResult.pageSize}"/>
						</form>
							<table class="table table-striped table-bordered">
								<thead>
									<tr>
										<th style="width:80px">凯特号</th>
										<th >姓名</th>
										<th >电话</th>
										<th >品牌</th>
										<th style="width:80px">店铺</th>
										<th >总费用</th>
										<th >已支付</th>
										<th>返利比例</th>
										<th>需返还</th>
										<th>返利方式</th>
										<th style="width:80px">订单日期</th>
										<th >订单图片</th>
										<th style="width:80px">申请日期</th>
										<th >状态</th>
										<th >操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${pageResult.param }" var="temp">
									<tr>
										<td>${temp.getMoreId }</td>
										<td>${temp.username }</td>
										<td>${temp.phone }</td>
										<td>${temp.brand.brandName }</td>
										<td>${temp.store.storeName }</td>
										<td>${temp.fare }</td>
										<td>${temp.hasPay }</td>
										<td>${temp.brand.rate }</td>
										<td>
											￥<fmt:formatNumber value="${temp.hasPay*temp.brand.rate }" maxFractionDigits="2" /> 
										</td>
										<td>${temp.backType==0?"微信支付":"网银支付" }</td>
										<td>
											<fmt:formatDate value="${temp.buyDate }" pattern="yyyy-MM-dd HH:mm:ss"/> 
										</td>
										<td><img class="imgShow" src="${temp.orderImg }" style="width:60px;"/></td>
										<td>
											<fmt:formatDate value="${temp.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/> 
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
											 <a class="btn btn-success editOrder btn-mini edit" orderid="${temp.orderId }" href="#"> 
												<i class="halflings-icon white edit"></i> 修改</a> 
											<a class="btn btn-danger  btn-mini changeStatu" orderid="${temp.orderId  }" status="${temp.status}" info="${temp.info }" href="#"> 
												<i class="halflings-icon trash white"></i> 切换状态</a> 
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>

							<!--分页控制  -->
							<div class="row-fluid">
								<div class="span12">
									<div class="dataTables_info text-left" style="padding-left:60px;" id="DataTables_Table_0_info">
										<table >
										<tr>
										<td>总共有  <span class="text-error">${pageResult.totalPage }</span> 页，当前显示的是第 
										 <span class="text-success">${pageResult.pageIndex } </span> 页,
										 跳转至 <i class="halflings-icon share-alt"></i> </td>
										<td>
										<select id="pageSelect" style='width:60px;'>
															<c:forEach begin="1" end="${pageResult.totalPage }" varStatus="index">
																<option  value="${index.count }" ${index.count==pageResult.pageIndex?"selected":"" }> ${index.count }</option>
															</c:forEach>
												</select>
												</td>
										<td> 页 </td>
										</tr>
										</table>
										
									</div>
								</div>
								<div class="span12 center">
									<div class="dataTables_paginate paging_bootstrap pagination">
										<ul id="page">
											<li index= ${pageResult.pageIndex-1>0?(pageResult.pageIndex-1):"'' class='disabled'" }><a href="#">上一页</a>
											</li>
											<c:forEach begin="1" end="${pageResult.totalPage }" varStatus="index">
											<li index="${pageResult.pageIndex!=index.count?index.count:"" }" class="${index.count==pageResult.pageIndex?"active":"" }"><a href="#">${index.count }</a>
											</li>
											</c:forEach>
											<li index=${pageResult.pageIndex+1<=pageResult.totalPage?pageResult.pageIndex+1:"'' class='disabled'" } class="next"><a href="#">下一页</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
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
	<div class="modal hide fade" id="editModal" style="width:650px;  margin-left: -290px;">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>家具订单管理</h3>
		</div>
		<div class="modal-body" style="min-height:300px;">
			<p><small class="text-success">修改订单</small></p>
				<table>
				<tr>
					<input class="input-large span3"  type="hidden"  id="orderId" />
					<td><div class="input-prepend" title="姓名">
					<span class="add-on"><i class="halflings-icon pencil"></i> 姓名</span>
					<input class="input-large span3"  type="text"  id="username" />
					</div></td>
					<td><div class="input-prepend" title="电话">
					<span class="add-on"><i class="halflings-icon pencil"></i> 电话 </span>
					<input class="input-large span3"  type="text"  id="phone" maxlength="11"/>
					</div></td>
					
				</tr>
				<tr>
					<td><div class="input-prepend" title="品牌">
					<span class="add-on"><i class="halflings-icon pencil"></i> 品牌 </span>
					<select  id="brand" style="width:150px;">
						<c:forEach items="${brands }" var="brand">
							<option value="${brand.brandId }">${brand.brandName }</option>
						</c:forEach>
					</select>
					</div></td>
					<td><div class="input-prepend" title="店铺">
					<span class="add-on"><i class="halflings-icon pencil"></i> 店铺</span>
						<select  id="store" >
						</select>
					</div></td>
					
				</tr>
				<tr>
					<td><div class="input-prepend" title="总费用">
					<span class="add-on"><i class="halflings-icon pencil"></i> 总费用 </span>
					<input class="input-large span3"  type="text"  id="fare" />
					</div></td>
					<td><div class="input-prepend" title="已支付">
					<span class="add-on"><i class="halflings-icon pencil"></i> 已支付 </span>
					<input class="input-large span3"  type="text"  id="hasPay" />
					</div></td>
				</tr>
				<tr>
				<td colspan="2"><div class="input-prepend" title="返利方式">
					<span class="add-on"><i class="halflings-icon pencil"></i> 返利</span>
					<select id="backType" style="width:150px;"> 
						<option value="0">微信支付</option>
						<option value="1">银行卡支付</option>
					</select>
					</div></td>
					</tr>
				</table>
				<div>
				</div>	
				<div style="padding-right:30px;text-align: right;">
				<small>--修改时候请谨慎，数据未做校验，建议仅在订单出错的情况下，更改，</small>
				</div>			
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary editSubmit">保存</a>
		</div>
	</div>
	
	<!-- 图片放大 -->
	<!-- 新增modal -->
	<div class="modal hide fade" id="bigImg">
		<div class="modal-body">
			<img class="tempImg" style="max-width:100%;"/>			
		</div>
		
	</div>
	
	<div class="clearfix"></div>

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
	//下拉款美化
	$("#pageSelect").chosen();
//	$(".select").chosen();
	//跳转某页
	function toPage(index){
		$("#pageIndex").val(index);
		$("#myform").submit();
	}
	//事件绑定
	$(function(){
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
	//
	$(".imgShow").on("click",function(){
		$("#bigImg .tempImg").attr("src",this.src);
		$("#bigImg").modal("show");
	});
});
	
	//刷新页面
	function reset(){
		$("#myform").submit();
	}
	
	//修改订单功能
	(function(){
		var storeId;//全局的店铺ID，用来作级联
		//品牌店铺级联
		$("#brand").on("change",function(){
				$("#store").empty();
				var brandId=$(this).val();
				if(brandId=='-1'){
					return;
				}
				$.post("list.html",{"brandId":brandId},function(json){
					$(json).each(function(){
						$("#store").append(new Option(this.storeName,this.storeId));
						if(storeId){
						$("#store option[value="+this.storeId+"]").attr("selected","selected");
						}
					});
				},"json");
			});
		
		$("#order .editOrder").on("click",function(){
			var order=$(this).attr("orderid");
			$.post("list.html",{"orderId":order},function(data){
				$("#orderId").val(data.orderId).attr("bak",data.orderId);
				$("#username").val(data.username).attr("bak",data.username);
				$("#phone").val(data.phone).attr("bak",data.phone);
				
				$("#brand").attr("bak",data.brand.brandId);
				$("#brand option[value="+data.brand.brandId+"]").attr("selected","selected");
				$("#store").attr("bak",data.store.storeId).empty();
				//初始化店铺
				storeId=data.store.storeId;//传递给公共变量
				$("#brand").change();
				
				$("#fare").val(data.fare).attr("bak",data.fare);
				$("#hasPay").val(data.hasPay).attr("bak",data.hasPay);
				
				$("#backType").attr("bak",data.backType);
				$("#backType option[value="+data.backType+"]").attr("selected","selected");
				
				$("#editModal").modal("show");
			},"json");
		});
		
		//提交更新
		$(".editSubmit").on("click",function(){
			var isChange=false;
			var param={};
			param.orderId=$("#orderId").val();//绑定orderId
			//判断username
			if(!$("#username").val()){
				layer.msg("订单姓名不能为空");
				return;
			}else if($("#username").val()!=$("#username").attr("bak")){
				isChange=true;
				param.username=$("#username").val();
			}
			//判断phone
			if(!$("#phone").val()){
				layer.msg("电话号码不能为空");
				return;
			}else if($("#phone").val()!=$("#phone").attr("bak")){
				isChange=true;
				param.phone=$("#phone").val();
			}
			//判断store
			if($("#store").val()!=$("#store").attr("bak")){
				param.store=$("#store").val();
				isChange=true;
			}
			//判断fare
			if($("#fare").val()!=$("#fare").attr("bak")){
				param.fare=$("#fare").val();
				isChange=true;
			}
			//判断hasPay
			if($("#hasPay").val()!=$("#hasPay").attr("bak")){
				param.hasPay=$("#hasPay").val();
				isChange=true;
			}
			//判断backType
			if($("#backType").val()!=$("#backType").attr("bak")){
				param.backType=$("#backType").val();
				isChange=true;
			}
			if(!isChange){
				layer.msg("表单数据没有变化");
				return;
			}
			$.post("saveOrUpdate.html",param,function(data){
				if(data.status=="ok"){
					layer.msg("更新成功");
					reset();
				}
			},"json");
		});
	//修改状态
	$(".changeStatu").on("click",function(){
		var status=$(this).attr("status");
		var orderId=$(this).attr("orderId");
		var info=$(this).attr("info");
		layer.open({
		    type: 1,
		    scrollbar: false,
		    title:"切换订单状态",
		    shadeClose:true,
		    skin: 'layui-layer-rim', //加上边框
		    area: ['520px', '340px'], //宽高
		    content: '<p class="stLine">订单状态：</p><input type="hidden" id="statusTemp"/><div class="status"><a class="btn  status btn-mini " status="1" href="javascript:;">'+ 
				' 凯特猫审核中</a><a class="btn  status btn-mini" status="2" href="javascript:;">'+ 
				' 品牌审核中</a><a class="btn  status btn-mini" status="2.5"  href="javascript:;">'+ 
				' 返利中</a><a class="btn  status btn-mini" status="3"  href="javascript:;">'+ 
				' 已返款</a><a class="btn  status btn-mini" status="4" href="javascript:;">'+ 
				' 审核不通过</a></div><p class="stLine">备注： <small>修改状态的时候，请更改备注</small></p><textarea class="statuInfo"></textarea>'+
				'<div class="modal-footer"><a href="#" class="btn btn-sm layui-layer-close" data-dismiss="modal">返回</a> <a href="#" class="btn btn-primary btn-sm status-submit">更新</a>'+
				'</div>',
			success:function(){
				$("div.status a.btn[status='"+status+"']").addClass("btn-success");
				$("#statusTemp").attr("status",status).attr("orderId",orderId);
				$(".statuInfo").val(info);
			}
		});
	});
	$("body").on("click","div.status a.btn",function(){
		if($(this).hasClass("btn-success")){
			return;
		}
		$(".statuInfo").val("");
		$("div.status a.btn").removeClass("btn-success");
		$(this).addClass("btn-success");
	});
	$("body").on("click","a.status-submit",function(){
		var oldstatus=$("#statusTemp").attr("status");
		var orderId=$("#statusTemp").attr("orderId");
		var newstatus=$("div.status a.btn[status].btn-success").attr("status");
		var info=$(".statuInfo").val();
		if(oldstatus==newstatus){
			layer.msg("状态未检测到变化！");
			return;
		}
		if(!info&&newstatus=='4'){
			layer.msg("请填写备注！");
			return;
		}
		var param={};
		param.status=newstatus;
		param.info=info;
		param.orderId=orderId;
		$.post("saveOrUpdate.html",param,function(data){
			if(data.status=="ok"){
				layer.msg("更新状态成功");
				reset();
			}
		},"json");
	});
	})();
	
	</script>
</body>
</html>
