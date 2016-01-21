package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.entity.FurnitureZoneToType;

public interface FurnitureZoneToTypeService{
	void saveZoneToType(FurnitureZoneToType furnitureZoneToType);
	void updateZoneToType( FurnitureZoneToType furnitureZoneToType);
	FurnitureZoneToType getZoneToTypeById(String id);
	List<FurnitureZoneToType> getByParam(FurnitureZoneToType furnitureZoneToType);
}
