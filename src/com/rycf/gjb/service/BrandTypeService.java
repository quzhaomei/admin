package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.entity.BrandType;

public interface BrandTypeService {
	void saveBrandType(BrandType brandType);
	void updateBrandType( BrandType brandType);
	BrandType getById(String id);
	List<BrandType> getBrandByParam(BrandType brandType);

}
