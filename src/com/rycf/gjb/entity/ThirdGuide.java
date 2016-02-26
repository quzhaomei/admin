package com.rycf.gjb.entity;

import java.util.Date;


/**
 * 第三方导购
 * @author Administrator
 */
public class ThirdGuide {
	private Integer guideId;//导购ID
	private Integer getMoreId;//绑定的凯特ID
	
	private String storeId;//店铺ID
	private String name;//20
	private Integer sex;//0-女，1-男
	private String phone;//手机
	private String job;//职务
	
	
	private Integer status;//状态 0-申请中，1-审核通过，2-冻结
	
	private Date createDate;//创建时间
	
	private Date updateDate;//更新时间

	//查询辅助条件
	private String userId;
	private String brandName;
	
	
	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Integer getGuideId() {
		return guideId;
	}

	public void setGuideId(Integer guideId) {
		this.guideId = guideId;
	}

	public Integer getGetMoreId() {
		return getMoreId;
	}

	public void setGetMoreId(Integer getMoreId) {
		this.getMoreId = getMoreId;
	}

	
	
	public String getStoreId() {
		return storeId;
	}

	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
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
	
	
}