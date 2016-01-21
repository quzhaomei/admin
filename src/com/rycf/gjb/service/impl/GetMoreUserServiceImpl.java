package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.GetMoreUserDao;
import com.rycf.gjb.dto.GetMoreUserDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.GetMoreUser;
import com.rycf.gjb.service.GetMoreUserService;
@Service
public class GetMoreUserServiceImpl implements GetMoreUserService {
	@Resource
	private GetMoreUserDao getMoreUserDao;
	@Override
	public void saveGetMoreUser(GetMoreUser user) {
		getMoreUserDao.saveGetMoreUser(user);
	}

	@Override
	public void updateGetMoreUser(GetMoreUser user) {
		getMoreUserDao.updateGetMoreUser(user);
	}
	@Override
	public GetMoreUserDTO getUserById(Integer getMoreId) {
		if(getMoreId!=null){
		GetMoreUser user =new GetMoreUser();
		user.setGetMoreId(getMoreId);
		return getMoreUserDao.getUserByParam(user);
		}
		return null;
	}

	@Override
	public int getCountByParam(GetMoreUser user) {
		return getMoreUserDao.getCountByParam(user);
	}

	@Override
	public GetMoreUserDTO getUserByParam(GetMoreUser user) {
		if(user!=null){
			return getMoreUserDao.getUserByParam(user);
		}
		return null;
	}

	@Override
	public List<GetMoreUserDTO> getUsersByParam(GetMoreUser user) {
		return getMoreUserDao.getUsersByParam(user);
	}

	@Override
	public PageDTO<List<GetMoreUserDTO>> getUsersByPage(
			PageDTO<GetMoreUser> page) {
		List<GetMoreUserDTO> data=getMoreUserDao.getUsersByPage(page);
		PageDTO<List<GetMoreUserDTO>> result=new PageDTO<List<GetMoreUserDTO>>();
		result.setPageIndex(page.getPageIndex());
		result.setParam(data);
		result.setPageSize(page.getPageSize());
		int count=getMoreUserDao.getCountByParam(page.getParam());
		count=count%page.getPageSize()==0?count/page.getPageSize():count/page.getPageSize()+1;
		result.setTotalPage(count);
		return result;
	}

	
}
