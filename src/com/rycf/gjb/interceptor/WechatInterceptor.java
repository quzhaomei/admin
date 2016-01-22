package com.rycf.gjb.interceptor;

import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.GetMoreUserDTO;
import com.rycf.gjb.entity.GetMoreUser;
import com.rycf.gjb.entity.WechatUser;
import com.rycf.gjb.service.GetMoreUserService;
import com.rycf.gjb.service.WechatUserService;
import com.rycf.gjb.util.OpenIdUtil;
import com.rycf.gjb.util.UuidUtils;

/**
 * 微信拦截
 */
public class WechatInterceptor extends HandlerInterceptorAdapter {
	@Resource
	private WechatUserService wechatUserService;
	@Resource
	private GetMoreUserService getMoreUserService;
	@Resource
	private OpenIdUtil openIdUtil;
	@Resource
	private OpenIdUtil util;
	@SuppressWarnings("unused")
	private Logger logger=Logger.getLogger(this.getClass());
	
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		if(handler.getClass().getAnnotation(WechatTag.class)!=null){
			String url=request.getRequestURL().toString();
			String queryString=request.getQueryString();
			GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession()
					.getAttribute(BaseController.LOGIN_USER);
			
			String code=request.getParameter("code");
			
			//测试
			boolean test=true;
			String getmoreId=request.getParameter("getId");
			if(test&&getmoreId!=null&&getmoreId.matches("\\d+")){
					loginUser=getMoreUserService.getUserById(Integer.parseInt(getmoreId));
					request.getSession().setAttribute(BaseController.LOGIN_USER, loginUser);// 保存session
					return true;
			}
			
			if(loginUser==null&&code==null){
				if(queryString!=null){
					url=url+"?"+queryString+"&"+new Date().getTime();
				}else{
					url=url+"?"+new Date().getTime();
				}
				String rediUrl=util.getCodeUrl(url);
				response.sendRedirect(rediUrl);
				return false;
			}else if(loginUser==null&&code!=null){	//开始调取数据
				String channelCode = request.getParameter("channelCode");// 渠道编码
				if (code != null) {
					Map<String, Object> jsonMap = openIdUtil.getObjByCode(code);
					String openId_temp = (String) jsonMap.get("openid");
					String access_token = (String) jsonMap.get("access_token");
					// 先查看用户注册没有。
					WechatUser wechatUser = wechatUserService
							.getWechatUserByOpenId(openId_temp);
					if (wechatUser == null) {
						wechatUser = openIdUtil.getUserByTokenAndUser(access_token,
								openId_temp);
						// 生成凯特猫用户
						GetMoreUser user = new GetMoreUser();
						user.setCreateDate(new Date());
						user.setPhoto(wechatUser.getHeadimgurl());
						user.setCode(channelCode);// 第一次进入初始化渠道编码
						user.setStatus(1);// 正常
						user.setType(1);// 微信用户
						user.setUserName(wechatUser.getNickname());
						user.setLoginName(UuidUtils.getObjectUUID("wechat"));
						user.setPassword(UuidUtils.getObjectUUID("wechat"));
						getMoreUserService.saveGetMoreUser(user);// 保存用户

						wechatUser.setGetMoreId(user.getGetMoreId());// 关联ID
						wechatUser.setOpenid(openId_temp);// 初始化openId 为了防止没有授权
						wechatUserService.saveWechatUser(wechatUser);
						// 保存session
						loginUser = getMoreUserService.getUserById(user
								.getGetMoreId());
						request.getSession().setAttribute(BaseController.LOGIN_USER, loginUser);
					} else {
						loginUser = getMoreUserService.getUserById(wechatUser
								.getGetMoreId());
						request.getSession().setAttribute(BaseController.LOGIN_USER, loginUser);// 保存session

						if (wechatUser.getHeadimgurl() == null
								|| "".equals(wechatUser.getHeadimgurl())) {
							Integer getMoreId = wechatUser.getGetMoreId();// 凯特号
							// 查看有头像信息不，没有再请求一次
							wechatUser = openIdUtil.getUserByTokenAndUser(
									access_token, openId_temp);
							if (wechatUser.getHeadimgurl() != null
									&& wechatUser.getOpenid() != null) {// 正确返回

								wechatUserService.update(wechatUser);// 更新数据
								// 更新头像昵称
								GetMoreUser updateParam = new GetMoreUser();
								updateParam.setGetMoreId(getMoreId);
								updateParam.setUserName(wechatUser.getNickname());
								updateParam.setPhoto(wechatUser.getHeadimgurl());
								getMoreUserService.updateGetMoreUser(updateParam);// 更新
							}

						}
					}
				} 
			}
/*			
			if(url.indexOf("index.html")==-1){
				if(loginUser==null){//进行拦截
					response.sendRedirect("index.html");
					return false;
				}
			}else{//进行微信授权
				String code=request.getParameter("code");
				String state=request.getParameter("state");
				//没有登录就授权
				if(loginUser==null&&code==null&&state==null){
					if(queryString!=null){
						url=url+"?"+queryString+"&"+new Date().getTime();
					}else{
						url=url+"?"+new Date().getTime();
					}
					String rediUrl=util.getCodeUrl(url);
					response.sendRedirect(rediUrl);
					return false;
				}else{
					if(request.getParameter("out")!=null){//如果是从外部请求
						request.setAttribute("uri", request.getParameter("out"));
					}
					
				}
			}
*/			
			
		}
		
		return true;
	}
}
