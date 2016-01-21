package com.rycf.gjb.dto;

import java.util.List;

/**
 * 品牌
 * @author Administrator
 *
 */
public class BrandPayCardDTO {
	private String userId;//虚拟主键
	private String payCardId;//实际主键
	private String brandCode;//商户编码
	private String brandKey;//商户秘钥
	
	//商户注册返回的信息
	private String ledgerno;//子账户商户编号
	
	//商户注册提交信息
	private String bindmobile;//绑定手机
	private String idcard;//身份证
	private String legalperson;//姓名
	private String bankaccountnumber;//银行卡号
	private String bankname;//开户行
	private String accountname;//开户名
	private String bankaccounttype;//开户类别PrivateCash：对公-PublicCash：对私
	private String bankprovince;//开户省
	private String bankcity;//开户市
	private String minsettleamount;//起结金额
	private String riskreserveday;//结算周期	
	
	
	
	public String getBindmobile() {
		return bindmobile;
	}
	public void setBindmobile(String bindmobile) {
		this.bindmobile = bindmobile;
	}

	public String getLedgerno() {
		return ledgerno;
	}
	public void setLedgerno(String ledgerno) {
		this.ledgerno = ledgerno;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public String getLegalperson() {
		return legalperson;
	}
	public void setLegalperson(String legalperson) {
		this.legalperson = legalperson;
	}
	
	public String getBankaccountnumber() {
		return bankaccountnumber;
	}
	public void setBankaccountnumber(String bankaccountnumber) {
		this.bankaccountnumber = bankaccountnumber;
	}
	public String getBankname() {
		return bankname;
	}
	public void setBankname(String bankname) {
		this.bankname = bankname;
	}
	public String getAccountname() {
		return accountname;
	}
	public void setAccountname(String accountname) {
		this.accountname = accountname;
	}
	public String getBankaccounttype() {
		return bankaccounttype;
	}
	public void setBankaccounttype(String bankaccounttype) {
		this.bankaccounttype = bankaccounttype;
	}
	public String getBankprovince() {
		return bankprovince;
	}
	public void setBankprovince(String bankprovince) {
		this.bankprovince = bankprovince;
	}
	public String getBankcity() {
		return bankcity;
	}
	public void setBankcity(String bankcity) {
		this.bankcity = bankcity;
	}
	public String getMinsettleamount() {
		return minsettleamount;
	}
	public void setMinsettleamount(String minsettleamount) {
		this.minsettleamount = minsettleamount;
	}
	public String getRiskreserveday() {
		return riskreserveday;
	}
	public void setRiskreserveday(String riskreserveday) {
		this.riskreserveday = riskreserveday;
	}

	private SystemUserDTO systemUserDTO;
	private List<BrandDTO> brandDTO;//用户对应的品牌
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public List<BrandDTO> getBrandDTO() {
		return brandDTO;
	}
	public void setBrandDTO(List<BrandDTO> brandDTO) {
		this.brandDTO = brandDTO;
	}
	public String getPayCardId() {
		return payCardId;
	}
	public void setPayCardId(String payCardId) {
		this.payCardId = payCardId;
	}
	public String getBrandCode() {
		return brandCode;
	}
	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}
	public String getBrandKey() {
		return brandKey;
	}
	public void setBrandKey(String brandKey) {
		this.brandKey = brandKey;
	}
	public SystemUserDTO getSystemUserDTO() {
		return systemUserDTO;
	}
	public void setSystemUserDTO(SystemUserDTO systemUserDTO) {
		this.systemUserDTO = systemUserDTO;
	}
	
	
}
