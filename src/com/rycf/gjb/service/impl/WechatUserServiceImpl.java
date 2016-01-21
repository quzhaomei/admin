package com.rycf.gjb.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.WechatUserDao;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.WechatUser;
import com.rycf.gjb.service.WechatUserService;
@Service
public class WechatUserServiceImpl implements WechatUserService {
	@Resource
	private WechatUserDao wechatUserDao;
	@Override
	public void saveWechatUser(WechatUser wechatUser) {
		wechatUser.setCreateDate(new Date());
		wechatUserDao.saveWechatUser(wechatUser);
	}

	@Override
	public WechatUser getWechatUserByOpenId(String openId) {
		if(openId==null)
			return null;
		return wechatUserDao.getWechatUserByOpenId(openId);
	}

	@Override
	public PageDTO<List<WechatUser>> getListByParam(PageDTO<WechatUser> page) {
		PageDTO<List<WechatUser>> result=new PageDTO<List<WechatUser>>();
		result.setPageIndex(page.getPageIndex());
		result.setPageSize(page.getPageSize());
		int count=wechatUserDao.getCountByParam(page);
		int totalPage=1;
		totalPage=count%page.getPageSize()==0?count/page.getPageSize():count/page.getPageSize()+1;
		result.setTotalPage(totalPage);
		List<WechatUser> dateList=wechatUserDao.getListByParam(page);
		result.setParam(dateList);
		return result;
	}

	@Override
	public int getCountByParam(PageDTO<WechatUser> page) {
		return wechatUserDao.getCountByParam(page);
	}

	@Override
	public void update(WechatUser wechatUser) {
		wechatUserDao.updateWechatUser(wechatUser);
	}

	@Override
	public WechatUser getWechatUserByGetMoreId(Integer getMoreId) {
		if(getMoreId==null)
			return null;
		return wechatUserDao.getWechatUserByGetMoreId(getMoreId);
	}
}
