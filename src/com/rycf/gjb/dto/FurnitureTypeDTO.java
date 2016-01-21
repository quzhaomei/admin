package com.rycf.gjb.dto;

import java.util.Date;
import java.util.List;

/**
 * 家具品类
 * @author Administrator
 */
public class FurnitureTypeDTO {
	private String typeId;//主键
	private String typeName;//品类名字
	private String status;//0-无效，1-有效
	private Date createDate;//创建时间
	private List<FurnitureZoneDTO> zones;
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
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public List<FurnitureZoneDTO> getZones() {
		return zones;
	}
	public void setZones(List<FurnitureZoneDTO> zones) {
		this.zones = zones;
	}
	
}
