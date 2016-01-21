package com.rycf.gjb.dto;

import java.util.Date;

/**
 * 第三方渠道商
 * @author Administrator
 */
public class ThirdChannelDTO {
	private Integer id;//ID
	private ThirdChannelDTO parent;//父ID 没有则为-1
	private GetMoreUserDTO userDTO;//绑定的凯特ID
	private Integer isCompany;//是否是公司 0-不是，1-是
	private String name;//名字         50
	private Integer sex;//性别          5  1-男，0-女，
	private String phone;//手机         11
	private Integer type;//类别  0-个人名义， 1-父级名义    
	private String introImg;//名片              200
	private Integer status;//0-提交审核，1-审核通过，2-审核不通过   5
	private String description;//备注     200
	private Date createDate;//提交时间；
	private Date updateDate;//修改时间
	private String updateUserId;
	private String code;//随机码         11
	private String job;//职业         20
	
	private Float unpay;//未支付的      11
	private Float totalPay;//总已支付的      11
	
	private Float rate;//比例         11
	
	public Float getRate() {
		return rate;
	}
	public void setRate(Float rate) {
		this.rate = rate;
	}
	
	public Float getUnpay() {
		return unpay;
	}
	public void setUnpay(Float unpay) {
		this.unpay = unpay;
	}
	public Float getTotalPay() {
		return totalPay;
	}
	public void setTotalPay(Float totalPay) {
		this.totalPay = totalPay;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public Integer getIsCompany() {
		return isCompany;
	}
	public void setIsCompany(Integer isCompany) {
		this.isCompany = isCompany;
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
	
	public String getUpdateUserId() {
		return updateUserId;
	}
	public void setUpdateUserId(String updateUserId) {
		this.updateUserId = updateUserId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public ThirdChannelDTO getParent() {
		return parent;
	}
	public void setParent(ThirdChannelDTO parent) {
		this.parent = parent;
	}
	public GetMoreUserDTO getUserDTO() {
		return userDTO;
	}
	public void setUserDTO(GetMoreUserDTO userDTO) {
		this.userDTO = userDTO;
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
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getIntroImg() {
		return introImg;
	}
	public void setIntroImg(String introImg) {
		this.introImg = introImg;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	
}
