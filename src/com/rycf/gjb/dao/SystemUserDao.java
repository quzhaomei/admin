package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.SystemUser;

/**
 * 系统用户管理
 * @author qzm
 *
 * @since 2015-6-15
 */
public interface SystemUserDao {
	/**
	 * 新增用户
	 * @param systemUser
	 */
	void saveSystemUser(@Param(value="systemUser")SystemUser systemUser);
	/**
	 * 查询用户
	 * @param systemUser
	 */
	SystemUserDTO getSystemUserById(@Param(value="id")String id);
	
	/**
	 * 更新用户
	 * @param systemUser
	 */
	void updateSystemUser(@Param(value="systemUser")SystemUser systemUser);
	/**
	 * 分页获取用户信息
	 */
	List<SystemUserDTO> getUserByPage(@Param(value="page")PageDTO<SystemUser> page);
	/**
	 * 查询所有用户
	 */
	List<SystemUserDTO> getAllUser();
	/**
	 * 根据条件获取总用户数目
	 */
	int getCountByParam(@Param(value="systemUser")SystemUser systemUser);
	/**
	 * 根据用户名以及密码获取用户
	 */
	SystemUserDTO getUserByParam(@Param(value="systemUser")SystemUser systemUser);
}
