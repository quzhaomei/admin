package com.rycf.gjb.talk;

import java.util.Date;
/**
 * 聊天记录
 * @author qzm
 */
public class TalkHistory {
	private Integer id;
	private Integer fromId;//来自于谁
	private Integer toId;//给谁，
	private String message;//对话信息
	
	private Integer status;//0-发出中，1-已接受
	private Date createDate;//创建时间
	
	/**
	private Integer type;//0-一时段对话，1-对话中的一段信息
	private Integer parentId;// 一段对话的ID
	private Integer info1;//预留打分字段，针对某一段对话
	private Integer info2;//预留打分字段，针对某一段对话
	**/
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getFromId() {
		return fromId;
	}
	public void setFromId(Integer fromId) {
		this.fromId = fromId;
	}
	public Integer getToId() {
		return toId;
	}
	public void setToId(Integer toId) {
		this.toId = toId;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
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
	
	
	
}
