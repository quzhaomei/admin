package com.rycf.gjb.entity.minisite;

import java.util.Date;

/**
 * 手机注册
 * @author Administrator
 */
public class PhoneRegister {
	private String registerId;//ID
	private String name;//用户名字  10
	private String phone;//用户手机  11
	private String registerCode;//注册码  20
	private Date readyTime;//预购时间
	private Date createDate;//发起时间
	private Date updateDate;//接受时间
	private String status;//0-发起中，1-已接受  2-短信发送中，
	private Integer type;//0-活动， 1-元旦活动
	private String shortUrl;//短连接
	
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getShortUrl() {
		return shortUrl;
	}
	public void setShortUrl(String shortUrl) {
		this.shortUrl = shortUrl;
	}
	public String getRegisterId() {
		return registerId;
	}
	public void setRegisterId(String registerId) {
		this.registerId = registerId;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getName() {
		return name;
	}
	
	public Date getReadyTime() {
		return readyTime;
	}
	public void setReadyTime(Date readyTime) {
		this.readyTime = readyTime;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegisterCode() {
		return registerCode;
	}
	public void setRegisterCode(String registerCode) {
		this.registerCode = registerCode;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
