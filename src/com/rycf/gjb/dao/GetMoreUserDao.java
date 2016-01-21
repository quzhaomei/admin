package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.GetMoreUserDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.GetMoreUser;

public interface GetMoreUserDao {
	void saveGetMoreUser(@Param(value="user")GetMoreUser user);
	void updateGetMoreUser(@Param(value="user")GetMoreUser user);
	int getCountByParam(@Param(value="user")GetMoreUser user);
	
	GetMoreUserDTO getUserByParam(@Param(value="user")GetMoreUser user);
	List<GetMoreUserDTO> getUsersByParam(@Param(value="user")GetMoreUser user);
	List<GetMoreUserDTO> getUsersByPage(@Param(value="page")PageDTO<GetMoreUser> page);
	
}
