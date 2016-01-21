package com.rycf.gjb.service.impl.minisite;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.minisite.PhoneRegisterDao;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.minisite.PhoneRegister;
import com.rycf.gjb.service.minisite.PhoneRegisterService;
@Service
public class PhoneRegisterServiceImpl implements PhoneRegisterService {

	@Resource
	protected PhoneRegisterDao phoneRegisterDao;
	@Override
	public void save(PhoneRegister register) {
			phoneRegisterDao.save(register);
	}
	@Override
	public void update(PhoneRegister register) {
			phoneRegisterDao.update(register);
	}

	@Override
	public List<PhoneRegister> getAll() {
		return phoneRegisterDao.getAll();
	}

	@Override
	public PhoneRegister getByParam(PhoneRegister register) {
		return phoneRegisterDao.getByParam(register);
	}

	@Override
	public PhoneRegister getById(String id) {
		if(id!=null){
			PhoneRegister register=new PhoneRegister();
			register.setRegisterId(id);
			return phoneRegisterDao.getByParam(register);
		}
		return null;
	}
	@Override
	public PageDTO<List<PhoneRegister>> getPageByParam(
			PageDTO<PhoneRegister> page) {
		List<PhoneRegister> list=phoneRegisterDao.getPageByParam(page);
		
		PageDTO<List<PhoneRegister>> result = new PageDTO<List<PhoneRegister>>();
		result.setParam(list);
		result.setPageIndex(page.getPageIndex());
		result.setPageSize(page.getPageSize());
		
		int count = phoneRegisterDao.getCount(page.getParam());
		count = (count % page.getPageSize() == 0 ? count / page.getPageSize()
				: count / page.getPageSize() + 1);
		result.setTotalPage(count);
		return result;
	}
	@Override
	public PageDTO<List<PhoneRegister>> getPageByParamAndTime(
			PageDTO<PhoneRegister> page, Date startTime, Date endTime) {
List<PhoneRegister> list=phoneRegisterDao.getPageByParamAndTime(page, startTime, endTime);
		
		PageDTO<List<PhoneRegister>> result = new PageDTO<List<PhoneRegister>>();
		result.setParam(list);
		result.setPageIndex(page.getPageIndex());
		result.setPageSize(page.getPageSize());
		
		int count = phoneRegisterDao.getCountByTime(page.getParam(), startTime, endTime);
		count = (count % page.getPageSize() == 0 ? count / page.getPageSize()
				: count / page.getPageSize() + 1);
		result.setTotalPage(count);
		return result;
	}
	@Override
	public List<PhoneRegister> getAllByType(Integer type) {
		return phoneRegisterDao.getAllByType(type);
	}

}
