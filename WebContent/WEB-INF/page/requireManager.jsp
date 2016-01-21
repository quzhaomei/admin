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
.resolve{padding:10px 10px;margin:5px 0;border-top:1px solid green;border-left:4px solid green;border-radius:3px;background-color:#eaeaea;color:#333;}
.brand{padding:10px 0px}
div.user{padding:10px 15px}
.reason{padding:5px 15px}
.description{padding:5px 5px;border-top:1px solid #fff;}
.imgitem{padding:5px 5px;}
.imgitem img{height:80px;}
.resolve .index{float:left;font-size:18px;font-weight:bold;color:#333;line-height:27px;}
.tag .label{margin:2px 5px;cursor:pointer;}
#addtag .label{cursor:pointer;}
.resolve_img img{margin:2px 2px;cursor:pointer;}
#addResolve{width:auto;min-width:560px}
#historyImg{
position:absolute;width:100px;display:none;
left:100%;background-color:#fff;border-radius:0 5px 5px 0;
border-left:1px solid #aaa;padding:5px 5px;
}
.imgbody {list-style:none;padding:2px 2px;margin:0 0;max-height: 300px;overflow: auto;}
.imgbody li{margin:5px 5px;border:2px solid #aaa;cursor: pointer;}
.addhistory{cursor: pointer;}
li.img-select{border:2px solid red}
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
					<li><a href="#">家具需求管理</a>
					</li>
				</ul>
				<div class="row-fluid sortable">
					<div class="box span12">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon user"></i><span class="break"></span>家具需求管理
							</h2>
							<div class="box-icon">
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
						<input name="pageIndex" id="pageIndex" type="hidden" value="${pageResult.pageIndex}"/>
						<input name="pageSize" type="hidden" value="${pageResult.pageSize}"/>
						</form>
							<table class="table table-striped table-bordered">
								<thead>
									<tr>
										<th >凯特号</th>
										<th >功能区域</th>
										<th style="width:100px;">家具品类</th>
										<th style="width:100px;">风格</th>
										<th >预算</th>
										<th style="width:100px;">创建时间</th>
										<th style="width:150px;">描述</th>
										<th >状态</th>
										<th >操作</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${pageResult.param }" var="temp" varStatus="status">
									<tr id="${temp.requiredId }">
										<td>${temp.getMoreId }</td>
										<td class="zone">
											<span class='label' zoneId="${temp.zoneDTO.zoneId}">
											${temp.zoneDTO.zoneName}</span></td>
										<td class="type">
											<c:forEach items="${temp.typeDTOs  }" var="type">
												<span class='label' typeId="${type.typeId }">${type.typeName }</span>
											</c:forEach>
										</td>
										<td class="style">
											<c:forEach items="${temp.styleDTOs }" var="style">
												<span class='label' styleId="${style.styleId }">${style.styleName }</span>
											</c:forEach>
										</td>
										<td>
											<c:if test="${temp.budgetDTO.startNum<0 }">不限制</c:if>
											<c:if test="${temp.budgetDTO.startNum>=0 }">
												${temp.budgetDTO.startNum } 至 ${temp.budgetDTO.endNum }万
											</c:if>
										</td>
										<td><fmt:formatDate value="${temp.createDate }" pattern="yyyy-MM-dd"/> </td>
										<td>${temp.description }</td>
										<td>
										<c:if test="${temp.status=='0'}">
											<span class='label label-success'>已被删</span>
										</c:if>
										<c:if test="${temp.status=='1'}">
											<span class='label label-success'>需求中</span>
										</c:if>
										<c:if test="${temp.status=='2'}">
											<span class='label label-success'>有回复</span>
										</c:if>
										
										</td>
										<td>
											 <a class="btn btn-success show-answer btn-mini edit" requiredId="${temp.requiredId }"
											> 
												<i class="halflings-icon white edit"></i> 方案</a> 
											<!--<a class="btn btn-danger  btn-mini changeStatu" userid="${temp.requiredId  }" status="0" href="#"> 
												<i class="halflings-icon trash white"></i> 删除</a> -->
										</td>
									</tr>
								<%-- 	
										      <div class="resolve"><span class="index">1. </span>
										     	 <div class="brand"><i class="halflings-icon globe "></i> 工艺大师</div>
										     	 <div class="reason">
										      		<i class="halflings-icon tags "></i>
										      		<span class="label label-success">现代</span> 
										      		<span class="label label-success">沙发</span> 
										      	</div>
										     	 <div class="user" style="line-height:15px;">
										     	 <i class="halflings-icon user "></i> 瞿大大  
										     	 &nbsp;<i class="halflings-icon phone "></i> 13333333333
										     	 &nbsp;<i class="halflings-icon qrcode "></i> quzhao_s
										     	 &nbsp;<i class="halflings-icon time "></i> 2015-7-15 15:21:15
										     	 </div>
										      	<div class="imgitem">
										      		<img src="../wechat/images/inslide1.jpg"/>
										      		<img  src="../wechat/images/inslide1.jpg"/>
										      		<img  src="../wechat/images/inslide1.jpg"/>
										      	</div>
										      	<div class="description">各种特殊，欧式风格，简约大气，必定满足您的各种体验</div>
										      </div>
										 --%>
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
	<div class="modal hide fade" id="addResolve">
		<!-- 历史方案图选择 -->
		<div id="historyImg">
			<h3><small class="text-success">选择历史图</small></h3>
				<ul class="imgbody">
				</ul>
				<div>
				<span class="addhistory label">确 定</span>
				
				</div>
			</div>
		<!-- 历史方案图选择-end -->
		
		
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>上传方案</h3>
		</div>
		<div class="modal-body" style="max-width: 600px"> 
			<p><small class="text-success">上传方案</small></p>
				
				<form action="#" id="addForm">
				<input type="hidden" id="required"/>
				<table class="table table-bordered">
				<tr>
					<td style="width:90px"><span class="add-on"> 品牌  </span></td>
					<td >
						<select id="add_brand">
						</select>
					</td>
				</tr>
				<tr>
					<td style="width:90px"><span class="add-on"> 标签选择  </span></td>
					<td id="addtag">
						
					</td>
				</tr>
				<tr><td colspan="2" style="position:relative;border-bottom:1px solid #ccc;color:#888;padding-top:5px">
					<label id="showHistoryImg" style="position:absolute;left:80%;">历史方案图  <i class="halflings-icon plus"> </i></label>
					<label for="resolve_img">方案图  <i class="halflings-icon plus"> </i>
					</label><input type="file" style="display: none;"  name="resolve_img" id="resolve_img" accept="image/*"/>
					</td>
					</tr>
				<tr>
					<td colspan="2" style="height:80px;">
					<div class="resolve_img">
					</div>
					</td>
					</tr>
				<tr>
					<td><span class="add-on"> 描述</span></td>
					<td colspan="1"><textarea id="description"  maxlength="100" cols="8" rows="3" style="resize:none;width:95%;height:95%"></textarea></td>
				</tr>
				</table>
				</form>
				<div>
				<small class="text-error">双击删除方案图</small>
				</div>				
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">返回</a> <a href="#"
				class="btn btn-primary addSubmit">保存</a>
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
	$(".roleSelect").chosen();
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
});
	
	//刷新页面
	function reset(){
		$("#myform").submit();
	}
	//查看方案
	(function(){
		$(".show-answer").on("click",function(){
			var param={};
			var requiredId=$(this).attr("requiredId");
			if($("#show"+requiredId).get(0)){
				$("#show"+requiredId+" .collapse").collapse("toggle");
				return;
			}
			param.operator="show-answer";
			param.requiredId=requiredId;
			$.post("list.html",param,function(json){
				if(json.status=="ok"){
					$("#"+requiredId).after($("<tr>").attr("id","show"+requiredId)
							.append($("<td>").attr("colspan",9).css({"padding":"0px 0px","border":"none"})));
						
					$("#show"+requiredId+" td").append(
					'<div class="collapse">'+
						'<div class="text-right" style="color:#F72727"><small>一共有'+json.data.length+'条方案</small>'+
						' <a class="btn btn-danger btn-mini addResolve edit" requiredId="'+requiredId+'">'+  
							'<i class="halflings-icon white" ></i> 添加我的方案</a> </div>');
					$("#show"+requiredId+" td .collapse").append(getAnswerHtml(json.data));
					$("#show"+requiredId+" .collapse").collapse("toggle");
				}
			},"json");
		});
		//展示数据
		function getAnswerHtml(dataList){
			var $html;
			$(dataList).each(function(){
				var $temp=
				 '<div class="resolve">'+
		     	 '<div class="brand"><i class="halflings-icon globe "></i>'+this.brand.brandName+'</div>'+
		     	'<div class="reason">'+
		      		'<i class="halflings-icon tags "></i>';
		      		for(var i=0;i<this.zones.length;i++){
		      			$temp+=' <span class="label label-success">'+this.zones[i].zoneName+'</span>';
		      		}
		      		for(var i=0;i<this.types.length;i++){
		      			$temp+=' <span class="label label-success">'+this.types[i].typeName+'</span>';
		      		}
		      		for(var i=0;i<this.styles.length;i++){
		      			$temp+=' <span class="label label-success">'+this.styles[i].styleName+'</span>';
		      		}
		      	$temp+=
		      	'</div>'+
		     	' <div class="user" style="line-height:15px;">'+
		     	' <i class="halflings-icon user "></i> '+this.user.userName+
		     	' &nbsp;<i class="halflings-icon phone "></i>'+this.user.phone+
		  //   	 '&nbsp;<i class="halflings-icon qrcode "></i> quzhao_s'+
		     	 '&nbsp;<i class="halflings-icon time "></i>'+this.createDate+
		     	' </div>'+
		      	'<div class="imgitem">';
		      	var imgArr=this.imgs.split(",");
			      	for(var i=0;i<imgArr.length;i++){
		      			$temp+='<img src="'+imgArr[i]+'"/>';
		      		}
			      	$temp+=	
		      '	</div>'+
		      	'<div class="description">'+this.description+'</div>'+
		      '</div>';
				if($html){
					$html+=	$temp;
				}else{
					$html =	$temp;
				}
			});
			return $html;
		}
		
	})();
	
	//添加方案
	(function(){
		var formdate;//表单对象
		if (window.FormData) {
	  		formdata = new FormData();
		}
		var imgs=new Array();
		$("body").on("click",".addResolve",function(){
			//验证权限
			var requiredId=$(this).attr("requiredId");
	 		var param={};
			param.operator="check-power";
			param.requiredId=requiredId;
			$.post("list.html",param,function(json){
				if(json.status=="0"){//审核不通过。
					layer.msg(json.message);
				}else{
					var brands=json.data;
					$("#add_brand").empty();
					$(brands).each(function(){
						$("#add_brand").append(new Option(this.brandName,this.brandId));
					});
					var zoneHtml=$("#"+requiredId+" .zone").html();
					var typeHtml=$("#"+requiredId+" .type").html();
					var styleHtml=$("#"+requiredId+" .style").html();
					$("#addtag").empty();
					$("#addtag").append($("<div>").html("<small>功能区域：</small>").append(zoneHtml));
					$("#addtag").append($("<div>").html("<small>家具品类：</small>").append(typeHtml));
					$("#addtag").append($("<div>").html("<small>风格样式：</small>").append(styleHtml));
					$("#required").val(requiredId);
					$("#addResolve").modal("show");
				}
			},"json"); 
		});
		
		//选择标签
		$("#addtag").on("click",".label",function(){
			$(this).toggleClass("label-success");
		});
		
		//选择历史
		$("#showHistoryImg").on("click",function(){
			if($("#historyImg .data").get(0)){
				$("#historyImg").fadeToggle("fast");
				
			}else{//请求数据
				var param={};
			param.operator="get-history-img";
				$.post("list.html",param,function(json){
					if(json.status=="ok"){
						if(json.data.length==0){
							layer.msg("没有历史图片！");
							return;
						}
						$("#historyImg .imgbody").addClass("data");
						$(json.data).each(function(){
							var $li=$("<li>").append($("<img>").attr("src",this.imgPath));
							$("#historyImg .data").append($li);
						});
					$("#historyImg").fadeIn("fast");
					}
				},"json");
			}
		})
		$("#historyImg").on("click","li",function(){
			$(this).toggleClass("img-select");
		});
		$("#historyImg").on("click",".addhistory",function(){
			$("#historyImg .data li.img-select img").each(function(){
				var $temp=$("<img>").attr("src",$(this).attr("src")).addClass("history").css("height","80px");
				$(".resolve_img").append($temp);
			});
			$("#historyImg .data li.img-select").removeClass("img-select");
		})
		
		//新增产品图
		$("#resolve_img").on("change",function(){
			var file=this.files[0];
			if (!!file.type.match(/image.*/)) {
				if ( window.FileReader ) {
					reader = new FileReader();
					reader.onloadend = function (e) { 
						$(".resolve_img").append($("<img >").attr("src",e.target.result).css("height","80px").addClass("new"));
					};
					reader.readAsDataURL(file);
				}
				imgs.push(file);
				$(this).val("");
			}	
		});
		//删除产品图
		$(".resolve_img").on("dblclick","img",function(){
			//从数组中删掉
			var index=$(this).index(".resolve_img img.new");
			if(index!=-1){
				var temp=new Array();
				for(var i=0;i<imgs.length;i++){
					if(i!=index){
					temp.push(imgs[i]);
					}
				}
				imgs=temp;
			}
			$(this).remove();
		});
		//进行增加操作
		$("#addResolve .addSubmit").on("click",function(){
			var requiredId=$("#required").val();
			var zone=$("#addtag span[zoneid].label-success").attr("zoneid");
			var type=$("#addtag span[typeid].label-success").attr("typeid");
			var style=$("#addtag span[styleid].label-success").attr("styleid");
			var brandId=$("#add_brand option:selected").val();
			if(!zone){
				layer.msg("请选择功能标签");
				return;
			}else if(!type){
				layer.msg("请选择家具品类");
				return;
			}else if(!style){
				layer.msg("请选择风格样式");
				return;
			}else if(!$(".resolve_img img").get(0)){
				layer.msg("请上传方案图");
				return;
			}else if(!$("#description").val()){
				layer.msg("请添加产品描述");
				return;
			}else{
				formdata.append("requiredId",requiredId);
				formdata.append("brandId",brandId);
				$("#addtag span[zoneid].label-success").each(function(){
					formdata.append("zoneId",$(this).attr("zoneid"));
				});
				$("#addtag span[typeid].label-success").each(function(){
					formdata.append("typeId",$(this).attr("typeid"));
				});
				$("#addtag span[styleid].label-success").each(function(){
					formdata.append("styleId",$(this).attr("styleid"));
				});
				formdata.append("description",$("#description").val());
				//进行产品图的添加，
				//新添加的
					$(imgs).each(function(){
						formdata.append("proImg[]",this);
					});
				//旧添加的
					$(".resolve_img img.history").each(function(){
						formdata.append("historyImgs",$(this).attr("src"));
					});
				$.ajax({
					url: "saveOrUpdate.html",
					type: "POST",
					data: formdata,
					processData: false,
					contentType: false,
					success: function (res) {
						layer.msg("更新成功");
						window.location.reload();
					}
				});
			}
		});
	})();
	
	</script>
</body>
</html>
