package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.BrandScanDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.BrandScan;

public interface BrandScanDao {
	void saveScan(@Param(value="scan") BrandScan brandScan);
	void updateScan(@Param(value="scan") BrandScan brandScan);
	void deleteScan(@Param(value="id") String id);
	
	int getCountByParam(@Param(value="scan")BrandScan brandScan);
	
	BrandScanDTO getScanById(@Param(value="id") String id);
	BrandScanDTO getScanByParam(@Param(value="scan") BrandScan brandScan);
	/**
	 * 获取凯特猫的浏览记录
	 */
	List<BrandScanDTO> getGetMoreScanByPage(@Param(value="page")PageDTO<BrandScan> page);
	int getGetMoreCountByParam(@Param(value="scan")BrandScan brandScan);
	
	/**
	 * 获取品牌的浏览记录
	 */
	List<BrandScanDTO> getScanByPage(@Param(value="page")PageDTO<BrandScan> page);
}
