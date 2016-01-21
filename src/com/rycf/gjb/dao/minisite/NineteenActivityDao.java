package com.rycf.gjb.dao.minisite;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.entity.minisite.NineteenActivity;

public interface NineteenActivityDao {
	void saveNineteenActivity(@Param(value="data") NineteenActivity nineteenActivity);
	List<NineteenActivity> getAllNineteenActivity();
	List<NineteenActivity> getNineteenActivityByType(@Param(value="type")Integer type);
	NineteenActivity getByPhone(@Param(value="phone")String phone,@Param(value="type")Integer type);
}
