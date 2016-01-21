package com.rycf.gjb.dto;

import java.util.Date;

/**
 * 家具风格
 * @author Administrator
 *
 */
public class FurnitureStyleDTO {
	private String styleId;//风格ID
	private String styleName;//风格名字
	private String status;//状态 0-无效，1-有效，
	private Date createDate;//创建时间
	public String getStyleId() {
		return styleId;
	}
	public void setStyleId(String styleId) {
		this.styleId = styleId;
	}
	public String getStyleName() {
		return styleName;
	}
	public void setStyleName(String styleName) {
		this.styleName = styleName;
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
	

}
