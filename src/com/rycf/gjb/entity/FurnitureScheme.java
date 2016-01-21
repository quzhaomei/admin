package com.rycf.gjb.entity;

import java.util.Date;

/**
 * 家具方案
 * @author Administrator
 *
 */
public class FurnitureScheme {
	private String schemeId;//方案ID;
	private String imgPathArr;//图片路径
	private String sysUserId;//方案提供人员ID
	private String deMandId;//需求ID
	private String content;//方案内容
	private Date createDate;//创建时间
	private String status;//0-有效，1-无效
	public String getSchemeId() {
		return schemeId;
	}
	public void setSchemeId(String schemeId) {
		this.schemeId = schemeId;
	}
	public String getImgPathArr() {
		return imgPathArr;
	}
	public void setImgPathArr(String imgPathArr) {
		this.imgPathArr = imgPathArr;
	}
	public String getSysUserId() {
		return sysUserId;
	}
	public void setSysUserId(String sysUserId) {
		this.sysUserId = sysUserId;
	}
	public String getDeMandId() {
		return deMandId;
	}
	public void setDeMandId(String deMandId) {
		this.deMandId = deMandId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
