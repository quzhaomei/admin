package com.rycf.gjb.service.impl.minisite;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.minisite.NineteenActivityDao;
import com.rycf.gjb.entity.minisite.NineteenActivity;
import com.rycf.gjb.service.minisite.NineteenActivityService;
import com.rycf.gjb.util.UuidUtils;

@Service
public class NineteenActivityServiceImpl implements NineteenActivityService{
	@Resource
	private NineteenActivityDao dao;
	@Override
	public void saveNineteenActivity(NineteenActivity nineteenActivity) {
		nineteenActivity.setActiveId(UuidUtils.getObjectUUID("active"));
		dao.saveNineteenActivity(nineteenActivity);
	}

	@Override
	public List<NineteenActivity> getAllNineteenActivity() {
		return dao.getAllNineteenActivity();
	}


	@Override
	public List<NineteenActivity> getNineteenActivityByType(Integer type) {
		return dao.getNineteenActivityByType(type);
	}

	@Override
	public NineteenActivity getByPhone(String phone) {
		return dao.getByPhone(phone,null);
	}
	@Override
	public NineteenActivity getByPhoneAndType(String phone, Integer type) {
		return dao.getByPhone(phone, type);
	}

}
