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
								第三方渠道管理
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
						
							<table class="table table-striped table-hover ">
								<thead>
									<tr>
										<td width="5%">序列</td>
										<td width="8%">凯特号</td>
										<th width="8%">姓名</th>
										<th width="10%">电话号码</th>
										<th width="10%">所属公司</th>
										<th width="15%">申请时间</th>
										<th width="10%">状态</th>
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
										<fmt:formatDate value="${temp.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/> 
										</td>
										<td status="${temp.status}">
										<c:if test="${temp.status==0 }">
										<span class="label">审核中</span>
										</c:if>
										<c:if test="${temp.status==1}">
										<span class="label label-success" >审核通过</span>
										</c:if>
										<c:if test="${temp.status==2}">
										<span class="label label-important" >审核退回</span>
										</c:if>
										</td>
										<td>
										<a class="btn btn-success  btn-mini detail"
											 tempid="${temp.id }" 
											 > 
											<i class="halflings-icon white"></i> 详细</a>
											
											<a class="btn btn-success  btn-mini changeStatu"
											 tempid="${temp.id }" status="${temp.status}"
											 description="${temp.description }"
											 > <i class="halflings-icon edit white"></i> 审核状态</a>
											<a class="btn btn-danger  btn-mini update" tempid="${temp.id }" > 
												<i class="halflings-icon edit white"></i> 修改</a>
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
		$(".detail").on("click",function(){//查看详细
			var tempId=$(this).attr("tempId");
			var param={};
			param.tempId=tempId;
			param.operator="findById";
			$.post("list.html",param,function(json){
				if(json.status=="1"){
					var channel=json.data;
					$("#detail_getMoreId").val(channel.userDTO.getMoreId);
					$("#detail_name").val(channel.name);
					$("#detail_phone").val(channel.phone);
					$("#detail_rate").val(channel.rate);
					$("#detail_code").val(channel.code);
					if(channel.type==0){
						$("#detail_type").val("个人名义");
					}else{
						$("#detail_type").val("公司名义");
					}
					$("#detail_introImg").html("<img style='width:100%;' src='"+channel.introImg+"' />");
					$("#detailModal").modal("show");
					
				}
			},"json");
		});
		
		//修改状态
		$(".changeStatu").on("click",function(){
			var status=$(this).attr("status");
			var tempId=$(this).attr("tempId");
			var description=$(this).attr("description");
			layer.open({
			    type: 1,
			    scrollbar: false,
			    title:"审核状态",
			    shadeClose:true,
			    skin: 'layui-layer-rim', //加上边框
			    area: ['520px', '340px'], //宽高
			    content: '<p class="stLine">审核状态：</p><input type="hidden" id="statusTemp"/><div class="status"><a class="btn  status btn-mini " status="0" href="javascript:;">'+ 
					' 审核中</a><a class="btn  status btn-mini" status="1" href="javascript:;">'+ 
					' 审核通过</a><a class="btn  status btn-mini" status="2"  href="javascript:;">'+ 
					' 审核不通过</a>'+ 
					' </div><p class="stLine">备注： <small>修改状态的时候，可添加备注</small></p><textarea class="statuInfo" maxlength="200"></textarea>'+
					'<div class="modal-footer"><a href="#" class="btn btn-sm layui-layer-close" data-dismiss="modal">返回</a> <a href="#" class="btn btn-primary btn-sm status-submit">更新</a>'+
					'</div>',
				success:function(){
					$("div.status a.btn[status='"+status+"']").addClass("btn-success");
					$("#statusTemp").attr("status",status).attr("tempId",tempId);
					$(".statuInfo").val(description);
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
		//提交状态
		$("body").on("click","a.status-submit",function(){
			var tempId=$("#statusTemp").attr("tempId");
			var newstatus=$("div.status a.btn[status].btn-success").attr("status");
			var description=$(".statuInfo").val();
			var param={};
			param.status=newstatus;
			param.tempId=tempId;
			param.description=description;
			param.operator="update";
			$.post("saveOrUpdate.html",param,function(data){
				if(data.status=="1"){
					layer.msg(data.message);
					reset();
				}else{
					layer.msg(data.message);
				}
			},"json");
		});
		
		//修改
		$(".update").on("click",function(){
			var tempId=$(this).attr("tempId");
			var param={};
			param.tempId=tempId;
			param.operator="findById";
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status=="1"){
					$("#update_id").val(tempId);
					$("#update_name").val(json.data.name);
					$("#update_phone").val(json.data.phone);
					$("#update_rate").val(json.data.rate);
					$("#update_code").val(json.data.code);
					var type=json.data.type;
					$("#update_type option").removeAttr("selected");
					$("#update_type option[value='"+type+"']").attr("selected","selected");
					if(json.data.parent){
						var parentId=json.data.parent.id;
						$("#update_parentId option[value='"+parentId+"']").attr("selected","selected");
					}else{
						$("#update_parentId option:eq(0)").attr("selected","selected");
					}
					
				$("#editModal").modal("show");
				}
			},"json")
		});
		//绑定公司修改事件
		$("#update_parentId").on("change",function(){
			if($(this).val()=="0"){
				$("#update_type option").removeAttr("selected");
				$("#update_type option:eq(0)").attr("selected","selected");
				$("#update_type option[value='1']").attr("disabled","disabled");
			}else{//不为空，则启用个人名义
				$("#update_type option").removeAttr("disabled");
			}
		});
		//保存修改
		$(".editSubmit").on("click",function(){
			var tempId=$("#update_id").val();
			var name=$("#update_name").val();
			var type=$("#update_type").val();
			var phone=$("#update_phone").val();
			var parentId=$("#update_parentId").val();
			var rate=$("#update_rate").val();
			if(!$.trim(name)){
				layer.msg("名字不能为空，或全为空格");
				return;
			}
			var param={};
			param.operator="update";
			param.name=name;
			param.phone=phone;
			param.type=type;
			param.tempId=tempId;
			param.parentId=parentId;
			param.rate=rate;
			
			$.post("saveOrUpdate.html",param,function(data){
				if(data.status=="1"){
					layer.msg(data.message);
					reset();
				}else{
					layer.msg(data.message);
				}
			},"json");
		});
		
	});
	</script>
