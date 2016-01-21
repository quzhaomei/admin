package com.rycf.gjb.service;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.MenuManagerDTO;
import com.rycf.gjb.entity.MenuManager;

public interface MenuManagerService {
	List<MenuManagerDTO> findAllMenu();
	MenuManagerDTO getMenuById(String id);
	void saveMenu(MenuManager menuManager);
	void updateMenu(MenuManager menu);
	List<MenuManagerDTO> findMenuByRole(String roleId);
	int findMenuByParentId(@Param( value = "parentId")String parentId);
}
