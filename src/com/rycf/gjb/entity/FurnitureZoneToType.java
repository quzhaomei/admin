package com.rycf.gjb.entity;
/**
 * 家具功能区域，品类，中间表
 * @author Administrator
 *
 */
public class FurnitureZoneToType {
	private String zoneToTypeId;//主键
	private String zoneId;//功能区域ID
	private String typeId;//品类ID
	private String status;//0-有效，1-无效
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getZoneToTypeId() {
		return zoneToTypeId;
	}
	public void setZoneToTypeId(String zoneToTypeId) {
		this.zoneToTypeId = zoneToTypeId;
	}
	public String getZoneId() {
		return zoneId;
	}
	public void setZoneId(String zoneId) {
		this.zoneId = zoneId;
	}
	public String getTypeId() {
		return typeId;
	}
	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
	
}
