<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>提交返利订单</title>
     <meta name="viewport" content="width=321">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
     <link rel="stylesheet" href="js/jquery-ui.css">
     <style type="text/css">
     .ui-datepicker select{display: inline-block !important;}
     </style>
</head>
<body>
	<div class="bg_white with_topbar order_submit" id="apply">
		<div class="topbar bar_red navback">
			<a href="center.html"><i class="icon-arrow-left"></i>  返回个人中心</a>
			<div class="getlogo"><a href="http://guide.51getmore.cn"><img src="images/cathead.svg"></a></div>
		</div>
		
		<header>
			<img src="images/head_upload.jpg">
		</header>

		<div class="formarea pad_narrow apply withicon">

			
		
			<fieldset class="b_info">
			<h1>
			购买人信息
			<span class="eng">
				Buyer info 
			</span>
			</h1>
			

			<div class="form_row">
				<i class="icon-user"></i>
				<input type="text" name="name" id="username" placeholder="购买人姓名" maxlength="20">
			</div>
			
			<div class="form_row">
				<i class="icon-iphone"></i>
				<input type="tel" name="tel" id="userphone" placeholder="购买人手机" maxlength="11">
			</div>

			<div class="form_row">
				<i class="icon-calendar"></i>
				<input type="text" name="date" id="buyDate" readonly="readonly" class="datepicker" placeholder="购买时间">
			</div>

			
			

			</fieldset>


			<fieldset class="p_info">
				<h1>
				商品信息
				<span class="eng">Product info</span>
				</h1>
				
				<div class="form_row">
					<i class="icon-star"></i>
					<select name="brand" id="brands">
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
					<select name="shop" id="stores">
					<option value="0">请选择品牌门店</option>
					</select>
				</div>

				<div class="form_row">
				<i class="icon-coin-yen"></i>
					<input type="text" name="totalamount" id="totalpay" placeholder="消费金额" value="" maxlength="11">
				</div>

				<div class="form_row">
				<i class="icon-credit-card"></i>
					<input type="text" name="payamount" id="haspay" placeholder="已付金额" value="" maxlength="11">
				</div>

				
				
			</fieldset>

			<fieldset>
				<div class="amounts">
					<div class="percent">
						<i class="icon-moon"></i><span>返利比例<strong id="back-rate">待选择…</strong></span>
					</div>
					<div class="rebates">
						<i class="icon-cny"></i><span>返利金额<strong id="back-fee">待计算…</strong></span>
						
					</div>
				
				</div>
			</fieldset>

			<fieldset>
				<label for="cameraInput" class="namecard upload">
				    <input type="file" capture="camera" accept="image/*" id="cameraInput" />
				    <img src="images/orderupload_gray.png" id="imgReviw">
				</label>
				
			</fieldset>
			
			

			<fieldset class="agree">
				<input type="checkbox" id='agree'>
				<label for="agree">
					<i class="icon-check2"></i>
				</label> 
				<span>我已阅读并同意<span data-target="#privacy" class="callpopup">凯特猫返利协议</span></span>
				
			</fieldset>

			<div class="bottombar bg_red">
				 <button type="button" id="sendOrder" class="bttn_full">提交返利订单</button>
			</div>

		</div>

		
		
		
		<div class="notice">
				
				<ul>
					<li>您以上填写的信息必须与订单照片一致，信息不符合的提交将无法通过审核</li>
					<li>尾款支付后将您将继续获得返利</li>
				</ul>
			</div>

	</div>




	<div class="popup pop_full bg_white anime offstage" id="privacy">
			<header>
				凯特猫返利协议
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
			






<script src="js/jquery.min.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/main.js"></script>
<script src="../out/showMenuScript.html?getMoreId=${sessionScope.loginUser.getMoreId }"></script>
<script type="text/javascript">
//根据品牌获取店铺
$("#brands").on("change",function(){
	var rate=$("#brands option:selected").attr("rate");
	$("#stores")[0].options.length=1;
	var brandId=$(this).val();
	if(brandId=='-1'){
		return;
	}
	$.post("getStoreByBrand.html",{"brandId":brandId},function(json){
		$(json).each(function(){
			$("#stores")[0].options.add(new Option(this.storeName+"-"+this.address,this.storeId));
		});
		$("#stores option:eq(0)").attr("selected","selected");
		$("#back-rate").html(parseFloat(rate)*100+"%");
	},"json");
});
var filetemp=null;
var formdate;//表单对象
 	if (window.FormData) {
  		formdata = new FormData();
	}
//订单图片预览
$("#cameraInput").on("change",function(){
	var file=this.files[0];
	if (file&&file.type.match(/image.*/)) {
		if(file.size>5000000){
			layer.msg("图片尺寸太大，不要超过50000KB！");
	 		return;
		}
		if ( window.FileReader ) {
			reader = new FileReader();
			reader.onloadend = function (e) { 
				$("#imgReviw").show();
				$("#imgReviw").get(0).src=e.target.result;
			};
			reader.readAsDataURL(file);
		}
		filetemp=file;
	}	
});

