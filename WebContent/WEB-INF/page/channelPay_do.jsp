<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/myTag" prefix="my" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>后台管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1">


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
</style>
<body>
	<div class="container-fluid-full">
		<div class="row-fluid">
			<!-- start: Content -->
			<div id="content" style="margin:0 0% !important;width:100%;">
				<div class="row-fluid">
					<div class="box span12" style="padding:0 10px;z-index: 99;position:relative; ">
						<!-- 条件选择 -->
						<div class="box-content">

							<form id="myform" action="list.html" style="margin: 0 20px;">
								<fieldset>
								<input type="hidden" name="operator" value="findById"/>
								
								<input type="hidden" id="tempId" name="tempId" value="${tempId }"/>
								<input type="hidden" id="pageIndex" name="pageIndex" value="${pageResult.pageIndex }"/>
								<input type="hidden" id="pageSize" name="pageSize" value="${pageResult.pageSize }"/>
								<div >
								<table class="table center">
								<tr><td width="20%">姓名</td><td width="10%">比例</td><td width="40%">已计算家具订单总额</td><td>未计算家具订单总额</td></tr>
								<tr>
								<td>${channel.name }</td>
								<td><span class="label label-important">
								<fmt:formatNumber value="${channel.rate*100 }" maxFractionDigits="5" ></fmt:formatNumber>
								%
								</span></td>
								<td><span class="label label-success">￥ ${total_pay }</span></td>
								<td><span class="label label">￥ ${total_unpay }</span></td>
								</tr>
								</table>
								历史未结算佣金：<fmt:formatNumber value="${channel.unpay+0 }"
								 maxFractionDigits="2"></fmt:formatNumber>&nbsp; | &nbsp;
								本次需结算总佣金：<fmt:formatNumber value="${total_unpay*channel.rate }"
								 maxFractionDigits="2"></fmt:formatNumber>&nbsp; 
								 
								 <c:if test="${total_unpay*channel.rate>0 }">
									 <a class="btn btn-success  btn-mini cal-channel-pay"
											 tempid="${temp.id }" > 
											<i class="halflings-icon money white"></i> 批量结算</a>
								 </c:if>
								 
								 | &nbsp;
								总计：
								<fmt:formatNumber value="${total_unpay*channel.rate+channel.unpay }"
								 maxFractionDigits="2"></fmt:formatNumber>&nbsp; 
									
											
								</fieldset>
							</form>
						</div>
					</div>
					<!--/span-->
					<div class="box span11" style="padding:0 30px;margin:0 50px; ">
						<!-- 数据展示 -->
						<div class="box-content">
							<table class="table table-striped table-bordered">
								<thead>
									<tr>
										<th style="width:8%;">凯特号</th>
										<th style="width:10%;">购买时间</th>
										<th style="width:10%;">姓名</th>
										<th style="width:10%;">电话</th>
										<th style="width:25%;">缩略图</th>
										<th style="width:10%;">已支付</th>
										<th style="width:10%;">状态</th>
										<th style="width:10%;">操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${pageResult.param }" var="temp">
									<tr>
										<td>${temp.getMoreId }</td>
										<th style="width:10%;">
										<fmt:formatDate value="${temp.buyDate }" pattern="yyyy-MM-dd"/>
										
										</th>
										<td>${temp.username}</td>
										<td>${temp.phone }</td>
										<td style="width:20%;">
										<div style="height:50px;overflow: hidden;">
										<img src="${temp.orderImg}"/>
										</div>
										<td>
											${temp.hasPay }
										</td>
										<td>
											${empty temp.tempId?"<span class='label'>未结算</span>"
											:"<span class='label label-success'>已结算</span>" }
										</td>
										<td>
										<c:if test="${empty temp.tempId }">
											<a class="btn btn-success  btn-mini order-channel-pay"
											 orderId="${temp.orderId }" > 
											<i class="halflings-icon edit white"></i> 结算</a>
											</c:if>
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
	<script>
	function toPage(index){
		$("#pageIndex").val(index);
		$("#myform").submit();
	}
	function reset(){
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
	
	$(function(){
		$(".cal-channel-pay").on("click",function(){
			var tempId=$("#tempId").val();
			if(!tempId){
				layer.msg("数据缺失");
				return;
			}else{
				layer.confirm("确定结算所有订单吗？", {
					title:"渠道佣金结算",
				    btn: ["确定","返回"], //按钮
				    shade: 0.4 //显示遮罩
				}, function(){
					var _this=this;
					$(this).attr("disabled","disabled");
					var param={};
					param.operator="call-all";
					param.tempId=tempId;
					$.post("saveOrUpdate.html",param,function(json){
						if(json.status=="1"){
							layer.msg(json.message,{icon:1,time:1000},function(){
								reset();
							});
						}else{
							layer.msg(json.message);
						}
					},"json")
				
				}, function(){
					
				});
				
			}
		});
		
		//结算单个
		$(".order-channel-pay").on("click",function(){
			var tempId=$("#tempId").val();
			var orderId=$(this).attr("orderId");
			if(!orderId){
				layer.msg("数据缺失");
				return;
			}else{
				layer.confirm("确定结算该订单吗？", {
					title:"渠道订单结算",
				    btn: ["确定","返回"], //按钮
				    shade: false //不显示遮罩
				}, function(){
					var _this=this;
					$(this).attr("disabled","disabled");
					var param={};
					param.operator="call-per";
					param.tempId=tempId;
					param.orderId=orderId;
					$.post("saveOrUpdate.html",param,function(json){
						if(json.status=="1"){
							layer.msg(json.message,{icon:1,time:1000},function(){
								reset();
							});
						}else{
							layer.msg(json.message);
						}
					},"json")
				
				}, function(){
					
				});
				
			}
			
		});
		
	});
	
	</script>
</body>
</html>
