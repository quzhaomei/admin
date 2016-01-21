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
		<link id="ie-style" href="css/ie.css" rel="stylesheet">
	<![endif]-->

<!--[if IE 9]>
		<link id="ie9style" href="css/ie9.css" rel="stylesheet">
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

input[type=checkbox] {
	width: 15px;
	height: 15px;
	vertical-align: top;
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
					<li><a href="#">系统设置<i class="icon-angle-right"></i> </a>
					</li>
					<li><a href="#">权限管理</a>
					</li>
				</ul>
				<p>
					<small class="text-error">-角色权限分配 <br />-请先选择需要更改权限的角色，再进行角色权限操作！
					</small>
				</p>
				<div id="searchDiv">
				<table>
				<tr>
				<td class="text-center text-success"><select id="pageSelect" style='width:180px;'>
							<option value="-1">- 请 选 择 -</option>
						<c:forEach items="${allRoles}" var="role">
							<option value="${role.roleId }">${role.roleName }</option>
						</c:forEach>
						</select>						
				</td>
				<td><button class="btn btn-primary btn-small" id="searchBtn">
				<i class="halflings-icon search white"></i></button></td>
				</select>	
				</tr>
				</table>
				</div>									
										
			</div>
		</div>
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
	//下拉款美化
	$("#pageSelect").chosen();
	
	$(function() {
		$("#searchBtn").click(function(){
				var roleId=$("#pageSelect").val();
				if(roleId=="-1"){
					return;
				}
				//TODO 查找是否已经存在,存在就取到第一位来
				if($("#"+roleId).get(0)){
					$("#"+roleId+" .box").hide();
					$("#"+roleId).insertAfter($("#searchDiv"));	
					$("#"+roleId+" .box").fadeIn(600);
					return;
				}
				//IF不存在查找对应权限
				$.post("list.html",{"roleId":roleId},function(json){
					createUserPowerTree(json.menuList,json.role);
				},"json");
			});	
	});
		function createUserPowerTree(jsonArr,role){
			var $div=$("<div>").addClass("row-fluid sortable").css("display","none").attr("id",role.roleId);
			var $div1=$("<div>").addClass("box span12")
			var $div2=$("<div>").addClass("box-header");
			var $div3=$("<div>").addClass("box-content");
			 $div.append($div1);
			 $div1.append($div2).append($div3);
			 $div3.append("<div class='tree well'></div>");
			 $div2.append("<h2><i class='halflings-icon user'></i><span class='break'></span>"+
									"<span class='roleName'>"+role.roleName+"</span></h2>");
			 $div2.append("<div class='box-icon'>"+
			 		"<a href='javascript:;' class='btn-save' style='display:none;'><i class='halflings-icon ok'></i> </a>"+//保存
					"<a href='javascript:;' class='btn-refresh'><i class='halflings-icon refresh'></i> </a>"+//刷新
					"<a href='javascript:;' class='btn-minimize'><i class='halflings-icon chevron-up'></i></a>"+//最小化
					"<a href='javascript:;' class='btn-close'><i class='halflings-icon remove'></i></a></div>");//关闭
			$div.insertAfter($("#searchDiv"));	
			$div.fadeIn(600);
			
			initRoleEdit(role.roleId);//初始化图标操作事件
			
			writeMenuList(jsonArr,"-1",null,$('#'+role.roleId+' .tree'));//画出权限树-1表示从根画起
			initMenuEvent();//绑定树的事件	
			//绑定值单个菜单权限的改变事件
			$("#"+role.roleId+" input:checkbox").click(function(){
				$(this).toggleClass("change");
			});
			//绑定整体值的改变事件
			$("#"+role.roleId).click(function(){
				if($("#"+role.roleId+" input:checkbox.change").get(0)){//值改变了
					$("#"+role.roleId+" .tree").css("backgroundColor","rgb(208, 239, 255)");
					$("#"+role.roleId+" .btn-save").show();
				}else{
					$("#"+role.roleId+" .tree").css("backgroundColor","#fff");
					$("#"+role.roleId+" .btn-save").hide();
				}
			});
				
		}

		function writeMenuList(jsonArr, parentId, $li,$position) {
			var $newul = $("<ul>");
			if (parentId == "-1" && !$li) {//先画出根目录
				$(jsonArr)
						.each(
								function() {
									if (this.menuId == parentId && !$li) {
										var $newli = $("<li>")
												.append(
														" <span class='item text-error'><i class='icon-folder-open'></i> "
																+ this.menuName
																+ "</span>");
										$newul.append($newli);
										writeMenuList(jsonArr, this.menuId,
												$newli);
									}
								});
				$position.append($newul);
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
														"<input type='checkbox' "+((this.hasPower=="1"?"checked":""))+" menuId='"+this.menuId+"'/> <span class='item "
																+ (this.type == "-1" ? "text-error"
																		: "")
																+ "'><i class='icon-"+clazz+"'></i> "
																+ this.menuName
																+ "</span>");
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
		function initMenuEvent() {
			$('.tree li:has(ul)').addClass('parent_li').find(' > span').attr(
					'title', '点击关闭');
			$('.tree li.parent_li > span').on(
					'click',
					function(e) {
						var children = $(this).parent('li.parent_li').find(
								' > ul > li');
						if (children.is(":visible")) {
							children.hide('fast');
							$(this).attr('title', '点击展开').find(' > i')
									.addClass('icon-plus-sign').removeClass(
											'icon-minus-sign');
						} else {
							children.show('fast');
							$(this).attr('title', '点击展开').find(' > i')
									.addClass('icon-minus-sign').removeClass(
											'icon-plus-sign');
						}
						e.stopPropagation();
					});
		}
		//刷新角色权限
		function refresh(roleId,msg){
			$.post("list.html",{"roleId":roleId},function(json){
					//先清空里面的内容
					var role=json.role;//绑定角色
					var jsonArr=json.menuList;//绑定菜单
					var $div=$("#"+roleId);
						$div.empty().hide();//清空内容
					var $div1=$("<div>").addClass("box span12")
					var $div2=$("<div>").addClass("box-header");
					var $div3=$("<div>").addClass("box-content");
					 $div.append($div1);
					 $div1.append($div2).append($div3);
					 $div3.append("<div class='tree well'></div>");
					 $div2.append("<h2><i class='halflings-icon user'></i><span class='break'></span>"+
											"<span class='roleName'>"+role.roleName+"</span></h2>");
					 $div2.append("<div class='box-icon'>"+
					 		"<a href='javascript:;' class='btn-save' style='display:none;'><i class='halflings-icon ok'></i> </a>"+//保存
							"<a href='javascript:;' class='btn-refresh'><i class='halflings-icon refresh'></i> </a>"+//刷新
							"<a href='javascript:;' class='btn-minimize'><i class='halflings-icon chevron-up'></i></a>"+//最小化
							"<a href='javascript:;' class='btn-close'><i class='halflings-icon remove'></i></a></div>");//关闭
					$div.fadeIn(600);
				//事件初始化	
					initRoleEdit(role.roleId);
					
					writeMenuList(jsonArr,"-1",null,$('#'+role.roleId+' .tree'));//画出权限树-1表示从根画起
					initMenuEvent();//绑定树的事件	
					//绑定值单个菜单权限的改变事件
					$("#"+role.roleId+" input:checkbox").click(function(){
						$(this).toggleClass("change");
					});
					//绑定整体值的改变事件
					$("#"+role.roleId).click(function(){
						if($("#"+role.roleId+" input:checkbox.change").get(0)){//值改变了
							$("#"+role.roleId+" .tree").css("backgroundColor","rgb(208, 239, 255)");
							$("#"+role.roleId+" .btn-save").show();
						}else{
							$("#"+role.roleId+" .tree").css("backgroundColor","#fff");
							$("#"+role.roleId+" .btn-save").hide();
						}
					});
					if(msg){
						layer.msg(msg);
					}else{
						layer.msg("刷新成功！");
					}
				},"json");
		}
		
		function initRoleEdit(roleId){
		//事件初始化	
			$('#'+roleId).sortable({
				revert:true,
				cancel:'.btn,.box-content,.nav-header',
				update:function(event,ui){
				}
			});	
			$('#'+roleId+' .btn-close').click(function(e){//关闭事件
					e.preventDefault();
					$(this).parent().parent().parent().fadeOut();
				});
			$('#'+roleId+' .btn-minimize').click(function(e){//最小化事件
					e.preventDefault();
					var $target = $(this).parent().parent().next('.box-content');
					if($target.is(':visible')) $('i',$(this)).removeClass('chevron-up').addClass('chevron-down');
					else 					   $('i',$(this)).removeClass('chevron-down').addClass('chevron-up');
					$target.slideToggle();
				});
			$('#'+roleId+' .btn-refresh').click(function(e){//刷新事件
				
				//有值改变，做提醒
				if($("#"+roleId+" input:checkbox.change").get(0)){//值改变了
					layer.confirm("检测到有值改变了，确定不保存直接刷新吗？",{title:"警告：有值改变了"},function(){
						refresh(roleId);
					},function(){});
					return;
				}
					refresh(roleId);
				});
			$('#'+roleId+' .btn-save').click(function(e){//保存
					var param={};
					param.roleId=roleId;//角色
					param.list=[];
					//获取改变的事件
					$("#"+roleId+" input:checkbox.change").each(//初始化参数
							function(){
								var statu=0;
								if($(this).attr("checked")){
									statu=1;//有效
								}
								param.list.push({"menuId":$(this).attr("menuId"),"status":statu});
							}
						);
						$.post( "saveOrUpdate.html", 
							param,  
				        	 function(json){
				            	if(json.status="ok"){
				            		refresh(roleId,"更新成功！！");
				            	}
				            }  
				        );
					
				});
		}
		
		
	</script>
</body>
</html>
