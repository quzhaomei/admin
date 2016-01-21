package com.rycf.gjb.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.interceptor.LimitTag;

@LimitTag
@Controller
@RequestMapping(value="/send")
/**
 * 发送短信，控制权限
 * @author Administrator
 */
public class SendMsgController extends BaseController{
	
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		return "sendMsg";
	}
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		List<SystemUserDTO> allUser=
				systemUserService.getAllUser();
		model.addAttribute("allUser", allUser);
		return "addMessage";
	}
}
