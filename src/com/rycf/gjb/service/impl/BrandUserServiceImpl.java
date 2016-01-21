package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.BrandUserDao;
import com.rycf.gjb.entity.BrandUser;
import com.rycf.gjb.service.BrandUserService;
import com.rycf.gjb.util.UuidUtils;
@Service
public class BrandUserServiceImpl implements BrandUserService{
	@Resource
	private BrandUserDao brandUserdao;
	@Override
	public void saveBrand(BrandUser brandUser) {
		brandUser.setBrandUserId(UuidUtils.getObjectUUID("bandUser"));
		brandUserdao.saveBrand(brandUser);
	}

	@Override
	public void updateBrand(BrandUser brandUser) {
		brandUserdao.updateBrand(brandUser);
	}

	@Override
	public BrandUser getBrandUserByParam(BrandUser brandUser) {
		return brandUserdao.getBrandUserByParam(brandUser);
	}

	@Override
	public List<BrandUser> getBrandByUserId(String userId) {
		return brandUserdao.getBrandByUserId(userId);
	}

}
