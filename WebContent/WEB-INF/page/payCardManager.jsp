<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- start: Meta -->
<meta charset="utf-8">
<title>后台管理</title>
<!-- end: Meta -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
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
					<li><a href="#">支付管理 <i class="icon-angle-right"></i> </a>
					</li>
					<li><a href="#">品牌管理支付账号</a>
					</li>
				</ul>	
				<div class="row-fluid sortable">
					<!--功能区域-->
					<div class="box span12 payCard">
						<div class="box-header" data-original-title>
							<h2>
								<i class="halflings-icon screenshot"></i><span class="break"></span>账号列表
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
							<table class="table table-striped table-hover table-bordered bootstrap-datatable datatable">
								<thead>
									<tr>
										<td>管理员手机</td>
										<th >管理员名字</th>
										<th style="width:120px !important;">旗下品牌</th>
										<th >银行卡</th>
										<th >商户ID</th>
										<th style="width:80px !important;">商户秘钥</th>
										<th >操作</th>
									</tr>
								</thead>
								<tbody>
							 	<c:forEach items="${payCardList}" var="pay" varStatus="temp">
									<tr>
										<td>${pay.systemUserDTO.phone }</td>
										<td>${pay.systemUserDTO.userName }</td>
										<td>
										<c:forEach items="${pay.brandDTO}" var="brand">
											<span class="label label-success"> ${brand.brandName }</span>
											</c:forEach>	
										</td>
										<td>${pay.bankaccountnumber==null?"<span class='label label-info'>未绑定</span>":"<span class='label label-success'>已绑定</span>" }</td>
										
										<td>${pay.brandCode }
										<c:if test="${pay.brandCode==null }">
										<a class="btn btn-danger btn-mini updateCode" userId="${pay.systemUserDTO.systemUserId }" href="#"> 
												<i class="halflings-icon white refresh"></i> 注册商户</a>
											</c:if>	
										<c:if test="${pay.brandCode!=null&&!isBrand }">
										<a class="btn btn-danger btn-mini updateCode" userId="${pay.systemUserDTO.systemUserId }" href="#"> 
												<i class="halflings-icon white refresh"></i> 重新注册</a>
											</c:if>	
												</td>
										<td >${pay.brandKey} 
										<a class="btn btn-danger btn-mini updateKey" userId="${pay.systemUserDTO.systemUserId }" href="#"> 
												<i class="halflings-icon white refresh"></i> 秘钥</a>
												</td>
										<td>
											 <a class="btn btn-success  btn-mini update" userId="${pay.systemUserDTO.systemUserId }" href="#"> 
												<i class="halflings-icon white edit"></i> ${pay.brandCode==null?"完善信息":"修改信息" }</a> 
												</td>
									</tr>
								</c:forEach> 
								</tbody>
							</table>
						</div>
					</div>
					
				</div>	
			</div>
			<!-- end: Content -->
		</div>
		<!--/#content.span10-->
	</div>
	<!--/fluid-row-->
	
	<!-- 修改 -->
	<div class="modal hide fade" id="updateModel" style="width:800px;left:600px;" >
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>支付账号管理</h3>
		</div>
		<div class="modal-body">
			<div id="myTabContent" class="tab-content">
				<!-- 修改tab -->
				<div class="tab-pane fade in active text-left" id="edit">
					<p class="text-success">--更新支付账号 </p>
					<table class="addBrand" style="width:98%;margin:5px 1%;" >
					<tr>
					<td colspan="2"><div class="input-prepend" title="用户名姓名">
					<span class="add-on"><i class="halflings-icon pencil"></i> 用户名姓名 </span>
					<input class="input-large span3"  type="hidden"  id="update_userId"/>
					<input class="input-large span3"  type="text"  readonly="readonly"  id="update_userName"/>
					</div></td>
					</tr>
					<tr>
					<td><div class="input-prepend" title="银行卡号">
					<span class="add-on"><i class="halflings-icon globe"></i> 银行卡号 </span>
					<input class="input-large span3"  type="text"  id="update_bankaccountnumber" maxlength="50"/>
					</div></td>
					<td><div class="input-prepend" title="开户类别">
					<span class="add-on"><i class="halflings-icon globe"></i> 开户类别 </span>
					<select id="update_bankaccounttype">
						<option value="-1">请选择账户类型</option>
						<option value="PrivateCash">私人账户</option>
						<option value="PublicCash">公司账户</option>
					</select>
					</div></td>
					</tr>
					
					<tr>
					<td><div class="input-prepend" title="开户名">
					<span class="add-on"><i class="halflings-icon globe"></i> 开户人姓名 </span>
					<input class="input-large span3"  type="text"  id="update_accountname" maxlength="20"/>
					</div></td>
					<td><div class="input-prepend" title="身份证号">
					<span class="add-on"><i class="halflings-icon pencil"></i> 身份证号 </span>
					<input class="input-large span3"  type="text"  id="update_idcard" maxlength="18"/>
					</div></td>
					
					</tr>
					
					<tr>
					<td><div class="input-prepend" title="开户省 ">
					<span class="add-on"><i class="halflings-icon globe"></i>开户省 </span>
					<input class="input-large span3" id="update_bankprovince" type="text" maxlength="10"/>
					<span class="add-on" style="display:none;"> <i class="halflings-icon pencil"></i></span>
					</div></td>
					<td>
					<div class="input-prepend" title="开户市">
					<span class="add-on"><i class="halflings-icon globe"></i> 开户市</span>
					<input class="input-large span3" id="update_bankcity" type="text" maxlength="20"/>
					<span class="add-on" style="display:none;"> <i class="halflings-icon pencil"></i></span>
					</div>
					</td>
					</tr>
					<tr>
					<td><div class="input-prepend" title="开户行">
					<span class="add-on"><i class="halflings-icon globe"></i> 开户行 </span>
					<input class="input-large span3"  type="text"  id="update_bankname" maxlength="50"/>
					</div></td>
					<td><div class="input-prepend" title="绑定手机">
					<span class="add-on"><i class="halflings-icon globe"></i> 绑定手机 </span>
					<input class="input-large span3"  type="text"  id="update_bindmobile" maxlength="11"/>
					</div></td>
					</tr>
					</table>
				</div>					
			</div>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">关闭</a>
			<a href="#"
				class="btn btn-primary updateBtn">确认</a>
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
	$(".roleSelect").chosen();
	$("input:file.uniform_on").uniform();
		
	$(function(){
		$(".payCard").on("click",".update",function(){
			$("#update_userId").val("");//清空数据
			var userId=$(this).attr("userId");
			$.post("list.html",{"userId":userId},function(data){
				var userName=data.systemUserDTO.userName;//用户名
				var bankaccountnumber=data.bankaccountnumber;//银行卡号
				var bankaccounttype=data.bankaccounttype;//开户类别
				var accountname=data.accountname;//开户姓名
				var idcard=data.idcard;//身份证号
				var bankprovince=data.bankprovince;//开户省
				var bankcity=data.bankcity;//开户市
				var bankname=data.bankname;//开户行
				var bindmobile=data.bindmobile;//绑定的手机
				
				$("#update_userId").val(userId);
				$("#update_userName").val(userName);
				
				$("#update_bankaccountnumber").val(bankaccountnumber).attr("bak",bankaccountnumber);
				$("#update_bankaccounttype").attr("bak",bankaccounttype);
				$("#update_bankaccounttype option[value='"+bankaccounttype+"']").attr("selected","selected");
				
				$("#update_accountname").val(accountname).attr("bak",accountname);
				$("#update_idcard").val(idcard).attr("bak",idcard);
				$("#update_bankprovince").val(bankprovince).attr("bak",bankprovince);
				$("#update_bankcity").val(bankcity).attr("bak",bankcity);
				$("#update_bankname").val(bankname).attr("bak",bankname);
				$("#update_bindmobile").val(bindmobile).attr("bak",bindmobile);
				
			$("#updateModel").modal("show");
			},"json")
		});
		//提交更新
		$("#updateModel .updateBtn").on("click",function(){
			
			var userId=$("#update_userId").val();
		
			//银行卡号
			var bankaccountnumber=$("#update_bankaccountnumber").val();
			var old_bankaccountnumber=$("#update_bankaccountnumber").attr("bak");
			//开户类别
			var bankaccounttype=$("#update_bankaccounttype").val();
			var old_bankaccounttype=$("#update_bankaccounttype").attr("bak");
			//开户姓名
			var accountname=$("#update_accountname").val();
			var old_accountname=$("#update_accountname").attr("bak");
			//身份证号
			var idcard=$("#update_idcard").val();
			var old_idcard=$("#update_idcard").attr("bak");
			//开户省
			var bankprovince=$("#update_bankprovince").val();
			var old_bankprovince=$("#update_bankprovince").attr("bak");
			//开户市
			var bankcity=$("#update_bankcity").val();
			var old_bankcity=$("#update_bankcity").attr("bak");
			//开户行
			var bankname=$("#update_bankname").val();
			var old_bankname=$("#update_bankname").attr("bak");
			//绑定的手机
			var bindmobile=$("#update_bindmobile").val();
			var old_bindmobile=$("#update_bindmobile").attr("bak");
		
			
			if(!bankaccountnumber){
				layer.msg("银行卡号不能为空");
				return;
			}
			if(bankaccounttype=="-1"){
				layer.msg("请选择账户类别");
				return;
			}
			if(!accountname){
				layer.msg("请填写开户姓名");
				return;
			}
			if(!idcard){
				layer.msg("请填写身份证号");
				return;
			}
			if(!bankprovince){
				layer.msg("请填写开户省");
				return;
			}
			if(!bankcity){
				layer.msg("请填写开户市");
				return;
			}
			if(!bankname){
				layer.msg("请填写开户行");
				return;
			}
			if(!bindmobile){
				layer.msg("请填写绑定手机");
				return;
			}
			
			var param={};
			param.userId=userId;
			
				
			if(old_bankaccountnumber!=bankaccountnumber){
				param.bankaccountnumber=bankaccountnumber;
			}
			if(old_bankaccounttype!=bankaccounttype){
				param.bankaccounttype=bankaccounttype;
			}
			if(old_accountname!=accountname){
				param.accountname=accountname;
			}
			if(old_idcard!=idcard){
				param.idcard=idcard;
			}
			if(old_bankprovince!=bankprovince){
				param.bankprovince=bankprovince;
			}
			if(old_bankcity!=bankcity){
				param.bankcity=bankcity;
			}
			if(old_bankname!=bankname){
				param.bankname=bankname;
			}
			if(old_bindmobile!=bindmobile){
				param.bindmobile=bindmobile;
			}
			
			$.post("saveOrUpdate.html",param,function(json){
				if(json.status=="ok"){
					layer.msg("更新成功");
					window.location.reload();
				}
			},"json");
			
		});
		
	//注册商户
	$("body").on("click",".updateCode",function(){
		var userId=$(this).attr("userid");
		//验证是否可以注册
		var param={};
		param.operator="registerBrand";
		param.userId=userId;
		$.post("list.html",param,function(json){
			if(json.status=="no"){
				layer.msg(json.message);
			}else if(json.status=="ok"){//开始注册
				layer.msg(json.message);
				setTimeout(function(){
				window.location.reload();
				},1500);
			}
		},"json");
	});
	
	//填写秘钥
	$("body").on("click",".updateKey",function(){
		var userId=$(this).attr("userid");
		var param={};
		param.operator="registerKey";
		param.userId=userId;
		layer.prompt({
		    title: "请输入商户秘钥",
		    formType: 0 //prompt风格，支持0-2
		}, function(key,index){
			layer.close(index);
			if(!key){
				layer.msg("秘钥为商户注册后，在易宝后台获取，且不能为空");
				return;
			}
			param.key=key;
			$.post("list.html",param,function(json){
				if(json.status=="ok"){
					layer.msg(json.message);
					setTimeout(function(){window.location.reload();},1500);
				}else if(json.status=="no"){
					layer.msg(json.message);
				}
				},"json");
		});
	});
	});
	
	layer.config({
	    extend: 'extend/layer.ext.js'
	});
	</script>
</body>
</html>
