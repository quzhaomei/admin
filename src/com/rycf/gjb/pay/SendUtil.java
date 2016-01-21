package com.rycf.gjb.pay;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.security.KeyStore;

import javax.net.ssl.SSLContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Result;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.dom4j.DocumentHelper;
import org.w3c.dom.Document;
import org.w3c.dom.Element;





public class SendUtil {
	private static String url="https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack";
	private static String key="getmore2015getmore2015getmore201";
	private static String password="1259988601";
	//生成红包的数字签名
	
	public static void setSign(RedPaper redPaper){
		String param="act_name="+redPaper.getAct_name()+
					"&client_ip="+redPaper.getClient_ip()+
					"&max_value="+redPaper.getMax_value()+
					"&mch_billno="+redPaper.getMch_billno()+
					"&mch_id="+redPaper.getMch_id()+
					"&min_value="+redPaper.getMin_value()+
					"&nick_name="+redPaper.getNick_name()+
					"&nonce_str="+redPaper.getNonce_str()+
					"&re_openid="+redPaper.getRe_openid()+
					"&remark="+redPaper.getRemark()+
					"&send_name="+redPaper.getSend_name()+
					"&total_amount="+redPaper.getTotal_amount()+
					"&total_num="+redPaper.getTotal_num()+
					"&wishing="+redPaper.getWishing()+
					"&wxappid="+redPaper.getWxappid()+
					"&key="+key;
		Logger.getLogger(SendUtil.class).info("加密前："+param);
		param=MD5Util.GetMD5Code(param).toUpperCase();
		Logger.getLogger(SendUtil.class).info("加密后："+param);
		redPaper.setSign(param);
	}
	
