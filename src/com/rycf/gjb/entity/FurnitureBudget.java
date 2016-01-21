package com.rycf.gjb.entity;

import java.util.Date;

/**
 * 家具需求预算
 * 资金区间段
 * @author Administrator
 *
 */
public class FurnitureBudget {
	private String budgetId;//预算ID
	private Float startNum;//起始资金
	private Float endNum;//截止资金
	private String status;//状态 0-无效，1-有效，
	private String createUserId;//创建者ID
	private Date createDate;//创建时间
	private String updateUserId;//更新者ID
	private Date updateDate;//更新时间
	public String getBudgetId() {
		return budgetId;
	}
	public void setBudgetId(String budgetId) {
		this.budgetId = budgetId;
	}
	public Float getStartNum() {
		return startNum;
	}
	public void setStartNum(Float startNum) {
		this.startNum = startNum;
	}
	public Float getEndNum() {
		return endNum;
	}
	public void setEndNum(Float endNum) {
		this.endNum = endNum;
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
