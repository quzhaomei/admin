package com.rycf.gjb.controller.admin;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.SystemUser;
import com.rycf.gjb.util.PasswordUtil;

@Controller
@RequestMapping(value="/login")
public class LoginController extends BaseController{
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String loginname=request.getParameter("loginname");
		String password=request.getParameter("password");
		if(loginname!=null){
			SystemUser systemUser=new SystemUser();
			systemUser.setLoginname(loginname);
			password=PasswordUtil.encodePsw(password);
			systemUser.setPassword(password);
			SystemUserDTO relUser=systemUserService.getUserByParam(systemUser);
			if(relUser!=null){//登录成功
				if(relUser.getStatus().equals("1")){
				request.getSession().setAttribute("user", relUser);
				try {
					response.sendRedirect("../welcome/index.html");
					return null;
				} catch (Exception e) {
					e.printStackTrace();
				}
				}else if(relUser.getStatus().equals("2")){
					model.addAttribute("info","用户已经被冻结！");
					return "login";
				}
			}
			model.addAttribute("info","用户名或密码错误！");
		}
		return "login";
	}
	@RequestMapping(value="/toLogin")
	public String toLogin(HttpServletRequest request,
			HttpServletResponse response, Model model){
		SystemUserDTO user=(SystemUserDTO) request.getSession().getAttribute("user");
		if(user!=null){
			request.getSession().invalidate();//销毁session
		}
		return "login";
	}
}
