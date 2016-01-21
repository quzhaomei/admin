package com.rycf.gjb.entity;

import java.util.Date;

/**
 * 家具品类
 * @author Administrator
 */
public class FurnitureType {
	private String typeId;//主键
	private String typeName;//品类名字
	private String status;//0-无效，1-有效
	private String createUserId;//创建者ID
	private Date createDate;//创建时间
	private String updateUserId;//更新者ID
	private Date updateDate;//更新时间
	
	//param
	private String zoneIds;//所属功能区域类
	
	public String getZoneIds() {
		return zoneIds;
	}
	public void setZoneIds(String zoneIds) {
		this.zoneIds = zoneIds;
	}
	public String getTypeId() {
		return typeId;
	}
	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
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
