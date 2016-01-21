<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>渠道商申请</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <meta name="format-detection" content="telephone=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
     <style>
     </style>
</head>
<body>
	<div class="bg_red with_bottombar" id="apply">
		<header>
			<img src="images/head_apply_distributor.jpg" alt="">
		</header>
		<div class="formarea pad_narrow apply withicon">
			<fieldset class="identity">
				<h1>
				申请名义
				<span class="eng">
					Identity 
				</span>
				</h1>
				
				<div class="form_row">
				<input type="radio" name="identity" id="i_company" value="1" checked="checked"><label for="i_company"><span><span></span></span>公司</label>
				<input type="radio" name="identity" id="i_person" value="0" ><label for="i_person"><span><span></span></span>个人</label>
				</div>
			</fieldset>
			
			<fieldset class="b_info">
			<h1>
			基本信息
			<span class="eng">
				Basic info 
			</span>
			</h1>
			<div class="form_row">
				<i class="icon-user"></i>
				<input type="text" name="name" id="add_name" placeholder="姓名" maxlength="10">
			</div>
			<div class="form_row">
				<i class="icon-male"></i>
				<select name="gender" id="add_sex">
				<option value="-1">请选择性别</option>
				<option value="1">男</option>
				<option value="0">女</option>
				</select>

			</div>
			
			<div class="form_row">
				<i class="icon-iphone"></i>
				<input type="text" name="phone" id="add_phone" placeholder="请输入手机" maxlength="11">
			</div>
			</fieldset>


				<fieldset class="p_info">
				<h1>
				职业信息
				<span class="eng">career info</span>
				</h1>
				
				<div class="form_row">
					<i class="icon-user-tie"></i>
					<select name="company" id="add_company">
					<option value="-2">请选择公司</option>
					<c:forEach	items="${companys }" var="temp">
					<option value="${temp.id }">${temp.name }</option>
					</c:forEach>
					<option value="-1" class="other">其他公司</option>
					<option value="0">无所属公司</option>
					</select>
				</div>

				<div class="form_row newcompany">
					<i class="icon-briefcase"></i>
					<input type="text" name="newcompany" id="new_company" placeholder="请填写您的公司名">
				</div>

				<div class="form_row occupation">
					<i class="icon-tie"></i>
					<select name="position" id="add_job">
					<option value="-1">请选择职业</option>
					<option value="设计师">设计师</option>
					<option value="房产中介">房产中介</option>
					<option value="房产销售">房产销售</option>
					<option value="开发商">开发商</option>
					<option value="其他">其他</option>
					</select>
				</div>
				
			</fieldset>
			
			
			<fieldset>
				<label for="add_introImg" class="namecard upload">
				    <input type="file" capture="camera" accept="image/*" id="add_introImg" />
				    <img src="images/cardupload_red.png" id="introImg_pre" alt="">
				</label>
			</fieldset>
			
			<fieldset class="agree">
				<input type="checkbox" id='agree'>
				<label for="agree">
					<i class="icon-check2"></i>
				</label> 
				<span>我已阅读并同意<span data-target="#privacy" class="callpopup">渠道商合作条款</span></span>
				
			</fieldset>
			
			<div class="bottombar bar_white">
				 <button type="button" class="bttn_full" id="info_submit">申请成为渠道商</button>
			</div>

		</div>
			
	</div>
	
		<div class="popup pop_full bg_white anime offstage" id="privacy">
			<header>
				合作渠道商相关申明
			</header>
			<div class="contents">
				为了更好地让广大软装消费者能够知晓并使用凯特猫平台，现推出“合作渠道商”政策，相关申明如下： <br>
				<ul>
					<li>“佣金”是指凯特猫合作渠道商（单位或个人）推荐其好友关注凯特猫官方平台（微信、网站，等），当其好友在凯特猫平台指定返利商户门店下单购买软装产品后获得相应的佣金。</li>
					<li>凯特猫平台的佣金由微信红包（默认）、银行转账，礼品等组成。</li>
					<li>凯特猫平台的佣金途径只返利到渠道账户中“推荐好友”对应的合作商或个人账号中。</li>
					<li>合作商账号仅限凯特猫合作商或本人使用，合作商必须向凯特猫平台提供真实有效的认证信息，对于由资料提供不正确、不真实导致佣金无法收到等后果，凯特猫平台不承担任何责任。</li>
					<li>一张订单只能返利一次，订单时间不得早于合作商推荐并关注成功时间。</li>
					<li>凯特猫返利平台上所有品牌商品均由消费者与品牌之间进行交易，本平台只提供相关的链接和推广，凯特猫返利平台不承担商品质量及售后服务。</li>
					<li>如果消费者退货，本平台将扣除佣金现金或同等价值的现金礼品</li>
					<li>更多解释权由上海居品汇信息技术有限公司旗下凯特猫平台所有。</li>
				</ul>
			</div>

			<button class="close bttn_gray">我已了解</button>



		</div>

	<!-- <div id="navicon">
		
	</div> -->

	<!-- <div id="navmenu" class="olay_dark">
		
	</div> -->
	



