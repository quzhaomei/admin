package com.rycf.gjb.dao.minisite;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.minisite.PhoneRegister;

public interface PhoneRegisterDao {
	void save(@Param(value="data") PhoneRegister register);
	void update(@Param(value="data") PhoneRegister register);
	List<PhoneRegister> getAll();
	List<PhoneRegister> getAllByType(@Param(value="type") Integer type);
	PhoneRegister getByParam(@Param(value="data")PhoneRegister register);
	
	List<PhoneRegister> getPageByParam(@Param(value="data")PageDTO<PhoneRegister> page);
	int  getCount(@Param(value="data")PhoneRegister param);
	
	List<PhoneRegister> getPageByParamAndTime(@Param(value="data")PageDTO<PhoneRegister> page
			,@Param(value="startTime")Date startTime,@Param(value="endTime")Date endTime);
	int  getCountByTime(@Param(value="data")PhoneRegister param,
			@Param(value="startTime")Date startTime,@Param(value="endTime")Date endTime);
}
