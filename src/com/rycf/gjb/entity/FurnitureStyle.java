package com.rycf.gjb.entity;

import java.util.Date;

/**
 * 家具风格
 * 
 * @author Administrator
 * 
 */
public class FurnitureStyle {
	private String styleId;// 风格ID
	private String styleName;// 风格名字
	private String status;// 状态 0-无效，1-有效，
	private String createUserId;// 创建者ID
	private Date createDate;// 创建时间
	private String updateUserId;// 更新者ID
	private Date updateDate;// 更新时间

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

	public String getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}

	public String getUpdateUserId() {
		return updateUserId;
	}

	public void setUpdateUserId(String updateUserId) {
		this.updateUserId = updateUserId;
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

}
