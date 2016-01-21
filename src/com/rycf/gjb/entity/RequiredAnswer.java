package com.rycf.gjb.entity;

import java.util.Date;

public class RequiredAnswer {
	private String requiredAnswerId;//主键
	private String userId;//回答者ID
	private String brandId;//品牌
	private String requiredId;//需求ID
	private String zoneIds;//功能IDs
	private String typeIds;//品类IDs
	private String imgs;//产品图
	private String styleIds;//风格IDs
	private String description;//描述
	private Date createDate;//创建时间
	private Date updateDate;//更新时间
	private String status;//0-需求中
	
	public String getBrandId() {
		return brandId;
	}
	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}
	public String getImgs() {
		return imgs;
	}
	public void setImgs(String imgs) {
		this.imgs = imgs;
	}
	public String getRequiredAnswerId() {
		return requiredAnswerId;
	}
	public void setRequiredAnswerId(String requiredAnswerId) {
		this.requiredAnswerId = requiredAnswerId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRequiredId() {
		return requiredId;
	}
	public void setRequiredId(String requiredId) {
		this.requiredId = requiredId;
	}
	public String getZoneIds() {
		return zoneIds;
	}
	public void setZoneIds(String zoneIds) {
		this.zoneIds = zoneIds;
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
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
