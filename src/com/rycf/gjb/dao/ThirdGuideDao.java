package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.ThirdGuideCustomDTO;
import com.rycf.gjb.dto.ThirdGuideDTO;
import com.rycf.gjb.dto.ThirdGuideHistoryDTO;
import com.rycf.gjb.entity.ThirdGuide;

public interface ThirdGuideDao {
	void save(@Param(value = "guide") ThirdGuide guide);
	void update(@Param(value = "guide") ThirdGuide guide);
	ThirdGuideDTO getById(@Param(value = "id") Integer id);
	ThirdGuideDTO getByGetMoreId(@Param(value = "getMoreId") Integer getMoreId);
	List<ThirdGuideDTO> getByPageAndParam(@Param(value = "page") PageDTO<ThirdGuide> page);
	
	
	
	List<ThirdGuideDTO> getListByParam(@Param(value = "guide") ThirdGuide guide);
	int getCountByParam(@Param(value = "guide")ThirdGuide guide);
	
	List<ThirdGuideCustomDTO> getCustomByGuideId(@Param(value = "guideId") Integer guideId);
	int getCustomCountByGuideId(@Param(value = "guideId") Integer guideId);
	
	int getTalkCountByGetMoreId(@Param(value = "getMoreId") Integer getMoreId);
	
	int check(@Param(value = "getMoreId") Integer getMoreId,@Param(value = "guideId") Integer guideId);
	
	int checkByBrandId(@Param(value = "getMoreId") Integer getMoreId,@Param(value = "brandId") String brandId);

	void userSetGuide(@Param(value = "getMoreId") Integer getMoreId,@Param(value = "guideId") Integer guideId);

	List<ThirdGuideHistoryDTO> getHistoryGuideId(@Param(value = "getMoreId") Integer getMoreId);
}
