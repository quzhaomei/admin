package com.rycf.gjb.interceptor;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.rycf.gjb.dto.MenuManagerDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.service.MenuManagerService;

/**
 * 拦截用户是否登录
 * 
 * @author jfwu
 * 
 */
public class LimitInterceptor extends HandlerInterceptorAdapter {
	@Resource
	private MenuManagerService menuManagerService;
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		if(handler.getClass().getAnnotation(LimitTag.class)!=null){//限制登录的
			SystemUserDTO user=(SystemUserDTO) request.getSession().getAttribute("user");
			if (user == null) {
				response.sendRedirect("/admin/login/index.html");
				return false;
			}
			//检测是否控制菜单
			if(handler.getClass().getAnnotation(LimitTag.class).menu()
				&&!user.getPhone().equals(ContextLoader.getCurrentWebApplicationContext().getServletContext().getInitParameter("godPhone"))
				){
				String uri=request.getRequestURI();
				int index=uri.indexOf("/");
				if(index!=-1){
					uri=uri.substring(index+1);
					if(user.getMenuList().get(uri)==null){
						response.getWriter().write("request deniy");
						return false;
					}
				}
			}
			List<MenuManagerDTO> allMenu=menuManagerService.findAllMenu();
			request.setAttribute("allMenu", allMenu);//绑定菜单
		}
		return true;
	}
}
