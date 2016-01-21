package com.rycf.gjb.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 菜单导航类
 * @author qzm
 *
 * @since 2015-6-10
 */
public class MenuManager implements Serializable{
	/**
	 * 版本号
	 */
	private static final long serialVersionUID = 1L;
	private String menuId;//主键
	private String menuName;//名称
	private String url;//链接
	private String parentId;//父导航ID。如果没有则为-1
	private String status;//状态，0-删除，1-有效
	private String type;//-1，初始化url，菜单-0-需要显示在导航栏上。操作-1-，菜单为打开页面，操作为发送请求，
	private Date createDate;//创建的时间
	private String createUserId;//创建的管理员ID。
	private Date updateDate;//更新时间
	private String updateUserId;//更新操作的管理员ID
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
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public String getUpdateUserId() {
		return updateUserId;
	}
	public void setUpdateUserId(String updateUserId) {
		this.updateUserId = updateUserId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}
