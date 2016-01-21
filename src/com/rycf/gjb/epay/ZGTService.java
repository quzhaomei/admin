package com.rycf.gjb.epay;



import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

/**
 * 掌柜通接口范例
 * @author	：yingjie.wang    
 * @since	：2015-01-26 
 */

public class ZGTService {

	/**
	 * 生成hmac方法
	 * @param arr
	 * 请求参数拼接的字符串
	 * @param keyValue
	 * 商户密钥
	 * @return hmac
	 */
	public static String getHmac(String[] arr, String keyValue) {
			String hmac = "";
			StringBuffer stringValue = new StringBuffer();
			
			for(int i = 0; i < arr.length; i++) {
					stringValue.append(formatString(arr[i]));
			}

			hmac = Digest.hmacSign(stringValue.toString(), keyValue);

			return (hmac);
	}

	/**
	 * 取得商户编号
	 */
	public static String getCustomernumber() {
			return Configuration.getInstance().getValue("customernumber");
	}

	/**
	 * 取得商户密钥
	 */
	public static String getKeyValue() {
			return Configuration.getInstance().getValue("keyValue");
	}

	/**
	 * 取得分账账号注册请求地址
	 */
	public static String getRegisterURL() {
			return Configuration.getInstance().getValue("registerURL");
	}

	/**
	 * 取得账户信息修改请求地址
	 */
	public static String getUpdateAccountURL() {
			return Configuration.getInstance().getValue("updateAccountURL");
	}

	/**
	 * 账户信息修改查询接口请求地址
	 */
	public static String getQueryUpdateURL() {
			return Configuration.getInstance().getValue("queryUpdateURL");
	}	

	/**
	 * 取得下单请求地址
	 */
	public static String getRequestURL() {
			return Configuration.getInstance().getValue("requestURL");
	}

	/**
	 * 取得查询请求地址
	 */
	public static String getQueryURL() {
			return Configuration.getInstance().getValue("queryURL");
	}

	/**
	 * 取得非交易转账请求地址
	 */
	public static String getTransferURL() {
			return Configuration.getInstance().getValue("transferURL");
	}

	/**
	 * 取得非交易转账查询请求地址
	 */
	public static String getTransferQueryURL() {
			return Configuration.getInstance().getValue("transferQueryURL");
	}

	/**
	 * 取得订单分账请求地址
	 */
	public static String getDivideURL() {
			return Configuration.getInstance().getValue("divideURL");
	}

	/**
	 * 取得订单分账查询请求地址
	 */
	public static String getDivideQueryURL() {
			return Configuration.getInstance().getValue("divideQueryURL");
	}

	/**
	 * 取得订单退款请求地址
	 */
	public static String getRefundURL() {
			return Configuration.getInstance().getValue("refundURL");
	}

	/**
	 * 取得订单退款查询请求地址
	 */
	public static String getRefundQueryURL() {
			return Configuration.getInstance().getValue("refundQueryURL");
	}

	/**
	 * 担保确认请求地址
	 */
	public static String getConfirmURL() {
			return Configuration.getInstance().getValue("confirmURL");
	}

	/**
	 * 余额查询请求地址
	 */
	public static String getBalanceQueryURL() {
			return Configuration.getInstance().getValue("balanceQueryURL");
	}

	/**
	 * 提现接口请求地址
	 */
	public static String getCashTransferURL() {
			return Configuration.getInstance().getValue("cashTransferURL");
	}

	/**
	 * 提现查询接口请求地址
	 */
	public static String getQueryCashTransferURL() {
			return Configuration.getInstance().getValue("queryCashTransferURL");
	}

	/**
	 * 结算结果查询接口请求地址
	 */
	public static String getQuerySettlementURL() {
			return Configuration.getInstance().getValue("querySettlementURL");
	}

	/**
	 * 绑卡查询接口请求地址
	 */
	public static String getQueryBindCardsURL() {
			return Configuration.getInstance().getValue("queryBindCardsURL");
	}	

	/**
	 * 解绑接口请求地址
	 */
	public static String getUnbindCardURL() {
			return Configuration.getInstance().getValue("unbindCardURL");
	}	

	/**
	 * 字符串格式化
	 */
	private static String formatString(String text) {
			return (text == null ? "" : text.trim());
	}

	/**
	 * 解析http请求的返回参数
	 */
	public static Map<String, String> parseHttpResponseBody(int statusCode, String responseBody,
															String[] hmacEncryptionOrder) {
		String keyForHmac			= getKeyValue();
	 	String keyForAES 			= getKeyValue().substring(0, 16);

		Map<String, String> result	= new HashMap<String, String>();
		String customError			= "";

		if(statusCode != 200) {
			customError	= "Request failed, response code = " + statusCode;
			result.put("customError", customError);
			return (result);
		}

		Map<String, String> jsonMap	= JSON.parseObject(responseBody, 
										new TypeReference<TreeMap<String, String>>() {});
		if(jsonMap.containsKey("msg")) {
			result	= jsonMap;
			return (result);
		}

		String dataFromYeepay	= formatString((String)jsonMap.get("data"));
		String decryptData		= AESUtil.decrypt(dataFromYeepay, keyForAES);

		result					= JSON.parseObject(decryptData, 
											new TypeReference<TreeMap<String, String>>() {});
		if(result.containsKey("msg")) {
			return (result);
		}

		String hmacYeepay		= formatString(result.get("hmac"));
		String hmacLocal		= "";

		StringBuffer buffer		= new StringBuffer();
		for(int i = 0; i < hmacEncryptionOrder.length; i++) {
			String temp	= formatString(result.get(hmacEncryptionOrder[i]));
			buffer.append(temp);
		}
		hmacLocal				= Digest.hmacSign(buffer.toString(), keyForHmac);

		if(!hmacLocal.equals(hmacYeepay)) {
			customError			= "hmac mismatch error.";
			result.put("customError", customError);
			System.out.println("hmacEncryptionDatas = " + buffer.toString());
			System.out.println("hmacYeepay = " + hmacYeepay);
			System.out.println("hmacLocal = " + hmacLocal);
		}
		
		System.out.println("httpResult: " + result);

		return (result);
	}



