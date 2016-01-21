package com.rycf.gjb.talk;

import com.rycf.gjb.dto.BrandDTO;

/**
 * 聊天用户
 * @author Administrator
 */
public class TalkUser {
	private Integer getMoreId;
	private String nickname;//昵称
	private String headImg;//头像
	
	private BrandDTO brand;//针对导购所属的品牌

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

	public String getHeadImg() {
		return headImg;
	}

	public void setHeadImg(String headImg) {
		this.headImg = headImg;
	}

	public BrandDTO getBrand() {
		return brand;
	}

	public void setBrand(BrandDTO brand) {
		this.brand = brand;
	}
	
	
}
