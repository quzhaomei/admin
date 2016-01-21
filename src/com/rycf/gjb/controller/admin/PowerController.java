package com.rycf.gjb.controller.admin;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.MenuManagerDTO;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.entity.RoleMenus;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.JSONUtil;

@Controller
@RequestMapping(value="/power")
@LimitTag
public class PowerController extends BaseController{
	//查找权限
	@RequestMapping(value="/list")
	public String getRoleList(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String roleId=request.getParameter("roleId");
		List<MenuManagerDTO> resultList=menuManagerService.findMenuByRole(roleId);
		RoleManagerDTO role=roleService.getRoleById(roleId);
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("menuList", resultList);
		map.put("role", role);
		model.addAttribute("json", JSONUtil.object2json(map));
		return "json";
	}
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		//查找所有的未冻结角色，并生成权限树
		List<RoleManagerDTO> allRoles=roleService.getAllRole();
		model.addAttribute("allRoles",allRoles);
		return "powerManager";
	}
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String roleId=request.getParameter("roleId");
		//处理传递过来的参数
		List<RoleMenus> roleMenusList=new ArrayList<RoleMenus>();
		int index=0;
		while(request.getParameter("list["+index+"][menuId]")!=null){
			RoleMenus roleMenu=new RoleMenus();
			roleMenu.setRoleId(roleId);
			roleMenu.setMenuId(request.getParameter("list["+index+"][menuId]"));
			roleMenu.setStatus(request.getParameter("list["+index+"][status]"));
			roleMenusList.add(roleMenu);
			index++;
		}
		for(RoleMenus roleMenus:roleMenusList){
			roleMenusService.saveOrUpdateRoleMenus(roleMenus);
		}
		JsonObject jsonObject=new JsonObject();
		jsonObject.setStatus("ok");
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}
}
