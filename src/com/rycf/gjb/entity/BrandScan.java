package com.rycf.gjb.entity;

import java.util.Date;


/**
 * 品牌浏览记录
 * @author Administrator
 */
public class BrandScan {
	private String brandScanId;//主键
	private Integer getMoreId;//getMoreId
	private String brandId;//品牌ID,品牌ID为空，则表示为访问凯特猫时间
	private Date seeDate;//浏览具体时间
	private String time;//格式2015-10-23
	
	public String getBrandScanId() {
		return brandScanId;
	}
	public void setBrandScanId(String brandScanId) {
		this.brandScanId = brandScanId;
	}
	
	public String getBrandId() {
		return brandId;
	}
	public void setBrandId(String brandId) {
		this.brandId = brandId;
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
	public Integer getGetMoreId() {
		return getMoreId;
	}
	public void setGetMoreId(Integer getMoreId) {
		this.getMoreId = getMoreId;
	}
	
}
