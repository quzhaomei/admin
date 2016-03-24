package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.ThirdChannelDTO;
import com.rycf.gjb.entity.ThirdChannel;
import com.rycf.gjb.entity.WechatUser;

public interface ThirdChannelService {
	void save( ThirdChannel channel);
	void update(ThirdChannel channel);
	ThirdChannelDTO getById( Integer id);
	ThirdChannelDTO getByGetMoreId(Integer getMoreId);
	ThirdChannelDTO getByCode(String code);
	
	PageDTO<List<ThirdChannelDTO>> getByPageAndParam( PageDTO<ThirdChannel> page);
	List<ThirdChannelDTO> getList( ThirdChannel channel);
	
	int getCountByParam(ThirdChannel channel);
	
	List<WechatUser> getFriendByChannelId(Integer channelId);
	int getFriendCount(Integer channelId);
}
