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
option[disabled]{display:none;}
#wechatModal{background-color:#B6D2B3;}
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
					<li><a href="#">渠道管理 <i class="icon-angle-right"></i> </a>
					</li>
				</ul>	
				<div class="row-fluid sortable">
					<!--功能区域-->
					<div class="box span12 store">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon screenshot"></i><span class="break"></span>
								第三方渠道支付管理
							</h2>
							<div class="box-icon">
								<!-- <a href="#" class="add"><i
									class="halflings-icon plus add_register"></i> </a>   -->
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
						<%-- 分类：<select  rel="chosen" name="status" id="chonseStatus" class="dateChange">
							<option value="-1" ${status=="-1"?"selected='selected'":""}>全部</option>
							<option value="0" ${status=="0"?"selected='selected'":"" }>发起中</option>
							<option value="2" ${status=="2"?"selected='selected'":"" }>短信中</option>
							<option value="1" ${status=="1"?"selected='selected'":"" }>已接收</option>
						</select>  --%>
						
						
						
						<input name="pageIndex" id="pageIndex"  type="hidden" value="${pageResult.pageIndex}"/>
						<input name="pageSize" type="hidden" value="${pageResult.pageSize}"/>
						</form>
						
							<table class="table table-striped table-hover border ">
								<thead>
									<tr>
										<td width="5%">序列</td>
										<td width="8%">凯特号</td>
										<th width="8%">姓名</th>
										<th width="10%">电话号码</th>
										<th width="10%">所属公司</th>
										<th width="20%">上次操作时间</th>
										<th width="10%">历史结算佣金</th>
										<th width="10%">未结算佣金</th>
										<th width="20%">操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${pageResult.param}" var="temp" varStatus="status">
									<tr>
										<td style="font-weight:bold;font-size:15px">${(pageResult.pageIndex-1)*pageResult.pageSize+status.count}</td>
										<td>${temp.userDTO.getMoreId }</td>
										<td>${temp.name }</td>
										<td>${temp.phone }</td>
										<td>
										${ empty temp.parent.name?"无":temp.parent.name }
										<c:choose>
											<c:when test="${temp.parent.status==0 }">
											(审核中)
											</c:when>
											
											<c:when test="${temp.parent.status==2 }">
											(审核未通过)
											</c:when>
										</c:choose>
										
										</td>
										<td>
											<fmt:formatDate value="${temp.updateDate }" 
											pattern="yyyy-MM-dd HH:mm:ss"/> 
										</td>
										<td>
											<fmt:formatNumber value="${temp.totalPay }"
								 maxFractionDigits="2"></fmt:formatNumber>
										</td>
										<td>
											<fmt:formatNumber value="${temp.unpay }"
								 maxFractionDigits="2"></fmt:formatNumber>
										</td>
										<td>
										<a class="btn btn-success  btn-mini channel-pay"
											 tempid="${temp.id }" href="#"> 
											<i class="halflings-icon edit white"></i> 审核订单</a>
											
										<c:if test="${temp.unpay>0 }">
										<a class="btn btn-primary  btn-mini cal-channel-pay" 
											 tempid="${temp.id }" href="#"> 
											<i class="halflings-icon edit white"></i> 佣金付款</a>
										
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
		//详细
		$(".channel-pay").on("click",function(){
			var tempId=$(this).attr("tempid");
			if(!tempId){
				layer.msg("网页数据缺失,请刷新页面！");
				return;
			}
			
			index=layer.open({
	            type: 2,
	        	title:'<div class="box-header" data-original-title><h2><i class="halflings-icon book"></i><span class="break"></span>核算订单</h2></div>',
	            shade: 0.8,
	            maxmin: true, //开启最大化最小化按钮
	            area: ['1150px', '650px'],
	            content:['list.html?operator=findById&tempId='+tempId],
	            end:function(){reset();}
	        });
			 openInit();
		});
		var tempId;
		//结算佣金
		$(".cal-channel-pay").on("click",function(){
			
			tempId=$(this).attr("tempId");
			var param={};
			param.operator="toMoney";
			param.tempId=tempId;
			$.post("money.html",param,function(json){
				
				//信息确认
				if(json.status=="1"){//银行卡付款
					$("#money_getMoreId").val(json.data.getMoreId);
					getMoreId=json.data.getMoreId;
					$("#money_unpay").val("￥"+json.message);
					$("#money_bankName").val(json.data.bankName);
					$("#money_cardNo").val(json.data.cardNo);
					$("#cardModal").modal("show");
				}else if(json.status=="2"){//微信红包
					$("#w_money_getMoreId").val(json.data.getMoreId);
					getMoreId=json.data.getMoreId;
					$("#w_money_unpay").val("￥"+json.message);
					$("#w_money_wename").val(json.data.nickname);
					$("#wechatModal").modal("show");
					
				}
			},"json");
		});
		
		//支付
		$(".do-pay-money").on("click",function(){
			if(!tempId){layer.msg("数据缺失！");return;}
			layer.confirm("确定更新吗？", {
				title:"佣金结算",
			    btn: ["确定","返回"], //按钮
			    shade: false //不显示遮罩
			}, function(){
				var param={};
				param.tempId=tempId;
				param.operator="doPay";
				$.post("money.html",param,function(json){
					if(json.status=="1"){//支付成功
						layer.msg(json.message,{icon:1,time:1500},reset);
					}else{
						layer.msg(json.message);
					}
				},"json");
				
			}, function(){
				
			});
			
		});
		
	});
	function openInit(){
		$("body").css("overflow","hidden");
	}
	function closeInit(){
		$("body").css("overflow","auto");
		layer.close(index);
	}
	</script>
