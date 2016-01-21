package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.BrandDTO;
import com.rycf.gjb.dto.RequiredAnswerDTO;
import com.rycf.gjb.entity.RequiredAnswer;

public interface RequiredAnswerService {
	void saveAnswer(RequiredAnswer answer);
	void updateAnswer(RequiredAnswer answer);
	List<RequiredAnswerDTO> getAnswerByRequiredId(String requiredId);
	List<RequiredAnswerDTO> getAnswerByOpenId(String userId);
	List<RequiredAnswerDTO> getAnswerByUserId(RequiredAnswer answer);
	List<BrandDTO> getUserNoAnswerBrand(RequiredAnswer answer);
}
