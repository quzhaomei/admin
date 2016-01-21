package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.OrderDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.Order;

public interface OrderDao {
	void saveOrder(@Param(value="order") Order order);
	void updateOrder(@Param(value="order") Order order);
	List<OrderDTO> getOrderByGetMoreId(@Param(value="getMoreId")Integer getMoreId);
	OrderDTO getOrderById(@Param(value="id")String id);
	int getCountByParam(@Param(value = "order")Order order);
	List<OrderDTO> getOrderByPageAndParam(@Param(value = "page") PageDTO<Order> page);
	
	int getUserTotalPay(@Param(value="getMoreId")Integer getMoreId);
	
	List<OrderDTO> getAllOrder();
}
