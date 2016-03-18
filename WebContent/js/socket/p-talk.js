var user;

/**
 * socket 公共js
 */
	
window.onerror = function(errorMessage, scriptURI, lineNumber,columnNumber,errorObj) {
    alert("错误信息："+ errorMessage+
      ",出错文件：" +scriptURI+","+lineNumber+","+columnNumber+","+errorObj);
   }	
	
var TalkingUser=(function($){
	
$(function(){
	$.ajax({
		url: "socketLogin.html",
		type: "get",
		dataType: 'jsonp',
		jsonp: 'jsoncallback',
		success: function(json){  
			user=new TalkingUser(json.user.getMoreId,json.user.userName,json.user.photo,
					json.url,json.role,json.serverhost);
			user.login();//登录
        },  
        error: function(){  
            alert('fail');  
        }  
	});
});
//聊天用户对象,在首页创建
function talkingUser(getMoreId,username,imgPath,server,role,serverhost){
	this.getMoreId=getMoreId,//id
	this.username=username,//姓名
	this.imgPath=imgPath,
	this.socket=null,//链接的socket
	this.server=server,
	this.role=role;
	this.url=serverhost;
	var _this=this;
	this.callback=null;//默认的回调
	this.login=function(){//登录聊天系统方法,并初始化事件
		socket = io.connect(server,{
			'reconnection delay' : 5000,
			'force new connection' : true
		});
		socket.on("connect success",function(data){
			data=JSON.parse(data);
			if(data.status=="ok"){//链接成功，推送登录信息
				setTimeout(function(){
					socket.emit("login", {//向服务器注册用户
						getMoreId:_this.getMoreId,
						username:_this.username,
						imgPath:_this.imgPath
					});
				}, 500);
			}
		});
		
		//初始化未接受信息条数
		socket.on("unaccpet msg",function(data){
			data=JSON.parse(data);
			if(data.uncheckcount&&data.uncheckcount!=0){//链接成功，推送登录信息
				$("body").append('<div id="msgnotify">'+
						'<i class="icon-bubbles4 spinning"></i>'+
						'<span class="num">'+data.uncheckcount+'</span></div>');
			}
			$("body").on("click","#msgnotify",function(){
				if(_this.role=="guide"){
					window.location.href=_this.url+"/wechat/guideCustom.html";
				}else if(_this.role=="normal"){
					window.location.href=_this.url+"/wechat/myQuestion.html";
				}
			});
		});
		//接受其他人信息
		socket.on("per2perTalking",function(data){
			data=JSON.parse(data);
			if(_this.callback){
				_this.callback(data);
			}else if(_this.role=="guide"){//默认处理方式  
				//TODO 导购的
				if(!$("#msgnotify")[0]){
					$("body").append('<div id="msgnotify">'+
					'<i class="icon-bubbles4 spinning"></i>'+
					'<span class="num">1</span></div>');
				}else{
					var num=$("#msgnotify .num").text();
					num=parseInt(num, 10);
					$("#msgnotify .num").text(num+1);
				}
			}else if(_this.role=="normal"){
				//TODO 普通用户的
				if(!$("#msgnotify")[0]){
					$("body").append('<div id="msgnotify">'+
					'<i class="icon-bubbles4 spinning"></i>'+
					'<span class="num">1</span></div>');
				}else{
					var num=$("#msgnotify .num").text();
					num=parseInt(num, 10);
					$("#msgnotify .num").text(num+1);
				}
			}else if(_this.role=="channel"){
				//TODO 渠道商的
				
			}
		});
		
		
		
	};
	//fromUser:  toUser:  message:  datatime:
	
	this.speak=function(toId,message,datatime,messageId){
		var data={};
		data.messageId=messageId;
		data.toId=toId;
		data.message=message;
		data.datatime=datatime;
		//说话
		socket.emit('say to user',data);
	};
}
return talkingUser;
})(window.jQuery);