package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.FurnitureBudgetDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.FurnitureBudget;

public interface FurnitureBudgetDao {
	void saveBudget(@Param(value = "budget") FurnitureBudget furnitureBudget);
	void updateBudget(@Param(value = "budget") FurnitureBudget furnitureBudget);
	FurnitureBudgetDTO getBudgetById(@Param(value = "id") String id);
	List<FurnitureBudgetDTO> getBudgetByPageAndParam(@Param(value = "page") PageDTO<FurnitureBudget> page);
	int getCountByParam(FurnitureBudget furnitureBudget);
	List<FurnitureBudgetDTO> getAllBudget();
}
