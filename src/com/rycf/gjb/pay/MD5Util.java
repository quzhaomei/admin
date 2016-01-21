package com.rycf.gjb.pay;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Util {	 
    // 全局数组
    private final static String[] strDigits = { "0", "1", "2", "3", "4", "5",
            "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };

    // 返回形式为数字跟字符串
    private static String byteToArrayString(byte bByte) {
        int iRet = bByte;
        // System.out.println("iRet="+iRet);
        if (iRet < 0) {
            iRet += 256;
        }
        int iD1 = iRet / 16;
        int iD2 = iRet % 16;
        return strDigits[iD1] + strDigits[iD2];
    }

    // 转换字节数组为16进制字串
    private static String byteToString(byte[] bByte) {
        StringBuffer sBuffer = new StringBuffer();
        for (int i = 0; i < bByte.length; i++) {
            sBuffer.append(byteToArrayString(bByte[i]));
        }
        return sBuffer.toString();
    }

    public static String GetMD5Code(String strObj) {
        String resultString = null;
        try {
            resultString = new String(strObj);
            MessageDigest md = MessageDigest.getInstance("MD5");
            // md.digest() 该函数返回值为存放哈希值结果的byte数组
            try {
				resultString = byteToString(md.digest(strObj.getBytes("UTF-8")));
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        } catch (NoSuchAlgorithmException ex) {
            ex.printStackTrace();
        }
        return resultString;
    }
 public static void main(String[] args) {
	System.out.println(GetMD5Code("act_name=凯特猫家具返利&client_ip=127.0.0.1&max_value=100&mch_billno=1259988601201508089023637897&mch_id=1259988601&min_value=100&nick_name=凯特猫&nonce_str=199112&re_openid=oXxoDs2z83M9QJ80-MH-M8-rbTiI&remark=祝您返利愉快&send_name=凯特猫家具返利&total_amount=100&total_num=1.0&wishing=凯特猫返利(品牌：大普),给您更多&wxappid=wx3eb32765a49ad851&key=getmore2015getmore2015getmore201"));
 }
}
