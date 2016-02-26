<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>个人中心 :: 我的帐号</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
     <meta name="format-detection" content="telephone=no">
     <link rel="apple-touch-icon" href="apple-touch-icon.png">
     <link rel="stylesheet" href="css/fonts.css">
     <link rel="stylesheet" href="css/main.css">
</head>
<body class="bg_dark with_topbar">
	
		<div class="topbar bar_red navback">
			<a href="center.html"><i class="icon-arrow-left"></i>  返回个人中心  </a>
		</div>
		<div id="accountsarea">
			<div class="wechat">
				<div class="item bg_red">
					<span class="accountname">微信红包</span>
					
					<div class="notice">
						红包24小时内不领取将被退回，请及时确认红包内的返还佣金
					</div>

				</div>
			</div>
			<div class="bankcard">
			<c:forEach items="${cards }" var="temp">
				<div class="item ${temp.statu=='1'?'default':'' }" userCardId="${temp.userCardId }" id="pufa">
					<span class="accountname">
					${temp.bankName }
					</span> 
					<span class="cardnumber">**** **** **** ${fn:substring(temp.cardNo,12,16) }</span>
					<span class="check">
						<i class="icon-checkmark">
							
						</i>
					</span>
				</div>
				</c:forEach>
				
				<!-- <div class="item default" id="pufa">
					<span class="accountname">浦发银行</span> <span class="cardnumber">**** **** **** 2341</span>
					<span class="check">
						<i class="icon-checkmark">
							
						</i>
					</span>
				</div>
				<div class="item" id="jianshe">
					<span class="accountname">建设银行</span> <span class="cardnumber">**** **** **** 5889</span>
					<span class="check">
						<i class="icon-checkmark">
							
						</i>
					</span>
				</div> -->
				
			</div>
			<div class="info">
				勾选卡为当前默认银行卡，点击选择可更换默认卡
			</div>

			<div class="addnew callpopup" data-target="#addcard">
				<i class="icon-circle-plus"></i> <span>添加新卡</span>
			</div>
			
		</div>

		<!-- 添加银行卡开始 -->
		<div class="popup bg_white anime offstage" id="addcard">
			<header>
				<span class="ptitle">添加银行卡</span>
				<span class="close">
					<i class="icon-close"></i>
				</span>
			</header>
			<div class="formarea pad_narrow">
			<fieldset>
				<div class="form_row">
				<select name="gender" id="add_bankName">
				<option value="0">请选择银行</option>
				<option value="工商银行">工商银行</option>
				<option value="建设银行">建设银行</option>
				<option value="中国银行">中国银行</option>
				<option value="农业银行">农业银行</option>
				</select>

			</div>
			<div class="form_row">
				<input type="text" name="name" id="add_cardNo" placeholder="卡号" maxlength="30">
			</div>
			</fieldset>

			
			<button class="bttn_full" type="button" id="add_card_btn">
				确认添加
			</button>
		
			</div>

		<!--  	<span class="close">
				<i class="icon-close"></i>
			</span>-->
			
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
		<!-- 添加银行卡结束 -->

		<!-- 更换默认银行卡开始 -->
		<div class="popup bg_white anime offstage" id="changecard">
			<header>
				更改默认银行卡
			</header>

			<div class="contents pad_narrow">
				<div class="alert center">
					<i class="icon-info"></i>
					<div class="alert_txt">
						
					</div>
				</div>
				

				
				<button class="bttn_full" id="confirmchange" onclick="">
					确认更改
				</button>
			</div>
			
			
		
			<span class="close">
				<i class="icon-close"></i>
			</span>

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
		<!-- 更换默认银行卡结束 -->






<script src="js/jquery.min.js"></script>
<script src="../out/showMenuScript.html?getMoreId=${sessionScope.loginUser.getMoreId }"></script>
<script src="js/main.js"></script>
<script>
	var cardid = '';
	var updateParam={};//临时变量
	
	$(document).ready(function() {
		$('.bankcard').on('click', ".item:not('.default')", function(event) {
			var bankname = $(this).children('.accountname').html(),
			    popup = $("#changecard"),
			    overlay = $(".overlay");
			cardid = '.item[userCardId='+$(this).attr("userCardId")+']';
			popup.removeClass('offstage');
			popup.find('.alert_txt').html('确认更改默认卡为<br><strong>'+bankname+'储蓄卡</strong>');
			popup.children('.close').one('click', closePopup);
			overlay.removeClass('hide');
			
			var userCardId=$(this).attr("userCardId");
			
			//更新临时变量
			updateParam.operator="update";
			updateParam.userCardId=userCardId;
			updateParam.status="1";
			
		});
		
		//保存银行卡
		$("#add_card_btn").on("click",function(){
			var bankName=$("#add_bankName").val();
			var cardNo=$("#add_cardNo").val();
			if(bankName==0){
				alert("请选择银行");return;
			}else if(!cardNo){
				alert("银行卡号不能为空！");return;
			}else if(!cardNo.match(/^\d+$/)){
				alert("请输入正确的银行卡号");return;
			}
			var param={};
			param.operator="save";
			param.bankName=bankName;
			param.cardNo=cardNo;
			$.post("channelCard.html",param,function(json){
				if(json.status==1){
					showProgress('success',json.message);
					window.location.reload();
				}else{
					showProgress('error',json.message);
				}
			},"json");
			
		});
		
		//更换默认银行卡
		$("#confirmchange").on("click",function(){
			showProgress('submitting','更换银行卡中！');
			$.post("channelCard.html",updateParam,function(json){
				if(json.status==1){//
					changeCard();
					showProgress('success',json.message);
				}else{
					showProgress('error',json.message);
				}
			},"json");
		});
		
	});	
</script>




</body>
</html>