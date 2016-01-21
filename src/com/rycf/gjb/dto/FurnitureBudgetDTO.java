package com.rycf.gjb.dto;

import java.util.Date;

/**
 * 家具需求预算
 * 资金区间段
 * @author Administrator
 *
 */
public class FurnitureBudgetDTO {
	private String budgetId;//预算ID
	private Float startNum;//起始资金
	private Float endNum;//截止资金
	private Date createDate;//创建时间
	private String status;//状态
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
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
	public Date getCreateDate() {
		return createDate;
	}
	
}
