package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.FurnitureBudgetDao;
import com.rycf.gjb.dto.FurnitureBudgetDTO;
import com.rycf.gjb.entity.FurnitureBudget;
import com.rycf.gjb.service.FurnitureBudgetService;
import com.rycf.gjb.util.UuidUtils;

@Service
public class FurnitureBudgetServiceImpl implements FurnitureBudgetService {
	@Resource
	private FurnitureBudgetDao FurnitureBudgetDao;
	@Override
	public void saveBudget(FurnitureBudget furnitureBudget) {
		furnitureBudget.setBudgetId(UuidUtils.getObjectUUID("budget"));
		FurnitureBudgetDao.saveBudget(furnitureBudget);
	}

	@Override
	public void updateBudget(FurnitureBudget furnitureBudget) {
		FurnitureBudgetDao.updateBudget(furnitureBudget);
	}

	@Override
	public FurnitureBudgetDTO getBudgetById(String id) {
		return FurnitureBudgetDao.getBudgetById(id);
	}

	@Override
	public List<FurnitureBudgetDTO> getAllBudget() {
		return FurnitureBudgetDao.getAllBudget();
	}

}
