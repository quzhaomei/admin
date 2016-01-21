package com.rycf.gjb.entity;

import java.util.Date;

public class Order {
	private String orderId;//订单ID;
	private Integer getMoreId;//凯特号
	private String username;
	private String phone;
	private String storeId;//店铺
	private String fare;//费用
	private String orderNum;//订单号
	private String orderAddress;//订单送货地址
	private String backType;//0-微信，1-银行
	
	private String externalid;//支付流水号
	
	
	private String userId;//查询时候辅助条件
	private Date buyDate;//购买时间
	
	public String getUserId() {
		return userId;
	}
	
	public Date getBuyDate() {
		return buyDate;
	}



	public void setBuyDate(Date buyDate) {
		this.buyDate = buyDate;
	}



	public String getExternalid() {
		return externalid;
	}



	public void setExternalid(String externalid) {
		this.externalid = externalid;
	}



	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBackType() {
		return backType;
	}
	public void setBackType(String backType) {
		this.backType = backType;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getOrderAddress() {
		return orderAddress;
	}
	public void setOrderAddress(String orderAddress) {
		this.orderAddress = orderAddress;
	}
	private String hasPay;//已付金额
	private String orderImg;//订单照片路径
	//状态：0-确认支付方式中，  1-凯特猫审核中，2-品牌审核中，2.5-返利中 ，3-返利完成，4-审核退回,5-个人删除中，6-退货，
	private String status;
	private String info;//修改状态时候的备注
	private Date createDate;//创建时间
	private Date updateDate;//修改时间
	private String updateUserId;//修改人
	
	private Float getMorePay;//凯特猫还需支付金额（针对微信红包的）
	
	public Float getGetMorePay() {
		return getMorePay;
	}
	public void setGetMorePay(Float getMorePay) {
		this.getMorePay = getMorePay;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	public Integer getGetMoreId() {
		return getMoreId;
	}

	public void setGetMoreId(Integer getMoreId) {
		this.getMoreId = getMoreId;
	}

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getFare() {
		return fare;
	}
	public void setFare(String fare) {
		this.fare = fare;
	}
	public String getHasPay() {
		return hasPay;
	}
	public void setHasPay(String hasPay) {
		this.hasPay = hasPay;
	}
	public String getOrderImg() {
		return orderImg;
	}
	public void setOrderImg(String orderImg) {
		this.orderImg = orderImg;
	}

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public String getUpdateUserId() {
		return updateUserId;
	}
	public void setUpdateUserId(String updateUserId) {
		this.updateUserId = updateUserId;
	}
	
}
