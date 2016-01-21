package com.rycf.gjb.dto;

/**
 * 菜单业务类
 * @author qzm
 *
 * @since 2015-6-10
 */
public class MenuManagerDTO {
	private String menuId;//主键
	private String menuName;//名称
	private String url;//链接
	private String parentId;//父导航ID。如果没有则为-1
	private String status;//状态，0-删除，1-有效
	private String type;//0-菜单，1-操作
	private String hasPower;//是否可以访问，0不可以，1可以，
	
	public String getHasPower() {
		return hasPower;
	}
	public void setHasPower(String hasPower) {
		this.hasPower = hasPower;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}
