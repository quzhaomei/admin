package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.BrandPayCardDTO;
import com.rycf.gjb.entity.BrandPayCard;

public interface BrandPayCardDao {
	void saveBrandPayCard(@Param(value="payCard")BrandPayCard payCard);
	void updateBrandPayCard(@Param(value="payCard")BrandPayCard payCard);
	BrandPayCardDTO getBrandPayCardByUserId(@Param(value="userId")String userId);
	List<BrandPayCardDTO> getAllBrandPayCard();
}
