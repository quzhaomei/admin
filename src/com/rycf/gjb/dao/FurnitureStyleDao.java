package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.FurnitureStyleDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.FurnitureStyle;

public interface FurnitureStyleDao {
	void saveStyle(@Param(value = "style") FurnitureStyle furnitureStyle);
	void updateStyle(@Param(value = "style") FurnitureStyle furnitureStyle);
	FurnitureStyleDTO getStyleById(@Param(value = "id") String id);
	List<FurnitureStyleDTO> getStyleByPageAndParam(@Param(value = "page") PageDTO<FurnitureStyle> page);
	int getCountByParam(FurnitureStyle furnitureStyle);
	List<FurnitureStyleDTO> getAllStyle();
}
