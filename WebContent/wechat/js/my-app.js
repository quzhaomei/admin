// Initialize your app
var myApp = new Framework7({
    animateNavBackIcon:true,
    cache:false,
    preroute: function (view, options) {
        if (false) {
            view.router.loadPage('auth.html'); //load another page with auth form
            return false; //required to prevent default router action
        }
    },
    onAjaxStart: function (xhr) {
        myApp.showIndicator();
    },
    onAjaxComplete: function (xhr) {
        myApp.hideIndicator();
    }
});


$(document).ajaxStart(function(){
	myApp.showIndicator();
	 });
$(document).ajaxStop(function(){
	myApp.hideIndicator();
	 });
// Export selectors engine
var $$ = Dom7;

// Add main View
var mainView = myApp.addView('.view-main', {
    // Enable dynamic Navbar
    dynamicNavbar: true,
    // Enable Dom Cache so we can use all inline pages
    domCache: true
});


var textnumtask;
//pageInit
$$(document).on('pageBeforeInit', function (e) { 
	if(loadTag&&bgtask){	//如果是打开的二级页面
		 //清除掉加载页面
	   	setTimeout(function(){
	   		$("#preloading").remove();
	   		clearInterval(bgtask);
	   		bgtask=null;
	   	},800);
	   	loadTag=false;//清除加载标签
	}
	if(textnumtask){
		clearInterval(textnumtask);
		textnumtask=null;
	}
	
	$(".cached[id!='index']").remove();//删除缓存
	var page = e.detail.page;
	var mySwiper3;
	 if(page.url.indexOf('addrequirement.html')!=-1) { 
//		$("#zones").parents(".cached").remove();//删除缓存
	 	//需求页面点开的时候。
	 	$("#zones").empty();
	 	$(zoneArr).each(function(){
	 		$("#zones").append(new Option(this.zoneName,this.zoneId));
	 	});
	 	$("#zones").on("change",function(){
	 		$("#types").empty();
	 		var value=this.value;
	 		$(zoneArr).each(function(){
	 			if(this.zoneId==value){
	 		 		$(this.types).each(function(){
	 		 			myApp.smartSelectAddOption('#types', new Option(this.typeName,this.typeId));
	 		 		});
	 			}
	 		});
	 		$("#types option:eq(0)").attr("selected","selected");
	 		$("#types").next(".item-content").find(".item-after").text($("#types option:eq(0)").text());
	 	});
	 	$("#zones").trigger("change");
	 	
	 	
	 	
	 	//品类风格，点击全部的时候
	 	$("#types").on("change",function(){
	 	 $$('body .smart-select-popup').on('close', function () {
		 		if($("#types option:eq(0)")[0].selected){
		 			$("#types option:gt(0)").removeAttr("selected");
		 			setTimeout(function(){
		 				$("#types").next(".item-content").find(".item-after").text($("#types option:eq(0)").text());
		 			}, 200)
		 		}
		 	});
	 	});
	 	$("#styles").on("change",function(){
	 	 $$('body .smart-select-popup').on('close', function () {
	 		if($("#styles option:eq(0)")[0].selected){
	 			$("#styles option:gt(0)").removeAttr("selected");
	 			setTimeout(function(){
	 				$("#styles").next(".item-content").find(".item-after").text($("#styles option:eq(0)").text());
	 			}, 200)
	 		 }
	 	 	});
	 	});
	 	
	 	textnumtask=setInterval(function(){
		 	var nowlength=$("#description").val().length;
		 		$("#inputcount").text(70-nowlength<0?0:70-nowlength);
	 	}, 600);
	 	
	 	$("#submitReq").on("click",function(){
	 		$("#submitReq").attr("disabled","disabled");//禁止重复点击
	 		var param={};
	 		param.zones=$("#zones").val();
	 		var types=$("#types").val();
	 		if(types){
	 			param.types=types.join(",");
	 		}
	 		var styles=$("#styles").val();
	 		if(styles){
	 			param.styles=styles.join(",");
	 		}
	 		param.budget=$("#budgets").val();
	 		param.description=$("#description").val();
	 		$.post("doAddRequire.html",param,function(json){
	 			$("#submitReq").removeAttr("disabled");//可以再次点击
	 			if(json.status=="ok"){
	 				myApp.views[0].router.loadPage("doAddRequire2.html");
	 			//	layer.msg('添加成功');
	 			}
	 		},"json");
	 	});
	 	
	 }else if(page.url.indexOf('myplan.html')!=-1){//我的需求。
//		$("#orderList").parents(".cached").remove();//删除缓存
		 //绑定删除
		 $$('.del').on('click', function () {
			 if(confirm("确认删除吗？")){
			  var requiredId=$(this).attr("requiredId");
			  var _this=this;
			  $.post("doDelRequire.html",{requiredId:requiredId},function(json){
				  if(json.status=="ok"){
					  layer.msg("删除成功！");
					  $(_this).parents(".card").remove();
				  }
			  },"json");
			 }
			});
		 var loading = false;
		 var total=$$("#totalPage").val();
		 var pageIndex=1;
		//绑定下拉刷新
		 $$('.infinite-scroll').on('infinite', function () {
			 if (loading) return;
			  loading = true;
			  pageIndex++;
			  if (pageIndex > total) {
			      // 加载完毕，则注销无限加载事件，以防不必要的加载
			      myApp.detachInfiniteScroll($$('.infinite-scroll'));
			      // 删除加载提示符
			      $$('.infinite-scroll-preloader').remove();
			      return;
			    }
			 $.post("myplan.html",{"pageIndex":pageIndex},function(html){
				 $$("#orderList").append(html);
				 loading = false;
			 });
			  
		 });
		 
	 }else if(page.url.indexOf('myorders.html')!=-1){
		 $$('.del').on('deleted', function () {
			  var orderId=$(this).attr("orderId");
			  $.post("doDelOrder.html",{orderId:orderId},function(json){
				  if(json.status=="ok"){
					  layer.msg("删除成功！")
				  }else if(json.status=="no"){
					  layer.msg(json.message)
				  }
			  },"json");
			});
		 $('.del-info').on('touchstart', function () {
			 var msg=$(this).attr("info");
			 alert(msg);
			});
		 
	 }else if ( page.url.indexOf('addorder.html')!=-1) { 
//		 $("#brands").parents(".cached").remove();//删除缓存
		 var calendarDefault = myApp.calendar({
			    input: '#buyDate',
			    dayNamesShort:['日', '一', '二', '三', '四', '五', '六'],
			    monthNames: ['一月', '二月', '三月','四月', '五月', '六月', '七月',
			                 '八月' , '九月' , '十月','十一月', '十二月'],
			    direction :'vertical',
			    closeOnSelect:true
			});   
		 	var fileTempId;//照片对象
		 	//根据品牌获取店铺
			$("#brands").on("change",function(){
				var rate=$("#brands option:selected").attr("rate");
				$("#stores").empty();
				var brandId=$(this).val();
				if(brandId=='-1'){
					return;
				}
				$.post("getStoreByBrand.html",{"brandId":brandId},function(json){
					$(json).each(function(){
						myApp.smartSelectAddOption('#stores', new Option(this.storeName+","+this.address,this.storeId));
					});
					$("#stores option:eq(0)").attr("selected","selected");
					$("#stores").next(".item-content").find(".item-after").text($("#stores option:eq(0)").text());
					$("#rate").html(parseFloat(rate)*100+"%");
				},"json");
			});
			//计算返利
			$("#hasPay").on("blur",function(){
				var hasPay=$(this).val();
					hasPay=parseFloat(hasPay);
				if(hasPay){
					$("#reFare").html("￥"+(hasPay*parseFloat($("#brands option:selected").attr("rate"))).toFixed(2));
				}
			});
			$("#cameraInput").on("click",function(){
				wx.chooseImage({
				    count: 1, // 默认9
				    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
				    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
				    success: function (res) {
				        var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
				        $("#imgReviw").show();
						$("#imgReviw").get(0).src=localIds[0];
						fileTempId=localIds[0];
						checkOk();
				    }
				});
				
			});
			function checkOk(){
				var isOk=true;
				if(!$("#username").val()){
					isOk=false;
				}else if(!$("#phone").val()){
					isOk=false;
				}else if($("#brands").val()=='-1'){
					isOk=false;
				}else if(!$("#fare").val()){
					isOk=false;
				}else if(!$("#hasPay").val()){
					isOk=false;
				}else if(!$("#buyDate").val()){//购买时间
					isOk=false;
				}else if(eval($("#hasPay").val()+"-"+$("#fare").val())>0){
					isOk=false;
				}else if(!fileTempId){
					isOk=false;
				}else{
					 var reg = /^1[3|4|5|8][0-9]\d{8}$/;
			 		 if(!reg.test($.trim($("#phone").val()))){
			 			isOk=false;
			 		 }
				}
				if(isOk){
					$("#submitOrder").removeAttr("disabled");
				}else{
					$("#submitOrder").attr("disabled","disabled");
				}
			}
			$("#addreq").on("click",function(){
				checkOk();
			});
			$("#buyDate").on("click",function(){
				checkOk();
			});
			$("#addreq").on("keydown",function(){
				checkOk();
			});
			//提交订单
			$("#submitOrder").on("click",function(){
				if(!$("#username").val()){
					layer.msg("请填写姓名");
					return;
				}else if(!$("#phone").val()){
					layer.msg("请填写电话号码");
					return;
				}else if($("#brands").val()=='-1'){
					layer.msg("请选择品牌");
					return;
				}else if(!$("#buyDate").val()){
					layer.msg("请选择购买时间");
					return;
				}else if(!$("#fare").val()){
					layer.msg("请填写消费金额");
					return;
				}else if(!$("#hasPay").val()){
					layer.msg("请填写已付金额");
					return;
				}else if(eval($("#hasPay").val()+"-"+$("#fare").val())>0){
					layer.msg("消费金额不能大于已付金额");
					return;
				}else if(!fileTempId){
					layer.msg("请上传订单图片");
					return;
				}else{
					 var reg = /^1[3|4|5|8|7][0-9]\d{8}$/;
			 		 if(!reg.test($.trim($("#phone").val()))){
			 			 layer.msg("手机号码有误！");
			 			return;
			 		 }
				}
				//上传图片到微信服务器
				wx.uploadImage({
				    localId: fileTempId, // 需要上传的图片的本地ID，由chooseImage接口获得
				    isShowProgressTips: 1, // 默认为1，显示进度提示
				    success: function (res) {
				        var param={};
				        param.cacheTag=new Date();
				        param.wechatImgId=res.serverId;
				        param.buyDate=$("#buyDate").val();
				        param.username=$("#username").val();
				        param.phone=$("#phone").val();
				        param.storeId=$("#stores").val();
				        param.fare=$("#fare").val();
				        param.hasPay=$("#hasPay").val();
				        
						$("#submitOrder").attr("disabled","disabled");
						$.post("saveOrder.html?"
								,param,function(json){
								if(json.status=="1"){//提交成功
									var orderId=$.trim(json.data.orderId);
									$("#submitOrder").removeAttr("disabled");
									myApp.views[0].router.loadPage("saveOrder2.html?orderId="+orderId);
								}else if(json.status=="0"){
									alert(json.message);
								}
							},"json");
								
				    }
				});
				return;
			});
			
		 }else if(page.url.indexOf('saveOrder2.html')!=-1){
			 $$(".order2Btn").on("click",function(){
				 var orderId=$("#orderAdd2").val();
				 var backType=$("#backType option:selected").val();
				 if(!$("#titleAgree:checked").get(0)){
					 layer.msg('请同意返利条款');
					 return;
				 }else if($("#backType").val()==-1){
					 layer.msg('请选择返利方式');
					 return;
				 }
				myApp.views[0].router.loadPage("saveOrder3.html?orderId="+orderId+"&backType="+backType);
			 });
			 
		 }else if(page.url.indexOf('saveOrder3.html')!=-1){
			 $$(".saveCard").on("click",function(){
				 bankName=$("#bankName option:selected").text();//银行名字
				 userCardId=$("#userCardId").val();//ID
				 bankAddress=$$("#bankAddress").val();
				 cardNum=$$("#cardNum").val();
				 cardUsername=$$("#cardUsername").val();
				 if(!bankName){
					 layer.msg("银行不能为空！");
					 return;
				 }else if(!bankAddress){
					 layer.msg("开户行不能为空");
					 return;
				 }else if(!cardNum){
					 layer.msg("卡号不能为空")
					 return;
				 }else if(!cardUsername){
					 layer.msg("户名不能为空");
					 return;
				 }
				 var queryparam="?a=a";
				 if(userCardId){//ID
					 queryparam+="&userCardId="+userCardId;
				 }
				 //银行名字
				 if(!($("#bankName").attr("bak"))||($("#bankName").attr("bak")&&$("#bankName").attr("bak")!=bankName)){
					 queryparam+="&bankName="+bankName;
				 }
				 //开户行
				 if(!($("#bankAddress").attr("bak"))||($("#bankAddress").attr("bak")&&$("#bankAddress").attr("bak")!=bankAddress)){
					 queryparam+="&bankAddress="+bankAddress;
				 }
				 //卡号
				 if(!($("#cardNum").attr("bak"))||($("#cardNum").attr("bak")&&$("#cardNum").attr("bak")!=cardNum)){
					 queryparam+="&cardNum="+cardNum;
				 }
				//户名
				 if(!($("#cardUsername").attr("bak"))||($("#cardUsername").attr("bak")&&$("#cardUsername").attr("bak")!=cardUsername)){
					 queryparam+="&cardUsername="+cardUsername;
				 }
			//	 var queryparam="?bankName="+bankName+"&bankAddress="+bankAddress+"&cardNum="+cardNum+"&cardUsername="+cardUsername
				
				 myApp.views[0].router.loadPage("saveCard.html"+encodeURI( encodeURI(queryparam)));
			 });
			 
		 }else if (page.url.indexOf('brandDetail.html')!=-1) {
			 
			 if(mySwiper3){
			 	mySwiper3.destroy(true,true);
			 	mySwiper3=null;
			 }
			  mySwiper3 = myApp.swiper('.swiper-between', {
					  pagination:'.swiper-between .swiper-pagination',
					  spaceBetween: 10,
		  			  slidesPerView: 1,
		  			  autoplay: 3000
					});
				
				$$('.open-detail').on('click', function () {
						 myApp.popup('.popup-detail');
					});
				//更新最近浏览
				$("#latest").html($$(".latest").html());
				
			 }

});
//搜索时候隐藏ABC
$("#searchInput").on("keyup",function(){
	if($(this).val()){//隐藏
		$(".alpha-title").hide();
	}else{//展示
		$(".alpha-title").show();
	}
});
$("#searchInput").on("change",function(){
	if($(this).val()){//隐藏
		$(".alpha-title").hide();
	}else{//展示
		$(".alpha-title").show();
	}
});
$("#searchInput").on("click",function(){
	if($(this).val()){//隐藏
		$(".alpha-title").hide();
	}else{//展示
		$(".alpha-title").show();
	}
});

