package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.FurnitureTypeDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.FurnitureType;

public interface FurnitureTypeService {
	void saveType(FurnitureType furnitureType);
	void updateType(FurnitureType furnitureType);
	FurnitureTypeDTO getTypeById(String id);
	List<FurnitureTypeDTO> getTypeByPageAndParam( PageDTO<FurnitureType> page);
	int getCountByParam(FurnitureType furnitureType);
	List<FurnitureTypeDTO> getAllType();
	List<FurnitureTypeDTO> getTypeByZone(String zoneId);
}
