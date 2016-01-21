package com.rycf.gjb.dao;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.RoleMenusDTO;
import com.rycf.gjb.entity.RoleMenus;
/**
 * 角色权限中间表
 * @author Administrator
 *
 */
public interface RoleMenusDao {
	void saveRoleMenus(@Param(value = "roleMenus") RoleMenus roleMenus);
	void updateRoleMenus(@Param(value = "roleMenus") RoleMenus roleMenus);
	RoleMenusDTO getRoleMenusById(@Param(value = "roleMenus") RoleMenus roleMenus);
}
