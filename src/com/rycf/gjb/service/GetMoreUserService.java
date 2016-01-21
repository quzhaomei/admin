package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.GetMoreUserDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.GetMoreUser;

public interface GetMoreUserService{
	void saveGetMoreUser(GetMoreUser user);
	void updateGetMoreUser(GetMoreUser user);
	int getCountByParam(GetMoreUser user);
	
	GetMoreUserDTO getUserById(Integer getMoreId);
	GetMoreUserDTO getUserByParam(GetMoreUser user);
	List<GetMoreUserDTO> getUsersByParam(GetMoreUser user);
	PageDTO<List<GetMoreUserDTO>> getUsersByPage(PageDTO<GetMoreUser> page);
}
