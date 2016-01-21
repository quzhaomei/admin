package com.rycf.gjb.service.minisite;

import java.util.List;

import com.rycf.gjb.entity.minisite.NineteenActivity;

public interface NineteenActivityService {
	void saveNineteenActivity(NineteenActivity nineteenActivity);
	List<NineteenActivity> getAllNineteenActivity();
	NineteenActivity getByPhone(String phone);
	NineteenActivity getByPhoneAndType(String phone,Integer type);
	List<NineteenActivity> getNineteenActivityByType(Integer type);
}
