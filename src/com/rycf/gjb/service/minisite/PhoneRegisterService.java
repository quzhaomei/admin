package com.rycf.gjb.service.minisite;

import java.util.Date;
import java.util.List;

import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.minisite.PhoneRegister;

public interface PhoneRegisterService {
	void save( PhoneRegister register);
	void update(PhoneRegister register);
	List<PhoneRegister> getAll();
	List<PhoneRegister> getAllByType(Integer type);
	PhoneRegister getByParam(PhoneRegister register);
	PhoneRegister getById(String id);
	
	PageDTO<List<PhoneRegister>> getPageByParam(PageDTO<PhoneRegister> page);
	
	PageDTO<List<PhoneRegister>> getPageByParamAndTime(PageDTO<PhoneRegister> page
			,Date startTime,Date endTime);
}
