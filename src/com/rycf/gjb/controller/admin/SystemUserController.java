package com.rycf.gjb.controller.admin;

import java.io.IOException;
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
import com.rycf.gjb.entity.SystemUser;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.JSONUtil;
import com.rycf.gjb.util.PasswordUtil;

@Controller
@RequestMapping(value="/user")
@LimitTag
public class SystemUserController extends BaseController {
	@RequestMapping(value="/index")
	public String menuIndex(HttpServletRequest request,
			HttpServletResponse response, Model model){
		//查找所有角色
		List<RoleManagerDTO> roleList=roleService.getAllRole();
		model.addAttribute("roles", roleList);
		String pageIndex=request.getParameter("pageIndex");//页面
		String pageSize=request.getParameter("pageSize");//页数量
		String roleId=request.getParameter("roleId");//角色ID
		if(pageIndex==null||!pageIndex.matches("\\d+")){
			pageIndex="1";
		}
		if(pageSize==null||!pageSize.matches("\\d+")){
			pageSize="10";
		}
		
		SystemUser user=new SystemUser();
		PageDTO<SystemUser> pageParam=new PageDTO<SystemUser>();
		if(roleId!=null&&!roleId.equals("-1")){
			user.setRolesArrStr(roleId);
			model.addAttribute("roleId", roleId);
		}
		pageParam.setParam(user);
		
		pageParam.setPageIndex(Integer.parseInt(pageIndex));
		pageParam.setPageSize(Integer.parseInt(pageSize));
		
		PageDTO<List<SystemUserDTO>> pageResult=
				systemUserService.getUserByPage(pageParam);
		//分页获取用户
		
		model.addAttribute("pageResult", pageResult);
		return "userManager";
	}
	/**
	 * 查找所有用户
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list")
	public String menuList(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String phone=request.getParameter("phone");
		String loginname=request.getParameter("loginname");
		String type=request.getParameter("type");//check remote验证
		String userId=request.getParameter("userId");
		
		if("check".equals(type)){//远程验证
			SystemUser systemUser=new SystemUser();
			systemUser.setPhone(phone);
			systemUser.setLoginname(loginname);
			int count=systemUserService.getCountByParam(systemUser);
			if(count==0){
				try {
					response.getWriter().write("true");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}else{
				try {
					response.getWriter().write("false");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			return null;
		}else if("get".equals(type)&&userId!=null){//如果是获取单个数据
			SystemUserDTO systemUser=systemUserService.getSystemUserById(userId);
			JsonObject json=new JsonObject();
			json.setData(systemUser);
			json.setStatus("ok");
			model.addAttribute("json", JSONUtil.object2json(json));
			return "json";
		}
		return null;
	}
	/**
	 * 进行用户的更新
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		SystemUserDTO sysUser=(SystemUserDTO) request.getSession().getAttribute("user");
		String operator=request.getParameter("operator");
		JsonObject jsonObject=new JsonObject();
		if("add".equals(operator)){//增加
			String userName=request.getParameter("userName");
			String rolesArrStr=request.getParameter("rolesArrStr");
			String loginName=request.getParameter("loginName");
			String phone=request.getParameter("phone");
			String email=request.getParameter("email");
			String description=request.getParameter("description");
			String wechatId=request.getParameter("wechatId");
			SystemUser user=new SystemUser();
			user.setLoginname(loginName);//登录名
			user.setUserName(userName);//真实姓名
			user.setPhone(phone);//电话号码
			user.setEmail(email==null?"":email);//email
			user.setWechatId(wechatId);
			user.setDescription(description==null?"":description);//备注
			user.setRolesArrStr(rolesArrStr==null?"":rolesArrStr);//角色
			user.setCreateDate(new Date());
			user.setCreateUserId(sysUser.getSystemUserId());
			user.setStatus("1");//设置为有效状态
			user.setPassword(PasswordUtil.encodePsw(phone));//初始化为电话号码，并加密
			try {
				systemUserService.saveSystemUser(user);
				jsonObject.setStatus("ok").setMessage("添加用户成功");
			} catch (Exception e) {
				e.printStackTrace();
				jsonObject.setStatus("no").setMessage("添加用户时，出现异常："+e.getMessage());
			}
		}else if("update".equals(operator)){//修改，或删除
			String systemUserId=request.getParameter("systemUserId");//ID
			String rolesArrStr=request.getParameter("rolesArrStr");//权限
			String userName=request.getParameter("userName");//真实姓名
			String email=request.getParameter("email");//email
			String description=request.getParameter("description");//备注
			String status=request.getParameter("status");//状态
			String wechatId=request.getParameter("wechatId");
			String phone=request.getParameter("phone");
			String loginname=request.getParameter("loginname");
			SystemUser param=new SystemUser();
			param.setSystemUserId(systemUserId);
			param.setRolesArrStr(rolesArrStr);
			param.setUserName(userName);
			param.setLoginname(loginname);
			param.setPhone(phone);
			param.setEmail(email);
			param.setUpdateDate(new Date());
			param.setUpdateUserId(sysUser.getSystemUserId());
			param.setDescription(description);
			param.setStatus(status);
			param.setWechatId(wechatId);
			systemUserService.updateSystemUser(param);
			jsonObject.setStatus("ok").setMessage("更新用户成功");
		}else if("reset".equals(operator)){//重置密码
			String systemUserId=request.getParameter("systemUserId");//ID
			SystemUserDTO systemUserDTO= systemUserService.getSystemUserById(systemUserId);
			if(systemUserDTO!=null){
				String password=PasswordUtil.encodePsw( systemUserDTO.getPhone());//初始化为电话号码，并加密
				SystemUser systemUser=new SystemUser();
				systemUser.setSystemUserId(systemUserId);
				systemUser.setPassword(password);
				systemUser.setUpdateDate(new Date());
				systemUser.setUpdateUserId(sysUser.getSystemUserId());
				systemUserService.updateSystemUser(systemUser);
				jsonObject.setStatus("ok").setMessage("重置密码成功");
			}
		}
	
		
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}
}
