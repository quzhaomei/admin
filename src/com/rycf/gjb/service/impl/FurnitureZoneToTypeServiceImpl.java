package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.FurnitureZoneToTypeDao;
import com.rycf.gjb.entity.FurnitureZoneToType;
import com.rycf.gjb.service.FurnitureZoneToTypeService;
import com.rycf.gjb.util.UuidUtils;

@Service
public class FurnitureZoneToTypeServiceImpl implements FurnitureZoneToTypeService {
	@Resource
	private FurnitureZoneToTypeDao furnitureZoneToTypeDao;
	@Override
	public void saveZoneToType(FurnitureZoneToType furnitureZoneToType) {
		furnitureZoneToType.setZoneToTypeId(UuidUtils.getObjectUUID("ztt"));
		furnitureZoneToTypeDao.saveZoneToType(furnitureZoneToType);
	}

	@Override
	public void updateZoneToType(FurnitureZoneToType furnitureZoneToType) {
		furnitureZoneToTypeDao.updateZoneToType(furnitureZoneToType);
	}

	@Override
	public FurnitureZoneToType getZoneToTypeById(String id) {
		return furnitureZoneToTypeDao.getZoneToTypeById(id);
	}

	@Override
	public List<FurnitureZoneToType> getByParam(
			FurnitureZoneToType furnitureZoneToType) {
		return furnitureZoneToTypeDao.getByParam(furnitureZoneToType);
	}

}
