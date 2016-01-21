package com.rycf.gjb.dto;

import java.util.Date;


/**
 * 品牌浏览记录
 * @author Administrator
 */
public class BrandScanDTO {
	private String brandScanId;//主键
	private GetMoreUserDTO user;//getMoreId
	private BrandDTO brand;//最近四个品牌ID
	private Date seeDate;//浏览具体时间
	private String time;//格式2015-10-23
	
	public String getBrandScanId() {
		return brandScanId;
	}
	public void setBrandScanId(String brandScanId) {
		this.brandScanId = brandScanId;
	}
	
	
	public BrandDTO getBrand() {
		return brand;
	}
	public void setBrand(BrandDTO brand) {
		this.brand = brand;
	}
	
	public Date getSeeDate() {
		return seeDate;
	}
	public void setSeeDate(Date seeDate) {
		this.seeDate = seeDate;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public GetMoreUserDTO getUser() {
		return user;
	}
	public void setUser(GetMoreUserDTO user) {
		this.user = user;
	}
	
}
