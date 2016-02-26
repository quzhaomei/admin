package com.rycf.gjb.dao;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.entity.ThirdNormal;

public interface ThirdNormalDao {
	void save(@Param(value = "normal") ThirdNormal normal);
	ThirdNormal getByGetMoreId(@Param(value = "getMoreId") Integer getMoreId);
}
