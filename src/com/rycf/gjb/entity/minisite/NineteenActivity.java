package com.rycf.gjb.entity.minisite;

import java.util.Date;

/**
 * 19家活动
 * @author Administrator
 *
 */
public class NineteenActivity {
	private String activeId;//活动id
	private String relName;
	private String phone;
	private String takeBus;//0-不乘坐，1-乘坐
	private String source;//渠道
	private Integer type;//0-19家活动  1-年底活动
	private Date createDate;
	
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getActiveId() {
		return activeId;
	}
	public void setActiveId(String activeId) {
		this.activeId = activeId;
	}
	public String getRelName() {
		return relName;
	}
	public void setRelName(String relName) {
		this.relName = relName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getTakeBus() {
		return takeBus;
	}
	public void setTakeBus(String takeBus) {
		this.takeBus = takeBus;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
}
