//日期输出格式化
Date.prototype.toString=function(){
	var date=new Date();
	date.setHours(0, 0, 0, 0);
	var year=this.getFullYear();
	var mon=this.getMonth()+1;
	var day=this.getDate();
	var hour=this.getHours();
	var min=this.getMinutes();
	if(min<10){
		min="0"+min;
	}
	var sec=this.getSeconds();
	if(this>date){
		return "今天 "+hour+":"+min+":"+sec;
	}else{
		return year+"-"+mon+"-"+day+" "+hour+":"+min;
	}
}


//输入框添加html
var chat={};
//滚动到底部
chat.scollToButtom=function(){
	$("#talking-container").scrollTop( $("#talking-container")[0].scrollHeight );
}
//发送信息
chat.speakHtml=function(content,headimgurl,time,loadTag){
	var $html=$("<span>").addClass("bubble b_right").html(content);
	var $li=$("<li>").addClass("alt");
	$li.append($html);
	$li.append($("<span>").addClass("avatar").append($("<img>").attr("src",headimgurl)));
	$li.append($("<div>").addClass("datetime").text(time));
	if(loadTag){
		$("#talking-container").prepend($li);
	}else{
		$("#talking-container").append($li);
	}
//	chat.scollToButtom();
};

//接收信息
chat.getHtml=function(content,headimgurl,time,loadTag){
	var $html=$("<span>").addClass("bubble b_left").html(content);
	
	var $li=$("<li>");
	$li.append($("<span>").addClass("avatar speakPhoto").append($("<img>").attr("src",headimgurl)));
	$li.append($html);
	$li.append($("<div>").addClass("datetime").text(time));
	if(loadTag){
		$("#talking-container").prepend($li);
	}else{
		$("#talking-container").append($li);
	}
};
//设置对话
chat.setDialog=function(json,loadTag){
	if(loadTag){
		loadTag=false;
	}else{
		loadTag=true; 
	}
		
	var toId=$("#toId").val();
	$(json).each(function(){
		if(this.fromUser.getMoreId==toId){
			//初始化对方的
			chat.getHtml(this.content,this.fromUser.photo,new Date(parseInt(this.timeStamp)),loadTag);
		}else{
			//初始化自己的
			chat.speakHtml(this.content,this.fromUser.photo,new Date(parseInt(this.timeStamp)),loadTag);
		}
	});
	
	
};
chat.htmlEncode=function (str)
{
  var s = "";
  if (str.length == 0) return "";
  s = s.replace(/&/g, "&amp;");
  s = str.replace(/>/g, "&gt;");
  s = s.replace(/</g, "&lt;");
  s = s.replace(/\'/g, "'");
  s = s.replace(/\"/g, '&quot;');
  s = s.replace(/\n/g, "&#39;");
  return s;
}
chat.sendText=function(text,obj){
	
	//转译
	text=chat.htmlEncode(text);
	//发送信息
	var param={};
	param.content=text;
	param.toId=$("#toId").val();
	$(obj).attr("disabled","disabled");
	$.post("guideSay.html",param,function(json){
		$(obj).removeAttr("disabled");
		if(json.status=="1"){
			//socket转发
			if(user){
				user.speak(json.data.toUser.getMoreId,text,json.data.timeStamp,json.data.historyId);
			}
			$("#talk-content").val("");
			chat.speakHtml(text,json.data.fromUser.photo,
					new Date(parseInt(json.data.timeStamp)));
			chat.scollToButtom();//到最下一页
		}else{
			alert(json.message);
		}
	},"json");
	
}
chat.sendHtml=function(html,obj){
	//发送信息
	var param={};
	param.content=html;
	param.toId=$("#toId").val();
	$(obj).attr("disabled","disabled");
	$.post("guideSay.html",param,function(json){
		$(obj).removeAttr("disabled");
		if(json.status=="1"){
			//socket转发
			if(user){
				user.speak(json.data.toUser.getMoreId,html,json.data.timeStamp,json.data.historyId);
			}
			
			$("#talk-content").val("");
			chat.speakHtml(html,json.data.fromUser.photo,
					new Date(parseInt(json.data.timeStamp)));
			
			chat.scollToButtom();//到最下一页
		}else{
			alert(json.message);
		}
	},"json");
	
}
//提示其余人信息
chat.showOther=function(imgPath,getMoreId,username){
	//处理标题
	var number=$(".morechat span.number_chat").text();
	if(number&&number.match(/^\d+$/)&&
			!$(".chatselect .col-3[getmoreid='"+getMoreId+"']")[0]){//新用户
		number=parseInt(number, "10");
		number=number+1;
		$(".morechat span.number_chat").text(number)
	}else if(!number){
		$(".morechat").append($("<span>").addClass("number_chat")
				.text(1));
	}
	//内部显示
	if(!$(".chatselect .col-3[getmoreid='"+getMoreId+"']")[0]){
		$(".chatselect .row").prepend(
		'<div class="col-3" getmoreid="'+getMoreId+'">'+
		'<a href="#">'+
		'<img src="'+imgPath+'" alt="">'+
		'<span>'+username+'</span>'+
		'<span class="count">1</span>'+
		'</a></div>');
	}else{//数量+1
		var number=$(".chatselect .col-3[getmoreid='"+getMoreId+"'] .count").text();
		//如果有则+1
		if(number&&number.match(/^\d+$/)){
			number=parseInt(number, "10")+1;
			$(".chatselect .col-3[getmoreid='"+getMoreId+"'] .count").text(number);
		}
		
	}
}

//TODO 待编写加载已接受的
function loadHistory(toId,pageIndex,pageSize,tempId,callback){
	
	var param={};
	param.toId=toId;
	param.pageIndex=pageIndex;
	param.pageSize=pageSize;
	if(tempId){
		param.tempId=tempId;
	}
	$.post("loadHistory.html",param,function(json){
		if(json.status=="0"){
			alert(json.message);
		}else if(json.status=="1"&&parseInt(json.data.totalPage,"10")>0){//加载历史数据
			if(!$(".li-tips")[0]){
				var $li=$("<li>").addClass("li-tips");
				$li.text(" - 以上为历史聊天记录 - ")
				$("#talking-container").prepend($li);
			}
			//初始化
			chat.setDialog(json.data.param);
			var tempId=json.message;
			if(parseInt(json.data.totalPage,"10")>parseInt(json.data.pageIndex,"10")){//说明还有下一页
				if($(".loadPage")[0]){
					$(".loadPage").attr("pageIndex",parseInt( json.data.pageIndex,"10")+1);
					$("#talking-container").prepend($(".loadPage"));
				}else{
					var $page=$("<li>").attr("pageSize",json.data.pageSize).attr("id","myload")
					.attr("pageIndex",parseInt( json.data.pageIndex,"10")+1).attr("tempId",json.message).addClass("loadPage li-tips")
					.attr("toId",toId);
					$page.html("<a href='#myload'> -加载更多- </a> ");
					$("#talking-container").prepend($page);
				}
				
			}else{
				if($(".loadPage")[0]){
					$("#talking-container").prepend($(".loadPage"));
					$(".loadPage").removeClass("loadPage")
					.html("-没有更多消息了！-");
				}
			}
			
		}
		if(callback){//加载回调函数
			callback();
		}
	},"json");
}
$("#talking-container").on("click",".loadPage",function(){
	var toId=$(this).attr("toId");
	var pageIndex=$(this).attr("pageIndex");
	var pageSize=$(this).attr("pageSize");
	var tempId=$(this).attr("tempId");
	loadHistory(toId,pageIndex,pageSize,tempId);
});

//加载未接受信息，以及历史信息数目
function loadUnCheckHis(toId,fn){
	
	var param={};
	param.toId=toId;
	$.post("loadUncheck.html",param,function(json){
		if(json.status=="0"){
			alert(json.message);
		}else if(json.status=="1"){//加载历史数据
			//初始化
			chat.setDialog(json.data,true);
		}
		//执行回调函数
		if(fn){
			fn();
		}
		
	},"json");
}

$(function(){
	//加载历史
	$("#talking-container").html("");//清空
	loadHistory($("#toId").val(),1,5,null,function(){
		//加载未接受历史聊天信息
		loadUnCheckHis($("#toId").val(),function(){
			//客户发送导购图片
			if($("#imgUrl").val()){
				chat.sendHtml("<img src='"+$("#imgUrl").val()+"'/>",$("#imgUrl"));
			}
		});
		
		
		
	});

	
	//发送图片
	$(".add_img").on("click",function(){
		
		$(".add_img").attr("disabled","disabled");
		
			wx.chooseImage({
			    count: 1, // 默认9
			    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
			    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
			    success: function (res) {
			    	var tempId = res.localIds[0]; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
			        
			    	//上传图片
			        wx.uploadImage({
			            localId: tempId, // 需要上传的图片的本地ID，由chooseImage接口获得
			            isShowProgressTips: 1, // 默认为1，显示进度提示
			            success: function (res) {
			                var serverId = res.serverId; // 返回图片的服务器端ID
			                
			                $.post("getWechatImg.html",{"tempId":serverId},function(json){
					        	$(".add_img").removeAttr("disabled");
					        	if(json.status=="1"){
					        		chat.sendHtml("<img src='"+json.data+"'/>",$(".add_img"));
					        	}else{
					        		alert("上传图片出错！");
					        	}
					        		
					        },"json");
			            }
			        });
			        
			    }
			});
		
	});
	
	
	//发送名片
	$(".add_namecard").on("click",function(){
		chat.sendHtml($("#guide-namecard").html(),this);
	});
	
	//发送地点
	$(".guide-location").on("click",function(){
		chat.sendHtml($("#guide-location").html(),this);
	});
	
	//发送话术
	$("#preword").on("change",function(){
		chat.sendHtml($(this).val(),this);
		$("#preword option:eq(0)").attr("selected","selected");
	});
	
	//发送聊天信息
	$("#talkform").on("submit",function(){
		var content=$("#talk-content").val();
		if(!content){
			alert("发送内容不能为空！");
		}else{
			chat.sendText(content,this);
		}
		return false;
	})
	//socket 接受到聊天信息
	var task=setInterval(function(){
		if(user){
			user.callback=function(data){
				if(data.fromUser.getMoreId==$("#toId").val()){//如果接受到的信息是来至这个人，则显示
					chat.getHtml(data.message,data.fromUser.imgPath
							,new Date(parseInt(data.datatime)));
					chat.scollToButtom();
					//该句更新为已读
					$.post("hasRead.html",{"messageId":data.messageId},function(json){
						
					});
				}else{
					$(".chatselect .nocontents").remove();
					//置顶显示
					chat.showOther(data.fromUser.imgPath,data.fromUser.getMoreId,
							data.fromUser.username);
					
				}
			}
		}
		clearInterval(task);
	}, 500);
	
	//切换聊天用户
	$(".chatselect .row").on("click",'div.col-3[getMoreId]',function(){
		$('.chatselect').removeClass('shown');
		$(this).remove();//移除，
		//处理顶部消息条数
		var number=$(".morechat span.number_chat").text();
		if(number&&number.match(/^\d+$/)){//新用户
			number=parseInt(number, "10");
			number=number-1;
			if(number>0){
				$(".morechat span.number_chat").text(number);
			}else{
				$(".morechat span.number_chat").remove();
			}
		}
		
		var getMoreId=$(this).attr("getMoreId");
		if(getMoreId){//进行切换
			$("#toId").val(getMoreId);
			//加载未接受历史聊天信息
			$("#talking-container").html("");//清空
			loadHistory($("#toId").val(),1,5,null,function(){
				//加载未接受历史聊天信息
				loadUnCheckHis($("#toId").val());
			});
		}
	});
	
	//add guide
	$(".addguider").on("click",function(){
		var guideId=$(this).attr("guideId");
		var param={};
		param.guideId=guideId;
		$.post("getGuide.html",param,function(json){
			if(json.status){
				$('.chatnotice').html(json.message).addClass('shown');
				setTimeout(function(){$('.chatnotice').removeClass('shown')}, 5000);
			}
			
		},"json");
	});
});