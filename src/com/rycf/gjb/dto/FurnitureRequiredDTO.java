package com.rycf.gjb.dto;

import java.util.Date;
import java.util.List;

public class FurnitureRequiredDTO {
	private String requiredId;
	private Integer getMoreId;//凯特号
	private FurnitureZoneDTO zoneDTO;
	private String typeIds;
	private String styleIds;
	private FurnitureBudgetDTO budgetDTO;
	private String description;
	private String status;//0-已删除，1-发布中，2-有答案
	private List<FurnitureTypeDTO> typeDTOs;
	private List<FurnitureStyleDTO> styleDTOs;
	
	
	private Integer count;//答案数。第一幅图。
	private String img;//第一幅图
	
	
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
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
	public FurnitureZoneDTO getZoneDTO() {
		return zoneDTO;
	}
	public void setZoneDTO(FurnitureZoneDTO zoneDTO) {
		this.zoneDTO = zoneDTO;
	}
	public FurnitureBudgetDTO getBudgetDTO() {
		return budgetDTO;
	}
	public void setBudgetDTO(FurnitureBudgetDTO budgetDTO) {
		this.budgetDTO = budgetDTO;
	}
	public List<FurnitureTypeDTO> getTypeDTOs() {
		return typeDTOs;
	}
	public void setTypeDTOs(List<FurnitureTypeDTO> typeDTOs) {
		this.typeDTOs = typeDTOs;
	}
	public List<FurnitureStyleDTO> getStyleDTOs() {
		return styleDTOs;
	}
	public void setStyleDTOs(List<FurnitureStyleDTO> styleDTOs) {
		this.styleDTOs = styleDTOs;
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
