package com.rycf.gjb.entity;

import java.io.Serializable;
import java.util.Date;
/**
 * 角色类，一个角色对应多个权限
 * @author qzm
 *
 * @since 2015-6-10
 */
public class RoleManager implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String roleId;//主键
	private String roleName;//角色名字
	private String status;//状态，0-删除，1-有效
	private Date createDate;//创建的时间
	private String createUserId;//创建的管理员ID。
	private Date updateDate;//更新时间
	private String updateUserId;//更新操作的管理员ID
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
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
	
}
