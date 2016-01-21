<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="my" uri="/myTag" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>后台管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<c:import url="public/p-css.jsp"></c:import>
<!-- end: Favicon -->
<style type="text/css">
.modal-body{max-height: 580px;}
label.error{
	display: inline-block;
	*display: inline;
	*zoom:1;
	margin-left:15px;
	color:#2D89EF;
	background: #e2e2e2;
	padding:5px 10px;
	}
label.error:before{
  content:"×";
  color:#2D89EF;
}
.errorDiv{
display: inline-block;
	*display: inline;
	*zoom:1;
}
</style>
</head>

<body>
	<!-- start: Header -->
		<c:import url="public/p-header.jsp"></c:import>
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
					<li><a href="#">量房申请</a>
					</li>
				</ul>

				<div class="row-fluid sortable">
					<div class="box span12">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon user"></i><span class="break"></span>量房申请
							</h2>
							<div class="box-icon">
							<a href="#" class="add"><i
									class="halflings-icon plus add_register"></i> </a> 
									<a href="#"
									class="btn-minimize"><i class="halflings-icon chevron-up"></i>
								</a> <a href="#" class="btn-close"><i
									class="halflings-icon remove"></i> </a>
							</div>
						</div>
						
						<!-- 数据展示 -->
						<div class="box-content">
						<!-- table框架 -->
						<form action="index.html" method="post" id="myform" rel="admin-form">
						<input name="pageIndex" id="pageIndex" type="hidden" value="${pageResult.pageIndex}"/>
						<input name="pageSize" type="hidden" value="${pageResult.pageSize}"/>
						</form>
							<table class="table table-striped table-bordered">
								<thead>
									<tr>
										<th >序列</th>
										<th >姓名</th>
										<th >电话号码</th>
										<th style="width: 70px;">所在区域</th>
										<th>家居面积</th>
										<th>状态</th>
										<th>短地址</th>
										<th style="width: 200px;">跟踪</th>
										<th>创建时间</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${pageResult.param }" var="apply" varStatus="status">
									<tr id="apply${apply.applyId }">
										<td>${pageResult.pageSize*(pageResult.pageIndex-1)+status.count}</td>
										<td>${fn:escapeXml(apply.username) }</td>
										<td>${apply.phone }</td>
										<td>${apply.location }</td>
										<td>${apply.size }</td>
										 <td>
										 	<c:choose>
										 		<c:when test="${apply.status==0 }">
										 			<span class="label">后台初始化中</span>
										 		</c:when>
										 		<c:when test="${apply.status==1 }">
										 			<span class="label">短信已发送</span>
										 		</c:when>
										 		<c:when test="${apply.status==2 }">
										 			<span class="label">浏览页面</span>
										 		</c:when>
										 		<c:when test="${apply.status==3 }">
										 			<span class="label">已注册</span>
										 		</c:when>
										 		
										 	</c:choose>
										 </td>
										 <td>${apply.shortUrl }</td>
										 <td>
										 	 <c:choose>
										 	<c:when test="${apply.description !=null&&fn:length(apply.description )>40 }">
										 		${fn:substring(apply.description ,0,40) }…
										 		<a class="red temp-info" title="${apply.description }" href="#">[详细]</a>
										 	</c:when>
										 	<c:otherwise>
												${apply.description  }
										 	</c:otherwise>
										 </c:choose>
										 </td>
										<td><fmt:formatDate value="${apply.createDate }"
										 pattern="yyyy-MM-dd HH:mm"/> </td>
										 <td>
										 	<c:if test="${apply.status==0 }">
										 		<span applyId="${apply.applyId }" class="toSend btn btn-mini btn-success">
										 		<i class="icon icon-edit"></i> 短信邀请</span>
										 	</c:if>
										 </td>
									</tr>
								</c:forEach>
								</tbody>
							</table>

							<!--分页控制  -->
								<my:page pageIndex="${pageResult.pageIndex }"
									 pageSize="${pageResult.pageSize}" 
									 totalPage="${pageResult.totalPage}"></my:page>
								
						</div>
						<!-- 数据展示结束 -->
						
					</div>
					<!--/span-->
				</div>
				
				
			</div>
			
		</div>
	</div>
	
	<div class="clearfix"></div>
	
	<c:import url="public/p-footer.jsp"></c:import>
	
	<!-- start: JavaScript-->
	<c:import url="public/p-javascript.jsp"></c:import>>
	<!-- end: JavaScript-->
	<script type="text/javascript">
		$(function(){
			//后台添加
			$(".add_register").on("click",function(){
				$("#addModal").modal("show");
			});
			//保存操作
			$(".addSubmit").on("click",function(){
				var name=$("#add_name").val();
				var phone=$("#add_phone").val();
				if(!name){
					layer.msg("请输入姓名");
					return;
				}
				if(!phone){
					layer.msg("请输入手机");
					return;
				}
				var param={};
				param.operator="add";
				param.name=name;
				param.phone=phone;
				$.post("saveOrUpdate.html",param,function(json){
					if(json.status==0){
						layer.msg(json.message);
					}else{
						layer.msg(json.message);
						window.location.reload();
					}
				},"json")
			});
			
			$(".temp-info").on("click",function(){
				var _this=this;
				layer.msg($(_this).attr("title").replace(/#/g,"<br/>"), {time: 7000, icon:6});
			});
			
			//发送短信
			var msg="尊敬的会员您好：感谢您预约免费量房，注册还可以领取装修礼包 <url>url</url> 。回复TD退订。";
			var applyId;
			//发送短信
			$(".toSend").on("click",function(){
				applyId=$(this).attr("applyId");
				parseMsg(applyId);
				$("#msgContent").html(msg);
				$("#toSendModal").modal("show");
			});
			function parseMsg(registerId){
				var url=$("#apply"+applyId).find("td:eq(6)").text();
				msg=msg.replace(/<url>.+<\/url>/,"<url>"+url+"<\/url>");
			}
			//发送短信
			$(".sendSubmit").on("click",function(){
				msg=$("#msgContent").html();//替换模板
				var param={};
				param.applyId=applyId;
				param.content=msg;
				$.post("sendMsg.html",param,function(json){
					if(json.isSuccess=="false"){
						layer.msg(json.info);
					}else{
						layer.msg(json.info);
						window.location.reload();
					}
				},"json");
			});
		});
	</script>
	</script>
</body>
<div class="modal hide fade" id="addModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>量房申请管理</h3>
		</div>
		<div class="modal-body">
			<p><small class="text-success">新建记录</small></p>
				<table class="table" style="width:100%;">
				<tr>
				<td width="20%"><label>姓名:</label></td>
				<td width="80%"><input type="text" id="add_name" maxlength="10" placeholder="请输入姓名"></td>
				</tr>
				<tr>
				<td><label>手机:</label></td>
				<td><input type="text" id="add_phone" maxlength="11" placeholder="请输入手机号">
				</td></tr>
				</table>	
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary addSubmit">保存</a>
		</div>
	</div>
	
	<!-- 发送短信modal -->
<div class="modal hide fade" id="toSendModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>发送短信</h3>
		</div>
		<div class="modal-body" >
			<h3 style="text-align:center;"><small class="text-success">编辑内容</small></h3>
			<div contentEditable=true id="msgContent"
			style="width:90%;margin:0 3%;height:100px;border:1px solid #aaa;padding:5px 5px;font-size:12px;color:#888;"></div>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary sendSubmit">发送</a>
		</div>
	</div>
</html>
