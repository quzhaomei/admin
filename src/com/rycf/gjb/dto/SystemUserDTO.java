package com.rycf.gjb.dto;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class SystemUserDTO {
	/**
	 */
	private String systemUserId;// 主键
	private String userName;// 用户名
	private String loginname;// 登录名
	private String password;// 登录密码
	private String phone;// 电话 ：用于找回密码
	private String email;// email
	private String wechatId;//微信号
	private String status;// 状态，0-激活，1-冻结，2-删除
	private Date createDate;// 创建的时间
	private SystemUserDTO createUserDTO;// 创建的管理员
	private Date updateDate;// 更新时间
	private SystemUserDTO updateUserDTO;// 更新操作的管理员
	private String rolesArrStr;
	private List<RoleManagerDTO> rolesArr;// 用户对应的角色ID字符串。id,id 隔开的字符串
	private Map<String,MenuManagerDTO> menuList;//用户可以访问的菜单
	private String description;//备注
	public String getDescription() {
		return description;
	}

	public String getWechatId() {
		return wechatId;
	}

	public void setWechatId(String wechatId) {
		this.wechatId = wechatId;
	}

	public String getEmail() {
		return email;
	}
	
	

	public Map<String, MenuManagerDTO> getMenuList() {
		return menuList;
	}

	public void setMenuList(Map<String, MenuManagerDTO> menuList) {
		this.menuList = menuList;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getSystemUserId() {
		return systemUserId;
	}
	public void setSystemUserId(String systemUserId) {
		this.systemUserId = systemUserId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
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
	
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public List<RoleManagerDTO> getRolesArr() {
		return rolesArr;
	}
	public void setRolesArr(List<RoleManagerDTO> rolesArr) {
		this.rolesArr = rolesArr;
	}
	
	public SystemUserDTO getCreateUserDTO() {
		return createUserDTO;
	}
	public void setCreateUserDTO(SystemUserDTO createUserDTO) {
		this.createUserDTO = createUserDTO;
	}
	public SystemUserDTO getUpdateUserDTO() {
		return updateUserDTO;
	}
	public void setUpdateUserDTO(SystemUserDTO updateUserDTO) {
		this.updateUserDTO = updateUserDTO;
	}
	public String getRolesArrStr() {
		return rolesArrStr;
	}
	public void setRolesArrStr(String rolesArrStr) {
		this.rolesArrStr = rolesArrStr;
	}

}
