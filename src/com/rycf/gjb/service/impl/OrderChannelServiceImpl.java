package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rycf.gjb.dao.OrderChannelDao;
import com.rycf.gjb.dto.OrderDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.Order;
import com.rycf.gjb.entity.OrderChannel;
import com.rycf.gjb.service.OrderChannelService;
@Service
@Transactional
public class OrderChannelServiceImpl implements OrderChannelService {
	@Resource
	private OrderChannelDao dao;
	@Override
	public void save(OrderChannel temp) {
		dao.save(temp);
	}
	@Override
	public PageDTO<List<OrderDTO>> getOrderByPageAndParam(PageDTO<Order> page,
			Integer channelId) {
		PageDTO<List<OrderDTO>> result=new PageDTO<List<OrderDTO>>();
		List<OrderDTO> list=dao.getOrderByChannelIdAndPage(page, channelId);
		result.setParam(list);
		result.setPageIndex(page.getPageIndex());
		result.setPageSize(page.getPageSize());
		
		int total=dao.getCountByChannelId(channelId);
		total=total%page.getPageSize()==0?total/page.getPageSize():total/page.getPageSize()+1;
		result.setTotalPage(total);
		return result;
	}
	@Override
	public float getPayedCount(@Param("channelId") Integer channelId) {
		return dao.getPayedCount(channelId);
	}
	@Override
	public float getUnPayedCount(@Param("channelId") Integer channelId) {
		return dao.getUnPayedCount(channelId);
	}
	@Override
	public void batchPayed(Integer channelId) {
		dao.batchPayed(channelId);
	}
	@Override
	public int getCount(Integer channelId) {
		return dao.getCountByChannelId(channelId);
	}
	@Override
	public PageDTO<List<OrderDTO>> getOrderByChannelIdAndPageForRead(
			PageDTO<Order> page, Integer channelId) {
		PageDTO<List<OrderDTO>> result=new PageDTO<List<OrderDTO>>();
		List<OrderDTO> list=dao.getOrderByChannelIdAndPageForRead(page, channelId);
		result.setParam(list);
		result.setPageIndex(page.getPageIndex());
		result.setPageSize(page.getPageSize());
		
		int total=dao.getCountByChannelIdForRead(channelId);
		total=total%page.getPageSize()==0?total/page.getPageSize():total/page.getPageSize()+1;
		result.setTotalPage(total);
		return result;
	}
	@Override
	public int getCountByChannelIdForRead(PageDTO<Order> page, Integer channelId) {
		return dao.getCountByChannelIdForRead(channelId);
	}

}
