<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>个人中心 | 个人资料</title>
     <meta name="viewport" content="width=321">
     <meta name="format-detection" content="telephone=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="bg_white with_topbar" id="personalinfo">
	
		<div class="topbar bar_red navback">
			<a href="center.html"><i class="icon-arrow-left"></i>  返回个人中心  </a>
			<div class="getlogo"><a href="http://guide.51getmore.cn"><img src="images/cathead.svg"></a></div>
		</div>

		<div class="title tcenter"><h2>基本信息</h2></div>
		<div class="listset">
			
			<div class="listitem arrowright">
				<div class="cavatar nolink" data-title="修改头像">
				<label for="cavatar" class="upload">
				<i class="icon-thumbs-o-up"></i>头像 

				<span class="right info">
				  	  <input type="file" capture="camera" accept="image/*" id="cavatar" />
				   	  <span class="img"><img src="${user.photo }" alt=""></span>
				</span>
				</label>

				</div>
			</div>
			<div class="listitem noarrow">
				<div class="nolink"><i class="icon-user"></i>姓名 <span class="right info">${guide.name }</span></div>
			</div>
			<div class="listitem noarrow">
				<div class="nolink"><i class="icon-male"></i>性别 <span class="right info">${guide.sex==0?"女":"男" }</span></div>
			</div>
			<div class="listitem arrowright">
				<a href="#" class="callpopup" id="cphone" data-target="#changeinfo" data-title="修改手机号"><i class="icon-iphone"></i
				>手机号 <span class="right info">${guide.phone }</span></a>
			</div>
			
		</div>


		<div class="title tcenter"><h2>职业信息</h2></div>

		
		<div class="listset">
			
			<div class="listitem arrowright">
				<a href="#" class="callpopup" id="cbrand" data-target="#changeinfo" data-title="修改所属公司"><i class="icon-star"></i>所属品牌 <span class="right info">${guide.brand.brandName }</span></a>
			</div>
			<div class="listitem arrowright">
				<a href="#" class="callpopup" id="cshop" data-target="#changeinfo" data-title="修改所属门店"><i class="icon-shop"></i>品牌门店 <span class="right info">${guide.store.storeName }</span></a>
			</div>

			<div class="listitem arrowright">
				<a href="#" class="callpopup" id="cposition" data-target="#changeinfo" data-title="修改职位"><i class="icon-user-tie"></i>店内职位 <span class="right info">${guide.job }</span></a>
			</div>
			
			
		</div>




		<div class="popup anime bg_white offstage" id="changeinfo">
		<header>
			<span class="ptitle"></span>
			<span class="close">
				<i class="icon-close"></i>
			</span>
		</header>
		<div class="contents formarea pad_narrow">
				<fieldset>
					<input type="number" name="tel" class="hide cphone formitem" placeholder="${guide.phone }" disabled="disalbed" id="phone" />
					<select name="brand" class="hide cbrand formitem" disabled="disalbed" id="brand">
						<option value="0">请选择品牌</option>
						<c:forEach items="${brands }" var="brand">
							<option value="${brand.brandId }">${brand.brandName }</option>
						</c:forEach>
					</select>

					<select name="shop" class="hide cshop formitem" disabled="disalbed" id="store">
						<option value="0">请选择门店</option>
						<c:forEach items="${stores }" var="store">
							<option value="${store.storeId }">${store.storeName }</option>
						</c:forEach>
					</select>

					<select name="position" class="hide cposition formitem" disabled="disalbed">
						<option value="0">请选择店内职务</option>
						<option value="店长">店长</option>
						<option value="销售">销售</option>
						<option value="导购">导购</option>
						
					</select>
					
				</fieldset>
				
				
				
				<button class="bttn_full" >确认保存</button>

		</div>



			<div class="progress">
				<div class="submitting hide" id="">
					
				</div>

				<div class="success hide" id="">
					<i class="icon-check-circle"></i>
				</div>

				<div class="error hide" id="">
					<i class="icon-circle-cross"></i>
				</div>
				
				<span class="progresstext">
					
				</span>
			</div>




		
			
		</div>


	


	<!-- <div id="navicon">
		
	</div> -->

	<!-- <div id="navmenu" class="olay_dark">
		
	</div> -->
	



<script src="js/jquery.min.js"></script>
<script src="../out/showMenuScript.html?getMoreId=${sessionScope.loginUser.getMoreId }"></script>
<script src="../js/socket/socket.io-1.3.4.js"></script>
<script src="../js/socket/p-talk.js"></script>
<script src="js/main.js"></script>
<script>
	$(document).ready(function() {
		var param=null;
		$('#personalinfo .listset').on('click', 'a', function(event) {
			event.preventDefault();
			param=this.id;
			var showitem = '.'+this.id,
				inputs = $('.formitem'),
				title = $(this).data('title'),
				target = $("#changeinfo"),
				titletarget = target.find('.ptitle');

			// reset popup area form
			titletarget.html('');
			inputs.addClass('hide').prop('disabled',true);


			titletarget.html(title);
			target.find(showitem).removeClass('hide').prop('disabled',false);
		});
		
		$("#brand").on("change",function(){
			var brandId=$(this).val();
				if(brandId=='0'){
					return;
				}
				$.post("getStoreByBrand.html",{"brandId":brandId},function(json){
					$("#store")[0].options.length=1;
					
					$(json).each(function(){
						$("#store")[0].options.add(
								new Option(this.storeName+","+this.address,this.storeId)
								);
					});
				},"json");
		});

		$(".bttn_full").on("click",function(){
			var value=$("."+param).val();
			var data={};
			data[param]=value;
			//数据监测
			if(param=="cphone"){//手机号
				if(!value){
					alert("请输入要更换手机号");
					return;
				}else if(!/^0?1[3|4|5|8|7][0-9]\d{8}$/.test(value)){
					alert("请输入正确格式的手机号");
					return;
				}
			}else if(param=="cbrand"){
				if(value=="0"){
					alert("请选择所属品牌");
					return;
				}else{//打开选择店铺页面
					$('#personalinfo .listset a#cshop').click();
				}
					return;
			}else if(param=="cshop"){
				if(value=="0"){
					alert("请选择所属店铺");
					return;
				}
			}else if(param=="cposition"){
				if(value=="0"){
					alert("请选择所属职务");
					return;
				}
			}
			showProgress('submitting','');//更新中
			$.post("guideUpdate.html",data,function(json){
				if(json.status=="0"){//失败
					showProgress('error',json.message);
				}else{//成功
					window.location.reload();
					showProgress('success',json.message);
				}
			},"json");
		});
		
		//更换头像
		$("#cavatar").on("change",function(){
			$(this).attr("disabled","disabled");
			var file=this.files[0];
			var formdata = new FormData();
			formdata.append("headImg",file);
			formdata.append("operator","update");
			showProgress('submitting');
			$.ajax({
				url: "headImgInfo.html",
				type: "POST",
				data: formdata,
				dataType:"json",
				processData: false,
				contentType: false,
				success: function (json) {
					if(json.status==1){//成功
						alert(json.message);
						window.location.reload();
					}else{//失败
						alert(json.message);
					}
				}
			});
		});
					
	});
</script>
</body>
</html>