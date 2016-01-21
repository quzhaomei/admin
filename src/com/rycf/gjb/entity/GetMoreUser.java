package com.rycf.gjb.entity;

import java.util.Date;

/**
 *	凯特猫用户 
 */
public class GetMoreUser {
	private Integer getMoreId;//凯特号
	private String userName;//姓名 20
	private String loginName;//登陆名 50
	private String password;//密码 50
	private String phone;//电话  11
	private String photo;//头像 100
	private Integer type;//类型 1-微信用户，2-pc用户
	private Date createDate;
	private Integer status;//状态 2
	
	private String code;//注册的推荐码
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Integer getGetMoreId() {
		return getMoreId;
	}
	public void setGetMoreId(Integer getMoreId) {
		this.getMoreId = getMoreId;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
}
