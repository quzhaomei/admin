package com.rycf.gjb.service;

import com.rycf.gjb.dto.RoleMenusDTO;
import com.rycf.gjb.entity.RoleMenus;

/**
 * 角色服务类
 * @author qzm
 *
 * @since 2015-6-11
 */
public interface RoleMenusService {
	void saveOrUpdateRoleMenus(RoleMenus roleMenus);
	RoleMenusDTO getRoleMenusByMenuIdAndRoleId(RoleMenus roleMenus);
}
