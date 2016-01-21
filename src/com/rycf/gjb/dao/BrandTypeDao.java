package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.entity.BrandType;

public interface BrandTypeDao {
	void saveBrandType(@Param(value="brandType") BrandType brandType);
	void updateBrandType(@Param(value="brandType") BrandType brandType);
	BrandType getById(@Param(value="id")String id);
	List<BrandType> getBrandByParam(@Param(value="brandType") BrandType brandType);
}
