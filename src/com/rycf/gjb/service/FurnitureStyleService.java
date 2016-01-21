package com.rycf.gjb.service;

import java.util.List;

import com.rycf.gjb.dto.FurnitureStyleDTO;
import com.rycf.gjb.entity.FurnitureStyle;

public interface FurnitureStyleService {
	void saveStyle(FurnitureStyle furnitureStyle);
	void updateStyle(FurnitureStyle furnitureStyle);
	FurnitureStyleDTO getStyleById( String id);
	List<FurnitureStyleDTO> getAllStyle();
}
