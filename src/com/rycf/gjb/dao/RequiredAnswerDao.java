package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.BrandDTO;
import com.rycf.gjb.dto.RequiredAnswerDTO;
import com.rycf.gjb.entity.RequiredAnswer;

public interface RequiredAnswerDao {
	void saveAnswer(@Param(value="answer")RequiredAnswer answer);
	void updateAnswer(@Param(value="answer")RequiredAnswer answer);
	List<RequiredAnswerDTO> getAnswerByRequiredId(@Param(value="requiredId")String requiredId);
	List<RequiredAnswerDTO> getAnswerByOpenId(@Param(value="openId")String openId);
	List<RequiredAnswerDTO> getAnswerByUserId(@Param(value="answer")RequiredAnswer answer);
	List<BrandDTO> getUserNoAnswerBrand(@Param(value="answer")RequiredAnswer answer);
//	List<BrandDTO> getNoAnswerBrandByBrandUserId(@Param(value="requiredAnswer")RequiredAnswer answer);
//	List<RequiredAnswerDTO> getAnswerByUserOfStore(@Param(value="requiredAnswer")RequiredAnswer answer);
}
