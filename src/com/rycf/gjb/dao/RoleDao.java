package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.entity.RoleManager;

public interface RoleDao {
	void saveRole(@Param(value = "roleManager") RoleManager roleManager);
	void updateRole(@Param(value = "roleManager") RoleManager roleManager);
	RoleManagerDTO getRoleById(@Param(value = "id") String id);
	List<RoleManagerDTO> getRoleByPageAndParam(@Param(value = "page") PageDTO<RoleManager> page);
	int getCountByParam(RoleManager roleManager);
	List<RoleManagerDTO> getAllRole();
}
