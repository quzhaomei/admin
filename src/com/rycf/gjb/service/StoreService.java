package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.StoreDTO;
import com.rycf.gjb.entity.Store;

public interface StoreService {
	List<StoreDTO> getNearStore( Store store);
	void updateStore(Store store);
	List<StoreDTO> getStoreByBrandId(String brandId);
	List<StoreDTO> getAllStores();
	StoreDTO getStoreByStoreId(String storeId);
	void saveStore(Store store);
	List<StoreDTO> getStoreByUserId( String userId);
	
	List<StoreDTO> getStoreByBrandKey(String key);
}
