package com.rycf.gjb.util;

import java.util.HashMap;
import java.util.Map;

/**
 * 常量定义
 * 
 * @author tj
 * 
 */
public class Constant {
	/**
	 * 用户登录产生session,保存session名称
	 */
	public static final String USER_SESSION_NAME = "userSessionName";
	public static final String USER_BACK_SESSION_NAME = "user";
	
	/**
	 * 验证码所使用的字符集
	 */
	public static final char[] CHARS = { 'A', 'B', 'C', 'D', 'E', 'F', 'G',
			'H', 'J', 'K', 'M', 'N', 'P', 'Q', 'R', 'S', 'T',
			'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g',
			'h', 'j', 'k', 'm', 'n', 'p', 'q', 'r', 's', 't',
			'u', 'v', 'w', 'x', 'y', 'z', '1', '2', '3', '4', '5', '6',
			'7', '8', '9' };
	public static final String SUCCESS = "发送成功";

	public static final String FAIL = "发送失败";

	public static final Integer[] USER_LEVEL = { 0, 1000, 10000 };

	// 分页常量
	public static final int SHOWLINES = 10;
	
	// 分页显示详细条数
	public static final int SHOWLINES_DETAIL = 6;
	/**
	 * 配资类型 天
	 */
	public static final String CHOOSE_DAY = "D";
	/**
	 * 配资类型月
	 */
	public static final String CHOOSE_MONTH = "M";
	/**
	 * 配资状态 未支付
	 */
	public static final String DO_WORK_WILL = "0";
	/**
	 * 配资状态 已支付
	 */
	public static final String DO_WORK_ED = "1";
	/**
	 * 配资状态 交易中
	 */
	public static final String DO_WORK_TRADEING = "2";
	/**
	 * 配资状态 已结束
	 */
	public static final String DO_WORK_TRADED = "3";
	/**
	 * 股票状态 未交易
	 */
	public static final String STOCK_WILL = "0";
	/**
	 * 股票状态 交易中
	 */
	public static final String STOCK_DOING = "1";
	/**
	 * 股票状态 交易完成
	 */
	public static final String STOCK_OVERED = "2";
	/**
	 * 配资待平仓
	 */
	public static final String MATCH_LOCAL_0 = "0";
	/**
	 * 配资已平仓
	 */
	public static final String MATCH_LOCAL_1 = "1";
	/**
	 * 配资处理完成
	 */
	public static final String MATCH_LOCAL_2 = "2";
	
	/**
	 * 深交所
	 */
	public static final String STOCK_LOCAL_0 = "0";
	/**
	 * 沪交所
	 */
	public static final String STOCK_LOCAL_1 = "1";
	/**
	 * 管理端交易
	 */
	public static final String REQUEST_G = "G";
	/**
	 * 客户端交易
	 */
	public static final String REQUEST_C = "C";
	/**
	 * 股票交易类别卖出
	 */
	public static final String TRADE_TYPE_S = "S";
	/**
	 * 股票交易类别买入
	 */
	public static final String TRADE_TYPE_B = "B";
	
	/*
	 * ==========================================================================
	 * ===============
	 */
	/**
	 *操作编码:131000-配资-投股
	 */
	public static final String Operation_code_131000 = "131000";
	/**
	 * 131001-配资冻结
	 */
	public static final String Operation_code_131001 = "131001";
	/**
	 * 131002-配资解冻
	 */
	public static final String Operation_code_131002 = "131002";
	/**
	 * 132000-投资
	 */
	public static final String Operation_code_132000 = "132000";
	/**
	 * 132001-接受转让
	 */
	public static final String Operation_code_132001 = "132001";
	/**
	 * 133000-充值
	 */
	public static final String Operation_code_133000 = "133000";
	/**
	 * 134000-提现
	 */
	public static final String Operation_code_134000 = "134000";
	/**
	 * 135000-回帐
	 */
	public static final String Operation_code_135000 = "135000";
	/**
	 * 135001-投资回帐
	 */
	public static final String Operation_code_135001 = "135001";
	/**
	 * 135003-转让回帐
	 */
	public static final String Operation_code_135003 = "135003";
	/**
	 * 135004-投资回帐（结算完成）
	 */
	public static final String Operation_code_135004 = "135004";
	/**
	 * 135002-配资回帐
	 */
	public static final String Operation_code_135002 = "135002";

	/*
	 * ==========================================================================
	 * ===============
	 */
	/**
	 * 身份证认证状态 0 未认证
	 */
	public static final int CARD_STATE_0 = 0;
	/**
	 * 身份证认证状态 1 认证完成
	 */
	public static final int CARD_STATE_1 = 1;

	/**
	 * 样式信息
	 */
	public static Map<String, String> styleMap = new HashMap<String, String>();

	static {
		styleMap.put("中国工商银行", "bank_01");
		styleMap.put("中国农业银行", "bank_02");
		styleMap.put("中国建设银行", "bank_03");
		styleMap.put("中国银行", "bank_04");
		styleMap.put("招商银行", "bank_05");
		styleMap.put("交通银行", "bank_06");
		styleMap.put("中国邮政储蓄", "bank_07");
		styleMap.put("兴业银行", "bank_08");
		styleMap.put("中信银行", "bank_09");
		styleMap.put("中国民生银行", "bank_10");
		styleMap.put("光大银行", "bank_11");
		styleMap.put("浦发银行", "bank_12");
		styleMap.put("广发银行", "bank_13");
		styleMap.put("深圳发展银行", "bank_14");
		styleMap.put("华夏银行", "bank_15");
		styleMap.put("厦门银行", "bank_16");
		styleMap.put("宁波银行", "bank_17");
		styleMap.put("平安银行", "bank_18");
	}

	/**
	 * 用户正常状态
	 */
	public static final String USER_NORMAL_STATE = "1";
	
	/**
	 * 用户锁定状态
	 */
	public static final String USER_LOCK_STATE = "2";
	
	/**
	 * 用户冻结状态
	 */
	public static final String USER_FORZEN_STATE = "0"; 
	
	/**
	 * 普通用户
	 */
	public static final String GJB_USER = "1";
	
	/**
	 * 经纪人
	 */
	public static final String GJB_BUSINESS = "2";
	
	/**
	 * 管理员
	 */
	public static final String GJB_MANAGER = "3";
	
	/**
	 * 超级管理员
	 */
	public static final String GJB_SUPER_MANAGER = "4";
	
	/**
	 * 开
	 */
	public static final String STATE_ON = "1";
	
	/**
	 * 关
	 */
	public static final String STATE_OFF = "0";
	
	/**
	 * 首页菜单
	 */
	public static final String MENU_TYPE_INDEX = "1";
	
	/**
	 * 个人中心菜单
	 */
	public static final String MENU_TYPE_USER_CENTER = "2";

	/**
	 * 后台菜单
	 */
	public static final String MENU_TYPE_BACK = "3";
	
	
	
}
