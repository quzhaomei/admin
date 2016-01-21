package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.OrderDao;
import com.rycf.gjb.dto.OrderDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.Order;
import com.rycf.gjb.service.OrderService;
import com.rycf.gjb.util.UuidUtils;
@Service
public class OrderServiceImpl implements OrderService {
	@Resource
	private OrderDao orderDao;
	@Override
	public void saveOrder(Order order) {
		order.setOrderId(UuidUtils.getObjectUUID("order"));
		orderDao.saveOrder(order);
	}
	public List<OrderDTO> getOrderByGetMoreId(Integer getMoreId) {
		return orderDao.getOrderByGetMoreId(getMoreId);
	}
	@Override
	public OrderDTO getOrderById(String id) {
		return orderDao.getOrderById(id);
	}
	@Override
	public void updateOrder(Order order) {
		orderDao.updateOrder(order);
	}
	@Override
	public int getCountByParam(Order order) {
		return orderDao.getCountByParam(order);
	}
	@Override
	public PageDTO<List<OrderDTO>> getOrderByPageAndParam(PageDTO<Order> page) {
		PageDTO<List<OrderDTO>> result=new PageDTO<List<OrderDTO>>();
		List<OrderDTO> list=orderDao.getOrderByPageAndParam(page);
		result.setParam(list);
		result.setPageIndex(page.getPageIndex());
		result.setPageSize(page.getPageSize());
		
		int total=orderDao.getCountByParam(page.getParam());
		total=total%page.getPageSize()==0?total/page.getPageSize():total/page.getPageSize()+1;
		result.setTotalPage(total);
		return result;
	}
	@Override
	public int getUserTotalPay(Integer getMoreId) {
		return orderDao.getUserTotalPay(getMoreId);
	}
	@Override
	public List<OrderDTO> getAllOrder() {
		return orderDao.getAllOrder();
	}

}
