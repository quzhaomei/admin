package com.rycf.gjb.entity;

import java.util.Date;

/**
 * 品牌
 * @author Administrator
 *
 */
public class Brand {
	private String brandId;//品牌ID
	private String brandName;//品牌名
	private String brandTypeIds;//品牌类型
	private String status;//0-无效，1-有效
	private String imgPath;//标志图片路径
	private String pinying;//拼音
	private String indexWord;//拼音首字母
	private Float rate;//返利比例
	private Float brandRate;//佣金比例
	private String introduce;//介绍
	private String proImgs;//产品图路径
	private Date createDate;
	private String createUserId;
	private Date updateDate;
	private String updateUserId;
	private Integer scanNum;//浏览量
	
	public Float getBrandRate() {
		return brandRate;
	}
	public void setBrandRate(Float brandRate) {
		this.brandRate = brandRate;
	}
	public String getBrandTypeIds() {
		return brandTypeIds;
	}
	public void setBrandTypeIds(String brandTypeIds) {
		this.brandTypeIds = brandTypeIds;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getIndexWord() {
		return indexWord;
	}
	public void setIndexWord(String indexWord) {
		this.indexWord = indexWord;
	}
	
	public String getProImgs() {
		return proImgs;
	}
	public void setProImgs(String proImgs) {
		this.proImgs = proImgs;
	}

	
	public Float getRate() {
		return rate;
	}
	public void setRate(Float rate) {
		this.rate = rate;
	}
	public String getPinying() {
		return pinying;
	}
	public void setPinying(String pinying) {
		this.pinying = pinying;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	public String getBrandId() {
		return brandId;
	}
	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}
	
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public String getUpdateUserId() {
		return updateUserId;
	}
	public void setUpdateUserId(String updateUserId) {
		this.updateUserId = updateUserId;
	}
	public Integer getScanNum() {
		return scanNum;
	}
	public void setScanNum(Integer scanNum) {
		this.scanNum = scanNum;
	}
	
}
