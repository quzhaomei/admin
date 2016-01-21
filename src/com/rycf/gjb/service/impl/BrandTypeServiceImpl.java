package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.BrandTypeDao;
import com.rycf.gjb.entity.BrandType;
import com.rycf.gjb.service.BrandTypeService;
import com.rycf.gjb.util.UuidUtils;
@Service
public class BrandTypeServiceImpl implements BrandTypeService {
	@Resource
	private BrandTypeDao dao;

	@Override
	public void saveBrandType(BrandType brandType) {
		brandType.setBrandTypeId(UuidUtils.getObjectUUID("brandType"));
		dao.saveBrandType(brandType);
	}

	@Override
	public void updateBrandType(BrandType brandType) {
		dao.updateBrandType(brandType);
	}

	@Override
	public BrandType getById(String id) {
		return dao.getById(id);
	}

	@Override
	public List<BrandType> getBrandByParam(BrandType brandType) {
		return dao.getBrandByParam(brandType);
	}

}
