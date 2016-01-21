package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.FurnitureBudgetDTO;
import com.rycf.gjb.entity.FurnitureBudget;

public interface FurnitureBudgetService {
	void saveBudget(FurnitureBudget furnitureBudget);
	void updateBudget(FurnitureBudget furnitureBudget);
	FurnitureBudgetDTO getBudgetById(String id);
	List<FurnitureBudgetDTO> getAllBudget();
}
