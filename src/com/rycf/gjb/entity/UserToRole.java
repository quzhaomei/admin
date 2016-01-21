package com.rycf.gjb.entity;
/**
 * 用户角色，中间表
 * @author Administrator
 */
public class UserToRole {
	private Integer id;
	private String userId;
	private String roleId;
	public Integer getId() {
		return id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
}
