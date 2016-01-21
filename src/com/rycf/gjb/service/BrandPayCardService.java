package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.BrandPayCardDTO;
import com.rycf.gjb.entity.BrandPayCard;

public interface BrandPayCardService {
	void saveBrandPayCard(BrandPayCard payCard);
	void updateBrandPayCard(BrandPayCard payCard);
	BrandPayCardDTO getBrandPayCardByUserId(String userId);
	List<BrandPayCardDTO> getAllBrandPayCard();
}
