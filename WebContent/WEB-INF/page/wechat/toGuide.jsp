<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>导购申请</title>
     <meta name="viewport" content="width=321">
     <meta name="format-detection" content="telephone=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="bg_white with_bottombar" id="apply">
	
		<header>
			<img src="images/head_apply_guider.jpg" alt="">
		</header>
		<div class="formarea pad_narrow apply withicon">

			
		
			<fieldset class="b_info">
			<h1>
			基本信息
			<span class="eng">
				Basic info 
			</span>
			</h1>
			

			<div class="form_row">
				<i class="icon-user"></i>
				<input type="text" name="name" id="add_name" maxlength="10" placeholder="姓名">
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
				<input type="text" name="tel" id="add_phone" placeholder="请输入手机" maxlength="11">
			</div>
			</fieldset>


			<fieldset class="p_info">
				<h1>
				品牌门店归属信息
				<span class="eng">Brand info</span>
				</h1>
				
				<div class="form_row">
					<i class="icon-star"></i>
					<select name="brand" id="add_brand">
					<option value="0">请选择品牌</option>
					  <c:forEach items="${brands }" var="brand">
			        	<c:if test="${ brand.status!='0'}">
			        		<option value="${brand.brandId }" rate="${brand.rate }">${brand.brandName } </option>
			        	</c:if>
			        </c:forEach>
					</select>
				</div>

				

				<div class="form_row">
					<i class="icon-shop"></i>
					<select name="shop" id="add_store">
					<option value="0">请选择品牌门店</option>
					</select>
				</div>

				<div class="form_row">
					<i class="icon-user-tie"></i>
					<select name="position" id="add_job">
					<option value="0">请选择店内职务</option>
					<option value="店长">店长</option>
					<option value="销售">销售</option>
					<option value="导购">导购</option>
					</select>
				</div>
				
			</fieldset>
			
			

			<fieldset class="agree">
				<input type="checkbox" id='agree'>
				<label for="agree">
					<i class="icon-check2"></i>
				</label> 
				<span>我已阅读并同意<span data-target="#privacy" class="callpopup">导购员合作条款</span></span>
				
			</fieldset>

			<div class="bottombar bg_red">
				 <button type="submit" id="btn-submit" class="bttn_full">申请成为导购员</button>
			</div>

		</div>


		<div class="popup pop_full bg_white anime offstage" id="privacy">
			<header>
				导购员申请相关申明
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
<script>
	$(document).ready(function() {
	
					$('#company').change(function(event) {
							if($(this).val() == '-1') {
								$('.newcompany').show();
							} else {
								$('.newcompany').hide();
								$('.newcompany input').val('');
							}
					});
					
			$("#add_brand").on("change",function(){
				var brandId=$(this).val();
					if(brandId=='0'){
						return;
					}
					$.post("getStoreByBrand.html",{"brandId":brandId},function(json){
						$("#add_store")[0].options.length=0;
						
						$(json).each(function(){
							$("#add_store")[0].options.add(
									new Option(this.storeName+","+this.address,this.storeId)
									);
						});
					},"json");
				
			});
			
			$("#btn-submit").on("click",function(){
				var name=$("#add_name").val();
				var sex=$("#add_sex").val();
				var phone=$("#add_phone").val();
				var storeId=$("#add_store").val();
				var job=$("#add_job").val();
				
				if(!name){alert("请输入名字！");return;}
				else if(!sex||sex=="-1"){alert("请选择性别");return;}
				else if(!phone){alert("请输入手机号码");return;}
				else if(!/^0?1[3|4|5|8|7][0-9]\d{8}$/.test(phone)){alert("请输入正确的手机号！");return;}
				else if(!storeId||storeId=="0"){alert("请选择相应的店铺");return;}
				else if(!job||job=="0"){alert("请选择相应的职务");return;}
				else if(!$("#agree:checked")[0]){alert("请同意本条约");return;}
				
				var param={};
				param.name=name;
				param.sex=sex;
				param.phone=phone;
				param.storeId=storeId;
				param.job=job;
				$(this).attr("disabled","disabled");
				$.post("saveGuide.html",param,function(json){
					if(json.status=="0"){
						alert(json.message);
					}else if(json.status=="1"){
						alert(json.message);
						window.location.reload();
					}
				},"json")
				
				
			});
	});
</script>
</body>
</html>