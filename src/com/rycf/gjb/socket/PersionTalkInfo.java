package com.rycf.gjb.socket;

public class PersionTalkInfo {
	private Integer toId;//来至
	private String message;//信息
	private Long datatime;//时间
	
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
	public Long getDatatime() {
		return datatime;
	}
	public void setDatatime(Long datatime) {
		this.datatime = datatime;
	}
	
}
