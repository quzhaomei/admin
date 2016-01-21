package com.rycf.gjb.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.entity.RoleManager;

/**
 * 角色服务类
 * @author qzm
 *
 * @since 2015-6-11
 */
public interface RoleService {
	void saveRole(@Param(value = "roleManager") RoleManager roleManager);
	void updateRole(@Param(value = "roleManager") RoleManager roleManager);
	RoleManagerDTO getRoleById(@Param(value = "id") String id);
	PageDTO<List<RoleManagerDTO>> getRoleByPageAndParam(@Param(value = "page") PageDTO<RoleManager> page);
	int getCountByParam(RoleManager roleManager);
	List<RoleManagerDTO> getAllRole();
}
