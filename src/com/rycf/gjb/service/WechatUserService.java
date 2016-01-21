package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.WechatUser;

public interface WechatUserService {
	void saveWechatUser(WechatUser wechatUser);
	void update( WechatUser wechatUser );
	WechatUser getWechatUserByOpenId( String openId);
	WechatUser getWechatUserByGetMoreId(Integer getMoreId);
	PageDTO<List<WechatUser>> getListByParam( PageDTO<WechatUser> page);
	int getCountByParam(PageDTO<WechatUser> page);
}
