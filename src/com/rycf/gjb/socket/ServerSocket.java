package com.rycf.gjb.socket;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.SocketIOServer;
import com.corundumstudio.socketio.listener.ConnectListener;
import com.corundumstudio.socketio.listener.DataListener;
import com.corundumstudio.socketio.listener.DisconnectListener;
import com.rycf.gjb.entity.GuideChatHistory;
import com.rycf.gjb.service.GuideChatHistoryService;
import com.rycf.gjb.util.JSONUtil;

@Repository
public class ServerSocket {
	private static Map<String,SocketIOClient> socketMap=new Hashtable<String, SocketIOClient>();
	public static boolean isOnline(Integer getMoreId){
		if(getMoreId!=null){
			return socketMap.get("user"+getMoreId)!=null;
		}
		return false;
	}
	private SocketIOServer server=null;
	@PreDestroy
	public void close(){
		server.stop();
	}
	public static void main(String[] args) {
		ServerSocket socket=new ServerSocket();
		socket.initSocket();
	}
	
	@Resource
	private GuideChatHistoryService guideChatHistoryService;
	
	//鍚姩鏃跺垵濮嬪寲
	@PostConstruct
	public void initSocket(){
		System.out.println("系统启动");
		Configuration config = new Configuration();
	    config.setPort(14080);
	    config.setUpgradeTimeout(100000);
        config.setPingTimeout(100000);
        config.setPingInterval(100000);
	    server=new SocketIOServer(config);
	    //连接成功事件
	    server.addConnectListener(new ConnectListener() {
	        @Override
	        public void onConnect(SocketIOClient socket) {
	        	socket.sendEvent
				("connect success", "{\"status\":\"ok\"}");
	        }
	    });
	   
	    //login浜嬩欢
	    server.addEventListener("login", UserInfo.class, new DataListener<UserInfo>() {
			@Override
			public void onData(SocketIOClient socket, UserInfo userInfo,
					AckRequest request) throws Exception {
//				if(socketMap.get(userInfo.getId())!=null){
//				}
				//进行登录操作
				SocketIOClient old=null;
				//挤出
				if((old=socketMap.put("user"+userInfo.getGetMoreId(), socket))!=null){
					old.sendEvent("pick up", " ");
					old.del("user");
					old.disconnect();
				}
				socket.set("user", userInfo);//绑定用户信息
				System.out.println("---"+userInfo.getUsername()+"登录");
				//初始化未接受消息条目
				GuideChatHistory history=new GuideChatHistory();
				history.setToId(userInfo.getGetMoreId());
				int uncheckcount=guideChatHistoryService.loadUncheckCountByParam(history);
				socket.sendEvent
				("unaccpet msg", "{\"uncheckcount\":"+uncheckcount+"}");
			}
	    });
	    //say to user
	    server.addEventListener("say to user", PersionTalkInfo.class, new DataListener<PersionTalkInfo>() {
	    	
			@Override
			public void onData(SocketIOClient socket, PersionTalkInfo talk,
					AckRequest request) throws Exception {
				System.out.println("---"+ talk+socketMap);
				Integer toUserId=talk.getToId();
				Map<String,Object> message=new HashMap<String,Object>();
				if(socketMap.get("user"+toUserId )!=null){
					message.put("messageId",talk.getMessageId());
					message.put("message", talk.getMessage());
					message.put("datatime", talk.getDatatime());
					message.put("fromUser", socket.get("user"));
					message.put("toUser", socketMap.get("user"+toUserId ).get("user"));
					socketMap.get("user"+toUserId).sendEvent
					("per2perTalking", JSONUtil.object2json(message));
					System.out.println("---"+ talk.getMessage()+"消息");
				}
				
			}
	    });
	    //失去连接事件
	    server.addDisconnectListener(new DisconnectListener() {
	        @Override
	        public void onDisconnect(SocketIOClient socket) {
	        	UserInfo userInfo=socket.get("user");
	        	if(userInfo!=null){
	        		System.out.println(userInfo.getUsername()+"下线了");
	        		Integer userId=userInfo.getGetMoreId();
	        		socketMap.remove("user"+userId);//socket
	        	}
	        }
	    });
	    server.start();
	}
}
