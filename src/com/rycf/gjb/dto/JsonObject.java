package com.rycf.gjb.dto;


/**
 * 负责封装json数据，
 * @author qzm
 *
 */
public class JsonObject {
	/**
	 * 状态 "true" 或者"false",表示该次处理的返回结果，成功与否
	 */
	private String status;
	/**
	 * 表示需要返回的提示信息。
	 */
	private String message;
	/**
	 * 表示返回的数据
	 */
	private Object data;
	public String getStatus() {
		return status;
	}
	public JsonObject setStatus(String status) {
		this.status = status;
		return this;
	}
	public String getMessage() {
		return message;
	}
	public JsonObject setMessage(String message) {
		this.message = message;
		return this;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	
	
}
