package com.rycf.gjb.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.FurnitureRequiredDao;
import com.rycf.gjb.dao.FurnitureStyleDao;
import com.rycf.gjb.dao.FurnitureTypeDao;
import com.rycf.gjb.dao.FurnitureZoneDao;
import com.rycf.gjb.dao.RequiredAnswerDao;
import com.rycf.gjb.dao.SystemUserDao;
import com.rycf.gjb.dto.BrandDTO;
import com.rycf.gjb.dto.FurnitureStyleDTO;
import com.rycf.gjb.dto.FurnitureTypeDTO;
import com.rycf.gjb.dto.FurnitureZoneDTO;
import com.rycf.gjb.dto.RequiredAnswerDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.RequiredAnswer;
import com.rycf.gjb.service.RequiredAnswerService;
import com.rycf.gjb.util.UuidUtils;
@Service
public class RequiredAnswerServiceImpl implements RequiredAnswerService {
	@Resource
	private RequiredAnswerDao requiredAnswerDao;
	@Resource
	private FurnitureRequiredDao furnitureRequiredDao;
	@Resource
	private SystemUserDao userDao;
	
	@Resource
	private FurnitureZoneDao zoneDao;
	
	@Resource
	private FurnitureTypeDao typeDao;
	
	@Resource
	private FurnitureStyleDao styleDao;

	@Override
	public void saveAnswer(RequiredAnswer answer) {
		answer.setRequiredAnswerId(UuidUtils.getObjectUUID("required"));
		requiredAnswerDao.saveAnswer(answer);
	}

	@Override
	public void updateAnswer(RequiredAnswer answer) {
		requiredAnswerDao.updateAnswer(answer);
	}

	@Override
	public List<RequiredAnswerDTO> getAnswerByRequiredId(String requiredId) {
		List<RequiredAnswerDTO> result=requiredAnswerDao.getAnswerByRequiredId(requiredId);
		for(RequiredAnswerDTO temp:result){
		//初始化需求
			temp.setRequiredDto(furnitureRequiredDao.getRequiredById(requiredId));
		//初始化用户
			SystemUserDTO user=userDao.getSystemUserById(temp.getUser().getSystemUserId());
			temp.setUser(user);
		//初始化功能区域
			List<FurnitureZoneDTO> zoneTemp=new ArrayList<FurnitureZoneDTO>();
			if(temp.getZoneIds()!=null)
			for(String str:temp.getZoneIds().split(",")){
				zoneTemp.add(zoneDao.getZoneById(str));
			}
			temp.setZones(zoneTemp);
		//初始化品类
			List<FurnitureTypeDTO> typeTemp=new ArrayList<FurnitureTypeDTO>();
			if(temp.getTypeIds()!=null)
			for(String str:temp.getTypeIds().split(",")){
				typeTemp.add(typeDao.getTypeById(str));
			}
			temp.setTypes(typeTemp);
		//初始化风格样式
			List<FurnitureStyleDTO> styleTemp=new ArrayList<FurnitureStyleDTO>();
			if(temp.getStyleIds()!=null)
			for(String str:temp.getStyleIds().split(",")){
				styleTemp.add(styleDao.getStyleById(str));
			}
			temp.setStyles(styleTemp);
		}
		return result;
	}

	@Override
	public List<RequiredAnswerDTO> getAnswerByOpenId(String openId) {
		List<RequiredAnswerDTO> result=requiredAnswerDao.getAnswerByOpenId(openId);
		for(RequiredAnswerDTO temp:result){
		//初始化需求
			temp.setRequiredDto(furnitureRequiredDao.getRequiredById(temp.getRequiredId()));
		//初始化用户
			SystemUserDTO user=userDao.getSystemUserById(temp.getUser().getSystemUserId());
			temp.setUser(user);
		//初始化功能区域
			List<FurnitureZoneDTO> zoneTemp=new ArrayList<FurnitureZoneDTO>();
			if(temp.getZoneIds()!=null)
			for(String str:temp.getZoneIds().split(",")){
				zoneTemp.add(zoneDao.getZoneById(str));
			}
			temp.setZones(zoneTemp);
		//初始化品类
			List<FurnitureTypeDTO> typeTemp=new ArrayList<FurnitureTypeDTO>();
			if(temp.getTypeIds()!=null)
			for(String str:temp.getTypeIds().split(",")){
				typeTemp.add(typeDao.getTypeById(str));
			}
			temp.setTypes(typeTemp);
		//初始化风格样式
			List<FurnitureStyleDTO> styleTemp=new ArrayList<FurnitureStyleDTO>();
			if(temp.getStyleIds()!=null)
			for(String str:temp.getStyleIds().split(",")){
				styleTemp.add(styleDao.getStyleById(str));
			}
			temp.setStyles(styleTemp);
		}
		return result;
	}

	@Override
	public List<RequiredAnswerDTO> getAnswerByUserId(RequiredAnswer answer) {
		List<RequiredAnswerDTO> result=requiredAnswerDao.getAnswerByUserId(answer);
		for(RequiredAnswerDTO temp:result){
		//初始化需求
//			temp.setRequiredDto(furnitureRequiredDao.getRequiredById(answer.getRequiredId()));
		//初始化用户
			SystemUserDTO user=userDao.getSystemUserById(temp.getUser().getSystemUserId());
			temp.setUser(user);
		//初始化功能区域
			List<FurnitureZoneDTO> zoneTemp=new ArrayList<FurnitureZoneDTO>();
			if(temp.getZoneIds()!=null)
			for(String str:temp.getZoneIds().split(",")){
				zoneTemp.add(zoneDao.getZoneById(str));
			}
			temp.setZones(zoneTemp);
		//初始化品类
			List<FurnitureTypeDTO> typeTemp=new ArrayList<FurnitureTypeDTO>();
			if(temp.getTypeIds()!=null)
			for(String str:temp.getTypeIds().split(",")){
				typeTemp.add(typeDao.getTypeById(str));
			}
			temp.setTypes(typeTemp);
		//初始化风格样式
			List<FurnitureStyleDTO> styleTemp=new ArrayList<FurnitureStyleDTO>();
			if(temp.getStyleIds()!=null)
			for(String str:temp.getStyleIds().split(",")){
				styleTemp.add(styleDao.getStyleById(str));
			}
			temp.setStyles(styleTemp);
		}
		return result;
	}

	@Override
	public List<BrandDTO> getUserNoAnswerBrand(RequiredAnswer answer) {
		return requiredAnswerDao.getUserNoAnswerBrand(answer);
	}

}
