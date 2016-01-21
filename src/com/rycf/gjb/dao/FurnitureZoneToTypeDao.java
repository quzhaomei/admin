package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.entity.FurnitureZoneToType;

public interface FurnitureZoneToTypeDao {
	void saveZoneToType(@Param(value = "zoneToType") FurnitureZoneToType furnitureZoneToType);
	void updateZoneToType(@Param(value = "zoneToType") FurnitureZoneToType furnitureZoneToType);
	FurnitureZoneToType getZoneToTypeById(@Param(value = "id") String id);
	List<FurnitureZoneToType> getByParam(@Param(value = "zoneToType") FurnitureZoneToType furnitureZoneToType);
}
