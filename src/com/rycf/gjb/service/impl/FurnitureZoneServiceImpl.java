package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.FurnitureZoneDao;
import com.rycf.gjb.dto.FurnitureZoneDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.FurnitureZone;
import com.rycf.gjb.service.FurnitureZoneService;
import com.rycf.gjb.util.UuidUtils;
@Service
public class FurnitureZoneServiceImpl implements FurnitureZoneService {
	@Resource
	private FurnitureZoneDao furnitureZoneDao;

	@Override
	public void saveZone( FurnitureZone furnitureZone) {
		furnitureZone.setZoneId(UuidUtils.getObjectUUID("zone"));
		furnitureZoneDao.saveZone(furnitureZone);
	}

	@Override
	public void updateZone(FurnitureZone furnitureZone) {
		furnitureZoneDao.updateZone(furnitureZone);
	}

	@Override
	public FurnitureZoneDTO getZoneById( String id) {
		return furnitureZoneDao.getZoneById(id);
	}

	@Override
	public PageDTO<List<FurnitureZoneDTO>> getZoneByPageAndParam(
			@Param("page") PageDTO<FurnitureZone> page) {
		List<FurnitureZoneDTO> list=furnitureZoneDao.getZoneByPageAndParam(page);
		PageDTO<List<FurnitureZoneDTO>> pageDTO=new PageDTO<List<FurnitureZoneDTO>>();
		pageDTO.setParam(list);
		pageDTO.setPageIndex(page.getPageIndex());
		pageDTO.setPageSize(page.getPageSize());
		int count=furnitureZoneDao.getCountByParam(page.getParam());
		count=count%page.getPageSize()==0?count/page.getPageSize():count/page.getPageSize()+1;
		pageDTO.setTotalPage(count);
		return pageDTO;
	}

	@Override
	public int getCountByParam(FurnitureZone furnitureZone) {
		return furnitureZoneDao.getCountByParam(furnitureZone);
	}

	@Override
	public List<FurnitureZoneDTO> getAllZone() {
		return furnitureZoneDao.getAllZone();
	}

}
