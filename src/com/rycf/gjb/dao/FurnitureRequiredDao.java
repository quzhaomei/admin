package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.FurnitureRequiredDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.FurnitureRequired;

public interface FurnitureRequiredDao {
	void saveRequired(@Param(value = "required")FurnitureRequired furnitureRequired);
	void updateRequired(@Param(value = "required")FurnitureRequired furnitureRequired);
	FurnitureRequiredDTO getRequiredById(@Param(value = "id") String id);
	List<FurnitureRequiredDTO> getBudgetByPageAndParam(@Param(value = "page") PageDTO<FurnitureRequired> page);
	int getCountByParam(@Param(value = "required")FurnitureRequired furnitureRequired);
}