</body>
<div class="modal hide fade" id="cardModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>渠道商佣金结算管理</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">佣金确认</small></p>
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on">  凯特号  </span></td>
					<td>
					<input class="input-large span3" id="money_getMoreId"  type="text" readonly="readonly"> 
					</td>
				</tr>
				<tr>
					<td style="width:90px"><span class="add-on"> 需要支付  </span></td>
					<td><input class="input-large span3" id="money_unpay"   type="text" readonly="readonly" > 
					</td>
				</tr>
				<tr>
					<td style="width:90px"><span class="add-on">  银行名称  </span></td>
					<td><input class="input-large span3" id="money_bankName"   type="text" readonly="readonly" > 
					</td>
				</tr>
				
				<tr>
					<td style="width:90px"><span class="add-on"> 卡号  </span></td>
					<td><input class="input-large span3" id="money_cardNo"   type="text" readonly="readonly" > 
					</td>
				</tr>
				
				
				</table>
				<div>
				<p>该用户选择银行卡支付，需要手动打款，然后点击
				 <a href="#" class="btn btn-primary red btn-mini do-pay-money"> 付款完成</a></p>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a>
		</div>
	</div>
	
	<!-- 微信红包 -->
	<div class="modal hide fade" id="wechatModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>渠道商佣金结算管理</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">佣金确认</small></p>
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on">  凯特号  </span></td>
					<td>
					<input class="input-large span3" id="w_money_getMoreId"  type="text" readonly="readonly"> 
					</td>
				</tr>
				<tr>
					<td style="width:90px"><span class="add-on"> 需要支付  </span></td>
					<td><input class="input-large span3" id="w_money_unpay"   type="text" readonly="readonly" > 
					</td>
				</tr>
				<tr>
					<td style="width:90px"><span class="add-on">  微信昵称  </span></td>
					<td><input class="input-large span3" id="w_money_wename"   type="text" readonly="readonly" > 
					</td>
				</tr>
				
				
				</table>
				<div>
				<p>该用户选择微信红包，点击
				<a href="#" class="btn btn-primary red btn-mini do-pay-money"> 发送红包</a>
				完成打款</p>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a>
		</div>
	</div>
</html>
