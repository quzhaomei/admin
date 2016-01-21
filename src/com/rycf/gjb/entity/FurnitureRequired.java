package com.rycf.gjb.entity;

import java.util.Date;

public class FurnitureRequired {
	private String requiredId;
	private Integer getMoreId;//凯特号
	private String zoneId;
	private String typeIds;
	private String styleIds;
	private String budgetId;
	private String description;
	private String status;//0-已删除，1-发布中，2-有答案
	private Date createDate;
	public String getRequiredId() {
		return requiredId;
	}
	public void setRequiredId(String requiredId) {
		this.requiredId = requiredId;
	}
	
	public Integer getGetMoreId() {
		return getMoreId;
	}
	public void setGetMoreId(Integer getMoreId) {
		this.getMoreId = getMoreId;
	}
	public String getZoneId() {
		return zoneId;
	}
	public void setZoneId(String zoneId) {
		this.zoneId = zoneId;
	}
	public String getTypeIds() {
		return typeIds;
	}
	public void setTypeIds(String typeIds) {
		this.typeIds = typeIds;
	}
	public String getStyleIds() {
		return styleIds;
	}
	public void setStyleIds(String styleIds) {
		this.styleIds = styleIds;
	}
	public String getBudgetId() {
		return budgetId;
	}
	public void setBudgetId(String budgetId) {
		this.budgetId = budgetId;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