	/**
	 * registerAccount() : 子账户商户编号注册方法 
	 */

	public static Map<String, String> registerAccount(Map<String, String> registerParams) {

		System.out.println("##### registerAccount() #####");

	 	String customernumber 		= getCustomernumber();		 					   		 
		String requestid            = formatString(registerParams.get("requestid"));         
        String bindmobile           = formatString(registerParams.get("bindmobile"));        
        String customertype         = formatString(registerParams.get("customertype"));      
        String signedname           = formatString(registerParams.get("signedname"));        
        String linkman              = formatString(registerParams.get("linkman"));           
        String idcard               = formatString(registerParams.get("idcard"));            
        String businesslicence      = formatString(registerParams.get("businesslicence"));   
        String legalperson          = formatString(registerParams.get("legalperson"));	   	 
        String minsettleamount      = formatString(registerParams.get("minsettleamount"));   
        String riskreserveday       = formatString(registerParams.get("riskreserveday"));    
        String bankaccountnumber    = formatString(registerParams.get("bankaccountnumber")); 
        String bankname             = formatString(registerParams.get("bankname"));          
        String accountname          = formatString(registerParams.get("accountname"));       
        String bankaccounttype      = formatString(registerParams.get("bankaccounttype"));   
        String bankprovince         = formatString(registerParams.get("bankprovince"));      
        String bankcity             = formatString(registerParams.get("bankcity"));          
        String manualsettle         = formatString(registerParams.get("manualsettle"));          

	 	String keyForHmac 			= getKeyValue();
	 	String keyForAES 			= getKeyValue().substring(0, 16);

		String[] stringArray		= {customernumber, requestid, bindmobile, customertype, signedname, linkman, 
										idcard, businesslicence, legalperson, minsettleamount, riskreserveday, 
										bankaccountnumber, bankname, accountname, bankaccounttype, bankprovince, 
										bankcity };
		String hmac					= getHmac(stringArray, keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", 	customernumber);      
	 	dataMap.put("requestid", 		requestid);
	 	dataMap.put("bindmobile", 		bindmobile);
	 	dataMap.put("customertype", 	customertype);
	 	dataMap.put("signedname", 		signedname);
	 	dataMap.put("linkman", 			linkman);
	 	dataMap.put("idcard", 			idcard);
	 	dataMap.put("businesslicence", 	businesslicence);
	 	dataMap.put("legalperson", 		legalperson);
	 	dataMap.put("minsettleamount", 	minsettleamount);
	 	dataMap.put("riskreserveday", 	riskreserveday);
	 	dataMap.put("bankaccountnumber",bankaccountnumber);
	 	dataMap.put("bankname",	 		bankname);
	 	dataMap.put("accountname", 		accountname);
	 	dataMap.put("bankaccounttype", 	bankaccounttype);
	 	dataMap.put("bankprovince", 	bankprovince);
	 	dataMap.put("bankcity", 		bankcity);
	 	dataMap.put("manualsettle", 	manualsettle);
	 	dataMap.put("hmac", 			hmac);

	 	String dataJsonString		= JSON.toJSONString(dataMap); 
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);
	 	
		System.out.println("dataMap : " + dataMap);
		System.out.println("dataJsonString : " + dataJsonString);

		String registerURL			= getRegisterURL();
		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(registerURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
									   new NameValuePair("data", data)};

		Map<String, String> result	= new HashMap<String, String>();
		String customError			= "";	// 自定义，非接口返回
	
		try {
			postMethod.setRequestBody(datas);
			int statusCode				= httpClient.executeMethod(postMethod);
			byte[] responseByte			= postMethod.getResponseBody();
			String responseBody			= new String(responseByte, "UTF-8");

			String[] hmacEncryptionOrder = {"customernumber", "requestid", "code", "ledgerno"};
			
			result					= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);

		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}

		System.out.println("result : " + result);
		                                                 	
