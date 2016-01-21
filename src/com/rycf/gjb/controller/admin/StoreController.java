package com.rycf.gjb.controller.admin;


import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.BrandDTO;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.dto.StoreDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.Store;
import com.rycf.gjb.entity.SystemUser;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.JSONUtil;
import com.rycf.gjb.util.MapUtil;
import com.rycf.gjb.util.PasswordUtil;
/**
 * 品牌controller
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/store")
@LimitTag
public class StoreController extends BaseController{
	@RequestMapping(value="/list")
	public String getRoleList(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String storeId=request.getParameter("storeId");
		StoreDTO storeDTO=storeService.getStoreByStoreId(storeId);
		model.addAttribute("json", JSONUtil.object2json(storeDTO));
		return "json";
	}
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String address=request.getParameter("address");
		String phone=request.getParameter("phone");
		if(phone!=null){
			SystemUser systemUser=new SystemUser();
			systemUser.setPhone(phone);
			SystemUserDTO user=systemUserService.getUserByParam(systemUser);
			JsonObject jsonObject=new JsonObject();
			jsonObject.setData(user);
			if(user!=null)
				jsonObject.setStatus("1");//已经存在
			else
				jsonObject.setStatus("0");//不存在
			model.addAttribute("json", JSONUtil.object2json(jsonObject));
			return "json";
		}else if(address!=null){
			String json=MapUtil.getLngAndLat(address);
			model.addAttribute("json", json);
			return "json";
		}
		SystemUserDTO sysUser=(SystemUserDTO) request.getSession().getAttribute("user");
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
		List<StoreDTO> storeList=null;
		if(isSuper||isGetMore){
			storeList=storeService.getAllStores();
		}else if(isBrand||isStore){
			storeList=storeService.getStoreByUserId(sysUser.getSystemUserId());
		}
		model.addAttribute("permit", isSuper||isGetMore);
		List<BrandDTO> brands=brandService.getAllBrand();
		model.addAttribute("stores", storeList);
		model.addAttribute("brands", brands);
		return "storeManager";
	}
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String storeId=request.getParameter("storeId");
		String storeName=request.getParameter("storeName");
		String brandId=request.getParameter("brandId");
		String address=request.getParameter("address");
		String lng=request.getParameter("lng");
		String lat=request.getParameter("lat");
		String phone=request.getParameter("phone");
		String doorCode=request.getParameter("doorCode");
		String username=request.getParameter("username");
		String userId=request.getParameter("userId");
		String wechatId=request.getParameter("wechatId");
		String status=request.getParameter("status");
		
		Store param=new Store();
		param.setStoreName(storeName);
		param.setBrandId(brandId);
		param.setCreateDate(new Date());
		param.setDoorCode(doorCode);
		if(lat!=null){
			param.setLat(Float.parseFloat(lat));
		}
		if(lng!=null){
			param.setLng(Float.parseFloat(lng));
		}
		param.setAddress(address);
		param.setStatus(status);
		String roleId="role143486931360527";//店长ID
		if(storeId!=null){//更新操作
			//更新店铺
			param.setStoreId(storeId);
			if(userId==null){//保存新人，并置为管理员
				if(username!=null&&phone!=null){
					SystemUser paramUser=new SystemUser();
					paramUser.setWechatId(wechatId);
					paramUser.setCreateDate(new Date());
					paramUser.setUserName(username);
					paramUser.setPhone(phone);
					paramUser.setLoginname(phone);
					paramUser.setPassword(PasswordUtil.encodePsw(phone));
					paramUser.setStatus("1");
					paramUser.setRolesArrStr(roleId);
					paramUser.setDescription("店铺创建时初始化~");
					try {
						systemUserService.saveSystemUser(paramUser);
					} catch (Exception e) {
						e.printStackTrace();
					}//保存用户
					param.setKeeperId(paramUser.getSystemUserId());
					
				}
			}else{
				param.setKeeperId(userId);
				
				//更新userId,置为管理员
				SystemUserDTO userDTO=systemUserService.getSystemUserById(userId);
				List<RoleManagerDTO> roles=userDTO.getRolesArr();
				boolean isStoreKeeper=false;
				for(RoleManagerDTO role:roles){
					if(roleId.equals(role.getRoleId())){
						isStoreKeeper=true;
					}
				}
				SystemUser systemUser=new SystemUser();
				systemUser.setSystemUserId(userId);
				systemUser.setUserName(username);
				systemUser.setWechatId(wechatId);
				if(!isStoreKeeper){
					String roleStr=userDTO.getRolesArrStr();
					if(roleStr==null){
						systemUser.setRolesArrStr(roleId);
					}else{
						systemUser.setRolesArrStr(roleStr+","+roleId);
					}
				}
				systemUserService.updateSystemUser(systemUser);
			}
			storeService.updateStore(param);
		}else{
			param.setStatus("1");//新建店铺为激活
			if(userId!=null&&!"".equals(userId)){//角色存在
				//更新该角色
				SystemUserDTO oldUser=systemUserService.getSystemUserById(userId);
				if(oldUser!=null){
					param.setKeeperId(userId);	
					storeService.saveStore(param);
					
					boolean isStoreKeeper=false;
					if(oldUser.getRolesArr()!=null){
						for(RoleManagerDTO temp:oldUser.getRolesArr()){
							if(roleId.equals(temp.getRoleId())){
								isStoreKeeper=true;
							}
						}
					}
					if(!isStoreKeeper){
						SystemUser systemUser=new SystemUser();
						if(oldUser.getRolesArrStr()==null||"".equals(oldUser.getRolesArrStr())){
							systemUser.setRolesArrStr(roleId);
						}else{
							systemUser.setRolesArrStr(oldUser.getRolesArrStr()+","+roleId);
						}
						systemUser.setSystemUserId(userId);
						systemUserService.updateSystemUser(systemUser);
					}
				}
			}else{//新建店长，然后保存
				
				//2.注册该新人
				SystemUser paramUser=new SystemUser();
				paramUser.setWechatId(wechatId);
				paramUser.setCreateDate(new Date());
				paramUser.setUserName(username);
				paramUser.setPhone(phone);
				paramUser.setLoginname(phone);
				paramUser.setPassword(PasswordUtil.encodePsw(phone));
				paramUser.setStatus("1");
				paramUser.setRolesArrStr(roleId);
				paramUser.setDescription("店铺创建时初始化~");
				try {
					systemUserService.saveSystemUser(paramUser);
				} catch (Exception e) {
					e.printStackTrace();
				}//保存用户
				
				userId=paramUser.getSystemUserId();
				param.setKeeperId(userId);	
				storeService.saveStore(param);//保存店铺
			}
		}
		//保存店铺
		JsonObject jsonObject=new JsonObject();
		jsonObject.setStatus("ok");
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}
}
