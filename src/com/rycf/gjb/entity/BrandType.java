package com.rycf.gjb.entity;
/**
 * 店铺类型
 * @author Administrator
 *
 */
public class BrandType {
	private String brandTypeId;//主键
	private String html;//icon代码
	private String name;//类型名字
	private String status;//1-有效，0-无效
	public String getBrandTypeId() {
		return brandTypeId;
	}
	public void setBrandTypeId(String brandTypeId) {
		this.brandTypeId = brandTypeId;
	}
	public String getHtml() {
		return html;
	}
	public void setHtml(String html) {
		this.html = html;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
