package com.rycf.gjb.service;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.FurnitureZoneDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.FurnitureZone;

public interface FurnitureZoneService {
	void saveZone(@Param(value = "zone") FurnitureZone furnitureZone);
	void updateZone(@Param(value = "zone") FurnitureZone furnitureZone);
	FurnitureZoneDTO getZoneById(@Param(value = "id") String id);
	PageDTO<List<FurnitureZoneDTO>> getZoneByPageAndParam(@Param(value = "page") PageDTO<FurnitureZone> page);
	int getCountByParam(FurnitureZone furnitureZone);
	List<FurnitureZoneDTO> getAllZone();
}
