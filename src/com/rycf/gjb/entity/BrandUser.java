package com.rycf.gjb.entity;
/**
 * @author Administrator
 *	品牌管理人中间表
 */
public class BrandUser {
	private String brandUserId;
	private String brandId;
	private String userId;
	private String status;//0-失效，1-有效
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getBrandUserId() {
		return brandUserId;
	}
	public void setBrandUserId(String brandUserId) {
		this.brandUserId = brandUserId;
	}
	public String getBrandId() {
		return brandId;
	}
	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
}
