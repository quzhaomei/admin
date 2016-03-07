package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.ThirdGuideCustomDTO;
import com.rycf.gjb.dto.ThirdGuideDTO;
import com.rycf.gjb.dto.ThirdGuideHistoryDTO;
import com.rycf.gjb.entity.ThirdGuide;

public interface ThirdGuideService {
	void save( ThirdGuide guide);
	void update(ThirdGuide guide);
	ThirdGuideDTO getById( Integer id);
	ThirdGuideDTO getByGetMoreId(Integer getMoreId);
	
	PageDTO<List<ThirdGuideDTO>> getByPageAndParam( PageDTO<ThirdGuide> page);
	
	
	List<ThirdGuideDTO> getList( ThirdGuide guide);
	
	int getCountByParam(ThirdGuide guide);
	
	List<ThirdGuideCustomDTO> getCustomByGuideId( Integer guideId);
	
	int getCustomCountByGuideId( Integer guideId);
	
	int getTalkCountByGetMoreId( Integer getMoreId);
	
	int getUncheckTalkCountByGetMoreId( Integer getMoreId);
	
	int getQuestionCountByGetMoreId( Integer getMoreId);
	int getUncheckQuestionCountByGetMoreId( Integer getMoreId);
	
	int check(Integer getMoreId,Integer guideId);
	
	int checkByBrandId(Integer getMoreId,String brandId);

	void userSetGuide(Integer getMoreId,Integer guideId);
	
	List<ThirdGuideHistoryDTO> getHistoryGuideId(Integer getMoreId);
	
	List<ThirdGuideDTO> getGuideByUserId(Integer getmoreId);
	
	List<ThirdGuideHistoryDTO> getHistoryGetMoreId( Integer getMoreId);
}
