package com.rycf.gjb.service;

import com.rycf.gjb.entity.ThirdNormal;

public interface ThirdNormalService {
	void save( ThirdNormal normal);
	ThirdNormal getByGetMoreId( Integer getMoreId);

}
