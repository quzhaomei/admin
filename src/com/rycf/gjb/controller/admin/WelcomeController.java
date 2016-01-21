package com.rycf.gjb.controller.admin;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.SystemUser;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.service.SystemUserService;
import com.rycf.gjb.util.JSONUtil;
import com.rycf.gjb.util.PasswordUtil;

@LimitTag
@Controller
@RequestMapping(value="/welcome")
/**
 * 欢迎页面。登陆可见，不控制权限
 * @author Administrator
 */
public class WelcomeController extends BaseController{
	
	@Resource
	private SystemUserService systemUserService;
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		return "welcome";
	}
	@RequestMapping(value="/updatePsw")
	public String updatePsw(HttpServletRequest request,
			HttpServletResponse response, Model model){
		SystemUserDTO systemUserDTO=(SystemUserDTO) request.getSession().getAttribute("user");
		String oldPsw=request.getParameter("oldPsw");
		String newPsw=request.getParameter("newPsw");
		if(oldPsw!=null&&newPsw!=null){
			SystemUser systemUser=new SystemUser();
			systemUser.setSystemUserId(systemUserDTO.getSystemUserId());
//			systemUser.setUserName(systemUserDTO.getLoginname());
			systemUser.setPassword(PasswordUtil.encodePsw(oldPsw));
			int count=systemUserService.getCountByParam(systemUser);
			if(count!=0){//验证成功，修改密码
				systemUser.setPassword(newPsw);
				systemUserService.updateSystemUser(systemUser);
				JsonObject jsonObject=new JsonObject();
				jsonObject.setStatus("ok");//修改成功
				model.addAttribute("json", JSONUtil.object2json(jsonObject));
				return "json";
			}
		}
		JsonObject jsonObject=new JsonObject();
		jsonObject.setStatus("no");//修改失败
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}
}
