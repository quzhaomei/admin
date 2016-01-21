package com.rycf.gjb.dto;

import java.util.Date;


/**
 * 第三方导购
 * @author Administrator
 */
public class ThirdGuideDTO {
	private Integer guideId;//导购ID
	private GetMoreUserDTO getMoreUser;//绑定的凯特ID

	private StoreDTO store;//商铺
	private BrandDTO brand;//品牌
	
	private String name;//20
	private Integer sex;//0-女，1-男
	private String phone;//手机
	private String job;//职务
	
	private Integer status;//状态 0-申请中，1-审核通过，2-冻结
	
	private Date createDate;//创建时间
	
	private Date updateDate;//更新时间

	public Integer getGuideId() {
		return guideId;
	}

	public void setGuideId(Integer guideId) {
		this.guideId = guideId;
	}
	
	public BrandDTO getBrand() {
		return brand;
	}

	public void setBrand(BrandDTO brand) {
		this.brand = brand;
	}

	public GetMoreUserDTO getGetMoreUser() {
		return getMoreUser;
	}

	public void setGetMoreUser(GetMoreUserDTO getMoreUser) {
		this.getMoreUser = getMoreUser;
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

	public StoreDTO getStore() {
		return store;
	}

	public void setStore(StoreDTO store) {
		this.store = store;
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

	
}
