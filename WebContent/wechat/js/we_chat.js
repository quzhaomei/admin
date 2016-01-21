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
//发送信息
chat.speakHtml=function(content,headimgurl,time,loadTag){
	var $html=$("<span>").addClass("bubble b_right").text(content);
	var $li=$("<li>").addClass("alt");
	$li.append($html);
	$li.append($("<span>").addClass("avatar").append($("<img>").attr("src",headimgurl)));
	$li.append($("<div>").addClass("datetime").text(time));
	if(loadTag){
		$("#talking-container").prepend($li);
	}else{
		$("#talking-container").append($li);
	}
};

//接收信息
chat.getHtml=function(content,headimgurl,time,loadTag){
	var $html=$("<span>").addClass("bubble b_left").text(content);
	
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
			chat.getHtml(this.content,this.toUser.headimgurl,new Date(parseInt(this.timeStamp)),1);
		}else{
			//初始化自己的
			chat.speakHtml(this.content,this.fromUser.headimgurl,new Date(parseInt(this.timeStamp)),1);
		}
	});
	
	
};

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
		chat.speakHtml($("#guide-namecard").html(),"images/avatar2.jpg","今天")
	});
	//发送地点
	$(".guide-location").on("click",function(){
		chat.speakHtml($("#guide-location").html(),"images/avatar2.jpg","今天")
	});
	//发送聊天信息
	$("#talkform").on("submit",function(){
		var _this=this;
		var content=$("#talk-content").val();
		if(!content){
			alert("发送内容不能为空！");
		}else{
			//发送信息
			var param={};
			param.content=content;
			param.toId=$("#toId").val();
			
			$(_this).attr("disabled","disabled");
			$.post("guideSay.html",param,function(json){
				$(_this).removeAttr("disabled");
				if(json.status=="1"){
					$("#talk-content").val("");
					chat.speakHtml(content,json.data.fromUser.headimgurl,
							new Date(parseInt(json.data.timeStamp)))
				}else{
					alert(json.message);
				}
			},"json");
			
		}
		return false;
	})
});