package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.FurnitureZoneDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.FurnitureZone;

public interface FurnitureZoneDao {
	void saveZone(@Param(value = "zone") FurnitureZone furnitureZone);
	void updateZone(@Param(value = "zone") FurnitureZone furnitureZone);
	FurnitureZoneDTO getZoneById(@Param(value = "id") String id);
	List<FurnitureZoneDTO> getZoneByPageAndParam(@Param(value = "page") PageDTO<FurnitureZone> page);
	int getCountByParam(FurnitureZone furnitureZone);
	List<FurnitureZoneDTO> getAllZone();
}
