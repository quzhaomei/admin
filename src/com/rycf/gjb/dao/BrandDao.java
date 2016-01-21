package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.BrandDTO;
import com.rycf.gjb.entity.Brand;

public interface BrandDao {
	List<BrandDTO> getAllBrand();
	BrandDTO getBrandById(@Param(value="brandId")String id);
	List<BrandDTO> getBrandByName(@Param(value="brandName")String brandName);
	List<BrandDTO> getBrandByUserId(@Param(value="userId")String userId);
	void saveBrand(@Param(value="brand")Brand brand);
	void updateBrand(@Param(value="brand")Brand brand);
}
