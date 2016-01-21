package com.rycf.gjb.entity;

import java.util.Date;

/**
 * 家具需求
 * @author Administrator
 */
public class FurnitureDemand {
	private String demandId;//主键ID
	private String openId;//微信用户Id
	private FurnitureZone furnitureZone;//功能区域
	private FurnitureType furnitureType;//家具品类
	private FurnitureStyle furnitureStyle;//家居风格
	private FurnitureBudget furnitureBudget;//家居预算
	private String title;//需求标题
	private String description;//文字描述
	private String status;//0-无效，1-有效无方案，2-有效有方案
	private Date createDate;//创建时间
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDemandId() {
		return demandId;
	}
	public void setDemandId(String demandId) {
		this.demandId = demandId;
	}
	public FurnitureZone getFurnitureZone() {
		return furnitureZone;
	}
	public void setFurnitureZone(FurnitureZone furnitureZone) {
		this.furnitureZone = furnitureZone;
	}
	public FurnitureType getFurnitureType() {
		return furnitureType;
	}
	public void setFurnitureType(FurnitureType furnitureType) {
		this.furnitureType = furnitureType;
	}
	public FurnitureStyle getFurnitureStyle() {
		return furnitureStyle;
	}
	public void setFurnitureStyle(FurnitureStyle furnitureStyle) {
		this.furnitureStyle = furnitureStyle;
	}
	public FurnitureBudget getFurnitureBudget() {
		return furnitureBudget;
	}
	public void setFurnitureBudget(FurnitureBudget furnitureBudget) {
		this.furnitureBudget = furnitureBudget;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
}
