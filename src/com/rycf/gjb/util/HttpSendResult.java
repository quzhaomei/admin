package com.rycf.gjb.util;
/**
 *邮件发送结果 
 */
public class HttpSendResult {
	private Boolean isSuccess;
	private String info;
	public Boolean getIsSuccess() {
		return isSuccess;
	}
	public void setIsSuccess(Boolean isSuccess) {
		this.isSuccess = isSuccess;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public HttpSendResult(Boolean isSuccess, String info) {
		super();
		this.isSuccess = isSuccess;
		this.info = info;
	}
	
}
