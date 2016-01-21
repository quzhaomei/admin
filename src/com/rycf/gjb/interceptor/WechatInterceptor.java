package com.rycf.gjb.interceptor;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.GetMoreUserDTO;
import com.rycf.gjb.util.OpenIdUtil;

/**
 * 微信拦截
 */
public class WechatInterceptor extends HandlerInterceptorAdapter {
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
			
		}
		
		return true;
	}
}
