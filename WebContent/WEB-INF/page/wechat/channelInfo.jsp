<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>个人中心 :: 个人资料</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <meta name="format-detection" content="telephone=no">
     <meta name="format-detection" content="telephone=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="bg_white with_topbar" id="personalinfo">
	
		<div class="topbar bar_red navback">
			<a href="center.html"><i class="icon-arrow-left"></i>  返回个人中心  </a>
		</div>

		<div class="title tcenter"><h2>基本信息</h2></div>
		<div class="listset">
			
			<div class="listitem arrowright">
				<div class="cavatar nolink" data-title="修改头像">
				<label for="cavatar"  class="upload">
				<i class="icon-thumbs-o-up"></i>头像 

				<span class="right info">
				
				  	  <input type="file"  capture="camera" accept="image/*" id="cavatar" />
				   	  <span class="img"><img src="${user.photo}" alt=""></span>
				
				</span>
				</label>

				</div>
			</div>
			<div class="listitem noarrow">
				<div class="nolink"><i class="icon-user"></i>姓名 <span class="right info">${channel.name }</span></div>
			</div>
			<div class="listitem noarrow">
				<div class="nolink"><i class="icon-male"></i>性别 <span class="right info">${channel.sex==1?"男":"女" }</span></div>
			</div>
			<div class="listitem arrowright">
				<a href="#" class="callpopup" id="cphone" data-target="#changeinfo" data-title="修改手机号"><i class="icon-iphone">
				</i>手机号 <span class="right info">${channel.phone }</span></a>
			</div>
			
		</div>


		<div class="title tcenter"><h2>职业信息</h2></div>

		
		<div class="listset">
			
			<div class="listitem arrowright">
				<a href="#" class="callpopup" id="ccompany"  data-target="#changeinfo"
				 data-title="修改所属公司"><i class="icon-briefcase">
				</i>所属公司 <span class="right info">${empty channel.parent?"无":(channel.parent.name) }
				<c:if test="${!empty channel.parent }">
					<c:choose>
						<c:when test="${channel.parent.status==0 }">
						(审核中)
						</c:when>
						<c:when test="${channel.parent.status==2 }">
						(审核未通过)
						</c:when>
					</c:choose>
				</c:if>
				</span></a>
			</div>
			<div class="listitem arrowright">
				<a href="#" class="callpopup" id="cposition" data-target="#changeinfo" data-title="修改职业">
				<i class="icon-user-tie">
				</i>职业 <span class="right info">${channel.job}</span></a>
			</div>
			<div class="listitem arrowright">
				<a href="#" class="callpopup" id="cnamecard"  data-target="#changeinfo" data-title="修改名片"><i class="icon-v-card">
				</i>名片 <span class="right info">已认证</span></a>
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
					<input type="text" name="tel" id="update_phone" maxlength="11" class="hide cphone formitem" 
					placeholder="${channel.phone }" disabled="disalbed" />
					<select name="company" class="hide ccompany formitem" id="update_company" disabled="disalbed">
						<option value="-2">请选择公司</option>
						<c:forEach	items="${companys }" var="temp">
						 <option value="${temp.id }">${temp.name }</option>
						</c:forEach>
						<option value="0">无所属公司</option>
					</select>
					
					<select name="position" class="hide cposition formitem" id="update_job" disabled="disalbed">
						<option value="-1">请选择职业</option>
						<option value="设计师">设计师</option>
						<option value="房产中介">房产中介</option>
						<option value="房产销售">房产销售</option>
						<option value="开发商">开发商</option>
						<option value="其他">其他</option>
					</select>
					<div class="notice nt_gray hide formitem">
					如您更改公司及职位信息，需要重新上传名片
					</div>

					<label for="namecard" class="cnamecard hide upload formitem">
					    <input type="file" capture="camera" class="formitem cnamecard hide" id="namecard" accept="image/*" disabled="disabled">
					    <!-- <img src="images/cardupload_gray.png" alt=""> -->
					   <img src="${channel.introImg }" alt="" id="img_reiw"> 
					</label>	
				</fieldset>
				
				
				
				<button class="bttn_full" id="btn-submit">确认保存</button>

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


		<div class="olay_dark overlay hide">
			
		</div>
	


	<!-- <div id="navicon">
		
	</div> -->

	<!-- <div id="navmenu" class="olay_dark">
		
	</div> -->
	



<script src="js/jquery.min.js"></script>
<script src="js/main.js"></script>
<script>
	$(document).ready(function() {
		$('#personalinfo .listset').on('click', 'a', function(event) {
			event.preventDefault();
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

		
		$("#btn-submit").on("click",function(){
			var param={};
			
			var phone=$("#update_phone").val();
			var company=$("#update_company").val();
			var job=$("#update_job").val();
			var namecard=$("#namecard")[0].files[0];
			var formdata = new FormData();
			if(phone&&!/^0?1[3|4|5|8|7][0-9]\d{8}$/.test(phone)&&
					!$("#update_phone").attr("disabled")){
				alert("请输入正确的手机号;");
				return;
			}
			if(company=="-2"&&
					!$("#update_company").attr("disabled")){
				alert("请选择公司，没有就选择无");
				return;
			}
			if(job=="-1"&&
					!$("#update_job").attr("disabled")){
				alert("请选择职业");
				return;
			}
			if(!namecard&&
					!$("#namecard").attr("disabled")){
				alert("请上传名片");
				return;
			}
			if(phone&&/^0?1[3|4|5|8|7][0-9]\d{8}$/.test(phone)&&
					!$("#update_phone").attr("disabled")){
				formdata.append("phone",phone);
			}
			if(company!="-2"&&!$("#update_company").attr("disabled")){
				formdata.append("company",company);
			}
			if(job!="-1"&&!$("#update_job").attr("disabled")){
				formdata.append("job",job);
			}
			if(namecard&&
					!$("#namecard").attr("disabled")){
				formdata.append("introImg",namecard);
			}
			
			
			formdata.append("operator","update");
			
			
			showProgress('submitting');
			$.ajax({
				url: "channelInfo.html",
				type: "POST",
				data: formdata,
				dataType:"json",
				processData: false,
				contentType: false,
				success: function (json) {
					if(json.status==1){//成功
						showProgress('success',json.message,function(){window.location.reload()});
					}else{//失败
						showProgress('error',json.message);
					}
				}
			});
				
				
			
		});
		
		//名片预览
		$("#namecard").on("change",function(){

			var file=this.files[0];
			if (file&&file.type.match(/image.*/)) {
				if ( window.FileReader ) {
					reader = new FileReader();
					reader.onloadend = function (e) { 
						$("#img_reiw").get(0).src=e.target.result;
					};
					reader.readAsDataURL(file);
				}
			}	
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