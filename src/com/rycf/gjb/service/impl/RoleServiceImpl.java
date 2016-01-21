package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.RoleDao;
import com.rycf.gjb.dao.SystemUserDao;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.RoleManager;
import com.rycf.gjb.service.RoleService;
import com.rycf.gjb.util.UuidUtils;

/**
 * 
 * @author qzm
 *
 * @since 2015-6-11
 */
@Service
public class RoleServiceImpl implements RoleService{
	@Resource
	private RoleDao roleDao;
	@Resource
	private SystemUserDao systemUserDao;
	@Override
	public void saveRole(RoleManager roleManager) {
		roleManager.setRoleId(UuidUtils.getObjectUUID("role"));
		roleDao.saveRole(roleManager);
	}

	@Override
	public void updateRole(RoleManager roleManager) {
		roleDao.updateRole(roleManager);
	}

	@Override
	public RoleManagerDTO getRoleById(String id) {
		return roleDao.getRoleById(id);
	}

	@Override
	public PageDTO<List<RoleManagerDTO>> getRoleByPageAndParam(PageDTO<RoleManager> page) {
		PageDTO<List<RoleManagerDTO>> result=new PageDTO<List<RoleManagerDTO>>();
		int count =roleDao.getCountByParam(new RoleManager());
		result.setParam(roleDao.getRoleByPageAndParam(page));//封装数据
		result.setPageIndex(page.getPageIndex());
		result.setPageSize(page.getPageSize());
		result.setTotalPage(count%page.getPageSize()==0?count/page.getPageSize():count/page.getPageSize()+1);
		for(RoleManagerDTO role:result.getParam()){
			if(role.getCreateUser()!=null&&role.getCreateUser().getSystemUserId()!=null){
				SystemUserDTO createUser=systemUserDao.getSystemUserById(role.getCreateUser().getSystemUserId());
				role.setCreateUser(createUser);
			}
			if(role.getUpdateUser()!=null&&role.getUpdateUser().getSystemUserId()!=null){
				SystemUserDTO updateUser=systemUserDao.getSystemUserById(role.getUpdateUser().getSystemUserId());
				role.setUpdateUser(updateUser);
			}
			
		}
		return result;
	}

	@Override
	public int getCountByParam(RoleManager roleManager) {
		return roleDao.getCountByParam(roleManager);
	}

	@Override
	public List<RoleManagerDTO> getAllRole() {
		return roleDao.getAllRole();
	}

}
