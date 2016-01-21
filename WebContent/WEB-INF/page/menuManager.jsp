<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
.tree {
	min-height: 20px;
	padding: 19px;
	margin-bottom: 20px;
	background-color: #fbfbfb;
	border: 1px solid #999;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
	-moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05)
}

.tree li {
	list-style-type: none;
	margin: 0;
	padding: 10px 5px 0 5px;
	position: relative
}

.tree li::before,.tree li::after {
	content: '';
	left: -20px;
	position: absolute;
	right: auto
}

.tree li::before {
	border-left: 1px solid #999;
	bottom: 50px;
	height: 100%;
	top: 0;
	width: 1px
}

.tree li::after {
	border-top: 1px solid #999;
	height: 20px;
	top: 25px;
	width: 25px
}

.tree li span {
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	border: 1px solid #999;
	border-radius: 5px;
	display: inline-block;
	padding: 3px 8px;
	text-decoration: none
}

.tree li.parent_li>span {
	cursor: pointer
}

.tree>ul>li::before,.tree>ul>li::after {
	border: 0
}

.tree li:last-child::before {
	height: 30px
}

.tree li.parent_li>span:hover,.tree li.parent_li>span:hover+ul li span {
	background: #eee;
	border: 1px solid #94a0b4;
	color: #000
}

.editTitle {
	display: none;
}

