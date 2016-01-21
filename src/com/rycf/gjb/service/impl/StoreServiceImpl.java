package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.StoreDao;
import com.rycf.gjb.dto.StoreDTO;
import com.rycf.gjb.entity.Store;
import com.rycf.gjb.service.StoreService;
import com.rycf.gjb.util.UuidUtils;

@Service
public class StoreServiceImpl implements StoreService {
	@Resource
	private StoreDao storeDao;

	@Override
	public List<StoreDTO> getNearStore(Store store) {
		return storeDao.getNearStore(store);
	}

	@Override
	public List<StoreDTO> getStoreByBrandId(String brandId) {
		return storeDao.getStoreByBrandId(brandId);
	}

	@Override
	public List<StoreDTO> getAllStores() {
		return storeDao.getAllStores();
	}

	@Override
	public StoreDTO getStoreByStoreId(String storeId) {
		return storeDao.getStoreByStoreId(storeId);
	}

	@Override
	public void saveStore(Store store) {
		
		store.setStoreId(UuidUtils.getObjectUUID("store"));
		storeDao.saveStore(store);
	}

	@Override
	public void updateStore(Store store) {
		storeDao.updateStore(store);
	}

	@Override
	public List<StoreDTO> getStoreByUserId(String userId) {
		return storeDao.getStoreByUserId(userId);
	}

	@Override
	public List<StoreDTO> getStoreByBrandKey(String key) {
		return storeDao.getStoreByBrandKey(key);
	}

}
