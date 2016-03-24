package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.ThirdChannelDTO;
import com.rycf.gjb.entity.ThirdChannel;
import com.rycf.gjb.entity.WechatUser;

public interface ThirdChannelDao {
	void save(@Param(value = "channel") ThirdChannel channel);
	void update(@Param(value = "channel") ThirdChannel channel);
	ThirdChannelDTO getById(@Param(value = "id") Integer id);
	ThirdChannelDTO getByGetMoreId(@Param(value = "getMoreId") Integer getMoreId);
	ThirdChannelDTO getByCode(@Param(value = "code") String code);
	
	List<ThirdChannelDTO> getByPageAndParam(@Param(value = "page") PageDTO<ThirdChannel> page);
	
	List<ThirdChannelDTO> getListByParam(@Param(value = "channel")ThirdChannel channel);
	int getCountByParam(@Param(value = "channel")ThirdChannel channel);
	
	List<WechatUser> getFriendByChannelId(@Param(value = "channelId")Integer channelId);
	int getFriendCount(@Param(value = "channelId")Integer channelId);
}