</body>
<!-- 详细 -->
<div class="modal hide fade" id="detailModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>申请信息详细</h3>
		</div>
		<div class="modal-body" id="editContent">
		<table style="width:100%;">
			<tr style="width:100%;">
			<td >
				<div class="input-prepend" title="凯特号">
					<span class="add-on"><i class="halflings-icon globe"></i> 凯特号</span>
					<input class="input-large span2" type="text" id="detail_getMoreId" readonly="readonly">
					</div>
				</td>
				<td >
				<div class="input-prepend" title="姓名">
					<span class="add-on"><i class="halflings-icon globe"></i> 姓名</span>
					<input class="input-large span2" type="text" id="detail_name"  readonly="readonly">
					</div>
				</td>
			</tr>
			<tr style="width:100%;">
			<td >
				<div class="input-prepend" title="电话号码">
					<span class="add-on"><i class="halflings-icon globe"></i> 电话号码</span>
					<input class="input-large span2" type="text" id="detail_phone" readonly="readonly">
					</div>
				</td>
				<td >
				<div class="input-prepend" title=" 所属公司">
					<span class="add-on"><i class="halflings-icon globe"></i> 名义</span>
					<input class="input-large span2" type="text" id="detail_type" readonly="readonly">
					</div>
				</td>
			</tr>
			<tr style="width:100%;">
			<td >
				<div class="input-prepend" title="电话号码">
					<span class="add-on"><i class="halflings-icon globe"></i> 比例</span>
					<input class="input-large span2" type="text" id="detail_rate" readonly="readonly">
					</div>
				</td>
				<td >
				<div class="input-prepend" title=" 所属公司">
					<span class="add-on"><i class="halflings-icon globe"></i> 随机码</span>
					<input class="input-large span2" type="text" id="detail_code" readonly="readonly">
					</div>
				</td>
			</tr>
			<tr style="width:100%;">
			<td colspan="2">
				<div class="input-prepend" title="名片" id="detail_introImg">
					
					</div>
				</td>
			</tr>
		</table>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary editSubmit">保存</a>
		</div>
	</div>	
	
	<!-- 修改modal -->
<div class="modal hide fade" id="editModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>信息修改</h3>
		</div>
		<div class="modal-body" id="editContent">
		<table style="width:100%;">
			<tr>
			<td >
				<div class="input-prepend" title="姓名">
					<span class="add-on"><i class="halflings-icon globe"></i> 名字</span>
					<input  type="hidden" id="update_id">
					<input class="input-large span2" type="text" id="update_name" maxlength="50">
					</div>
				</td>
			<td >
				<div class="input-prepend" title="电话号码">
					<span class="add-on"><i class="halflings-icon globe"></i> 电话号码</span>
					<input class="input-large span2" type="text" id="update_phone" maxlength="50">
					</div>
				</td>
			</tr>
			<tr>
			<td >
				<div class="input-prepend" title="姓名">
					<span class="add-on"><i class="halflings-icon globe"></i> 比例</span>
					<input  type="hidden" id="update_id">
					<input class="input-large span2" type="text" id="update_rate" maxlength="10">
					</div>
				</td>
			<td >
				<div class="input-prepend" title="电话号码">
					<span class="add-on"><i class="halflings-icon globe"></i> 随机码</span>
					<input class="input-large span2" type="text" id="update_code" maxlength="6" readonly="readonly">
					</div>
				</td>
			</tr>
			<tr>
			<td >
				<div class="input-prepend" title="所属公司">
					<span class="add-on"><i class="halflings-icon globe"></i> 所属公司</span>
					<select class="span2" id="update_parentId" >
						<option value="0">无</option>
						<c:forEach items="${companys }" var="company">
							<option value="${company.id }">${company.name }</option>
						</c:forEach>
					</select>
					</div>
				</td>
			<td >
				<div class="input-prepend" title="名义">
					<span class="add-on"><i class="halflings-icon globe"></i> 名义</span>
						<select class="span2" id="update_type">
							<option value="0">个人</option>
							<option value="1">公司</option>
						</select>
					</div>
				</td>	
				</tr>
		</table>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary editSubmit">保存</a>
		</div>
	</div>
	
</html>
