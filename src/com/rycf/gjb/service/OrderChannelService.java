package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.OrderDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.Order;
import com.rycf.gjb.entity.OrderChannel;

public interface OrderChannelService {
	void save(OrderChannel temp);
	PageDTO<List<OrderDTO>> getOrderByPageAndParam(PageDTO<Order> page,Integer channelId);
	
	PageDTO<List<OrderDTO>> getOrderByChannelIdAndPageForRead(PageDTO<Order> page,Integer channelId);
	int getCountByChannelIdForRead(PageDTO<Order> page,Integer channelId);
	
	float getPayedCount(Integer channelId);
	float getUnPayedCount(Integer channelId);
	int getCount(Integer channelId);
	
	void batchPayed(Integer channelId);
}
