package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.FurnitureStyleDao;
import com.rycf.gjb.dto.FurnitureStyleDTO;
import com.rycf.gjb.entity.FurnitureStyle;
import com.rycf.gjb.service.FurnitureStyleService;
import com.rycf.gjb.util.UuidUtils;
@Service
public class FurnitureStyleServiceImpl implements FurnitureStyleService{
	@Resource
	private FurnitureStyleDao furnitureStyleDao;
	@Override
	public void saveStyle(FurnitureStyle furnitureStyle) {
		furnitureStyle.setStyleId(UuidUtils.getObjectUUID("style"));
		furnitureStyleDao.saveStyle(furnitureStyle);
	}

	@Override
	public void updateStyle(FurnitureStyle furnitureStyle) {
		furnitureStyleDao.updateStyle(furnitureStyle);
	}

	@Override
	public FurnitureStyleDTO getStyleById(String id) {
		return furnitureStyleDao.getStyleById(id);
	}

	@Override
	public List<FurnitureStyleDTO> getAllStyle() {
		return furnitureStyleDao.getAllStyle();
	}

}