//初始化右边的字母条
$("#brandlist .alpha-title a").each(function(){
	var _this=this;
	  $(".alphadiv span[data="+this.innerHTML+"]").removeClass("noitem");
 // click touchstart
  $(".alphadiv span[data="+this.innerHTML+"]").on("touchstart",function(){
	  $(".alphadiv span.live").removeClass("live");
	  $(this).addClass("live");
	  $("#index .page-content").animate({"scrollTop":$("#index .page-content").scrollTop()+$(_this).position().top-50},300);
  });
});

$(".page-content").on("scroll",function(){
	var height=$(".page-content").scrollTop();
	for(var i=0;i< $("#brandlist .alpha-title a").length;i++){
		if($("#brandlist .alpha-title a:eq("+i+")").position().top-50>-30&&
    			$("#brandlist .alpha-title a:eq("+i+")").position().top-50<30){
			 var html=$("#brandlist .alpha-title a:eq("+i+")").text();
			 $(".alphadiv span.live").removeClass("live");
			 $(".alphadiv span[data="+html+"]").addClass("live");
			 break;
		}
	}
});


function slickStart($obj){
  $obj.slick({
       autoplay: true,
       arrows: false,
       speed: 800,
       autoplaySpeed: 4000
      });
}
function slickStop($obj){
  $obj.unslick();
}

