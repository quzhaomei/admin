package com.rycf.gjb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rycf.gjb.dto.MenuManagerDTO;
import com.rycf.gjb.entity.MenuManager;
/**
 * 表情对象DAO
 * @author qzm
 *
 * @since 2015-5-7
 */
public interface MenuManagerDao {
	 MenuManagerDTO getMenuById(@Param( value = "id")String id);
	/**
	 * 保存菜单
	 * @param brow
	 * @return
	 */
	void saveMenu(@Param( value = "menu")MenuManager menu);
	/**
	 * 修改菜单
	 * @param menu
	 */
	void updateMenu(@Param( value = "menu")MenuManager menu);
	/**
	 * 查找所有的菜单
	 * @return
	 */
	List<MenuManagerDTO> findAllMenu();
	/**
	 * 根据角色查找菜单
	 * @return
	 */
	List<MenuManagerDTO> findMenuByRole(@Param( value = "roleId")String roleId);
	/**
	 * 查询所有子菜单的数量
	 */
	int findMenuByParentId(@Param( value = "parentId")String parentId);
}
