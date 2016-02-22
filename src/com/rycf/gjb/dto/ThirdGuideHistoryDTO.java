package com.rycf.gjb.dto;

import java.util.Date;

/**
 * 第三方导购客户信息
 * @author Administrator
 */
public class ThirdGuideHistoryDTO {
	private Integer getMoreId;
	private String nickname;
	private String headimgurl;
	
	private Date lastTime;
	
	private int isFriend;
	
	private Integer uncheckCount;
	
	public Date getLastTime() {
		return lastTime;
	}
	public void setLastTime(Date lastTime) {
		this.lastTime = lastTime;
	}
	public int getIsFriend() {
		return isFriend;
	}
	public void setIsFriend(int isFriend) {
		this.isFriend = isFriend;
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
	
	public Integer getUncheckCount() {
		return uncheckCount;
	}
	public void setUncheckCount(Integer uncheckCount) {
		this.uncheckCount = uncheckCount;
	}
	
	
}
