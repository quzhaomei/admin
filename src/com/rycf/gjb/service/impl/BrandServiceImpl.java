package com.rycf.gjb.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.BrandDao;
import com.rycf.gjb.dao.BrandTypeDao;
import com.rycf.gjb.dao.StoreDao;
import com.rycf.gjb.dto.BrandDTO;
import com.rycf.gjb.dto.StoreDTO;
import com.rycf.gjb.entity.Brand;
import com.rycf.gjb.entity.BrandType;
import com.rycf.gjb.service.BrandService;
import com.rycf.gjb.util.UuidUtils;
@Service
public class BrandServiceImpl implements BrandService {
	@Resource
	private BrandDao brandDao;
	@Resource
	private StoreDao storeDao;
	@Resource
	private BrandTypeDao brandTypeDao;
	@Override
	public List<BrandDTO> getAllBrand() {
		List<BrandDTO> result=brandDao.getAllBrand();
		for(BrandDTO temp:result){
			String brandTypeIds=temp.getBrandTypeIds();
			if(brandTypeIds!=null){
				String[]ids=brandTypeIds.split(",");
				List<BrandType> typeList=new ArrayList<BrandType>();
				for(String typeId:ids){
					BrandType brandType=brandTypeDao.getById(typeId);
					if(brandType!=null){
						typeList.add(brandType);
					}
				}
				temp.setBrandType(typeList);
			}
		}
		return result;
	}
	@Override
	public BrandDTO getBrandById(String id) {
		BrandDTO result=brandDao.getBrandById(id);
		if(result!=null){
			List<StoreDTO> stores=storeDao.getStoreByBrandId(id);
			result.setStores(stores);
			List<String> list=new ArrayList<String>();
			if(result.getProImgs()!=null){
				for(String str:result.getProImgs().split(",")){
					list.add(str);
				}
			}
			result.setProImgList(list);
		}
		String brandTypeIds=result.getBrandTypeIds();
		if(brandTypeIds!=null){
			String[]ids=brandTypeIds.split(",");
			List<BrandType> typeList=new ArrayList<BrandType>();
			for(String typeId:ids){
				BrandType brandType=brandTypeDao.getById(typeId);
				if(brandType!=null){
					typeList.add(brandType);
				}
			}
			result.setBrandType(typeList);
		}
		return result; 
	}
	@Override
	public BrandDTO getBrandByName(String brandName) {
		List<BrandDTO> result=brandDao.getBrandByName(brandName);
		if(result==null||result.size()==0){
			return null;
		}
		return result.get(0);
	}
	@Override
	public void saveBrand(Brand brand) {
		brand.setBrandId(UuidUtils.getObjectUUID("brand"));
		brandDao.saveBrand(brand);
	}
	@Override
	public void updateBrand(Brand brand) {
		brandDao.updateBrand(brand);
	}
	@Override
	public List<BrandDTO> getBrandByUserId(String userId) {
		return brandDao.getBrandByUserId(userId);
	}

}
