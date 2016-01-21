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
import com.rycf.gjb.dto.MenuManagerDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.MenuManager;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.JSONUtil;

@Controller
@RequestMapping(value="/menu")
@LimitTag
public class MenuManagerController extends BaseController {
	
	@RequestMapping(value="/index")
	public String menuIndex(HttpServletRequest request,
			HttpServletResponse response, Model model){
		return "menuManager";
	}
	/**
	 * 查找单条或者多条菜单
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list")
	public String menuList(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String menuId=request.getParameter("menuId");
		if(menuId!=null){//如果不为空，则查询单个
			MenuManagerDTO menuDTO=	menuManagerService.getMenuById(menuId);
			model.addAttribute("json", JSONUtil.object2json(menuDTO));
		}else{
		List<MenuManagerDTO> lists=menuManagerService.findAllMenu();
			model.addAttribute("json", JSONUtil.object2json(lists));
		}
		return "json";
	}
	/**
	 * 进行菜单的更新操作
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String menuId=request.getParameter("menuId");
		String menuName=request.getParameter("menuName");
		String url=request.getParameter("url");
		SystemUserDTO sysUser=(SystemUserDTO) request.getSession().getAttribute("user");
		if(url==null||url.trim().equals("")){
			url="#";
		}
		if(menuName!=null){
			menuName=menuName.trim();
		}
		String operator=request.getParameter("operator");//add edit  del
		if(operator!=null){
			MenuManagerDTO parentMenu=menuManagerService.getMenuById(menuId);
			if(parentMenu!=null){//验证父目录是否存在
				if(operator.trim().equals("add")){//增加操作
					
					MenuManager menuManager=new MenuManager();
					menuManager.setCreateDate(new Date());
					menuManager.setCreateUserId(sysUser.getSystemUserId());//管理员操作
					menuManager.setMenuName(menuName);
					menuManager.setStatus("1");//1为有效
					menuManager.setType("1");//-1为系统初始化，不可删除，0，为菜单，1为操作;新建的默认都为操作
					menuManager.setUrl(url);
					menuManager.setParentId(menuId);//设置父级Id；
					menuManagerService.saveMenu(menuManager);
					/**当从一个菜单新建子菜单的时候，需要改变该菜单的type，从操作，变为目录* */
					if(parentMenu.getType().equals("1")){
						MenuManager parent=new MenuManager();
						parent.setMenuId(parentMenu.getMenuId());
						parent.setType("0");
						menuManagerService.updateMenu(parent);
					}
				}else if(operator.trim().equals("edit")){//修改
					MenuManager menuManager=new MenuManager();
					menuManager.setMenuId(menuId);
					menuManager.setMenuName(menuName);
					menuManager.setUrl(url);
					menuManager.setUpdateDate(new Date());
					menuManager.setUpdateUserId(sysUser.getSystemUserId());
					menuManagerService.updateMenu(menuManager);
				}else if(operator.trim().equals("del")){//删除操作
					if(!parentMenu.getType().equals("-1")){//如果不是系统初始化，则可以进行删除操作
						MenuManager menuManager=new MenuManager();
						menuManager.setMenuId(parentMenu.getMenuId());
						menuManager.setStatus("0");//0为删除标志，且不再显示
						menuManager.setUpdateDate(new Date());
						menuManager.setUpdateUserId(sysUser.getSystemUserId());
						menuManagerService.updateMenu(menuManager);
						//更新父菜单，如果没有子菜单了，则更新为操作
						int count=menuManagerService.findMenuByParentId(parentMenu.getParentId());//查询父节点的子节点
						if(count==0){
							MenuManager parent=new MenuManager();
							parent.setMenuId(parentMenu.getParentId());
							parent.setType("1");
							menuManagerService.updateMenu(parent);
						}
					}
				}
			}
		}
		JsonObject jsonObject=new JsonObject();
		jsonObject.setStatus("ok");
		model.addAttribute("json",JSONUtil.object2json(jsonObject));
		return "json";
	}
}