function slickPause($obj){
  $obj.slickPause()
}
function slickContinue($obj){
 $obj.slickPlay()
}



	function compressImg(imgData,maxHeight,onCompress){
	if(!imgData)return;
	onCompress = onCompress || function(){};
	maxHeight = maxHeight || 800;//默认最大高度200px
	var canvas = document.createElement('canvas');
	var img = new Image();
	img.onload = function(){ 
		if(img.height > maxHeight) {//按最大高度等比缩放
		img.width *= maxHeight / img.height; 
		img.height = maxHeight; 
		}
		canvas.width=img.width;
		 canvas.height=img.height;
	var ctx = canvas.getContext("2d"); 
	ctx.clearRect(0, 0, canvas.width, canvas.height); // canvas清屏
	ctx.drawImage(img, 0, 0, img.width, img.height); // 将图像绘制到canvas上 
		onCompress(canvas.toDataURL("image/jpeg"),0.5);//必须等压缩完才读取canvas值，否则canvas内容是黑帆布
	};
	// 记住必须先绑定事件，才能设置src属性，否则img没内容可以画到canvas
	img.src = imgData;
	}


	function dataURItoBlob(dataURI) {
		//上传服务器解码
	    // convert base64/URLEncoded data component to raw binary data held in a string
	    var byteString;
	    if (dataURI.split(',')[0].indexOf('base64') >= 0)
	        byteString = atob(dataURI.split(',')[1]);
	    else
	        byteString = unescape(dataURI.split(',')[1]);

	    // separate out the mime component
	    var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];
	    // write the bytes of the string to a typed array
	    var ia = new Uint8Array(byteString.length);
	    
	    for (var i = 0; i < byteString.length; i++) {
	        ia[i] = byteString.charCodeAt(i);
	    }
	    return new Blob([ia], {type:mimeString});
	}
