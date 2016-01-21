package com.rycf.gjb.dto;

import java.util.Date;
/**
 * 角色管理业务类
 * @author qzm
 *
 * @since 2015-6-11
 */
public class RoleManagerDTO {
	private String roleId;
	private String roleName;
	private String status;
	private Date createDate;//创建的时间
	private SystemUserDTO createUser;//创建的管理员ID。
	private Date updateDate;//更新时间
	private SystemUserDTO updateUser;//更新操作的管理员ID
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
	public SystemUserDTO getCreateUser() {
		return createUser;
	}
	public void setCreateUser(SystemUserDTO createUser) {
		this.createUser = createUser;
	}
	public SystemUserDTO getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(SystemUserDTO updateUser) {
		this.updateUser = updateUser;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	
}
