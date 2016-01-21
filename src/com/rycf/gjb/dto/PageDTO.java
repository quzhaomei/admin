package com.rycf.gjb.dto;


/**
 * 分页数据封装对象
 * @author qzm
 *
 * @since 2015-5-14
 */
public class PageDTO<T> {
	private int pageSize;//
	private int pageIndex;//
	private int totalPage;
	private T param;//
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public T getParam() {
		return param;
	}
	public void setParam(T param) {
		this.param = param;
	}
	
	
}
