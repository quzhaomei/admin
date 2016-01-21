package com.rycf.gjb.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 系统人员类，一个系统人员，可以对应多个角色
 * 
 * @author qzm
 * 
 * @since 2015-6-10
 */
public class SystemUser implements Serializable {
	/**
	 */
	private static final long serialVersionUID = 1L;
	private String systemUserId;// 主键
	private String userName;// 用户名
	private String loginname;// 登录名
	private String password;// 登录密码
	private String phone;// 电话 ：用于找回密码
	private String email;//	邮箱
	private String wechatId;//微信号
	private String status;// 状态，0-删除，1-有效,2-冻结
	private Date createDate;// 创建的时间
	private String createUserId;// 创建的管理员ID。
	private Date updateDate;// 更新时间
	private String updateUserId;// 更新操作的管理员ID
	private String rolesArrStr;// 用户对应的角色ID字符串。id,id 隔开的字符串
	private String description;//备注
	public String getSystemUserId() {
		return systemUserId;
	}
	public void setSystemUserId(String systemUserId) {
		this.systemUserId = systemUserId;
	}
	public String getEmail() {
		return email;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public void setEmail(String email) {
		this.email = email;
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
	
	public String getWechatId() {
		return wechatId;
	}
	public void setWechatId(String wechatId) {
		this.wechatId = wechatId;
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
	public String getRolesArrStr() {
		return rolesArrStr;
	}
	public void setRolesArrStr(String rolesArrStr) {
		this.rolesArrStr = rolesArrStr;
	}
	
}
