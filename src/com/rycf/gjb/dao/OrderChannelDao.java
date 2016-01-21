package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.OrderDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.Order;
import com.rycf.gjb.entity.OrderChannel;

public interface OrderChannelDao {
	void save(@Param(value = "temp") OrderChannel temp);
	List<OrderDTO> getOrderByChannelIdAndPage(@Param(value = "page") PageDTO<Order> page,
			@Param(value = "channelId")Integer channelId);
	int getCountByChannelId(@Param(value = "channelId")Integer channelId);
	
	float getPayedCount(@Param(value = "channelId")Integer channelId);
	float getUnPayedCount(@Param(value = "channelId")Integer channelId);
	
	void batchPayed(@Param(value = "channelId")Integer channelId);
	
	int getCountByChannelIdForRead(@Param(value = "channelId")Integer channelId);
	List<OrderDTO> getOrderByChannelIdAndPageForRead(@Param(value = "page") PageDTO<Order> page,
			@Param(value = "channelId")Integer channelId);
}
