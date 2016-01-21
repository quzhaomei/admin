package com.rycf.gjb.dto;
/**
 * 门店
 * @author Administrator
 *
 */
public class StoreDTO {
	private String storeId;
	private String storeName;
	private String status;
	private String address;
	private String doorCode;//门牌号;
	private Float lat;//维度
	private Float lng;//经度
	private BrandDTO brand;//品牌
	private SystemUserDTO user;//店长
	
	public String getDoorCode() {
		return doorCode;
	}
	public void setDoorCode(String doorCode) {
		this.doorCode = doorCode;
	}
	public SystemUserDTO getUser() {
		return user;
	}
	public void setUser(SystemUserDTO user) {
		this.user = user;
	}
	public BrandDTO getBrand() {
		return brand;
	}
	public void setBrand(BrandDTO brand) {
		this.brand = brand;
	}
	//页面data
	private Double distance;//距离
	
	public Double getDistance() {
		return distance;
	}
	public void setDistance(Double distance) {
		this.distance = distance;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Float getLat() {
		return lat;
	}
	public void setLat(Float lat) {
		this.lat = lat;
	}
	public Float getLng() {
		return lng;
	}
	public void setLng(Float lng) {
		this.lng = lng;
	}
}
