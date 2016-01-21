package com.rycf.gjb.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rycf.gjb.dao.MenuManagerDao;
import com.rycf.gjb.dao.RoleDao;
import com.rycf.gjb.dao.SystemUserDao;
import com.rycf.gjb.dto.MenuManagerDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.SystemUser;
import com.rycf.gjb.service.SystemUserService;
import com.rycf.gjb.util.UuidUtils;

@Service
@Transactional
public class SystemUserServiceImpl implements SystemUserService {
	@Resource
	private SystemUserDao systemUserDao;
	
	@Resource
	private RoleDao roleDao;
	
	
	@Resource
	private MenuManagerDao menuManagerDao;
	@Override
	public void saveSystemUser(SystemUser systemUser) {
		systemUser.setSystemUserId(UuidUtils.getObjectUUID("user"));
		systemUserDao.saveSystemUser(systemUser);
		//保存角色
		
	}

	@Override
	public void updateSystemUser(SystemUser systemUser) {
		systemUserDao.updateSystemUser(systemUser);
	}

	@Override
	public PageDTO<List<SystemUserDTO>> getUserByPage(PageDTO<SystemUser> page) {
		List<SystemUserDTO> resultList = systemUserDao.getUserByPage(page);
		PageDTO<List<SystemUserDTO>> result = new PageDTO<List<SystemUserDTO>>();
		result.setParam(resultList);
		result.setPageIndex(page.getPageIndex());
		result.setPageSize(page.getPageSize());
		
		for(SystemUserDTO temp:result.getParam()){//初始化角色
			if(temp.getRolesArrStr()!=null){
				List<RoleManagerDTO> roleList=new ArrayList<RoleManagerDTO>();
				String[]roleIdArr=temp.getRolesArrStr().split(",");
				for(String roleId: roleIdArr){
					RoleManagerDTO roleDTO= roleDao.getRoleById(roleId);
					if(roleDTO!=null){
						roleList.add(roleDTO);
					}
				}
				temp.setRolesArr(roleList);
			}
		}
		
		int count = systemUserDao.getCountByParam(page.getParam());
		count = (count % page.getPageSize() == 0 ? count / page.getPageSize()
				: count / page.getPageSize() + 1);
		result.setTotalPage(count);
		return result;
	}

	@Override
	public int getCountByParam(SystemUser systemUser) {
		return systemUserDao.getCountByParam(systemUser);
	}

	@Override
	public SystemUserDTO getSystemUserById(String id) {
		SystemUserDTO result = systemUserDao.getSystemUserById(id);
		List<RoleManagerDTO> list = new ArrayList<RoleManagerDTO>();
		if (result!=null&&result.getRolesArrStr() != null) {
			for (String str : result.getRolesArrStr().split(",")) {
				RoleManagerDTO roleManagerDTO = new RoleManagerDTO();
				roleManagerDTO.setRoleId(str);
				list.add(roleManagerDTO);
			}
		}
		result.setRolesArr(list);
		return result;
	}

	@Override
	public SystemUserDTO getUserByParam(SystemUser systemUser) {
		SystemUserDTO result=systemUserDao.getUserByParam(systemUser);
			if(result!=null&&result.getRolesArrStr()!=null){//绑定角色
				List<RoleManagerDTO> roleList=new ArrayList<RoleManagerDTO>();
				String[]roleIdArr=result.getRolesArrStr().split(",");
				for(String roleId: roleIdArr){
					RoleManagerDTO roleDTO= roleDao.getRoleById(roleId);
					if(roleDTO!=null){
						roleList.add(roleDTO);
					}
				}
				result.setRolesArr(roleList);
				//绑定菜单
				Map<String,MenuManagerDTO> userMenuList=new HashMap<String,MenuManagerDTO>();
				for(RoleManagerDTO roleManagerDTO:roleList){
					List<MenuManagerDTO>  roleMenuList=menuManagerDao.findMenuByRole(roleManagerDTO.getRoleId());
					
					for(MenuManagerDTO temp:roleMenuList){
						if("1".equals(temp.getHasPower())){//有权限的菜单
							userMenuList.put(temp.getMenuId(), temp);//以ID为key放入map
							String uri=temp.getUrl();
							if(uri.indexOf("/")!=-1){
							userMenuList.put(uri.substring(uri.indexOf("/")+1), temp);
							}
						}
					}
				}
				result.setMenuList(userMenuList);
			}
		return result;
	}

	@Override
	public List<SystemUserDTO> getAllUser() {
		List<SystemUserDTO> resultList = systemUserDao.getAllUser();
		
		for(SystemUserDTO temp:resultList){//初始化角色
			if(temp.getRolesArrStr()!=null){
				List<RoleManagerDTO> roleList=new ArrayList<RoleManagerDTO>();
				String[]roleIdArr=temp.getRolesArrStr().split(",");
				for(String roleId: roleIdArr){
					RoleManagerDTO roleDTO= roleDao.getRoleById(roleId);
					if(roleDTO!=null){
						roleList.add(roleDTO);
					}
				}
				temp.setRolesArr(roleList);
			}
		}
		return resultList;
	}
}
