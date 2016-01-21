package com.rycf.gjb.controller.admin;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.entity.minisite.NineteenActivity;
import com.rycf.gjb.interceptor.LimitTag;
/**
 * 品牌controller
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/active")
@LimitTag
public class ActiveController extends BaseController{
	//19家活动，type=0
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		List<NineteenActivity> result=nineteenActivityService.getNineteenActivityByType(0);
		model.addAttribute("result", result);
		return "minisite/nineteen";
	}
	
	//年底活动，type=1
	@RequestMapping(value="/index_2")
	public String index2(HttpServletRequest request,
			HttpServletResponse response, Model model){
		List<NineteenActivity> result=nineteenActivityService.getNineteenActivityByType(1);
		model.addAttribute("result", result);
		model.addAttribute("activename", "年底活动");
		return "minisite/nineteen_2";
	}
	
}
