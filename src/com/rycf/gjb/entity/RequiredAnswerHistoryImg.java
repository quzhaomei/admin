package com.rycf.gjb.entity;

import java.util.Date;

/**
 * 方案历史图
 * @author Administrator
 *
 */
public class RequiredAnswerHistoryImg {
	private String historyImgId;
	private String userId;
	private String imgPath;//路径
	private String status;//0-删除，1-正常
	private Date updateTime;
	public String getHistoryImgId() {
		return historyImgId;
	}
	public void setHistoryImgId(String historyImgId) {
		this.historyImgId = historyImgId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
}
