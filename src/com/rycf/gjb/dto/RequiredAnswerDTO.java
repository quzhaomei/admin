package com.rycf.gjb.dto;

import java.util.Date;
import java.util.List;

public class RequiredAnswerDTO {
	private String requiredAnswerId;//主键
	private String requiredId;//需求ID
	private FurnitureRequiredDTO requiredDto;//需求DTO
	private String zoneIds;//功能IDs
	private List<FurnitureZoneDTO> zones;
	private SystemUserDTO user;
	private StoreDTO store;
	private BrandDTO brand;
	
	private String typeIds;//品类IDs
	private List<FurnitureTypeDTO> types;
	
	private String imgs;//产品图
	private String styleIds;//风格IDs
	private List<FurnitureStyleDTO> styles;
	
	private String description;//描述
	private Date createDate;//创建时间
	private Date updateDate;//更新时间
	private String status;//0-需求中
	public String getRequiredAnswerId() {
		return requiredAnswerId;
	}
	public void setRequiredAnswerId(String requiredAnswerId) {
		this.requiredAnswerId = requiredAnswerId;
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
	
	public FurnitureRequiredDTO getRequiredDto() {
		return requiredDto;
	}
	public void setRequiredDto(FurnitureRequiredDTO requiredDto) {
		this.requiredDto = requiredDto;
	}
	public void setZoneIds(String zoneIds) {
		this.zoneIds = zoneIds;
	}
	public List<FurnitureZoneDTO> getZones() {
		return zones;
	}
	public void setZones(List<FurnitureZoneDTO> zones) {
		this.zones = zones;
	}
	public SystemUserDTO getUser() {
		return user;
	}
	public void setUser(SystemUserDTO user) {
		this.user = user;
	}
	public StoreDTO getStore() {
		return store;
	}
	public void setStore(StoreDTO store) {
		this.store = store;
	}
	public BrandDTO getBrand() {
		return brand;
	}
	public void setBrand(BrandDTO brand) {
		this.brand = brand;
	}
	public String getTypeIds() {
		return typeIds;
	}
	public void setTypeIds(String typeIds) {
		this.typeIds = typeIds;
	}
	public List<FurnitureTypeDTO> getTypes() {
		return types;
	}
	public void setTypes(List<FurnitureTypeDTO> types) {
		this.types = types;
	}
	public String getImgs() {
		return imgs;
	}
	public void setImgs(String imgs) {
		this.imgs = imgs;
	}
	public String getStyleIds() {
		return styleIds;
	}
	public void setStyleIds(String styleIds) {
		this.styleIds = styleIds;
	}
	public List<FurnitureStyleDTO> getStyles() {
		return styles;
	}
	public void setStyles(List<FurnitureStyleDTO> styles) {
		this.styles = styles;
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
