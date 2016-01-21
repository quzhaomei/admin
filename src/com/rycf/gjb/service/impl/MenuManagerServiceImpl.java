package com.rycf.gjb.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.rycf.gjb.dao.MenuManagerDao;
import com.rycf.gjb.dto.MenuManagerDTO;
import com.rycf.gjb.entity.MenuManager;
import com.rycf.gjb.service.MenuManagerService;
import com.rycf.gjb.util.UuidUtils;
@Service
public class MenuManagerServiceImpl implements MenuManagerService{
	@Resource
	private MenuManagerDao menuManagerDao;
	@Override
	public List<MenuManagerDTO> findAllMenu() {
		
		return menuManagerDao.findAllMenu();
	}
	@Override
	public MenuManagerDTO getMenuById(String id) {
		return menuManagerDao.getMenuById(id);
	}
	@Override
	public void saveMenu(MenuManager menuManager) {
		menuManager.setMenuId(UuidUtils.getObjectUUID("menu"));
		menuManagerDao.saveMenu(menuManager);	
	}
	@Override
	public void updateMenu(MenuManager menu) {
		menuManagerDao.updateMenu(menu);
	}
	@Override
	public List<MenuManagerDTO> findMenuByRole(String roleId) {
		return menuManagerDao.findMenuByRole(roleId);
	}
	@Override
	public int findMenuByParentId(String parentId) {
		return menuManagerDao.findMenuByParentId(parentId);
	}

}