//返利金额计算back-fee
 $("#haspay").on("blur",function(){
	 var value=this.value;
	 if(value&&value.match(/^\d+$/)){
		 var rate=$("#brands option:selected").attr("rate");
		 if(rate){
			 rate=parseFloat(rate);
			 backFee=parseInt(value, 10)*rate;
			 $("#back-fee").text(backFee.toFixed(2));
		 }
	 }
	 
 });
 
 $.datepicker.regional['zh-CN'] ={
		 clearText: '清除', clearStatus: '清除已选日期',  
		 closeText: '关闭', closeStatus: '不改变当前选择',  
		 prevText: '<上月', prevStatus: '显示上月',  
		 nextText: '下月>', nextStatus: '显示下月',  
		 currentText: '今天', currentStatus: '显示本月',  
		 monthNames: ['一月','二月','三月','四月','五月','六月',  
		 '七月','八月','九月','十月','十一月','十二月'],  
		 monthNamesShort: ['一','二','三','四','五','六',  
		 '七','八','九','十','十一','十二'],  
		 monthStatus: '选择月份', yearStatus: '选择年份',  
		 weekHeader: '周', weekStatus: '年内周次',  
		 dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],  
		 dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],  
		 dayNamesMin: ['日','一','二','三','四','五','六'],  
		 dayStatus: '设置 DD 为一周起始', dateStatus: '选择 m月 d日, DD',  
		 dateFormat: 'yy-mm-dd', firstDay: 1,  
		 initStatus: '请选择日期', isRTL: false  }
	 $.datepicker.setDefaults($.datepicker.regional['zh-CN']);  

	$('.datepicker').datepicker({changeYear:true,changeMonth:true,maxDate:0});
 
//检测数据
	$("#sendOrder").on("click",function(){
		var username=$("#username").val();
		var userphone=$("#userphone").val();
		var buyDate=$("#buyDate").val();
		var brands=$("#brands").val();
		var stores=$("#stores").val();
		var totalpay=$("#totalpay").val();
		var haspay=$("#haspay").val();
		
		if(!username){
			$("#username").focus();
			alert("请输入购买人姓名！");
			return;
		}else if(!userphone){
			$("#userphone").focus();
			alert("请输入购买人手机号码！");
			return;
		}else if(!/^1[3|4|5|7|8][0-9]\d{8}$/.test(userphone)){
			$("#userphone").focus();
			alert("请输入正确的手机号码！");
			return;
		}else if(!buyDate){
			$("#buyDate").focus();
			alert("请选择购买时间");
			return;
		}else if(brands=="0"){
			$("#brands").focus();
			alert("请选择家具品牌");
			return;
		}else if(stores=="0"){
			$("#stores").focus();
			alert("请选择品牌门店");
			return;
		}else if(!totalpay){
			$("#totalpay").focus();
			alert("请输入消费金额");
			return;
		}else if(!totalpay.match(/^[1-9]?[0-9]*\.?[0-9]*$/)){
			$("#totalpay").focus();
			alert("请输入正确的消费金额");
			return;
		}else if(!haspay){
			$("#totalpay").focus();
			alert("请输入已付金额");
			return;
		}else if(!haspay.match(/^[1-9]?[0-9]*\.?[0-9]*$/)){
			$("#totalpay").focus();
			alert("请输入正确的已付金额");
			return;
		}else if(parseFloat(haspay)-parseFloat(totalpay)>0){
			$("#totalpay").focus();
			alert("已付金额不能多余消费金额");
			return;
		}else if(!filetemp){
			alert("请上传订单图片！");
			return;
		}else if(!$("#agree:checked")[0]){
			alert("请同意凯特猫返利协议");
			return;
		}
		formdata.append("username",$("#username").val());//添加姓名
		formdata.append("phone",$("#userphone").val());//添加电话
		formdata.append("buyDate",$("#buyDate").val());//购买时间
		formdata.append("storeId",$("#stores").val());//添加店铺
		formdata.append("fare",$("#totalpay").val());//消费金额
		formdata.append("hasPay",$("#haspay").val());//已付金额
		formdata.append("orderImg",filetemp);//已付金额
		$("#sendOrder").attr("disabled","disabled");
		$.ajax({
			url: "saveOrderByUrlImg.html",
			type: "POST",
			data: formdata,
			processData: false,
			contentType: false,
			dataType:"json",
			success: function (res) {
				if(res.status=="1"){//成功
					var orderId=res;
					alert("订单提交成功，请耐心等待工作人员审核");
					window.location.href="myOrders.html";
				}else{
					alert("订单提交失败，请稍后再试");
				}
			}
		});
	});
</script>
</body>
</html>