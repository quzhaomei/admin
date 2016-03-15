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
import com.rycf.gjb.dto.ThirdChannelDTO;
import com.rycf.gjb.dto.ThirdGuideDTO;
import com.rycf.gjb.entity.GetMoreUser;
import com.rycf.gjb.entity.ThirdNormal;
import com.rycf.gjb.entity.WechatUser;
import com.rycf.gjb.service.GetMoreUserService;
import com.rycf.gjb.service.ThirdChannelService;
import com.rycf.gjb.service.ThirdGuideService;
import com.rycf.gjb.service.ThirdNormalService;
import com.rycf.gjb.service.WechatUserService;
import com.rycf.gjb.util.Constant;
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
	protected ThirdNormalService normalService;// 普通用户
	@Resource
	protected ThirdGuideService thirdGuideService;// 导购
	@Resource
	protected ThirdChannelService channelService;// 渠道

	@Resource
	private OpenIdUtil openIdUtil;
	@SuppressWarnings("unused")
	private Logger logger = Logger.getLogger(this.getClass());

	// 设置角色
	private void setRole(HttpServletRequest request, GetMoreUserDTO loginUser) {
		ThirdNormal normal = normalService.getByGetMoreId(loginUser.getGetMoreId());

		if (normal != null) {
			request.getSession().setAttribute(Constant.ROLE, Constant.NORMAL);
			return;
		}

		// 导购
		ThirdGuideDTO guide = thirdGuideService.getByGetMoreId(loginUser.getGetMoreId());
		if (guide != null) {
			request.getSession().setAttribute(Constant.ROLE, Constant.GUIDE);
			request.getSession().setAttribute(Constant.STATUS, guide.getStatus());
			return;
		}

		// 渠道商
		ThirdChannelDTO channel = channelService.getByGetMoreId(loginUser.getGetMoreId());
		if (channel != null) {
			request.getSession().setAttribute(Constant.STATUS,  channel.getStatus());
			request.getSession().setAttribute(Constant.ROLE, Constant.CHANNEL);
		}
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		if (handler.getClass().getAnnotation(WechatTag.class) != null) {
			String url = request.getRequestURL().toString();
			String queryString = request.getQueryString();
			GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(BaseController.LOGIN_USER);

			String code = request.getParameter("code");
			String state = request.getParameter("state");

			// 测试
			boolean test = false;
			String getmoreId = request.getParameter("getId");
			if (loginUser == null && test && getmoreId != null && getmoreId.matches("\\d+")) {
				loginUser = getMoreUserService.getUserById(Integer.parseInt(getmoreId));
				request.getSession().setAttribute(BaseController.LOGIN_USER, loginUser);// 保存session
				setRole(request, loginUser);
				return true;
			}
			//先获取openid
			if (loginUser == null && code == null) {
				if (queryString != null) {
					url = url + "?" + queryString + "&" + new Date().getTime();
				} else {
					url = url + "?" + new Date().getTime();
				}
				String rediUrl = openIdUtil.getBaseCodeUrl(url);
				response.sendRedirect(rediUrl);
				return false;
			}else if (loginUser == null && code != null&&"base".equals(state)) { // 开始调取数据
				if (code != null) {
					Map<String, Object> jsonMap = openIdUtil.getObjByCode(code);
					String openId_temp = (String) jsonMap.get("openid");
					// 先查看用户注册没有。
					WechatUser wechatUser = wechatUserService.getWechatUserByOpenId(openId_temp);
					if (wechatUser == null||
							(wechatUser.getHeadimgurl() == null || "".equals(wechatUser.getHeadimgurl()))
							) {
						if (queryString != null) {
							url = url + "?" + queryString + "&" + new Date().getTime();
						} else {
							url = url + "?" + new Date().getTime();
						}
						String rediUrl = openIdUtil.getCodeUrl(url);//拉取用户信息
						response.sendRedirect(rediUrl);
						return false;
					} 
				}
			}else if(loginUser == null && code != null&&"info".equals(state)) { // 开始调取数据
				String channelCode = request.getParameter("channelCode");// 渠道编码
				if (code != null) {
					Map<String, Object> jsonMap = openIdUtil.getObjByCode(code);
					String openId_temp = (String) jsonMap.get("openid");
					String access_token = (String) jsonMap.get("access_token");
					// 先查看用户注册没有。
					WechatUser wechatUser = wechatUserService.getWechatUserByOpenId(openId_temp);
					if (wechatUser == null) {
						wechatUser = openIdUtil.getUserByTokenAndUser(access_token, openId_temp);
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
						loginUser = getMoreUserService.getUserById(user.getGetMoreId());
						request.getSession().setAttribute(BaseController.LOGIN_USER, loginUser);
					} else {
						loginUser = getMoreUserService.getUserById(wechatUser.getGetMoreId());
						setRole(request, loginUser);
						request.getSession().setAttribute(BaseController.LOGIN_USER, loginUser);// 保存session
						if (wechatUser.getHeadimgurl() == null || "".equals(wechatUser.getHeadimgurl())) {
							Integer getMoreId = wechatUser.getGetMoreId();// 凯特号
							// 查看有头像信息不，没有再请求一次
							wechatUser = openIdUtil.getUserByTokenAndUser(access_token, openId_temp);
							if (wechatUser.getHeadimgurl() != null && wechatUser.getOpenid() != null) {// 正确返回

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
			
			if (loginUser == null && code == null) {
				if (queryString != null) {
					url = url + "?" + queryString + "&" + new Date().getTime();
				} else {
					url = url + "?" + new Date().getTime();
				}
				String rediUrl = openIdUtil.getCodeUrl(url);
				response.sendRedirect(rediUrl);
				return false;
			} else if (loginUser == null && code != null) { // 开始调取数据
				String channelCode = request.getParameter("channelCode");// 渠道编码
				if (code != null) {
					Map<String, Object> jsonMap = openIdUtil.getObjByCode(code);
					String openId_temp = (String) jsonMap.get("openid");
					String access_token = (String) jsonMap.get("access_token");
					// 先查看用户注册没有。
					WechatUser wechatUser = wechatUserService.getWechatUserByOpenId(openId_temp);
					if (wechatUser == null) {
						wechatUser = openIdUtil.getUserByTokenAndUser(access_token, openId_temp);
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
						loginUser = getMoreUserService.getUserById(user.getGetMoreId());
						request.getSession().setAttribute(BaseController.LOGIN_USER, loginUser);
					} else {
						loginUser = getMoreUserService.getUserById(wechatUser.getGetMoreId());
						setRole(request, loginUser);
						request.getSession().setAttribute(BaseController.LOGIN_USER, loginUser);// 保存session
						if (wechatUser.getHeadimgurl() == null || "".equals(wechatUser.getHeadimgurl())) {
							Integer getMoreId = wechatUser.getGetMoreId();// 凯特号
							// 查看有头像信息不，没有再请求一次
							wechatUser = openIdUtil.getUserByTokenAndUser(access_token, openId_temp);
							if (wechatUser.getHeadimgurl() != null && wechatUser.getOpenid() != null) {// 正确返回

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
			
			*/

		}

		return true;
	}
}