<script src="js/jquery.min.js"></script>
<script src="js/main.js"></script>
<script src="../js/layer/layer.js"></script>
<script src="js/qzm.js"></script>
<script>
	$(document).ready(function() {
					$('#add_company').change(function(event) {
							if($(this).val() == '-1') {
								$('.newcompany').show();
							}else if(($(this).val() == '0')){
								//强制为个人名义
								$("input[name='identity'][value='0']").attr("checked","checked");
							}else {
								$('.newcompany').hide();
								$('.newcompany input').val('');
							}
					});
					
		//照片预览
		$("#add_introImg").on("change",function(){
			    var files = this.files;
			    if(files.length){
			        checkFile(this.files);
			    }
		});
		function checkFile(files){
		    var file = files[0];
		    var reader = new FileReader();
		    if(!/image\/\w+/.test(file.type)){
		        alert("请确保文件为图像类型");
		        $("#add_introImg")[0].files="";
		        return false;
		    }
		    // onload是异步操作
		    reader.onload = function(e){
		    	$("#introImg_pre")[0].src=e.target.result;
		    }
		    reader.readAsDataURL(file);
		}
		
		//提交信息
		$("#info_submit").on("click",function(){
			
			//数据检测
			var name=$("#add_name").val();
			var sex=$("#add_sex").val();
			var phone=$("#add_phone").val();
			var type=$("input[name='identity']").val();
			var company=$("#add_company").val();
			var new_company_name=$("#new_company").val();
			var job=$("#add_job").val();
			if(!name){
				alert("请输入姓名");
				$("#add_name").focus();
				return;
			}else if(!sex||sex=="-1"){
				alert("请选择性别");
				$("#add_sex").focus();
				return;
			}else if(!phone){
				alert("请填入手机号码");
				$("#add_phone").focus();
				return;
			}else if(!/^0?1[3|4|5|8|7][0-9]\d{8}$/.test(phone)){
				alert("请填入正确格式的手机号码");
				$("#add_phone").focus();
				return;
			}else if(company=="-2"){
				alert("请选择公司，如没有，请选择无");
				$("#add_company").focus();
				return;
			}else if(!$("#add_introImg")[0].files[0]){
				alert("请上传名片");
				return;
			}
			//判断公司
			if(company=="-1"){//新建，判断名字
				if(!new_company_name||!$.trim(new_company_name)){
				alert("请输入公司名字");
				return;
				}
			}else if(job=="-1"){
				alert("请选择职业");
				return;
			}else if(!$("#agree:checked")[0]){
				alert("请选择同意条款！");
				return;
			}
			
			$("#info_submit").attr("disabled","disabled");
			var oMyForm = new FormData();
			oMyForm.append("name", name);
			oMyForm.append("sex", sex);
			oMyForm.append("job", job);
			oMyForm.append("phone", phone);
			oMyForm.append("type", type);
			if(company=="-1"){
				oMyForm.append("companyName", new_company_name);
			}else{
				oMyForm.append("company", company);
			}
			oMyForm.append("introImg", $("#add_introImg")[0].files[0]);//名片

			$.ajax({
				  url: "saveChannel.html",
				  type: "POST",
				  data: oMyForm,
				  processData: false,  // 告诉jQuery不要去处理发送的数据
				  contentType: false,   // 告诉jQuery不要去设置Content-Type请求头
				  dataType: "json",
				  success:function(json){
						if(json.status=="1"){
							layer.msg(json.message);
							window.location.reload();
						}else{
							$("#info_submit").removeAttr("disabled");
							layer.msg(json.message);
						}
					}
				});
		});

	});
</script>
</body>
</html>