	public static String getXmlStr(RedPaper redPaper){
	    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	    DocumentBuilder builder=null;
		try {
			builder = factory.newDocumentBuilder();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		}
        Document document = builder.newDocument();
        Element root = document.createElement("xml");
        document.appendChild(root);
        Element act_name = document.createElement("act_name");
        act_name.setTextContent(redPaper.getAct_name());
        root.appendChild(act_name);
        
        Element client_ip = document.createElement("client_ip");
        client_ip.setTextContent(redPaper.getClient_ip());
        root.appendChild(client_ip);
        
        Element max_value = document.createElement("max_value");
        max_value.setTextContent(redPaper.getMax_value());
        root.appendChild(max_value);
        
        Element mch_billno = document.createElement("mch_billno");
        mch_billno.setTextContent(redPaper.getMch_billno());
        root.appendChild(mch_billno);
        
        Element mch_id = document.createElement("mch_id");
        mch_id.setTextContent(redPaper.getMch_id());
        root.appendChild(mch_id);
        
        Element min_value = document.createElement("min_value");
        min_value.setTextContent(redPaper.getMin_value());
        root.appendChild(min_value);
        
        Element nick_name = document.createElement("nick_name");
        nick_name.setTextContent(redPaper.getNick_name());
        root.appendChild(nick_name);
        
        Element nonce_str = document.createElement("nonce_str");
        nonce_str.setTextContent(redPaper.getNonce_str());
        root.appendChild(nonce_str);
        
        Element re_openid = document.createElement("re_openid");
        re_openid.setTextContent(redPaper.getRe_openid());
        root.appendChild(re_openid);
        
        Element remark = document.createElement("remark");
        remark.setTextContent(redPaper.getRemark());
        root.appendChild(remark);
        
        Element send_name = document.createElement("send_name");
        send_name.setTextContent(redPaper.getSend_name());
        root.appendChild(send_name);
        
        Element total_amount = document.createElement("total_amount");
        total_amount.setTextContent(redPaper.getTotal_amount());
        root.appendChild(total_amount);
        
        Element total_num = document.createElement("total_num");
        total_num.setTextContent(redPaper.getTotal_num());
        root.appendChild(total_num);
        
        Element wishing = document.createElement("wishing");
        wishing.setTextContent(redPaper.getWishing());
        root.appendChild(wishing);
        
        Element wxappid = document.createElement("wxappid");
        wxappid.setTextContent(redPaper.getWxappid());
        root.appendChild(wxappid);
        
        Element sign = document.createElement("sign");
        sign.setTextContent(redPaper.getSign());
        root.appendChild(sign);
        
        DOMSource source = new DOMSource(document);  
        
        StringWriter writerStr = new StringWriter();  
        Result resultStr = new StreamResult(writerStr);  
          
        // 此抽象类的实例能够将源树转换为结果树。  
        Transformer transformer=null;
		try {
			transformer = TransformerFactory.newInstance()  
			        .newTransformer();
		} catch (TransformerConfigurationException e1) {
			e1.printStackTrace();
		} catch (TransformerFactoryConfigurationError e1) {
			e1.printStackTrace();
		}  
        // 设置编码  
        transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");  
        // 是否缩进  
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");  
        // 将 XML Source 转换为 Result  
        try {
			transformer.transform(source, resultStr);
		} catch (TransformerException e) {
			e.printStackTrace();
		}  
        //获取XML字符串  
        String xmlStr = writerStr.getBuffer().toString(); 
        return xmlStr;
	}
	//发送红包
	public static SendResult sendPaper(RedPaper paper){
		  SendResult result=new SendResult();
		 KeyStore keyStore=null;
		try {
			keyStore = KeyStore.getInstance("PKCS12");
			
	        InputStream instream = SendUtil.class.getClassLoader().getResourceAsStream("apiclient_cert.p12");
	        try {
	            keyStore.load(instream, password.toCharArray());
	        }  finally {
	            instream.close();
	        }
	        SSLContext sslcontext = SSLContexts.custom()
	                .loadKeyMaterial(keyStore, password.toCharArray())
	                .build();
	        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
	                sslcontext,
	                new String[] { "TLSv1" },
	                null,
	                SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
	        CloseableHttpClient httpclient = HttpClients.custom()
	                .setSSLSocketFactory(sslsf)
	                .build();
	        try {
	        	
	        	
	            HttpPost httpost=new HttpPost(url);
	            httpost.addHeader("Connection", "keep-alive");
	        	httpost.addHeader("Accept", "*/*");
	        	httpost.addHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
	        	httpost.addHeader("Host", "api.mch.weixin.qq.com");
	        	httpost.addHeader("X-Requested-With", "XMLHttpRequest");
	        	httpost.addHeader("Cache-Control", "max-age=0");
	        	httpost.addHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0) ");
	    		httpost.setEntity(new StringEntity(getXmlStr(paper), "UTF-8"));
	            CloseableHttpResponse response = httpclient.execute(httpost);
	            try {
	                HttpEntity entity = response.getEntity();
	                if (entity != null) {
	                	StringBuffer resultSb=new StringBuffer();
	                    BufferedReader bufferedReader = new BufferedReader(
	                    		new InputStreamReader(entity.getContent(),"utf-8"));
	                    String text;
	                    while ((text = bufferedReader.readLine()) != null) {
	                    	resultSb.append(text);
	                    }
	                        org.dom4j.Document doc;   
	                         doc = DocumentHelper.parseText(resultSb.toString());   
	                         
	                         org.dom4j.Element root = doc.getRootElement();  
	                        String code= root.element("return_code").getTextTrim();
	                        String msg= root.element("return_msg").getTextTrim();
	                        result.setReturn_code(code);
	                        result.setReturn_msg(msg); 
	                }
	                EntityUtils.consume(entity);
	            } finally {
	                response.close();
	            }
	        } finally {
	            httpclient.close();
	        }
	    }catch (Exception e) {
		e.printStackTrace();
	    }
		return result;
	}
	/**
	 * 获取ip
	 * 
	 * @param request
	 * @return
	 */
}
