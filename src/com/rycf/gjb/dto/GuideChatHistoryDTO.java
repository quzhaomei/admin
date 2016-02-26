package com.rycf.gjb.dto;

import java.util.Date;
/**
 * 聊天记录
 * @author Administrator
 */
public class GuideChatHistoryDTO {
	private Integer historyId;//主键
	private GetMoreUserDTO fromUser;
	private GetMoreUserDTO toUser;
	private Date createDate;//创建
	private String content;//内容
	private Integer status;	//0-未接收，1-已接收，
	
	private long timeStamp;//时间戳
	public Integer getHistoryId() {
		return historyId;
	}
	public void setHistoryId(Integer historyId) {
		this.historyId = historyId;
	}
	
	public GetMoreUserDTO getFromUser() {
		return fromUser;
	}
	public void setFromUser(GetMoreUserDTO fromUser) {
		this.fromUser = fromUser;
	}
	public GetMoreUserDTO getToUser() {
		return toUser;
	}
	public void setToUser(GetMoreUserDTO toUser) {
		this.toUser = toUser;
	}
	public long getTimeStamp() {
		return timeStamp;
	}
	public void setTimeStamp(long timeStamp) {
		this.timeStamp = timeStamp;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
}