package com.rycf.gjb.util;

import java.util.Date;
import java.util.Random;

public class UuidUtils {
	public static final Random random=new Random();
	/**
	 * 主键生成策略,生成一个15位不重复的主键
	 * @return
	 */
	public static char[]arr=new char[]{'2','3','4','5','6','7','8','9','A','B','C','D','E','F',
			'G','H','J','K','M','N','O','P','Q','R','S','T','W','X','Y','Z'};
	
	public static String getUUID(){
		return new Date().getTime()+""+(random.nextInt(10))+(random.nextInt(10));
	}
	public static String getSixCode(){
		StringBuilder sb=new StringBuilder("");
		for(int i=0;i<6;i++){
		sb.append(arr[random.nextInt(arr.length)]);
		}
		return sb.toString();
	}
	public static void main(String[] args) {
		System.out.println(getSixCode());
	}
	public static String getImgUUID(){
		return "img"+new Date().getTime()+""+(random.nextInt(10))+(random.nextInt(10));
	}
	public static String getObjectUUID(String code){
		if(code==null){
			code="";
		}
		return code+new Date().getTime()+""+(random.nextInt(10))+(random.nextInt(10))+random.nextInt(10);
	}
	//生成11位不重复的商户requiestId
	public static String getRequirstId(){
		String str=System.currentTimeMillis()+"";
		str=str.substring(str.length()-8)+random.nextInt(10)+random.nextInt(10);
		return str;
	}
}
