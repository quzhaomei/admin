package com.rycf.gjb.test;

import java.io.IOException;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

import com.yeepay.g3.utils.common.json.JSONUtils;


public class Test {
	public static void main(String[] args) {
		String action="http://dwz.cn/create.php";
		String url="http://localhost:8080/admin/phoneRegister.html?" +
				"registerCode=d0431c6e970c1dcd3c733d33568a32cc";
		String alias="";
		
		PostMethod method=new PostMethod(action);
		method.addParameters(new NameValuePair[]{
				new NameValuePair("url", url),
				new NameValuePair("alias", alias)}
					);
		HttpClient client=new HttpClient();
		try {
			int status=client.executeMethod(method);
			if(status==HttpStatus.SC_OK){
				System.out.println("请求成功");
			String res=method.getResponseBodyAsString();
			Map<String, Object>result=JSONUtils.jsonToMap(res, String.class, String.class);
			result.get("tinyurl");
			}else{
				System.out.println("请求失败");
			}
		} catch (HttpException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}
