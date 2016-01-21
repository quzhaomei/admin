package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.StoreDTO;
import com.rycf.gjb.entity.Store;

public interface StoreDao {
	void saveStore(@Param(value = "store") Store store);
	void updateStore(@Param(value = "store") Store store);
	StoreDTO getStoreByStoreId(@Param(value = "storeId") String storeId);
	List<StoreDTO> getNearStore(@Param(value = "store") Store store);
	List<StoreDTO> getStoreByBrandId(@Param(value = "brandId") String brandId);
	List<StoreDTO> getAllStores();
	List<StoreDTO> getStoreByUserId(@Param(value = "userId") String userId);
}
