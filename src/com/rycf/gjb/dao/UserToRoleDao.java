package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.UserToRoleDTO;
import com.rycf.gjb.entity.SystemUser;
import com.rycf.gjb.entity.UserToRole;

/**
 * @author Administrator
 */
public interface UserToRoleDao {
	void batchSave(@Param("user")SystemUser user,@Param("roleIds")List<Integer> roleIds);//��������Ȩ��
	void batchEmpty(@Param("user")SystemUser user);
	void save(UserToRole user);
	void update(UserToRole user);
	List<UserToRoleDTO> getListByParam(UserToRole menu);
	UserToRoleDTO getByParam(UserToRole menut);
	int getCountByParam(UserToRole menu);
}
