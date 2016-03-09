var user;

/**
 * socket 公共js
 */
	
window.onerror = function(errorMessage, scriptURI, lineNumber,columnNumber,errorObj) {
    alert("错误信息："+ errorMessage+
      ",出错文件：" +scriptURI+","+lineNumber+","+columnNumber+","+errorObj);
   }	
	

$(function(){
	//userInfo 获取
//	$.post("socketLogin.html",function(json){
//		user=new TalkingUser(json.user.getMoreId,json.user.userName,json.user.photo,
//				json.url);
//		user.login();//登录
//	},"json");
	
	$.ajax({
		url: "socketLogin.html",
		type: "get",
		dataType: 'jsonp',
		jsonp: 'jsoncallback',
		success: function(json){  
			user=new TalkingUser(json.user.getMoreId,json.user.userName,json.user.photo,
					json.url,json.role);
			user.login();//登录
        },  
        error: function(){  
            alert('fail');  
        }  
	});
});
//聊天用户对象,在首页创建
function TalkingUser(getMoreId,username,imgPath,server,role){
	this.getMoreId=getMoreId,//id
	this.username=username,//姓名
	this.imgPath=imgPath,
	this.socket=null,//链接的socket
	this.server=server,
	this.role=role;
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
				}, 500)
			}
		});
		//接受其他人信息
		socket.on("per2perTalking",function(data){
			data=JSON.parse(data);
			if(_this.callback){
				_this.callback(data);
			}else if(this.role=="guide"){//默认处理方式  
				//TODO 导购的
			}else if(this.role=="normal"){//
				//TODO 普通用户的
			}else if(this.role=="channel"){
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
