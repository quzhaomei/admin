package com.rycf.gjb.talk;

import java.util.Date;

import com.rycf.gjb.dto.GetMoreUserDTO;
/**
 * 聊天记录
 * @author qzm
 */
public class TalkHistoryDTO {
	private Integer id;
	private GetMoreUserDTO fromUser;//来自于谁
	private GetMoreUserDTO toUser;//给谁，
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
