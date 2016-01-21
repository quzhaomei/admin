package com.rycf.gjb.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.SystemUser;

public interface SystemUserService {
	/**
	 * 新增用户
	 * @param systemUser
	 */
	void saveSystemUser(@Param(value="systemUser")SystemUser systemUser) throws Exception;
	/**
	 * 更新用户
	 * @param systemUser
	 */
	void updateSystemUser(@Param(value="systemUser")SystemUser systemUser);
	/**
	 * 根据ID获取用户
	 * @param id
	 * @return
	 */
	SystemUserDTO getSystemUserById(@Param(value="id")String id);
	/**
	 * 根据用户名以及密码获取用户
	 */
	SystemUserDTO getUserByParam(@Param(value="systemUser")SystemUser systemUser);
	/**
	 * 分页获取用户信息
	 */
	PageDTO<List<SystemUserDTO>> getUserByPage(@Param(value="page")PageDTO<SystemUser> page);
	
	List<SystemUserDTO> getAllUser();
	/**
	 * 根据条件获取总用户数目
	 */
	int getCountByParam(@Param(value="systemUser")SystemUser systemUser);
	
}
