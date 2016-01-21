package com.rycf.gjb.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.FurnitureRequiredDao;
import com.rycf.gjb.dao.FurnitureStyleDao;
import com.rycf.gjb.dao.FurnitureTypeDao;
import com.rycf.gjb.dao.RequiredAnswerDao;
import com.rycf.gjb.dto.FurnitureRequiredDTO;
import com.rycf.gjb.dto.FurnitureStyleDTO;
import com.rycf.gjb.dto.FurnitureTypeDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.RequiredAnswerDTO;
import com.rycf.gjb.entity.FurnitureRequired;
import com.rycf.gjb.service.FurnitureRequiredService;
import com.rycf.gjb.util.UuidUtils;
@Service
public class FurnitureRequiredServiceImpl implements FurnitureRequiredService {
	@Resource
	private FurnitureRequiredDao requiredDao;
	@Resource
	private RequiredAnswerDao answerDao;
	@Resource
	private FurnitureTypeDao typeDao;
	@Resource
	private FurnitureStyleDao styleDao;
	@Override
	public void saveRequired(FurnitureRequired furnitureRequired) {
		furnitureRequired.setRequiredId(UuidUtils.getObjectUUID("required"));
		requiredDao.saveRequired(furnitureRequired);
	}

	@Override
	public void updateRequired(FurnitureRequired furnitureRequired) {
		requiredDao.updateRequired(furnitureRequired);
	}

	@Override
	public FurnitureRequiredDTO getRequiredById(String id) {
		return null;
	}

	@Override
	public PageDTO<List<FurnitureRequiredDTO>> getRequiredByPageAndParam(
			PageDTO<FurnitureRequired> page) {
		List<FurnitureRequiredDTO> list=requiredDao.getBudgetByPageAndParam(page);
		PageDTO<List<FurnitureRequiredDTO>> result=new PageDTO<List<FurnitureRequiredDTO>>();
		result.setParam(list);
		result.setPageIndex(page.getPageIndex());
		result.setPageSize(page.getPageSize());
		int count=requiredDao.getCountByParam(page.getParam());
		count=count%page.getPageSize()==0?count/page.getPageSize():count/page.getPageSize()+1;
		result.setTotalPage(count);
		
		
		//初始化功能区域以及家具平类
		for(FurnitureRequiredDTO requiredDTO:result.getParam()){
			String status=requiredDTO.getStatus();
			if("1".equals(status)){//需求中，没有答案
				requiredDTO.setCount(0);
			}else if("2".equals(status)){//有答案。初始化数目，以及读取第一张图片
				List<RequiredAnswerDTO> required2 =	
						answerDao.getAnswerByRequiredId(requiredDTO.getRequiredId());
				requiredDTO.setCount(required2.size());
				requiredDTO.setImg(required2.get(0).getImgs().split(",")[0]);
			}
			if(requiredDTO.getTypeIds()!=null){
				List<FurnitureTypeDTO> typeList=new ArrayList<FurnitureTypeDTO>();
				requiredDTO.setTypeDTOs(typeList);
				for(String typeId:requiredDTO.getTypeIds().split(",")){
					FurnitureTypeDTO temp=typeDao.getTypeById(typeId);
					if(temp!=null){
						typeList.add(temp);
					}
				}
			}
			if(requiredDTO.getStyleIds()!=null){
				List<FurnitureStyleDTO> styleList=new ArrayList<FurnitureStyleDTO>();
				requiredDTO.setStyleDTOs(styleList);
				for(String styleId:requiredDTO.getStyleIds().split(",")){
					FurnitureStyleDTO temp=styleDao.getStyleById(styleId);
					if(temp!=null){
						styleList.add(temp);
					}
				}
			}
		}
		return result;
	}

	@Override
	public int getCountByParam(FurnitureRequired furnitureRequired) {
		return 0;
	}

}
