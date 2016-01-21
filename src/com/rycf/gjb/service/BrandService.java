package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.BrandDTO;
import com.rycf.gjb.entity.Brand;

public interface BrandService {
	List<BrandDTO> getAllBrand();
	BrandDTO getBrandById(String id);
	BrandDTO getBrandByName(String brandName);
	void saveBrand(Brand brand);
	void updateBrand(Brand brand);
	List<BrandDTO> getBrandByUserId(String userId);
}
