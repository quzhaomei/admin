package com.rycf.gjb.controller.admin;


import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.dto.ThirdChannelDTO;
import com.rycf.gjb.dto.ThirdGuideDTO;
import com.rycf.gjb.entity.ThirdChannel;
import com.rycf.gjb.entity.ThirdGuide;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.JSONUtil;
/**
 * 导购
 * @author Administrator
 */
@Controller
@RequestMapping(value="/guide")
@LimitTag
public class GuideController extends BaseController{
	@RequestMapping(value="/list")
	public String getRoleList(HttpServletRequest request,
			HttpServletResponse response, Model model){
		
		String tempId=request.getParameter("tempId");
		String operator=request.getParameter("operator");
		JsonObject json=new JsonObject();
		if(operator!=null&&tempId!=null&&tempId.matches("\\d+")){
			ThirdChannelDTO channel=channelService.getById(Integer.parseInt(tempId));
			json.setStatus("1").setData(channel);
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		SystemUserDTO sysUser=(SystemUserDTO) request.getSession().getAttribute("user");
		String pageIndex=request.getParameter("pageIndex");
		String pageSize=request.getParameter("pageSize");
		if(pageIndex==null){
			pageIndex="1";
		}
		if(pageSize==null){
			pageSize="7";
		}
		boolean isSuper=false;//超级管理员
		boolean isGetMore=false;
		boolean isBrand=false;//品牌管理员
		boolean isStore=false;//店长
		for(RoleManagerDTO role:sysUser.getRolesArr()){
			if(superId.equals(role.getRoleId())){
				isSuper=true;
			}
			if(getMoreId.equals(role.getRoleId())){
				isGetMore=true;
			}
			if(brandRoleId.equals(role.getRoleId())){
				isBrand=true;
			}
			if(storeId.equals(role.getRoleId())){
				isStore=true;
			}
		}
		PageDTO<ThirdGuide> page=new PageDTO<ThirdGuide>();
		page.setPageIndex(Integer.parseInt(pageIndex.trim()));
		page.setPageSize(Integer.parseInt(pageSize.trim()));
		ThirdGuide param=new ThirdGuide();
		page.setParam(param);
		PageDTO<List<ThirdGuideDTO>> result= null;
		//凯特猫超级管理员能查看所有的，但是不能修改，
		if(isGetMore||isSuper){
			result=thirdGuideService.getByPageAndParam(page);
			
		}else if(isBrand||isStore){//品牌管理员能查看本品牌所有店铺的导购，能修改，
			param.setUserId(sysUser.getSystemUserId());
			result=thirdGuideService.getByPageAndParam(page);
		}
		
		model.addAttribute("pageResult", result);
		return "guide";
	}
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		SystemUserDTO sysUser = (SystemUserDTO) request.getSession()
				.getAttribute("user");
		String operator=request.getParameter("operator");
		String tempId = request.getParameter("tempId");
		String status = request.getParameter("status");
		
		JsonObject jsonObject = new JsonObject();
		if (operator != null) {
			if (operator.equals("update")) {
				if (tempId != null && tempId.matches("\\d+")
						&& (status == null || status.matches("[012]"))
						) {
					ThirdGuide guide=new ThirdGuide();
					guide.setGuideId(Integer.parseInt(tempId));
					if(status!=null)
						guide.setStatus(Integer.parseInt(status));
					try {
						thirdGuideService.update(guide);
						jsonObject.setStatus("1");
						jsonObject.setMessage("更新成功");
					} catch (Exception e) {
						e.printStackTrace();
						jsonObject.setStatus("0");
						jsonObject.setMessage("更新失败："+e.getMessage());
					}
				}
			}else if("findById".equals(operator)){
				if (tempId != null && tempId.matches("\\d+")){
					
				}
			}
		} else {
			jsonObject.setStatus("0");
			jsonObject.setMessage("数据缺失");
		}

		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}
	
}