.editTitle i {
	min-width: 50px;
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

				<!-- start: 鏍囬鑿滃崟 -->
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
					<li><a href="#">系统设置 <i class="icon-angle-right"></i> </a>
					</li>
					<li><a href="#">菜单管理</a>
					</li>
				</ul>

				<div class="tree well">
					<p class='text-error'>
						<small> --红色的代表系统初始化菜单，不能进行删除！<br/>--系统左侧导航栏只显示至第二级菜单</small>
					</p>
					
				</div>

			</div>
			<!-- end: Content -->
		</div>
		<!--/#content.span10-->
	</div>
	<!--/fluid-row-->

	<div class="modal hide fade" id="myModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>设置菜单</h3>
		</div>
		<div class="modal-body">

			<ul id="myTab" class="nav nav-tabs">
				<li class="active"><a class="edit_mod" href="#edit" data-toggle="tab"> <i
						class="icon-pencil"></i> 修改 </a>
				</li>
				<li ><a class="del_mod" href="#del" data-toggle="tab"><i class="icon-file"></i>
						删除</a></li>
				<li ><a class="add_mod" href="#add"  data-toggle="tab"><i class="icon-leaf"></i>
						增加子菜单</a>
				</li>
			</ul>
			<div id="myTabContent" class="tab-content">
				<!-- 修改tab -->
				<div class="tab-pane fade in active text-left" id="edit">
					<p><small class="text-success">修改本菜单</small></p>
					<div class="alert alert-error alert-dismissable" style="display:none">
						 <span class="content" > </span>
						</div>
					<div class="input-prepend" title="菜单名字">
					<span class="add-on"><i class="halflings-icon pencil"></i> 名 称 </span>
					<input class="input-large span5" id="menuName"  type="text" placeholder="请输入菜单名字" maxlength="10" >
					<input type="hidden" id="menuId" />
					<input type="hidden" id="operator" value="edit"/>
					</div>
					<div class="input-prepend" title="链接">
					<span class="add-on"><i class="halflings-icon globe"></i> 链 接 </span>
					<input class="input-large span5" id="url" type="text" style="ime-mode:disabled" placeholder="请输入链接" maxlength="40"/>
					</div>
				</div>
				<!-- 删除tab -->
				<div class="tab-pane fade text-left" id="del" >
					<p class="text-success"><small>请输入：<span id="repeat" class="text-warn">我确认删除</span></small></p>
					<div class="alert alert-error alert-dismissable" style="display:none">
						 <span class="content" > 错误！请输入上面提示内容。</span>
						</div>
					<input class="input-large span5" type="text" id="editrepeat" placeholder="请输入上面提示的内容" maxlength="20"/>
				</div>
				<!-- 增加tab -->
				<div class="tab-pane fade text-left" id="add">
					<p><small class="text-success">新建子菜单</small></p>
					<div class="alert alert-error alert-dismissable" style="display:none">
						 <span class="content" ></span>
						</div>
					<div class="input-prepend" title="菜单名字">
					<span class="add-on"><i class="icon-leaf""></i> 名 称 </span>
					<input class="input-large span5" id="add_menuName"  type="text" placeholder="请输入菜单名字" maxlength="10" >
					</div>
					<div class="input-prepend" title="链接">
					<span class="add-on"><i class="halflings-icon globe"></i> 链 接 </span>
					<input class="input-large span5" id="add_url" type="text" style="ime-mode:disabled" placeholder="请输入链接" maxlength="40"/>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">关闭</a> <a href="#"
				class="btn btn-primary saveOrUpdate">确认</a>
		</div>
	</div>

	<div class="clearfix">
    </ul>
	
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
		$(function() {
			//从服务器获取菜单数据
			$.post("list.html", function(jsonArr) {
				writeMenuList(jsonArr, "-1");
				initMenuEvent();
			}, "json");
		});
		function initMenuEvent() {
			$('.tree li:has(ul)').addClass('parent_li').find(' > span').attr(
					'title', '点击展开');
			$('.tree li.parent_li > span').on(
					'click',
					function(e) {
						var children = $(this).parent('li.parent_li').find(
								' > ul > li');
						if (children.is(":visible")) {
							children.hide('fast');
							$(this).attr('title', '点击关闭').find(' > i')
									.addClass('icon-plus-sign').removeClass(
											'icon-minus-sign');
						} else {
							children.show('fast');
							$(this).attr('title', '点击关闭').find(' > i')
									.addClass('icon-minus-sign').removeClass(
											'icon-plus-sign');
						}
						e.stopPropagation();
					});

			$(".item + .editTitle").on("click", function() {
				var menuId = $(this).attr("menuId");
				//获取指定的菜单并展示
				$.post("list.html", {
					"menuId" : menuId
				}, function(data) {
					//如果是系统初始化设置，是不允许删除的,
					if(data.type=="-1"){
						$("#myModal .del_mod").parent().hide();
					}else{
						$("#myModal .del_mod").parent().show();
					}
					$("#myModal").find("#menuId").val(data.menuId);
					$("#myModal").find("#menuName").val(data.menuName);
					$("#myModal").find("#url").val(data.url);
					//重置为编辑tab
					$("#myModal").modal("show");
					setTimeout(function(){
					$("#myModal .edit_mod").tab("show");//重置为编辑
					$("#myModal #operator").val("edit");
					}, 300);
					
					
				}, "json");
			});

			//saveOrUpdate
			$("#myModal .saveOrUpdate").on("click",function() {
				//初始化参数，
				var param = {};
				param.operator = $("#myModal").find("#operator").val();//操作
				if(param.operator=="add"){//新增操作
					param.menuId = $("#myModal").find("#menuId").val();//ID
					param.menuName = $("#myModal").find("#add_menuName").val();//NAME
					param.url = $("#myModal").find("#add_url").val();//URL
					if(!param.menuName||$.trim(param.menuName)==""){//如果名称为空，则进行提醒
						$("#add .alert").hide();
						$("#add .alert .content").text("错误！名字不能为空");
						$("#add .alert").removeClass("alert-success").addClass("alert-danger");
						$("#add .alert").fadeIn("fast");
						$("#add_menuName").focus();										
						return;
					}
				}else if(param.operator=="edit"){//编辑操作
					param.menuId = $("#myModal").find("#menuId").val();//ID
					param.menuName = $("#myModal").find("#menuName").val();//NAME
					param.url = $("#myModal").find("#url").val();//URL
					
					if(!param.menuName||$.trim(param.menuName)==""){//如果名称为空，则进行提醒
						$("#edit .alert").hide();
						$("#edit .alert .content").text("错误！名字不能为空");
						$("#edit .alert").removeClass("alert-success").addClass("alert-danger");
						$("#edit .alert").fadeIn("fast");
						$("#menuName").focus();										
						return;
					}
				}else if(param.operator=="del"){//删除操作
					//检验是否输入
					var repeat=$("#editrepeat").val();
					if(!repeat){
						$("#del .alert").hide();
						$("#del .alert .content").text("错误！输入不能为空");
						$("#del .alert").removeClass("alert-success").addClass("alert-danger");
						$("#del .alert").fadeIn("fast");
						$("#editrepeat").focus();										
						return;
					}else if(repeat!=$("#repeat").text()){
						$("#del .alert").hide();
						$("#del .alert .content").text("错误！请正确输入上面提示内容");
						$("#del .alert").removeClass("alert-success").addClass("alert-danger");
						$("#del .alert").fadeIn("fast");
						$("#editrepeat").val("");
						$("#editrepeat").focus();
						return
					}
					param.menuId = $("#myModal").find("#menuId").val();//ID
				}
				  $.post("saveOrUpdate.html", param, function(data) {
						  $(".alert").hide();
					if(data.status=="ok"){
					if(param.operator=="del"){//删除成功的操作提示
							$("#del .alert").removeClass("alert-error").addClass("alert-success");
							$("#del .alert .content").text("删除操作成功！");							
							$("#del .alert").fadeIn("fast");
						}else if(param.operator=="add"){//增加成功的操作提示
						
							$("#add .alert").removeClass("alert-error").addClass("alert-success");
							$("#add .alert").fadeIn("fast");
							$("#add .alert .content").text("增加子菜单操作成功！");
						}else if(param.operator=="edit"){//修改成功的操作提示
							$("#edit .alert").removeClass("alert-error").addClass("alert-success");
							$("#edit .alert").fadeIn("fast");
							$("#edit .alert .content").text("更新菜单操作成功！");
						}
						setTimeout(function(){
								window.location="index.html";
							}, 1500);//加载页面
					}
				},"json");  
			});

			$(".item").on("mouseover", function() {
				$(".tree").find(".editTitle").hide();
				$(this).next(".editTitle").fadeIn("fast");
			});
			$(".tree .editTitle").on("mouseout", function() {
				$(this).hide();
			});
			
			$("#myModal .edit_mod").click(function(){
			$("#myModal #operator").val("edit");
				$("#edit .alert").hide();
			});
			
			$("#myModal .del_mod").click(function(){
			$("#myModal #operator").val("del");
				$("#del .alert").hide();
			});
			
			$("#myModal .add_mod").click(function(){
			$("#myModal #operator").val("add");
				$("#add .alert").hide();
			});
		}
		function writeMenuList(jsonArr, parentId, $li) {
			var $newul = $("<ul>");
			if (parentId == "-1" && !$li) {//先画出根目录
				$(jsonArr)
						.each(
								function() {
									if (this.menuId == parentId && !$li) {
										var $newli = $("<li>")
												.append(
														"<span class='item text-error'><i class='icon-folder-open'></i> "
																+ this.menuName
																+ "</span>"
																+ "<a href='#' class='editTitle' menuId="+this.menuId+" ><i class='icon-pencil'> 编辑</i> </a>");
										$newul.append($newli);
										writeMenuList(jsonArr, this.menuId,
												$newli);
									}
								});
				$('.tree').append($newul);
			} else {//画出其余的节点
				$(jsonArr)
						.each(
								function() {
									if (this.parentId == parentId
											&& this.menuId != "-1") {
										var claszz = "";
										if (this.type == "1") {//是操作
											clazz = "leaf";
										} else if (this.type == "0"
												|| this.type == "-1") {//是添加的菜单
											clazz = "minus-sign";
										}

										var $newli = $("<li>")
												.append(
														"<span class='item "
																+ (this.type == "-1" ? "text-error"
																		: "")
																+ "'><i class='icon-"+clazz+"'></i> "
																+ this.menuName
																+ "</span>"
																+ "<a href='#' class='editTitle'  menuId="+this.menuId+" ><i class='icon-pencil'> 编辑</i> </a>");
										$newul.append($newli);
										$li.append($newul);
										if (this.type == "0"
												|| this.type == "-1") {//是目录或是系统初始值 就再次递归一遍
											writeMenuList(jsonArr, this.menuId,
													$newli);
										}
									}
								});
			}

		}
	</script>
</body>
</html>
