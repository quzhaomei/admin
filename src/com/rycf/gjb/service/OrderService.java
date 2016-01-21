package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.OrderDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.Order;

public interface OrderService {
	void saveOrder(Order order);
	List<OrderDTO> getOrderByGetMoreId(Integer getMoreId);
	OrderDTO getOrderById(String id);
	void updateOrder( Order order);
	int getCountByParam(Order order);
	PageDTO<List<OrderDTO>> getOrderByPageAndParam(PageDTO<Order> page);
	
	List<OrderDTO> getAllOrder();
	
	int getUserTotalPay(Integer getMoreId);
}
