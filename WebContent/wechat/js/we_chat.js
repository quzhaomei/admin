//日期输出格式化
Date.prototype.toString=function(){
	var date=new Date();
	date.setHours(0, 0, 0, 0);
	var year=this.getFullYear();
	var mon=this.getMonth()+1;
	var day=this.getDate();
	var hour=this.getHours();
	var min=this.getMinutes();
	var sec=this.getSeconds();
	if(this>date){
		return "今天 "+hour+":"+min;
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
	chat.scollToButtom();
};

//接收信息
chat.getHtml=function(content,headimgurl,time,loadTag){
	var $html=$("<span>").addClass("bubble b_left").html(content);
	
	var $li=$("<li>");
	$li.append($("<span>").addClass("avatar").append($("<img>").attr("src",headimgurl)));
	$li.append($html);
	$li.append($("<div>").addClass("datetime").text(time));
	if(loadTag){
		$("#talking-container").prepend($li);
	}else{
		$("#talking-container").append($li);
	}
};
//设置对话
chat.setDialog=function(json){
	var toId=$("#toId").val();
	$(json).each(function(){
		if(this.fromUser.getMoreId==toId){
			//初始化对方的
			chat.getHtml(this.content,this.fromUser.headimgurl,new Date(parseInt(this.timeStamp)),1);
		}else{
			//初始化自己的
			chat.speakHtml(this.content,this.fromUser.headimgurl,new Date(parseInt(this.timeStamp)),1);
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
				user.speak(json.data.toUser.getMoreId,text,json.data.timeStamp);
			}
			$("#talk-content").val("");
			chat.speakHtml(text,json.data.fromUser.headimgurl,
					new Date(parseInt(json.data.timeStamp)));
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
			$("#talk-content").val("");
			chat.speakHtml(html,json.data.fromUser.headimgurl,
					new Date(parseInt(json.data.timeStamp)))
		}else{
			alert(json.message);
		}
	},"json");
	
}


//TODO 待编写
function loadHis(toId,pageIndex,pageSize,status){
	var param={};
	param.toId=toId;
	param.pageIndex=pageIndex;
	param.pageSize=pageSize;
	$.post("loadSay.html",param,function(json){
		if(json.status=="0"){
			alert(json.message);
		}else if(json.status=="1"){//加载历史数据
			//初始化
			chat.setDialog(json.param);
		}
	},"json");
}
//加载未接受信息，以及历史信息数目
function loadUnCheckHis(toId){
	var param={};
	param.toId=toId;
	$.post("loadUncheck.html",param,function(json){
		if(json.status=="0"){
			alert(json.message);
		}else if(json.status=="1"){//加载历史数据
			//初始化
			chat.setDialog(json.data);
		}
	},"json");
}

$(function(){
	//加载未接受历史聊天信息
	loadUnCheckHis($("#toId").val());
	
	//发送名片
	$(".add_namecard").on("click",function(){
		chat.sendHtml($("#guide-namecard").html(),this);
	});
	//发送地点
	$(".guide-location").on("click",function(){
		chat.sendHtml($("#guide-location").html(),this);
	});
	//发送话术
	$("#preword").on("click",function(){
		chat.sendHtml($(this).val(),this);
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
			alert("设置回调");
			user.callback=function(data){
				chat.getHtml(data.message,data.fromUser.imgPath
						,new Date(parseInt(data.datatime)));
			}
		}
		clearInterval(task);
	}, 500);
	
});