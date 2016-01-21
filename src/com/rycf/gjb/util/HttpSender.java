package com.rycf.gjb.util;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URLDecoder;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.URI;
import org.apache.commons.httpclient.methods.GetMethod;

/**
 * @author Beyond
 */
public class HttpSender {
	private static String sendUrl = "http://222.73.117.158/msg/";// 应用地址
	private static String account = "jupinghui02";// 账号
	private static String pswd = "Tch123456";// 密码
	private static String testInfo = "您好，您的验证码是123456";// 短信内容
	
	public static HttpSendResult sendMsg(String mobile, String msg) throws Exception{
		if(msg==null){
			msg=testInfo;
		}
		return parseResult(
				send(sendUrl, account, pswd, mobile, msg, true, null, null
						));
	}
	public static void main(String[] args) {
		try {
			System.out.println(sendMsg("18809127168",
					"尊敬的小Q,凯特猫家居返利，铁打的返利,详情点击链接http://www.getmore.cn-退订回复TD").getInfo());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	private static HttpSendResult parseResult(String info){
		//是否成功
		String[] isok=info.split("\n");
		if(isok.length>1){
			return new HttpSendResult(true, "短信发送成功！") ;
		}else{
			isok=info.split(",");
			String key=isok[1].trim();//获取第二个提示
			String tips=null;
			switch (Integer.parseInt(key)) {
			case 101:
				tips = "无此用户";
				break;
			case 102:
				tips = "密码错误";
				break;
			case 104:
				tips = "系统繁忙";
				break;
			case 105:
				tips = "短信内容包含敏感词";
				break;
			case 106:
				tips = "消息长度过长，不能大于536";
				break;
			case 107:
				tips = "手机号码错误";
				break;
			case 108:
				tips = "手机号码个数错误";
				break;
			case 109:
				tips = "短信额度已用完";
				break;
			case 110:
				tips = "不在发送时间内";
				break;
			case 111:
				tips = "超出该账户当月发送额度限制";
				break;
			case 112:
				tips = "无此产品，用户没有订购该产品";
				break;
			case 113:
				tips = "extno格式错（非数字或者长度不对）";
				break;
			case 115:
				tips = "自动审核驳回";
				break;
			case 116:
				tips = "签名不合法，未带签名";
				break;
			case 117:
				tips = "IP地址认证错";
				break;
			case 118:
				tips = "用户没有相应的发送权限";
				break;
			case 119:
				tips = "用户已过期";
				break;
			default:
				tips = "";
				break;
			}
			return new HttpSendResult(false, "短信账户："+tips+"("+key+")") ;
		}
	}
	/**
	 * @param url 应用地址，类似于http://ip:port/msg/
	 * @param account 账号
	 * @param pswd 密码
	 * @param mobile 手机号码，多个号码使用","分割
	 * @param msg 短信内容
	 * @param needstatus 是否需要状态报告，需要true，不需要false
	 * @return 返回值定义参见HTTP协议文档
	 * @throws Exception
	 */
	private static String send(String url, String account, String pswd, String mobile, String msg,
			boolean needstatus, String product, String extno) throws Exception {
		HttpClient client = new HttpClient();
		GetMethod method = new GetMethod();
		try {
			URI base = new URI(url, false);
			method.setURI(new URI(base, "HttpBatchSendSM", false));
			method.setQueryString(new NameValuePair[] { 
					new NameValuePair("account", account),
					new NameValuePair("pswd", pswd), 
					new NameValuePair("mobile", mobile),
					new NameValuePair("needstatus", String.valueOf(needstatus)), 
					new NameValuePair("msg", msg),
					new NameValuePair("product", product), 
					new NameValuePair("extno", extno), 
				});
			int result = client.executeMethod(method);
			if (result == HttpStatus.SC_OK) {
				InputStream in = method.getResponseBodyAsStream();
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				byte[] buffer = new byte[1024];
				int len = 0;
				while ((len = in.read(buffer)) != -1) {
					baos.write(buffer, 0, len);
				}
				return URLDecoder.decode(baos.toString(), "UTF-8");
			} else {
				throw new Exception("HTTP ERROR Status: " + method.getStatusCode() + ":" + method.getStatusText());
			}
		} finally {
			method.releaseConnection();
		}

	}

	/**
	 * 
	 * @param url 应用地址，类似于http://ip:port/msg/
	 * @param account 账号
	 * @param pswd 密码
	 * @param mobile 手机号码，多个号码使用","分割
	 * @param msg 短信内容
	 * @param needstatus 是否需要状态报告，需要true，不需要false
	 * @return 返回值定义参见HTTP协议文档
	 * @throws Exception
	 */
	protected static String batchSend(String url, String account, String pswd, String mobile, String msg,
			boolean needstatus, String product, String extno) throws Exception {
		HttpClient client = new HttpClient();
		GetMethod method = new GetMethod();
		try {
			URI base = new URI(url, false);
			method.setURI(new URI(base, "HttpBatchSendSM", false));
			method.setQueryString(new NameValuePair[] { 
					new NameValuePair("account", account),
					new NameValuePair("pswd", pswd), 
					new NameValuePair("mobile", mobile),
					new NameValuePair("needstatus", String.valueOf(needstatus)), 
					new NameValuePair("msg", msg),
					new NameValuePair("product", product),
					new NameValuePair("extno", extno), 
				});
			int result = client.executeMethod(method);
			if (result == HttpStatus.SC_OK) {
				InputStream in = method.getResponseBodyAsStream();
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				byte[] buffer = new byte[1024];
				int len = 0;
				while ((len = in.read(buffer)) != -1) {
					baos.write(buffer, 0, len);
				}
				return URLDecoder.decode(baos.toString(), "UTF-8");
			} else {
				throw new Exception("HTTP ERROR Status: " + method.getStatusCode() + ":" + method.getStatusText());
			}
		} finally {
			method.releaseConnection();
		}

	}
}
