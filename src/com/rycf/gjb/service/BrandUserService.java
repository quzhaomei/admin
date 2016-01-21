package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.entity.BrandUser;

public interface BrandUserService {
	void saveBrand(BrandUser brandUser);
	void updateBrand(BrandUser brandUser);
	BrandUser getBrandUserByParam(BrandUser brandUser);
	List<BrandUser> getBrandByUserId(String userId);
}
