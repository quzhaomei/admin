package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.BrandPayCardDao;
import com.rycf.gjb.dto.BrandPayCardDTO;
import com.rycf.gjb.entity.BrandPayCard;
import com.rycf.gjb.service.BrandPayCardService;
import com.rycf.gjb.util.UuidUtils;
@Service
public class BrandPayCardServiceImpl implements BrandPayCardService{
	@Resource
	private BrandPayCardDao brandPayCardDao;

	@Override
	public void saveBrandPayCard(BrandPayCard payCard) {
		payCard.setPayCardId(UuidUtils.getObjectUUID("paycard"));
		brandPayCardDao.saveBrandPayCard(payCard);
	}

	@Override
	public void updateBrandPayCard(BrandPayCard payCard) {
		brandPayCardDao.updateBrandPayCard(payCard);
	}

	@Override
	public BrandPayCardDTO getBrandPayCardByUserId(String userId) {
		return brandPayCardDao.getBrandPayCardByUserId(userId);
	}

	@Override
	public List<BrandPayCardDTO> getAllBrandPayCard() {
		return brandPayCardDao.getAllBrandPayCard();
	}


}
