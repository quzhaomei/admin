package com.rycf.gjb.entity;
/**
 * 订单渠道-已结算中间表
 * @author Administrator
 */
public class OrderChannel {
	private Integer id;
	private String orderId;
	private Integer channelId;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public Integer getChannelId() {
		return channelId;
	}
	public void setChannelId(Integer channelId) {
		this.channelId = channelId;
	}
	
}
