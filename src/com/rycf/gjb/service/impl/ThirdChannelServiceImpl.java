package com.rycf.gjb.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rycf.gjb.dao.ThirdChannelDao;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.ThirdChannelDTO;
import com.rycf.gjb.entity.ThirdChannel;
import com.rycf.gjb.entity.WechatUser;
import com.rycf.gjb.service.ThirdChannelService;
import com.rycf.gjb.util.UuidUtils;

@Service
@Transactional
public class ThirdChannelServiceImpl implements ThirdChannelService {
	@Resource
	private ThirdChannelDao channelDao;

	@Override
	public void save(ThirdChannel channel) {
		if(channel.getParentName()!=null){//保存新建的
			ThirdChannel parent=new ThirdChannel();
			parent.setName(channel.getParentName());
			parent.setStatus(0);
			parent.setGetMoreId(channel.getGetMoreId());
			parent.setCreateDate(new Date());
			parent.setIsCompany(1);
			parent.setJob("");//公司
			parent.setType(0);
			parent.setRate(0.01f);//初始化为0.01
			channelDao.save(parent);
			
			channel.setParentId(parent.getId());
		}
		ThirdChannel tcode=new ThirdChannel();//生成随机码
		tcode.setCode(UuidUtils.getSixCode());
		while(channelDao.getCountByParam(tcode)>0){
			tcode.setCode(UuidUtils.getSixCode());
		}
		channel.setCode(tcode.getCode());
		channelDao.save(channel);
	}

	@Override
	public void update(ThirdChannel channel) {
		if(channel!=null)
		channelDao.update(channel);
	}

	@Override
	public ThirdChannelDTO getById(Integer id) {
		if(id!=null)
			return channelDao.getById(id);
		return null;
	}

	@Override
	public PageDTO<List<ThirdChannelDTO>> getByPageAndParam(
			PageDTO<ThirdChannel> page) {
		List<ThirdChannelDTO> resultList = channelDao.getByPageAndParam(page);
		PageDTO<List<ThirdChannelDTO>> result = new PageDTO<List<ThirdChannelDTO>>();
		result.setParam(resultList);
		result.setPageIndex(page.getPageIndex());
		result.setPageSize(page.getPageSize());
		
		
		int count = channelDao.getCountByParam(page.getParam());
		count = (count % page.getPageSize() == 0 ? count / page.getPageSize()
				: count / page.getPageSize() + 1);
		result.setTotalPage(count);
		return result;
	}

	@Override
	public int getCountByParam(ThirdChannel channel) {
		return channelDao.getCountByParam(channel);
	}

	@Override
	public List<ThirdChannelDTO> getList(ThirdChannel channel) {
		return channelDao.getListByParam(channel);
	}

	@Override
	public ThirdChannelDTO getByGetMoreId(Integer getMoreId) {
		return channelDao.getByGetMoreId(getMoreId);
	}

	@Override
	public List<WechatUser> getFriendByChannelId(Integer channelId) {
		return channelDao.getFriendByChannelId(channelId);
	}

	@Override
	public int getFriendCount(Integer channelId) {
		return channelDao.getFriendCount(channelId);
	}

	@Override
	public ThirdChannelDTO getByCode(String code) {
		return channelDao.getByCode(code);
	}

}
