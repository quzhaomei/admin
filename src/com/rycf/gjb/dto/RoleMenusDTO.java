package com.rycf.gjb.dto;

public class RoleMenusDTO {
	private String roleMenusId;//主键
	private String roleId;//角色ID
	private String menuId;//菜单ID;
	private String status;//状态，0-删除，1-有效
	public String getRoleMenusId() {
		return roleMenusId;
	}
	public void setRoleMenusId(String roleMenusId) {
		this.roleMenusId = roleMenusId;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
