package com.rycf.gjb.controller;

import java.io.File;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.rycf.gjb.pay.RedPaperFactory;
import com.rycf.gjb.service.BrandPayCardService;
import com.rycf.gjb.service.BrandScanService;
import com.rycf.gjb.service.BrandService;
import com.rycf.gjb.service.BrandTypeService;
import com.rycf.gjb.service.BrandUserService;
import com.rycf.gjb.service.FurnitureBudgetService;
import com.rycf.gjb.service.FurnitureRequiredService;
import com.rycf.gjb.service.FurnitureStyleService;
import com.rycf.gjb.service.FurnitureTypeService;
import com.rycf.gjb.service.FurnitureZoneService;
import com.rycf.gjb.service.FurnitureZoneToTypeService;
import com.rycf.gjb.service.GetMoreUserService;
import com.rycf.gjb.service.GuideChatHistoryService;
import com.rycf.gjb.service.MenuManagerService;
import com.rycf.gjb.service.OrderChannelService;
import com.rycf.gjb.service.OrderService;
import com.rycf.gjb.service.RequiredAnswerHistoryImgService;
import com.rycf.gjb.service.RequiredAnswerService;
import com.rycf.gjb.service.RoleMenusService;
import com.rycf.gjb.service.RoleService;
import com.rycf.gjb.service.StoreService;
import com.rycf.gjb.service.SystemUserService;
import com.rycf.gjb.service.ThirdChannelService;
import com.rycf.gjb.service.ThirdGuideService;
import com.rycf.gjb.service.ThirdNormalService;
import com.rycf.gjb.service.UserCardService;
import com.rycf.gjb.service.WechatUserService;
import com.rycf.gjb.service.minisite.DesignApplyService;
import com.rycf.gjb.service.minisite.NineteenActivityService;
import com.rycf.gjb.service.minisite.PhoneRegisterService;
import com.rycf.gjb.util.OpenIdUtil;

/**
 * 基础Controller类。负责 service注入
 * @author qzm
 * @since 2015-5-13
 */
@Controller
public class BaseController {
	//图片生成存放路径,在tomcat根目录
	protected String imgPath=System.getProperty("catalina.base")+"/imgStore/";
	
	//类创建完毕后加载图片仓库
	@PostConstruct
	public void init(){
		File imgFile=new File(imgPath);
		if(!imgFile.exists()){
			imgFile.mkdirs();
		}
	}
	protected String superId="101";//超级管理员ID
	protected String getMoreId="role143486797292016";//凯特毛管理ID
	protected String brandRoleId="role143486930117862";//   品牌管理人ID
	protected String storeId="role143486931360527";//店长ID
	public static final String LOGIN_USER="loginUser";//店长ID
	//加载微信公众号
	@Resource
	protected OpenIdUtil openIdUtil;//菜单管理service
	
	@Resource
	protected RedPaperFactory redPaperFactory;//生成红包
	@Resource
	protected MenuManagerService menuManagerService;//菜单管理service
	@Resource
	protected RoleService roleService;//角色管理service
	@Resource
	protected RoleMenusService roleMenusService;//权限管理service 
	@Resource
	protected SystemUserService systemUserService;//系统人员service
	@Resource
	protected FurnitureZoneService furnitureZoneService;//家具功能区域service
	@Resource
	protected FurnitureTypeService furnitureTypeService;//家具品类service
	@Resource
	protected FurnitureZoneToTypeService furnitureZoneToTypeService;//家具功能-品类service
	@Resource
	protected FurnitureStyleService furnitureStyleService;//家具品类service
	@Resource
	protected FurnitureBudgetService furnitureBudgetService;//家具预算service
	@Resource
	protected BrandTypeService brandTypeService;//品牌类型预算service
	@Resource
	protected FurnitureRequiredService furnitureRequiredService;//家具需求service
	@Resource
	protected StoreService storeService;//店铺服务类
	@Resource
	protected BrandService brandService;
	@Resource
	protected BrandScanService scanService;//店铺浏览历史记录
	@Resource
	protected OrderService orderService;//订单详情
	@Resource
	protected UserCardService userCardService;//用户卡绑定
	@Resource
	protected BrandUserService brandUserService;//品牌-管理员对应表
	@Resource
	protected NineteenActivityService nineteenActivityService;//19家活动表
	@Resource
	protected RequiredAnswerService requiredAnswerService;//方案表
	@Resource
	protected RequiredAnswerHistoryImgService historyImgService;//方案历史图片
	@Resource
	protected BrandPayCardService brandPayCardService;//品牌管理员支付账号
	@Resource
	protected WechatUserService wechatUserService;//微信用户
	
	@Resource
	protected PhoneRegisterService registerService;//注册列表
	
	@Resource
	protected GetMoreUserService getMoreUserService;//凯特猫用户
	
	@Resource
	protected ThirdChannelService channelService;//渠道
	
	@Resource
	protected OrderChannelService orderChannelService;//渠道支付中间表
	
	@Resource
	protected ThirdGuideService thirdGuideService;//导购
	
	@Resource
	protected GuideChatHistoryService chatService;//聊天
	
	@Resource
	protected DesignApplyService applyService;//
	
	@Resource
	protected ThirdNormalService normalService;//普通用户
	
	
}
