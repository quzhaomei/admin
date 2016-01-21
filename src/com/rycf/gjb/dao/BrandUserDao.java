package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.entity.BrandUser;

public interface BrandUserDao {
	void saveBrand(@Param(value="brandUser")BrandUser brandUser);
	void updateBrand(@Param(value="brandUser")BrandUser brandUser);
	BrandUser getBrandUserByParam(@Param(value="brandUser")BrandUser brandUser);
	List<BrandUser> getBrandByUserId(@Param(value="userId")String userId);
}
