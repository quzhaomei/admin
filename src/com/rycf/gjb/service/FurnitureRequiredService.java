package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.FurnitureRequiredDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.FurnitureRequired;

public interface FurnitureRequiredService {
	void saveRequired(FurnitureRequired furnitureRequired);
	void updateRequired(FurnitureRequired furnitureRequired);
	FurnitureRequiredDTO getRequiredById(String id);
	PageDTO<List<FurnitureRequiredDTO>> getRequiredByPageAndParam(PageDTO<FurnitureRequired> page);
	int getCountByParam(FurnitureRequired furnitureRequired);
}
