package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.FurnitureTypeDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.FurnitureType;

public interface FurnitureTypeDao {
	void saveType(@Param(value = "type") FurnitureType furnitureType);
	void updateType(@Param(value = "type") FurnitureType furnitureType);
	FurnitureTypeDTO getTypeById(@Param(value = "id") String id);
	List<FurnitureTypeDTO> getTypeByPageAndParam(@Param(value = "page") PageDTO<FurnitureType> page);
	int getCountByParam(FurnitureType furnitureType);
	List<FurnitureTypeDTO> getAllType();
	List<FurnitureTypeDTO> getTypeByZone(@Param(value = "zoneId")String zoneId);
}
