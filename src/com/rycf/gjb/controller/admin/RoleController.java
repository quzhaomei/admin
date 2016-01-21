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
import com.rycf.gjb.entity.RoleManager;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.JSONUtil;

@Controller
@RequestMapping(value="/role")
@LimitTag
public class RoleController extends BaseController{
	@RequestMapping(value="/list")
	public String getRoleList(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String roleId=request.getParameter("roleId");
		if(roleId!=null){//如果roleId不为空，表示查询单个
			RoleManagerDTO role=roleService.getRoleById(roleId);
			model.addAttribute("json", JSONUtil.object2json(role));
		}
		return "json";
	}
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String pageIndex=request.getParameter("pageIndex");
		String pageSize=request.getParameter("pageSize");
		if(pageIndex==null){
			pageIndex="1";
		}
		if(pageSize==null){
			pageSize="7";
		}
		PageDTO<RoleManager> page=new PageDTO<RoleManager>();
		page.setPageIndex(Integer.parseInt(pageIndex.trim()));
		page.setPageSize(Integer.parseInt(pageSize.trim()));
		PageDTO<List<RoleManagerDTO>> result= roleService.getRoleByPageAndParam(page);
		model.addAttribute("pageResult", result);
		return "roleManager";
	}
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		SystemUserDTO sysUser=(SystemUserDTO) request.getSession().getAttribute("user");
		String roleId=request.getParameter("roleId");
		String roleName=request.getParameter("roleName");
		String operator=request.getParameter("operator");
		String status=request.getParameter("status");	
		
		if(roleName!=null){
			roleName=roleName.trim();
		}
		if(operator!=null){
			if(operator.equals("add")){
				RoleManager roleManager=new RoleManager();
				roleManager.setRoleName(roleName);
				roleManager.setCreateDate(new Date());
				roleManager.setCreateUserId(sysUser.getSystemUserId());
				roleManager.setStatus("1");//默认是激活状态
				roleService.saveRole(roleManager);
			}else if(operator.equals("update")){
				RoleManager roleManager=new RoleManager();
				roleManager.setRoleId(roleId);
				roleManager.setRoleName(roleName);
				roleManager.setUpdateDate(new Date());
				roleManager.setUpdateUserId(sysUser.getSystemUserId());
				roleManager.setStatus(status);//默认是激活状态
				roleService.updateRole(roleManager);
			}
		}
		JsonObject jsonObject=new JsonObject();
		jsonObject.setStatus("ok");
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}
}
