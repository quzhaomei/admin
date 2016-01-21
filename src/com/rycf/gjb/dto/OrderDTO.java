package com.rycf.gjb.dto;

import java.util.Date;

public class OrderDTO {
	private String orderId;
	private StoreDTO store;
	private BrandDTO brand;
	private Date createDate;
	private Float fare;
	private Float hasPay;
	private String status;//0-确定支付方式中，1-凯特猫审核中，2-品牌审核中，3-返利完成，4-审核退回,5-个人删除中,6-退货
	private String backType;//返利方式
	private String orderImg;
	private String username;
	private String phone;
	private Integer getMoreId;
	private String info;//备注
	private Date buyDate;//购买时间
	
	public Date getBuyDate() {
		return buyDate;
	}
	public void setBuyDate(Date buyDate) {
		this.buyDate = buyDate;
	}
	private String  headimgurl;//img
	private String  nickname;//nickname
	
	
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getHeadimgurl() {
		return headimgurl;
	}
	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
	}
	private Float getMorePay;//凯特猫还需支付金额（针对微信红包的）
	
	private String externalid;//易宝支付流水号
	
	private Integer tempId;//第三方渠道支付号标志
	
	public Integer getTempId() {
		return tempId;
	}
	public void setTempId(Integer tempId) {
		this.tempId = tempId;
	}
	public String getExternalid() {
		return externalid;
	}
	public void setExternalid(String externalid) {
		this.externalid = externalid;
	}
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
	public String getBackType() {
		return backType;
	}
	public void setBackType(String backType) {
		this.backType = backType;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public StoreDTO getStore() {
		return store;
	}
	public void setStore(StoreDTO store) {
		this.store = store;
	}
	public BrandDTO getBrand() {
		return brand;
	}
	public void setBrand(BrandDTO brand) {
		this.brand = brand;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Float getFare() {
		return fare;
	}
	public void setFare(Float fare) {
		this.fare = fare;
	}
	public Float getHasPay() {
		return hasPay;
	}
	public void setHasPay(Float hasPay) {
		this.hasPay = hasPay;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getOrderImg() {
		return orderImg;
	}
	public void setOrderImg(String orderImg) {
		this.orderImg = orderImg;
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
	public Integer getGetMoreId() {
		return getMoreId;
	}
	public void setGetMoreId(Integer getMoreId) {
		this.getMoreId = getMoreId;
	}
	
}
