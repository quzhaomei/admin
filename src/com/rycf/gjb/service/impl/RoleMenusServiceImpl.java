package com.rycf.gjb.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.RoleMenusDao;
import com.rycf.gjb.dto.RoleMenusDTO;
import com.rycf.gjb.entity.RoleMenus;
import com.rycf.gjb.service.RoleMenusService;
import com.rycf.gjb.util.UuidUtils;

@Service
public class RoleMenusServiceImpl implements RoleMenusService{
	@Resource
	private RoleMenusDao roleMenusDao;
	@Override
	public void saveOrUpdateRoleMenus(RoleMenus roleMenus) {
		RoleMenusDTO result=roleMenusDao.getRoleMenusById(roleMenus);//如果为空，则保存
		if(result==null){//保存，
			roleMenus.setRoleMenusId(UuidUtils.getObjectUUID("roleMenus"));
			roleMenusDao.saveRoleMenus(roleMenus);
		}else{//修改
			roleMenusDao.updateRoleMenus(roleMenus);
		}
	}

	@Override
	public RoleMenusDTO getRoleMenusByMenuIdAndRoleId(RoleMenus roleMenus) {
		return roleMenusDao.getRoleMenusById(roleMenus);
	}
	
}
