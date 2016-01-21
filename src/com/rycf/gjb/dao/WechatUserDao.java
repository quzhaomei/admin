package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.WechatUser;

public interface WechatUserDao {
	void saveWechatUser(@Param(value="wechatUser")WechatUser wechatUser);
	void updateWechatUser(@Param(value="wechatUser")WechatUser wechatUser);
	WechatUser getWechatUserByOpenId(@Param(value="openId") String openId);
	WechatUser getWechatUserByGetMoreId(@Param(value="getMoreId") Integer getMoreId);
	List<WechatUser> getListByParam(@Param(value="page") PageDTO<WechatUser> page);
	int getCountByParam(@Param(value="page") PageDTO<WechatUser> page);
}
