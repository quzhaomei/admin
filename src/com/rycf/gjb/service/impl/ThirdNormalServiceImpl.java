package com.rycf.gjb.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rycf.gjb.dao.ThirdNormalDao;
import com.rycf.gjb.entity.ThirdNormal;
import com.rycf.gjb.service.ThirdNormalService;

@Service
@Transactional
public class ThirdNormalServiceImpl implements ThirdNormalService{
	@Resource
	private ThirdNormalDao normalDao;

	@Override
	public void save(ThirdNormal normal) {
		normalDao.save(normal);
	}

	@Override
	public ThirdNormal getByGetMoreId(Integer getMoreId) {
		return normalDao.getByGetMoreId(getMoreId);
	}

}
