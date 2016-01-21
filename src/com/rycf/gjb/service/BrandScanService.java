package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.BrandScanDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.BrandScan;

public interface BrandScanService {
	void saveScan(BrandScan brandScan);
	void updateScan(BrandScan brandScan);
	void deleteScan(String id);
	int getCountByParam(BrandScan brandScan);
	BrandScanDTO getScanById(String id);
	BrandScanDTO getScanByParam(BrandScan brandScan);
	
	/**
	 * 获取凯特猫的浏览记录
	 */
	PageDTO<List<BrandScanDTO>> getGetMoreScanByPage(PageDTO<BrandScan> page);
	
	/**
	 * 获取品牌的浏览记录
	 */
	PageDTO<List<BrandScanDTO>> getScanByPage(PageDTO<BrandScan> page);
}
