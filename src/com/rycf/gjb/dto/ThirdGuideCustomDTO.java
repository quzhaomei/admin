package com.rycf.gjb.dto;

/**
 * 第三方导购客户信息
 * @author Administrator
 */
public class ThirdGuideCustomDTO {
	private Integer getMoreId;
	private Integer guideId;
	private String nickname;
	private String headimgurl;
	private String phone;
	
	private Integer orderCount;
	private Float totalPay;
	
	private Integer uncheckCount;
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
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
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getHeadimgurl() {
		return headimgurl;
	}
	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
	}
	public Integer getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(Integer orderCount) {
		this.orderCount = orderCount;
	}
	public Float getTotalPay() {
		return totalPay;
	}
	public void setTotalPay(Float totalPay) {
		this.totalPay = totalPay;
	}
	public Integer getUncheckCount() {
		return uncheckCount;
	}
	public void setUncheckCount(Integer uncheckCount) {
		this.uncheckCount = uncheckCount;
	}
	
	
}
