package com.rycf.gjb.dto;

import java.util.Date;

/**
 * 用户的银行卡信息
 * @author Administrator
 *
 */
public class UserCardDTO {
	private String userCardId;
	private Integer getMoreId;//用户id
	private String bankName;//银行名字
	private String accountAddr;//开户位置
	private String cardNo;//卡号
	private String username;//用户名
	private Date createDate;//创建时间
	private Date updatedate;//更新时间
	private String statu;//0-冻结，1-正常
	
	public String getUserCardId() {
		return userCardId;
	}
	public void setUserCardId(String userCardId) {
		this.userCardId = userCardId;
	}
	
	public Integer getGetMoreId() {
		return getMoreId;
	}
	public void setGetMoreId(Integer getMoreId) {
		this.getMoreId = getMoreId;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getAccountAddr() {
		return accountAddr;
	}
	public void setAccountAddr(String accountAddr) {
		this.accountAddr = accountAddr;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}
	public String getStatu() {
		return statu;
	}
	public void setStatu(String statu) {
		this.statu = statu;
	}
	
}
