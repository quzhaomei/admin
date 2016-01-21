package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.BrandScanDao;
import com.rycf.gjb.dto.BrandScanDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.BrandScan;
import com.rycf.gjb.service.BrandScanService;
import com.rycf.gjb.util.UuidUtils;

@Service
public class BrandScanServiceImpl implements BrandScanService {
	@Resource
	private BrandScanDao scanDao;

	@Override
	public void saveScan(BrandScan brandScan) {
		brandScan.setBrandScanId(UuidUtils.getObjectUUID("scan"));
		scanDao.saveScan(brandScan);
	}

	@Override
	public void updateScan(BrandScan brandScan) {
		scanDao.updateScan(brandScan);
	}

	@Override
	public int getCountByParam(BrandScan brandScan) {
		return scanDao.getCountByParam(brandScan);
	}

	@Override
	public BrandScanDTO getScanById(String id) {
		return scanDao.getScanById(id);
	}
	@Override
	public BrandScanDTO getScanByParam(BrandScan brandScan) {
		return scanDao.getScanByParam(brandScan);
	}
	@Override
	public PageDTO<List<BrandScanDTO>> getScanByPage(PageDTO<BrandScan> page) {
		List<BrandScanDTO> data=scanDao.getScanByPage(page);
		PageDTO<List<BrandScanDTO>>  result=new PageDTO<List<BrandScanDTO>>();
		result.setPageIndex(page.getPageIndex());
		result.setPageSize(page.getPageSize());
		result.setParam(data);
		int count=scanDao.getCountByParam(page.getParam());
		count=count%page.getPageSize()==0?count/page.getPageSize():count/page.getPageSize()+1;
		result.setTotalPage(count);
		return result;
	}

	@Override
	public PageDTO<List<BrandScanDTO>> getGetMoreScanByPage(
			PageDTO<BrandScan> page) {
		List<BrandScanDTO> data=scanDao.getGetMoreScanByPage(page);
		PageDTO<List<BrandScanDTO>>  result=new PageDTO<List<BrandScanDTO>>();
		result.setPageIndex(page.getPageIndex());
		result.setPageSize(page.getPageSize());
		result.setParam(data);
		int count=scanDao.getGetMoreCountByParam(page.getParam());
		count=count%page.getPageSize()==0?count/page.getPageSize():count/page.getPageSize()+1;
		result.setTotalPage(count);
		return result;
	}

	@Override
	public void deleteScan(String id) {
		scanDao.deleteScan(id);
	}
}
