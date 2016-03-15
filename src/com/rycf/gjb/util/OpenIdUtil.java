package com.rycf.gjb.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.alibaba.fastjson.JSONObject;
import com.rycf.gjb.entity.WechatUser;

@Repository
public class OpenIdUtil {
	private Logger logger=Logger.getLogger(this.getClass());
	@Value("#{propertyConfigurer['appId']}")
	private String appId;
	@Value("#{propertyConfigurer['secret']}")
	private String secret;
	//根据media-id获取多媒体文件
	public InputStream getFile(String token,String mediaId){
		String imgurl="http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="+token+"&media_id="+mediaId;
		  URL url=null;
		try {
			url = new URL(imgurl);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}  
		BufferedInputStream bis=null;
		try {
			bis= new BufferedInputStream(url.openStream());
		} catch (IOException e) {
			e.printStackTrace();
		} 
		logger.info("微信图片=====token:"+token+" media_id: "+mediaId+","+bis);
		return bis;
	}
	//单独获取openId
	public String getOpenIdByCode(String code) {
		String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="
				+ appId + "&secret=" + secret + "&code=" + code + "&"
				+ "grant_type=authorization_code";
		String json = MapUtil.loadJSON(url);
		Map<String, Object> map = JSONObject.parseObject(json);
		return (String) map.get("openid");
	}
	
	//获取一个返回的状态
	public Map<String, Object> getObjByCode(String code) {
		String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="
				+ appId + "&secret=" + secret + "&code=" + code + "&"
				+ "grant_type=authorization_code";
		String json = MapUtil.loadJSON(url);
		logger.info("getObjByCode:"+json);
		return JSONObject.parseObject(json);
	}
	//获得access_token
	public String getToken(){
		String getToken="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+appId+"&secret="+secret;
		String tokenJson = MapUtil.loadJSON(getToken);
		String token= (String) JSONObject.parseObject(tokenJson).get("access_token");
		return token;
	}
	//获得ticket
	public String getTicket(String noncestr,String time,String token){
		String loadurl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+token+"&type=jsapi";
		String json = MapUtil.loadJSON(loadurl);
		//换取ticket
		String ticket= (String) JSONObject.parseObject(json).get("ticket");
		return ticket;
	}
	
	//获得签名
	public String getJsSign(String noncestr,String time,String ticket,String url){
		String param="jsapi_ticket=" +ticket+
				"&noncestr=" + noncestr+
				"&timestamp=" + time+
				"&url="+url;
		return  SHA1.SHA1Digest(param);
	}
	//只获取openid
	public String getBaseCodeUrl(String uri) {
		try {
			uri=URLEncoder.encode(uri,"utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String rediUrl = "https://open.weixin.qq.com/connect/oauth2/authorize"
				+ "?appid="+appId+"&redirect_uri="+uri+"&response_type=code"
				+ "&scope=snsapi_base&state=base#wechat_redirect";
		return rediUrl;
	}
	
	public String getCodeUrl(String uri) {
		try {
			uri=URLEncoder.encode(uri,"utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String rediUrl = "https://open.weixin.qq.com/connect/oauth2/authorize"
				+ "?appid="+appId+"&redirect_uri="+uri+"&response_type=code"
				+ "&scope=snsapi_userinfo&state=info#wechat_redirect";
		return rediUrl;
	}
	
	public WechatUser getUserByTokenAndUser(String token,String openId){
	String userurl="https://api.weixin.qq.com/sns/userinfo?access_token="+token+"&openid="+openId+"&lang=zh_CN";
	String userjson = MapUtil.loadJSON(userurl);
	logger.info("getUserByTokenAndUser:"+userjson);	
		Map<String, Object> usermap = JSONObject.parseObject(userjson);
		WechatUser user=new WechatUser();
		String openid=(String) usermap.get("openid");
		//昵称处理特殊字符
		String nickname=(String) usermap.get("nickname");
		Integer code=(Integer) usermap.get("sex");
		String sex=null;
		if(code!=null){
		 sex=code.toString();
		}
		String province=(String) usermap.get("province");
		String city=(String) usermap.get("city");
		String country=(String) usermap.get("country");
		String headimgurl=(String) usermap.get("headimgurl");
		user.setOpenid(openid);
		if(nickname!=null){
			try {
				user.setNickname(StringUtils.filterOffUtf8Mb4(nickname));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		user.setSex(sex);
		user.setProvince(province);
		user.setCity(city);
		user.setCountry(country);
		user.setHeadimgurl(headimgurl);
		return user;
	}
	public WechatUser getUserByCode(String code){
		String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="
				+ appId + "&secret=" + secret + "&code=" + code + "&"
				+ "grant_type=authorization_code";
		String json = MapUtil.loadJSON(url);
		//获取openId与token
		Map<String, Object> map = JSONObject.parseObject(json);
		String token=(String) map.get("access_token");
		String openId=(String) map.get("openid");
		String userurl="https://api.weixin.qq.com/sns/userinfo?access_token="+token+"&openid="+openId+"&lang=zh_CN";
		
		String userjson = MapUtil.loadJSON(userurl);
		Map<String, Object> usermap = JSONObject.parseObject(userjson);
		WechatUser user=new WechatUser();
		String openid=(String) usermap.get("openid");
		String nickname=(String) usermap.get("nickname");
		String sex=(String) usermap.get("sex");
		String province=(String) usermap.get("province");
		String city=(String) usermap.get("city");
		String country=(String) usermap.get("country");
		String headimgurl=(String) usermap.get("headimgurl");
		user.setOpenid(openid);
		user.setNickname(nickname);
		user.setSex(sex);
		user.setProvince(province);
		user.setCity(city);
		user.setCountry(country);
		user.setHeadimgurl(headimgurl);
		return user;
	}
}