		return (result);	
	} 



	/**
	 * updateAccount() : 账户信息修改接口 
	 */

	public static Map<String, String> updateAccount(Map<String, String> params) {

		System.out.println("##### updateAccount() #####");

	 	String customernumber 		= getCustomernumber();		 					   		 
		String requestid            = formatString(params.get("requestid"));         
        String ledgerno             = formatString(params.get("ledgerno"));           
        String bankaccountnumber    = formatString(params.get("bankaccountnumber")); 
        String bankname             = formatString(params.get("bankname"));          
        String accountname          = formatString(params.get("accountname"));       
        String bankaccounttype      = formatString(params.get("bankaccounttype"));   
        String bankprovince         = formatString(params.get("bankprovince"));      
        String bankcity             = formatString(params.get("bankcity"));          
        String minsettleamount      = formatString(params.get("minsettleamount"));   
        String riskreserveday       = formatString(params.get("riskreserveday"));    
        String manualsettle         = formatString(params.get("manualsettle"));          
        String callbackurl          = formatString(params.get("callbackurl"));          

	 	String keyForHmac 			= getKeyValue();
	 	String keyForAES 			= getKeyValue().substring(0, 16);

		String[] stringArray		= {customernumber, requestid, ledgerno, bankaccountnumber, bankname, 
										accountname, bankaccounttype, bankprovince, bankcity,  minsettleamount, 
										riskreserveday, manualsettle,  callbackurl};
		String hmac					= getHmac(stringArray, keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", 	customernumber);      
	 	dataMap.put("requestid", 		requestid);
	 	dataMap.put("ledgerno", 		ledgerno);
	 	dataMap.put("bankaccountnumber",bankaccountnumber);
	 	dataMap.put("bankname",	 		bankname);
	 	dataMap.put("accountname", 		accountname);
	 	dataMap.put("bankaccounttype", 	bankaccounttype);
	 	dataMap.put("bankprovince", 	bankprovince);
	 	dataMap.put("bankcity", 		bankcity);
	 	dataMap.put("minsettleamount", 	minsettleamount);
	 	dataMap.put("riskreserveday", 	riskreserveday);
	 	dataMap.put("manualsettle", 	manualsettle);
	 	dataMap.put("callbackurl", 		callbackurl);
	 	dataMap.put("hmac", 			hmac);

	 	String dataJsonString		= JSON.toJSONString(dataMap); 
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);
	 	
		System.out.println("dataMap : " + dataMap);
		System.out.println("dataJsonString : " + dataJsonString);

		String updateAccountURL		= getUpdateAccountURL();
		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(updateAccountURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
									   new NameValuePair("data", data)};

		Map<String, String> result	= new HashMap<String, String>();
		String customError			= "";	// 自定义，非接口返回
	
		try {
			postMethod.setRequestBody(datas);
			int statusCode				= httpClient.executeMethod(postMethod);
			byte[] responseByte			= postMethod.getResponseBody();
			String responseBody			= new String(responseByte, "UTF-8");

			String[] hmacEncryptionOrder = {"customernumber", "requestid", "code"};
			
			result					= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);

		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}

		System.out.println("result : " + result);
		                                                 	
		return (result);	
	}  	


	/**
	 * queryUpdate() : 查询账户信息修改接口 
	 */

	public static Map<String, String> queryUpdate(String requestid) {

		System.out.println("##### queryUpdate() #####");

	 	String customernumber 		= getCustomernumber();		 					   		 

	 	String keyForHmac 			= getKeyValue();
	 	String keyForAES 			= getKeyValue().substring(0, 16);

		String[] stringArray		= {customernumber, requestid};
		String hmac					= getHmac(stringArray, keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", 	customernumber);      
	 	dataMap.put("requestid", 		requestid);
	 	dataMap.put("hmac", 			hmac);

	 	String dataJsonString		= JSON.toJSONString(dataMap); 
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);
	 	
		System.out.println("dataMap : " + dataMap);
		System.out.println("dataJsonString : " + dataJsonString);

		String queryUpdateURL		= getQueryUpdateURL();
		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(queryUpdateURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
									   new NameValuePair("data", data)};

		Map<String, String> result	= new HashMap<String, String>();
		String customError			= "";	// 自定义，非接口返回
	
		try {
			postMethod.setRequestBody(datas);
			int statusCode				= httpClient.executeMethod(postMethod);
			byte[] responseByte			= postMethod.getResponseBody();
			String responseBody			= new String(responseByte, "UTF-8");

			String[] hmacEncryptionOrder = {"customernumber", "requestid", "code", "status", "desc"};
			
			result					= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);

		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}

		System.out.println("result : " + result);
		                                                 	
		return (result);	
	}  		

	/**
	 * paymentRequest() : 订单支付请求方法
	 */
	
	public static Map<String, String> paymentRequest(Map<String, String> reqParams) {
	
		System.out.println("##### paymentRequest() #####");

	 	String customernumber 		= getCustomernumber();
	 	String requestid			= formatString(reqParams.get("requestid"));
	 	String amount				= formatString(reqParams.get("amount"));
	 	String assure				= formatString(reqParams.get("assure"));
	 	String productname			= formatString(reqParams.get("productname"));
	 	String productcat			= formatString(reqParams.get("productcat"));
	 	String productdesc			= formatString(reqParams.get("productdesc"));
	 	String divideinfo			= formatString(reqParams.get("divideinfo"));
	 	String callbackurl			= formatString(reqParams.get("callbackurl"));
	 	String webcallbackurl		= formatString(reqParams.get("webcallbackurl"));
	 	String bankid				= formatString(reqParams.get("bankid")).toUpperCase();
	 	String period				= formatString(reqParams.get("period"));
	 	String memo		  			= formatString(reqParams.get("memo"));
	 	String payproducttype		= formatString(reqParams.get("payproducttype"));
	 	String userno		  		= formatString(reqParams.get("userno"));
	 	String isbind		  		= formatString(reqParams.get("isbind"));
	 	String bindid		  		= formatString(reqParams.get("bindid"));
	 	String ip		  			= formatString(reqParams.get("ip"));
	 	String cardname				= formatString(reqParams.get("cardname"));
	 	String idcard				= formatString(reqParams.get("idcard"));
	 	//String idcardtype			= formatString(reqParams.get("idcardtype"));
	 	String bankcardnum			= formatString(reqParams.get("bankcardnum"));
	 	String mobilephone			= formatString(reqParams.get("mobilephone"));
	 	String cvv2					= formatString(reqParams.get("cvv2"));
	 	String expiredate			= formatString(reqParams.get("expiredate"));
	 	String mcc					= formatString(reqParams.get("mcc"));
	 	String areacode				= formatString(reqParams.get("areacode"));

	 	String keyForHmac 			= getKeyValue(); 									
	 	String keyForAES 			= getKeyValue().substring(0, 16); 				

		String[] stringArray		= {customernumber, requestid, amount, assure, productname, productcat, 
									   productdesc, divideinfo, callbackurl, webcallbackurl, bankid, period, memo};
		String hmac					= getHmac(stringArray, keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber",	customernumber );
	 	dataMap.put("requestid", 		requestid );		  
	 	dataMap.put("amount", 			amount );				  
	 	dataMap.put("assure", 			assure );				  
	 	dataMap.put("productname",		productname );	  
	 	dataMap.put("productcat", 		productcat );		  
	 	dataMap.put("productdesc", 		productdesc );	  
	 	dataMap.put("divideinfo", 		divideinfo ); 		  
	 	dataMap.put("callbackurl", 		callbackurl );	  
	 	dataMap.put("webcallbackurl", 	webcallbackurl );
	 	dataMap.put("bankid",			bankid );				  
	 	dataMap.put("period", 			period );				  
	 	dataMap.put("memo", 			memo );					  
	 	dataMap.put("payproducttype", 	payproducttype );  
	 	dataMap.put("userno", 			userno );				  
	 	dataMap.put("isbind", 			isbind );				  
	 	dataMap.put("bindid", 			bindid );				  
	 	dataMap.put("ip", 				ip );						  
	 	dataMap.put("mcc", 				mcc );				  
	 	dataMap.put("areacode", 		areacode );				  
	 	dataMap.put("cardname", 		cardname );				  
	 	dataMap.put("idcard", 			idcard );				  
	 	//dataMap.put("idcardtype", 		idcardtype );				  
	 	dataMap.put("mobilephone", 		mobilephone );				  
	 	dataMap.put("bankcardnum", 		bankcardnum );				  
	 	dataMap.put("cvv2", 			cvv2 );				  
	 	dataMap.put("expiredate", 		expiredate );				  
	 	dataMap.put("hmac", 			hmac );					  
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap);
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);

		String requestURL			= getRequestURL();

		System.out.println("dataMap : " + dataMap);
		System.out.println("requestURL : " + requestURL);

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(requestURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
									   new NameValuePair("data", data)};
	
		Map<String, String> result	= new HashMap<String, String>();
		String customError			= "";	// 自定义，非接口返回
	
		try {
			postMethod.setRequestBody(datas);
			int statusCode			= httpClient.executeMethod(postMethod);
			byte[] responseByte		= postMethod.getResponseBody();
			String responseBody		= new String(responseByte, "UTF-8");

			String[] hmacEncryptionOrder = {"customernumber", "requestid", "code", "externalid", "amount", "payurl"};

			result					= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);

		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}

		System.out.println("result : " + result);
		                                                 	
		return (result);
	}


	/**
	 * paymentQuery() : 订单查询方法
	 */

	public static Map<String, String> paymentQuery(String requestid) {

		System.out.println("##### paymentQuery() #####");

	 	String customernumber 			= getCustomernumber();
	 	String keyForHmac 				= getKeyValue();
	 	String keyForAES 				= getKeyValue().substring(0, 16);
		String queryURL					= getQueryURL();

		StringBuffer buffer			= new StringBuffer();
		buffer.append(customernumber);
		buffer.append(requestid);
		String hmac					= Digest.hmacSign(buffer.toString(), keyForHmac);

	 	Map<String, String> dataMap 	= new HashMap<String, String>();
	 	dataMap.put("customernumber", customernumber);
	 	dataMap.put("requestid", requestid);
	 	dataMap.put("hmac", hmac);
	 	
	 	String dataJsonString			= JSON.toJSONString(dataMap);
		String data						= AESUtil.encrypt(dataJsonString, keyForAES);

		HttpClient httpClient			= new HttpClient();
		PostMethod postMethod			= new PostMethod(queryURL);
		NameValuePair[] datas			= {new NameValuePair("customernumber", customernumber),
									       new NameValuePair("data", data)};
		
		Map<String, String> result		= new HashMap<String, String>();
		String customError				= ""; // 自定义变量，非接口返回
		
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "UTF-8");
 
			String[] hmacEncryptionOrder = {"customernumber", "requestid", "code", "externalid", "amount", 
									        "productname", "productcat", "productdesc", "status", "ordertype",
								   	        "busitype", "orderdate", "createdate", "bankid"};

			result				= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);
			
		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}
		
		System.out.println("result : " + result);
		                                                 	
		return (result);	
	}   

	/**
	 * decryptPayCallbackData() 
	 */

	public static Map<String, String> decryptPayCallbackData(String data) {

		System.out.println("##### decryptPayCallbackData() #####");

		Map<String, String> result 	= new HashMap<String, String>();
		String customernumber	   	= ""; 
        String requestid		   	= ""; 
        String code				   	= ""; 
        String notifytype		   	= ""; 
        String externalid		   	= ""; 
        String amount			   	= ""; 
        String cardno			   	= ""; 
        String bankcode			   	= ""; 
        String hmacYeepay		   	= ""; 
        String customError		   	= ""; // 自定义变量，非接口返回

	 	String keyForHmac 		   	= getKeyValue(); 				// 商户秘钥
	 	String keyForAES 		   	= getKeyValue().substring(0, 16); 
	 	
		try {
			String decryptDataStr	= AESUtil.decrypt(data, keyForAES);
			result  				= JSON.parseObject(decryptDataStr, 
													new TypeReference<TreeMap<String, String>>() {});

			if(result.containsKey("msg")) {
				return (result);
			} 

			customernumber		  	= formatString((String)result.get("customernumber")); 
			requestid			  	= formatString((String)result.get("requestid"));
			code				  	= formatString((String)result.get("code"));
			notifytype			  	= formatString((String)result.get("notifytype"));
			externalid			  	= formatString((String)result.get("externalid"));
			amount				  	= formatString((String)result.get("amount"));
			cardno				  	= formatString((String)result.get("cardno"));
			bankcode			  	= formatString((String)result.get("bankcode"));
			hmacYeepay			  	= formatString((String)result.get("hmac"));

			String[] stringArray   	= {customernumber, requestid, code, notifytype, externalid, amount, cardno};
			String hmacLocal	   	= getHmac(stringArray, keyForHmac);

			if(!hmacLocal.equals(hmacYeepay)) {
				customError			= "hmac mismatch error.";
				result.put("customError", customError);
				StringBuffer buffer = new StringBuffer();
				for(int i = 0; i < stringArray.length; i++) {
					buffer.append(stringArray[i]);
				}
				System.out.println("hmacstring = " + buffer.toString());
				System.out.println("hmacYeepay = " + hmacYeepay);
				System.out.println("hmacLocal = " + hmacLocal);
			}
		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} 
		
		System.out.println("result : " + result);
		                                                 	
		return (result);	
	}   

	
	/**
	 * transfer() : 转账方法
	 */
	
	public static Map<String, String> transfer(Map<String, String> transferParams) {
	
		System.out.println("##### transfer() #####");

	 	String customernumber 		= getCustomernumber();
	 	String requestid			= formatString(transferParams.get("requestid"));
	 	String ledgerno				= formatString(transferParams.get("ledgerno"));
	 	String sourceledgerno		= formatString(transferParams.get("sourceledgerno"));
	 	String amount				= formatString(transferParams.get("amount"));

	 	String keyForHmac 			= getKeyValue(); 
	 	String keyForAES 			= getKeyValue().substring(0, 16);

		StringBuffer buffer			= new StringBuffer();
		buffer.append(customernumber);
		buffer.append(requestid);
		buffer.append(ledgerno);
		buffer.append(amount);
		String hmac					= Digest.hmacSign(buffer.toString(), keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", 	customernumber);
	 	dataMap.put("requestid", 		requestid);		  
	 	dataMap.put("ledgerno", 		ledgerno);		  
	 	dataMap.put("amount", 			amount);				  
	 	dataMap.put("sourceledgerno", 	sourceledgerno);				  
	 	dataMap.put("hmac", 			hmac);					  
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap); 		// map中数据转为json格式
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);

		String transferURL			= getTransferURL();

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(transferURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
										new NameValuePair("data", data)};
	
		Map<String, String> result	= new HashMap<String, String>();
		String customError			= ""; //自定义，非接口返回	
	
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "UTF-8");

			String[] hmacEncryptionOrder = {"customernumber", "requestid", "code"};
			result	= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);
			
		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}
		
		System.out.println("result : " + result);
		                                                 	
		return (result);	
	}   


	/**
	 * transferQuery() : 转账查询方法
	 */

	public static Map<String, String> transferQuery(String requestid) {

		System.out.println("##### transferQuery() #####");

	 	String customernumber 		= getCustomernumber();		 							
	 	String keyForHmac 			= getKeyValue(); 										
	 	String keyForAES 			= getKeyValue().substring(0, 16); 						

		StringBuffer buffer			= new StringBuffer();
		buffer.append(customernumber);
		buffer.append(requestid);
		String hmac					= Digest.hmacSign(buffer.toString(), keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", customernumber);
	 	dataMap.put("requestid", requestid);
	 	dataMap.put("hmac", hmac);
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap);
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);
		String transferQueryURL		= getTransferQueryURL();

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(transferQueryURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
										new NameValuePair("data", data)};

		Map<String, String> result	= new HashMap<String, String>();
		String customError			= "";// 自定义变量，非接口返回
	
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "UTF-8");

			String[] hmacEncryptionOrder = {"customernumber", "requestid", "code", "ledgerno", "amount", "status"};
			result	= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);

		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}

		System.out.println("result : " + result);
		                                                 	
		return (result);	
	}   

		
	/**
	 * divide() : 订单分账方法
	 **/
	
	public static Map<String, String> divide (Map<String, String> divideParams) {

		System.out.println("##### divide() #####");

	 	String customernumber 		= getCustomernumber();
	 	String requestid			= formatString(divideParams.get("requestid"));
	 	String orderrequestid		= formatString(divideParams.get("orderrequestid"));
	 	String divideinfo			= formatString(divideParams.get("divideinfo"));

	 	String keyForHmac 			= getKeyValue(); 
	 	String keyForAES 			= getKeyValue().substring(0, 16);

		String[] stringArray		= {customernumber, requestid, orderrequestid, divideinfo};
		String hmac					= getHmac(stringArray, keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", customernumber);
	 	dataMap.put("requestid", 	  requestid);		  
	 	dataMap.put("orderrequestid", orderrequestid);		  
	 	dataMap.put("divideinfo", 	  divideinfo);				  
	 	dataMap.put("hmac", 		  hmac);					  
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap); 
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);

		String divideURL			= getDivideURL();

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(divideURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
									   new NameValuePair("data", data)};
	
		Map<String, String> result	= new HashMap<String, String>();
		String customError			= "";	//自定义，非接口返回
	
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "GBK");

			String[] hmacEncryptionOrder = {"customernumber", "requestid", "code"};
			result	= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);

		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}

		System.out.println("result : " + result);
		                                                 	
		return (result);
	}

			
	/**
	 * divideQuery() : 订单分账查询方法
	 **/
	
	public static Map<String, String> divideQuery (Map<String, String> divideQueryParams) {

		System.out.println("##### divideQuery() #####");

	 	String customernumber 		= getCustomernumber();
	 	String orderrequestid		= formatString(divideQueryParams.get("orderrequestid"));
	 	String dividerequestid		= formatString(divideQueryParams.get("dividerequestid"));
	 	String ledgerno				= formatString(divideQueryParams.get("ledgerno"));

	 	String keyForHmac 			= getKeyValue(); 
	 	String keyForAES 			= getKeyValue().substring(0, 16);

		String[] stringArray		= {customernumber, orderrequestid, dividerequestid, ledgerno};
		String hmac					= getHmac(stringArray, keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", customernumber);
	 	dataMap.put("orderrequestid", orderrequestid);		  
	 	dataMap.put("dividerequestid",dividerequestid);		  
	 	dataMap.put("ledgerno", 	  ledgerno);				  
	 	dataMap.put("hmac", 		  hmac);					  
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap); 
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);

		String divideURL			= getDivideQueryURL();

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(divideURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
										new NameValuePair("data", data)};
	
		Map<String, String> result	= new HashMap<String, String>();
		String customError			= "";	// 自定义变量，非接口返回
	
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "GBK");

			String[] hmacEncryptionOrder = {"customernumber", "orderrequestid", "code", "divideinfo"};
			result	= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);

		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}

		System.out.println("result : " + result);
		                                                 	
		return (result);
	}

	/**
	 * refund() : 订单退款方法
	 **/
	
	public static Map<String, String> refund (Map<String, String> params) {

		System.out.println("##### refund() #####");

	 	String customernumber 		= getCustomernumber();
	 	String requestid			= formatString(params.get("requestid"));
	 	String orderrequestid		= formatString(params.get("orderrequestid"));
	 	String amount				= formatString(params.get("amount"));
	 	String divideinfo			= formatString(params.get("divideinfo"));
	 	String confirm				= formatString(params.get("confirm"));
	 	String memo					= formatString(params.get("memo"));

	 	String keyForHmac 			= getKeyValue(); 
	 	String keyForAES 			= getKeyValue().substring(0, 16);

		String[] stringArray		= {customernumber, requestid, orderrequestid, amount, divideinfo, confirm, memo};
		String hmac					= getHmac(stringArray, keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", customernumber);
	 	dataMap.put("requestid", 	  requestid);				  
	 	dataMap.put("orderrequestid", orderrequestid);		  
	 	dataMap.put("amount", 	  	  amount);				  
	 	dataMap.put("divideinfo", 	  divideinfo);				  
	 	dataMap.put("confirm", 	  	  confirm);				  
	 	dataMap.put("memo", 		  memo);					  
	 	dataMap.put("hmac", 		  hmac);					  
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap); 
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);

		String refundURL			= getRefundURL();

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(refundURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
									   new NameValuePair("data", data)};
	
		Map<String, String> result	= new HashMap<String, String>();
		String customError			= "";	// 自定义变量，非接口返回
	
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "GBK");

			String[] hmacEncryptionOrder = {"customernumber", "requestid", "code", "refundexternalid"};
			result	= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);

		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}

		System.out.println("result : " + result);
		                                                 	
		return (result);
	}

	
	/**
	 * refundQuery() : 订单退款查询方法
	 **/
	
	public static Map<String, String> refundQuery (Map<String, String> params) {

		System.out.println("##### refundQuery() #####");

	 	String customernumber 		= getCustomernumber();
	 	String orderrequestid		= formatString(params.get("orderrequestid"));
	 	String refundrequestid		= formatString(params.get("refundrequestid"));

	 	String keyForHmac 			= getKeyValue(); 
	 	String keyForAES 			= getKeyValue().substring(0, 16);

		String[] stringArray		= {customernumber, orderrequestid, refundrequestid};
		String hmac					= getHmac(stringArray, keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", customernumber);
	 	dataMap.put("orderrequestid", orderrequestid);		  
	 	dataMap.put("refundrequestid",refundrequestid);		  
	 	dataMap.put("hmac", 		  hmac);					  
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap); 
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);

		String refundQueryURL		= getRefundQueryURL();

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(refundQueryURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
										new NameValuePair("data", data)};
	
		Map<String, String> result	= new HashMap<String, String>();
		String customError			= "";	// 自定义变量，非接口返回
	
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "GBK");

			String[] hmacEncryptionOrder = {"customernumber", "orderrequestid", "code", "externalid", "refundinfo"};
			result	= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);

		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}

		System.out.println("result : " + result);
		                                                 	
		return (result);
	}

		
	/**
	 * confirm() : 担保确认方法
	 **/
	
	public static Map<String, String> confirm (String orderrequestid) {

		System.out.println("##### confirm() #####");

	 	String customernumber 		= getCustomernumber();
	 	String keyForHmac 			= getKeyValue(); 
	 	String keyForAES 			= getKeyValue().substring(0, 16);

		String[] stringArray		= {customernumber, orderrequestid};
		String hmac					= getHmac(stringArray, keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", customernumber);
	 	dataMap.put("orderrequestid", orderrequestid);		  
	 	dataMap.put("hmac", 		  hmac);					  
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap); 
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);

		String confirmURL			= getConfirmURL();

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(confirmURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
									   new NameValuePair("data", data)};
	
		Map<String, String> result	= new HashMap<String, String>();
		String customError			= "";// 自定义变量，非接口返回	
	
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "GBK");

			String[] hmacEncryptionOrder = {"customernumber", "orderrequestid", "code"};
			result	= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);

		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}

		System.out.println("result : " + result);
		                                                 	
		return (result);
	}
	

	/**
	 * balanceQuery() : 余额查询方法
	 */

	public static Map<String, String> balanceQuery(String ledgerno) {

		System.out.println("##### balanceQuery() #####");

	 	String customernumber 		= getCustomernumber();
	 	String keyForHmac 			= getKeyValue();
	 	String keyForAES 			= getKeyValue().substring(0, 16);
		String balanceQueryURL		= getBalanceQueryURL();

		StringBuffer buffer			= new StringBuffer();
		buffer.append(customernumber);
		buffer.append(ledgerno);
		String hmac					= Digest.hmacSign(buffer.toString(), keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", customernumber);
	 	dataMap.put("ledgerno", ledgerno);
	 	dataMap.put("hmac", hmac);
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap);
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(balanceQueryURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
									   new NameValuePair("data", data)};
		
		Map<String, String> result	= new HashMap<String, String>();
		String customError			= ""; // 自定义变量，非接口返回
		
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "UTF-8");
 
			String[] hmacEncryptionOrder = {"customernumber", "code", "balance", "ledgerbalance"};
			result	= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);
			
		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}
		
		System.out.println("result : " + result);
		                                                 	
		return (result);	
	} 


	/**
	 * cashTransfer() : 提现方法
	 */

	public static Map<String, String> cashTransfer(Map<String, String> params) {

		System.out.println("##### cashTransfer() #####");

	 	String customernumber 		= getCustomernumber();
	 	String keyForHmac 			= getKeyValue();
	 	String keyForAES 			= getKeyValue().substring(0, 16);
		String cashTransferURL		= getCashTransferURL();

		String requestid			= formatString(params.get("requestid"));	
		String ledgerno				= formatString(params.get("ledgerno"));	
		String amount				= formatString(params.get("amount"));	
		String callbackurl			= formatString(params.get("callbackurl"));	

		StringBuffer buffer			= new StringBuffer();
		buffer.append(customernumber);
		buffer.append(requestid);
		buffer.append(ledgerno);
		buffer.append(amount);
		buffer.append(callbackurl);
		String hmac					= Digest.hmacSign(buffer.toString(), keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", customernumber);
	 	dataMap.put("requestid", requestid);
	 	dataMap.put("ledgerno", ledgerno);
	 	dataMap.put("amount", amount);
	 	dataMap.put("callbackurl", callbackurl);
	 	dataMap.put("hmac", hmac);
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap);
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);

		System.out.println("dataMap : " + dataMap);

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(cashTransferURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
									   new NameValuePair("data", data)};
		
		Map<String, String> result	= new HashMap<String, String>();
		String customError			= ""; // 自定义变量，非接口返回
		
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "UTF-8");
 
			String[] hmacEncryptionOrder = {"customernumber", "requestid", "code"};
			result	= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);
			
		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}
		
		System.out.println("result : " + result);
		                                                 	
		return (result);	
	} 


	/**
	 * queryCashTransfer() : 提现查询方法
	 */

	public static Map<String, String> queryCashTransfer(String cashrequestid) {

		System.out.println("##### queryCashTransfer() #####");

	 	String customernumber 		= getCustomernumber();
	 	String keyForHmac 			= getKeyValue();
	 	String keyForAES 			= getKeyValue().substring(0, 16);
		String queryCashTransferURL	= getQueryCashTransferURL();

		StringBuffer buffer			= new StringBuffer();
		buffer.append(customernumber);
		buffer.append(cashrequestid);
		String hmac					= Digest.hmacSign(buffer.toString(), keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", customernumber);
	 	dataMap.put("cashrequestid", cashrequestid);
	 	dataMap.put("hmac", hmac);
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap);
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(queryCashTransferURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
									   new NameValuePair("data", data)};
		
		Map<String, String> result	= new HashMap<String, String>();
		String customError			= ""; // 自定义变量，非接口返回
		
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "UTF-8");
 
			String[] hmacEncryptionOrder = {"customernumber", "cashrequestid", "code", "ledgerno", 
												"amount", "status", "lastno", "desc"};
			result	= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);
			
		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}
		
		System.out.println("result : " + result);
		                                                 	
		return (result);	
	} 

	/**
	 * decryptCashCallbackData() 
	 */

	public static Map<String, String> decryptCashCallbackData(String data) {

		System.out.println("##### decryptCashCallbackData() #####");

		Map<String, String> result 	= new HashMap<String, String>();
		String customernumber	   	= ""; 
        String cashrequestid		= ""; 
        String code			   		= ""; 
        String ledgerno				= ""; 
        String amount		   		= ""; 
        String status		   		= ""; 
        String desc			   		= ""; 
        String lastno			   	= ""; 
        String hmacYeepay		   	= ""; 
        String customError		   	= ""; // 自定义变量，非接口返回

	 	String keyForHmac 		   	= getKeyValue(); 				// 商户秘钥
	 	String keyForAES 		   	= getKeyValue().substring(0, 16); 
	 	
		try {
			String decryptDataStr	= AESUtil.decrypt(data, keyForAES);
			result  				= JSON.parseObject(decryptDataStr, 
													new TypeReference<TreeMap<String, String>>() {});

			if(result.containsKey("msg")) {
				return (result);
			} 

			customernumber		  	= formatString((String)result.get("customernumber")); 
			cashrequestid			= formatString((String)result.get("cashrequestid"));
			code			  		= formatString((String)result.get("code"));
			ledgerno				= formatString((String)result.get("ledgerno"));
			amount			  		= formatString((String)result.get("amount"));
			status			  		= formatString((String)result.get("status"));
			desc			  		= formatString((String)result.get("desc"));
			lastno				  	= formatString((String)result.get("lastno"));
			hmacYeepay			  	= formatString((String)result.get("hmac"));

			String[] stringArray   	= {customernumber, cashrequestid, code, ledgerno, amount, status, desc, lastno};
			String hmacLocal	   	= getHmac(stringArray, keyForHmac);

			if(!hmacLocal.equals(hmacYeepay)) {
				customError			= "hmac mismatch error.";
				result.put("customError", customError);
				StringBuffer buffer = new StringBuffer();
				for(int i = 0; i < stringArray.length; i++) {
					buffer.append(stringArray[i]);
				}
				System.out.println("hmacstring = " + buffer.toString());
				System.out.println("hmacYeepay = " + hmacYeepay);
				System.out.println("hmacLocal = " + hmacLocal);
			}
		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} 
		
		System.out.println("result : " + result);
		                                                 	
		return (result);	
	}   
	
	/**
	 * querySettlement() : 结算结果查询
	 */

	public static Map<String, String> querySettlement(String ledgerno, String date) {

		System.out.println("##### querySettlement() #####");

	 	String customernumber 		= getCustomernumber();
	 	String keyForHmac 			= getKeyValue();
	 	String keyForAES 			= getKeyValue().substring(0, 16);
		String querySettlementURL	= getQuerySettlementURL();

		StringBuffer buffer			= new StringBuffer();
		buffer.append(customernumber);
		buffer.append(ledgerno);
		buffer.append(date);
		String hmac					= Digest.hmacSign(buffer.toString(), keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", customernumber);
	 	dataMap.put("ledgerno", ledgerno);
	 	dataMap.put("date", date);
	 	dataMap.put("hmac", hmac);
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap);
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);

		System.out.println("dataMap : " + dataMap);
		System.out.println("querySettlementURL : " + querySettlementURL);

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(querySettlementURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
									   new NameValuePair("data", data)};
		
		Map<String, String> result	= new HashMap<String, String>();
		String customError			= ""; // 自定义变量，非接口返回
		
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "UTF-8");
 
			String[] hmacEncryptionOrder = {"customernumber", "code", "info"};
			result	= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);
			
		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}
		
		System.out.println("result : " + result);
		                                                 	
		return (result);	
	} 


	/**
	 * queryBindCards() : 绑卡列表查询接口
	 */

	public static Map<String, String> queryBindCards(String userno) {

		System.out.println("##### queryBindCards() #####");

	 	String customernumber 		= getCustomernumber();
	 	String keyForHmac 			= getKeyValue();
	 	String keyForAES 			= getKeyValue().substring(0, 16);
		String queryBindCardsURL	= getQueryBindCardsURL();

		StringBuffer buffer			= new StringBuffer();
		buffer.append(customernumber);
		buffer.append(userno);
		String hmac					= Digest.hmacSign(buffer.toString(), keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", customernumber);
	 	dataMap.put("userno", userno);
	 	dataMap.put("hmac", hmac);
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap);
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);

		System.out.println("dataMap : " + dataMap);
		System.out.println("queryBindCardsURL : " + queryBindCardsURL);

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(queryBindCardsURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
									   new NameValuePair("data", data)};
		
		Map<String, String> result	= new HashMap<String, String>();
		String customError			= ""; // 自定义变量，非接口返回
		
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "UTF-8");
 
			String[] hmacEncryptionOrder = {"customernumber", "userno", "code"};
			result	= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);
			
		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}
		
		System.out.println("result : " + result);
		                                                 	
		return (result);	
	} 

	
	/**
	 * unbindCard() : 解绑接口 
	 */

	public static Map<String, String> unbindCard(Map<String, String> params) {

		System.out.println("##### unbindCard() #####");

	 	String customernumber 		= getCustomernumber();
	 	String keyForHmac 			= getKeyValue();
	 	String keyForAES 			= getKeyValue().substring(0, 16);
		String unbindCardURL		= getUnbindCardURL();

		String userno				= formatString(params.get("userno"));
		String bindid				= formatString(params.get("bindid"));
		String cause				= formatString(params.get("cause"));

		StringBuffer buffer			= new StringBuffer();
		buffer.append(customernumber);
		buffer.append(userno);
		buffer.append(bindid);
		String hmac					= Digest.hmacSign(buffer.toString(), keyForHmac);

	 	Map<String, String> dataMap = new HashMap<String, String>();
	 	dataMap.put("customernumber", customernumber);
	 	dataMap.put("userno", userno);
	 	dataMap.put("bindid", bindid);
	 	dataMap.put("cause", cause);
	 	dataMap.put("hmac", hmac);
	 	
	 	String dataJsonString		= JSON.toJSONString(dataMap);
		String data					= AESUtil.encrypt(dataJsonString, keyForAES);

		System.out.println("dataMap : " + dataMap);
		System.out.println("unbindCardURL : " + unbindCardURL);

		HttpClient httpClient		= new HttpClient();
		PostMethod postMethod		= new PostMethod(unbindCardURL);
		NameValuePair[] datas		= {new NameValuePair("customernumber", customernumber),
									   new NameValuePair("data", data)};
		
		Map<String, String> result	= new HashMap<String, String>();
		String customError			= ""; // 自定义变量，非接口返回
		
		try {
			postMethod.setRequestBody(datas);
			int statusCode		= httpClient.executeMethod(postMethod);
			byte[] responseByte	= postMethod.getResponseBody();
			String responseBody	= new String(responseByte, "UTF-8");
 
			String[] hmacEncryptionOrder = {"customernumber", "userno", "bindid", "code"};
			result	= parseHttpResponseBody(statusCode, responseBody, hmacEncryptionOrder);
			
		} catch(Exception e) {
			customError	= "Caught an Exception - " + e.toString();
			result.put("customError", customError);
			e.printStackTrace();
		} finally {
			postMethod.releaseConnection();
		}
		
		System.out.println("result : " + result);
		                                                 	
		return (result);	
	} 
}           
