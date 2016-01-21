package com.rycf.gjb.pay;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
@Repository
public class RedPaperFactory {
	@Value("#{propertyConfigurer['appId']}")
	private String appId="wx3eb32765a49ad851";
	private static final String password="1259988601";
	private SimpleDateFormat dateFormat=new SimpleDateFormat("yyyyMMdd");
	private String getBillno(){//生成商户订单号
		String ten=System.currentTimeMillis()+"";
		ten=ten.substring(ten.length()-10);
		return password+dateFormat.format(new Date())+ten;
	}
	public String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("PRoxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		if (null == ip) {
			ip = "";
		}
		if (ip!=null&&!ip.equals("")) {
			String[] ipArr = ip.split(",");
			if (ipArr.length > 1) {
				ip = ipArr[0];
			}
		}
		return ip;
	}
	public RedPaper getInstance(String openId,float num,HttpServletRequest request){
		RedPaper redPaper=new RedPaper();
		redPaper.setNonce_str("19911212");
		redPaper.setMch_id(password);
		redPaper.setMch_billno(getBillno());
		redPaper.setWxappid(appId);
		redPaper.setNick_name("凯特猫");
		redPaper.setSend_name("凯特猫家具返利");
		redPaper.setRe_openid(openId);
		redPaper.setTotal_amount(Math.round(num*100)+"");
		redPaper.setMax_value(Math.round(num*100)+"");
		redPaper.setMin_value(Math.round(num*100)+"");
		redPaper.setTotal_num("1");
		redPaper.setWishing("凯特猫给你的更多");
		redPaper.setClient_ip(getIpAddr(request));
		redPaper.setAct_name("凯特猫家具返利");
		redPaper.setRemark("祝您返利愉快");
		SendUtil.setSign(redPaper);//生成签名
		return redPaper;
	}
	public RedPaper getInstance(String openId,float num,HttpServletRequest request,String wish){
		RedPaper redPaper=new RedPaper();
		redPaper.setNonce_str("19911212");
		redPaper.setMch_id(password);
		redPaper.setMch_billno(getBillno());
		redPaper.setWxappid(appId);
		redPaper.setNick_name("凯特猫");
		redPaper.setSend_name("凯特猫家具返利");
		redPaper.setRe_openid(openId);
		redPaper.setTotal_amount(Math.round(num*100)+"");
		redPaper.setMax_value(Math.round(num*100)+"");
		redPaper.setMin_value(Math.round(num*100)+"");
		redPaper.setTotal_num("1");
		redPaper.setWishing(wish);
		if(request!=null){
			redPaper.setClient_ip(getIpAddr(request));
		}else{
			redPaper.setClient_ip("127.0.0.1");
		}
		redPaper.setAct_name("凯特猫家具返利");
		redPaper.setRemark("祝您返利愉快");
		SendUtil.setSign(redPaper);//生成签名
		return redPaper;
	}
	public static void main(String[] args) {
		String openId="oXxoDs2z83M9QJ80-MH-M8-rbTiI";
		RedPaperFactory redFac=new RedPaperFactory();
			RedPaper red= redFac.getInstance(openId, 1.0f, null,"inhao");
			SendResult sendResult= SendUtil.sendPaper(red);
			System.out.println(sendResult.getReturn_msg());
			
	}
}
