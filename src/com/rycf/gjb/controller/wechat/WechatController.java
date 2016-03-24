package com.rycf.gjb.controller.wechat;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.mysql.jdbc.StringUtils;
import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.BrandDTO;
import com.rycf.gjb.dto.BrandScanDTO;
import com.rycf.gjb.dto.FurnitureBudgetDTO;
import com.rycf.gjb.dto.FurnitureRequiredDTO;
import com.rycf.gjb.dto.FurnitureStyleDTO;
import com.rycf.gjb.dto.FurnitureZoneDTO;
import com.rycf.gjb.dto.GetMoreUserDTO;
import com.rycf.gjb.dto.GuideChatHistoryDTO;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.OrderDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.RequiredAnswerDTO;
import com.rycf.gjb.dto.StoreDTO;
import com.rycf.gjb.dto.ThirdChannelDTO;
import com.rycf.gjb.dto.ThirdGuideCustomDTO;
import com.rycf.gjb.dto.ThirdGuideDTO;
import com.rycf.gjb.dto.ThirdGuideHistoryDTO;
import com.rycf.gjb.dto.UserCardDTO;
import com.rycf.gjb.entity.Brand;
import com.rycf.gjb.entity.BrandScan;
import com.rycf.gjb.entity.FurnitureRequired;
import com.rycf.gjb.entity.GetMoreUser;
import com.rycf.gjb.entity.GuideChatHistory;
import com.rycf.gjb.entity.Order;
import com.rycf.gjb.entity.Store;
import com.rycf.gjb.entity.ThirdChannel;
import com.rycf.gjb.entity.ThirdGuide;
import com.rycf.gjb.entity.ThirdNormal;
import com.rycf.gjb.entity.UserCard;
import com.rycf.gjb.entity.WechatUser;
import com.rycf.gjb.interceptor.WechatTag;
import com.rycf.gjb.pay.MD5Util;
import com.rycf.gjb.socket.ServerSocket;
import com.rycf.gjb.util.Constant;
import com.rycf.gjb.util.ImgUtil;
import com.rycf.gjb.util.JSONUtil;
import com.rycf.gjb.util.MapUtil;
import com.rycf.gjb.util.MatrixToImageWriter;
import com.rycf.gjb.util.UuidUtils;

import sun.security.action.GetLongAction;

/**
 * 微信
 * 
 * @author Administrator
 */
@RequestMapping(value = "/wechat")
@Controller
@WechatTag
public class WechatController extends BaseController {

	protected Logger logger = Logger.getLogger(this.getClass());
	@Value("#{propertyConfigurer['appId']}")
	private String appId;

	private String timestamp;
	private String token;
	private String nonceStr;
	private String ticket;
	private Map<String, Date> time = new HashMap<String, Date>();

	@PostConstruct
	public void initJsapiSign() {// 2小时 后 刷新
		try {
			timestamp = create_timestamp();
			nonceStr = create_nonce_str();
			token = openIdUtil.getToken();
			ticket = openIdUtil.getTicket(nonceStr, timestamp, token);// 2小时刷新一次
			time.put("ticket_time", new Date());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/login")
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		WechatUser weUser = wechatUserService.getWechatUserByGetMoreId(loginUser.getGetMoreId());
		String url = request.getParameter("url");
		String key = "xiaoqushitiancai";
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		String sign = MD5Util.GetMD5Code(weUser.getOpenid() + key);
		if (request.getParameter("url") != null) {// 如果是从外部请求
			try {
				url = URLDecoder.decode(url, "utf-8");
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
			try {
				response.sendRedirect(url + "?openId=" + weUser.getOpenid() + "&nickname=" + weUser.getNickname()
						+ "&sign=" + sign + "&role=" + role);
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
		return null;
	}

	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {

		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		if (request.getParameter("out") != null) {// 如果是从外部请求
			request.setAttribute("uri", request.getParameter("out"));
		}
		// 更新凯特猫的浏览记录
		String timeFormat = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		BrandScan param = new BrandScan();
		param.setGetMoreId(loginUser.getGetMoreId());
		param.setTime(timeFormat);
		BrandScanDTO history = scanService.getScanByParam(param);
		param.setSeeDate(new Date());
		// 保存今天的浏览记录
		if (history == null) {
			scanService.saveScan(param);
		} else {
			param.setBrandScanId(history.getBrandScanId());
			scanService.updateScan(param);
		}

		// 验证超时了没。
		Date putDate = time.get("ticket_time");
		Long dual = new Date().getTime() - putDate.getTime();
		if (dual > 7200 * 900) {// 重置ticket
			initJsapiSign();
		}
		String queryString = request.getQueryString();
		String url = request.getRequestURL().toString();
		if (queryString != null) {
			url = url + "?" + queryString;
		}
		String sign = openIdUtil.getJsSign(nonceStr, timestamp, ticket, url);
		// 生成微信凭证
		model.addAttribute("appId", appId);
		model.addAttribute("timestamp", timestamp);
		model.addAttribute("signature", sign);
		model.addAttribute("nonceStr", nonceStr);
		if (request.getParameter("out") != null) {// 如果是从外部请求
			request.setAttribute("uri", request.getParameter("out"));
		}
		// 查询是否需要内部跳转
		String goto_uri = request.getParameter("goto");
		if (goto_uri != null) {
			try {
				request.setAttribute("appId", appId);
				request.setAttribute("timestamp", timestamp);
				request.setAttribute("signature", sign);
				request.setAttribute("nonceStr", nonceStr);
				request.getRequestDispatcher(goto_uri).forward(request, response);
				return null;
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// 查询近四次的浏览记录
		BrandScan scan = new BrandScan();
		scan.setGetMoreId(loginUser.getGetMoreId());
		PageDTO<BrandScan> page = new PageDTO<BrandScan>();
		page.setPageIndex(1);
		page.setPageSize(4);
		page.setParam(scan);

		List<BrandScanDTO> scanHistory = scanService.getScanByPage(page).getParam();

		List<BrandDTO> brands = brandService.getAllBrand();
		model.addAttribute("brands", brands);
		model.addAttribute("scanHistory", scanHistory);

		return "wechat/index";
	}

	@RequestMapping(value = "/test")
	public String test(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "wechat/test";
	}

	// 返利流程
	@RequestMapping(value = "/help")
	public String help(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "wechat/help";
	}

	// 查询品牌详情
	@RequestMapping(value = "/brandDetail")
	public String brandDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
		String brandId = request.getParameter("brandId");
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String time = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		// 保存浏览记录
		BrandScan param = new BrandScan();
		param.setBrandId(brandId);
		param.setGetMoreId(loginUser.getGetMoreId());
		param.setTime(time);
		BrandScanDTO history = scanService.getScanByParam(param);
		param.setSeeDate(new Date());
		// 保存今天的浏览记录
		if (history == null) {
			scanService.saveScan(param);
			// 更新品牌的浏览记录次数
			BrandDTO brandDTO = brandService.getBrandById(brandId);
			if (brandDTO != null) {
				Brand brand = new Brand();
				brand.setBrandId(brandId);
				brand.setScanNum(brandDTO.getScanNum() + 1);
				brandService.updateBrand(brand);
			}
		} else {
			param.setBrandScanId(history.getBrandScanId());
			scanService.updateScan(param);
		}
		BrandDTO brand = brandService.getBrandById(brandId);

		// 查询近四次的浏览记录
		BrandScan scan = new BrandScan();
		scan.setGetMoreId(loginUser.getGetMoreId());
		PageDTO<BrandScan> page = new PageDTO<BrandScan>();
		page.setPageIndex(1);
		page.setPageSize(4);
		page.setParam(scan);

		List<BrandScanDTO> scanHistory = scanService.getScanByPage(page).getParam();

		model.addAttribute("brand", brand);
		model.addAttribute("scanHistory", scanHistory);
		return "wechat/brand";
	}

	// 摇一摇
	@RequestMapping(value = "/shake")
	public String shake(HttpServletRequest request, HttpServletResponse response, Model model) {

		return "wechat/shake";
	}

	@RequestMapping(value = "/nearStore")
	public String getNearStore(HttpServletRequest request, HttpServletResponse response, Model model) {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);

		String lng = request.getParameter("lng");// 维度
		String lat = request.getParameter("lat");// 经度
		Store store = new Store();
		if (lng == null) {
			return null;
		}
		float lng1 = Float.parseFloat(lng);
		float lat1 = Float.parseFloat(lat);
		store.setLng(lng1);
		store.setLat(lat1);
		List<StoreDTO> nearStore = storeService.getNearStore(store);// 获得前50最近的店铺排序
		List<StoreDTO> result = null;
		for (int i = 0; i < nearStore.size(); i++) {// 获取3000米以内的数据
			float lng2 = nearStore.get(i).getLng();
			float lat2 = nearStore.get(i).getLat();
			double distance = MapUtil.getDistance(lng1, lat1, lng2, lat2);
			nearStore.get(i).setDistance((double) Math.round(distance));
			if (distance >= 1000 && i > 4) {
				result = nearStore.subList(0, i); // 返回小于3000米的
				break;
			}
		}
		// 获取近期的浏览记录
		BrandScan scan = new BrandScan();
		scan.setGetMoreId(loginUser.getGetMoreId());
		PageDTO<BrandScan> page = new PageDTO<BrandScan>();
		page.setPageIndex(1);
		page.setPageSize(4);
		page.setParam(scan);
		List<BrandScanDTO> history = scanService.getScanByPage(page).getParam();

		if (history != null) {
			for (int i = history.size() - 1; i >= 0; i--) {
				BrandDTO temp = history.get(i).getBrand();// 获取第一个，如果有，则提上前
				for (int inner = 0; inner < result.size(); inner++) {
					String brandId = null;
					if (result.get(inner).getBrand() != null) {
						brandId = result.get(inner).getBrand().getBrandId();
					}
					if (brandId != null && brandId.equals(temp.getBrandId())) {
						StoreDTO frontdata = result.get(inner);
						result.remove(inner);
						List<StoreDTO> newResult = new ArrayList<StoreDTO>();
						newResult.add(frontdata);
						newResult.addAll(result);
						result = newResult;
						break;
					}
				}
			}
		}

		JsonObject jsonObject = new JsonObject();
		jsonObject.setStatus("no");
		if (result != null) {
			jsonObject.setStatus("ok");
			jsonObject.setData(result);
		}
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}

	@RequestMapping(value = "/addrequirement")
	public String addrequirement(HttpServletRequest request, HttpServletResponse response, Model model) {
		// 功能区域和品类由JS控制
		// 获取所有的样式
		List<FurnitureStyleDTO> styleList = furnitureStyleService.getAllStyle();
		// 获取所有预算
		List<FurnitureBudgetDTO> budgetList = furnitureBudgetService.getAllBudget();
		model.addAttribute("styles", styleList);
		model.addAttribute("budgets", budgetList);
		return "wechat/addrequirement";
	}

	// 进行添加需求操作
	@RequestMapping(value = "/doAddRequire")
	public String doAddRequire(HttpServletRequest request, HttpServletResponse response, Model model) {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String zoneId = request.getParameter("zones");
		String types = request.getParameter("types");
		String styles = request.getParameter("styles");
		String budget = request.getParameter("budget");
		String description = request.getParameter("description");
		FurnitureRequired required = new FurnitureRequired();
		required.setZoneId(zoneId);
		required.setTypeIds(types);
		required.setStyleIds(styles);
		required.setBudgetId(budget);
		required.setDescription(description);
		required.setGetMoreId(loginUser.getGetMoreId());
		required.setStatus("1");
		required.setCreateDate(new Date());
		furnitureRequiredService.saveRequired(required);
		JsonObject jsonObject = new JsonObject();
		jsonObject.setStatus("ok");
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}

	// 进行添加删除操作
	@RequestMapping(value = "/doDelRequire")
	public String doDelRequire(HttpServletRequest request, HttpServletResponse response, Model model) {

		String requiredId = request.getParameter("requiredId");
		FurnitureRequired required = new FurnitureRequired();
		required.setRequiredId(requiredId);
		required.setStatus("0");
		furnitureRequiredService.updateRequired(required);
		JsonObject jsonObject = new JsonObject();
		jsonObject.setStatus("ok");
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}

	// 进行添加需求询问操作
	@RequestMapping(value = "/doAddRequire2")
	public String doAddRequire2(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "wechat/addreq2";
	}

	@RequestMapping(value = "/myrequirement")
	public String myrequirement(HttpServletRequest request, HttpServletResponse response, Model model) {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);

		String pageIndex = request.getParameter("pageIndex");
		String pageSize = request.getParameter("pageSize");
		boolean initTag = false;
		if (pageIndex == null) {
			initTag = true;
			pageIndex = "1";
		}
		if (pageSize == null) {
			pageSize = "10";// 一页显示10条
		}
		PageDTO<FurnitureRequired> param = new PageDTO<FurnitureRequired>();
		FurnitureRequired required = new FurnitureRequired();
		required.setGetMoreId(loginUser.getGetMoreId());
		param.setParam(required);
		param.setPageIndex(Integer.parseInt(pageIndex));
		param.setPageSize(Integer.parseInt(pageSize));
		PageDTO<List<FurnitureRequiredDTO>> result = furnitureRequiredService.getRequiredByPageAndParam(param);
		if (initTag) {// 初始化页面
			model.addAttribute("page", result);
			return "wechat/myrequirement";
		} else {// ajax获取消息
			model.addAttribute("json", JSONUtil.object2json(result));
			return "json";
		}
	}

	@RequestMapping(value = "/myplan")
	public String myplan(HttpServletRequest request, HttpServletResponse response, Model model) {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);

		String pageIndex = request.getParameter("pageIndex");
		String pageSize = request.getParameter("pageSize");
		boolean initTag = false;
		if (pageIndex == null) {
			initTag = true;
			pageIndex = "1";
		}
		if (pageSize == null) {
			pageSize = "5";// 一页显示5条
		}
		PageDTO<FurnitureRequired> param = new PageDTO<FurnitureRequired>();
		FurnitureRequired required = new FurnitureRequired();
		required.setGetMoreId(loginUser.getGetMoreId());
		param.setParam(required);
		param.setPageIndex(Integer.parseInt(pageIndex));
		param.setPageSize(Integer.parseInt(pageSize));
		PageDTO<List<FurnitureRequiredDTO>> result = furnitureRequiredService.getRequiredByPageAndParam(param);
		if (initTag) {// 初始化页面
			model.addAttribute("page", result);
			return "wechat/myplan";
		} else {// ajax获取消息
			model.addAttribute("page", result);
			return "wechat/myplan_ajax";
		}
	}

	@RequestMapping(value = "/myplan2")
	public String myplan2(HttpServletRequest request, HttpServletResponse response, Model model) {
		String requiredId = request.getParameter("requiredId");
		List<RequiredAnswerDTO> result = requiredAnswerService.getAnswerByRequiredId(requiredId);
		for (RequiredAnswerDTO temp : result) {// 处理方案图
			String imgs = temp.getImgs();
			imgs = imgs.split(",")[0];
			temp.setImgs(imgs);
		}
		model.addAttribute("answers", result);
		return "wechat/myplan_1";
	}

	// 增加订单
	@RequestMapping(value = "/addorder")
	public String addOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		List<BrandDTO> allBrands = brandService.getAllBrand();
		model.addAttribute("brands", allBrands);
		return "wechat/addorder";
	}

	// 查询订单
	/**
	 * @RequestMapping(value = "/myOrders") public String
	 *                       myOrders(HttpServletRequest request,
	 *                       HttpServletResponse response, Model model) {
	 *                       GetMoreUserDTO loginUser = (GetMoreUserDTO)
	 *                       request.getSession().getAttribute(LOGIN_USER);
	 * 
	 *                       List<OrderDTO> allOrders =
	 *                       orderService.getOrderByGetMoreId(loginUser.
	 *                       getGetMoreId()); model.addAttribute("orders",
	 *                       allOrders); return "wechat/myorder_bak"; }
	 */

	// 查询订单
	@RequestMapping(value = "/myOrders")
	public String myOrders(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.NORMAL)) {// 如果不是普通用户,或是新用户
			try {
				request.setAttribute("role", Constant.NORMAL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);

		List<OrderDTO> allOrders = orderService.getOrderByGetMoreId(loginUser.getGetMoreId());
		model.addAttribute("orders", allOrders);
		return "wechat/myOrders";
	}

	// 删除订单
	@RequestMapping(value = "/doDelOrder.html")
	public String doDelOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		String orderId = request.getParameter("orderId");
		OrderDTO orderDTO = orderService.getOrderById(orderId);
		String status = orderDTO.getStatus();// 0-确定支付方式中，1-凯特猫审核中，2-品牌审核中，3-返利完成，4-删除,5-个人删除中
		JsonObject jsonObject = new JsonObject();
		if ("0".equals(status) || "1".equals(status) || "4".equals(status)) {
			jsonObject.setStatus("ok");
			Order order = new Order();
			order.setOrderId(orderId);
			order.setStatus("5");
			orderService.updateOrder(order);
		} else if ("2".equals(status) || "3".equals(status)) {
			jsonObject.setStatus("no");
			jsonObject.setMessage("后台审核中，暂不能删除");
		}
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}

	@RequestMapping(value = "/saveOrderByUrlImg")
	public String saveOrderByUrlImg(HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam(value = "orderImg") MultipartFile file) {
		JsonObject json = new JsonObject();

		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);

		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.NORMAL)) {// 如果不是普通用户,或是新用户
			return null;
		}

		String username = request.getParameter("username");
		String phone = request.getParameter("phone");
		String storeId = request.getParameter("storeId");
		String fare = request.getParameter("fare");
		String hasPay = request.getParameter("hasPay");
		String buyDate = request.getParameter("buyDate");// 购买时间

		Date buyTime = null;
		try {
			buyTime = new SimpleDateFormat("yyyy-MM-dd").parse(buyDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		File parent = new File(imgPath + "order/");
		if (!parent.exists()) {
			parent.mkdirs();
		}
		String filename = UuidUtils.getImgUUID();
		File target = new File(parent, filename);

		try {
			ImgUtil.compressPic(file.getInputStream(), target.getPath());
		} catch (IOException e) {
			e.printStackTrace();
		}
		Order order = new Order();
		order.setCreateDate(new Date());

		order.setBuyDate(buyTime);// 初始化购买时间

		order.setGetMoreId(loginUser.getGetMoreId());
		order.setOrderImg("/imgStore/order/" + filename);
		order.setPhone(phone);
		order.setFare(fare);
		order.setHasPay(hasPay);
		order.setUsername(username);
		order.setStoreId(storeId);
		order.setStatus("1");// 直接凯特猫审核

		orderService.saveOrder(order);
		json.setStatus("1");// 提交成功
		json.setData(order);
		model.addAttribute("json", JSONUtil.object2json(json));

		return "json";
	}

	@RequestMapping(value = "/getWechatImg")
	public String getWechatImg(HttpServletRequest request, HttpServletResponse response, Model model) {
		String tempId = request.getParameter("tempId");
		File parent = new File(imgPath + "order/");
		if (!parent.exists()) {
			parent.mkdirs();
		}
		String filename = UuidUtils.getImgUUID();
		File target = new File(parent, filename);

		InputStream imgIn = openIdUtil.getFile(token, tempId);
		ImgUtil.compressPic(imgIn, target.getPath());
		String src = "/imgStore/order/" + filename;
		JsonObject json = new JsonObject();
		json.setData(src);
		json.setStatus("1");
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}

	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/saveOrder")
	public String saveOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		JsonObject json = new JsonObject();

		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);

		String username = request.getParameter("username");
		String phone = request.getParameter("phone");
		String storeId = request.getParameter("storeId");
		String fare = request.getParameter("fare");
		String hasPay = request.getParameter("hasPay");
		String buyDate = request.getParameter("buyDate");// 购买时间
		String wechatImgId = request.getParameter("wechatImgId");// wechatImageId

		String backType = request.getParameter("backType");// 返利方式
		Date buyTime = null;
		try {
			buyTime = new SimpleDateFormat("yyyy-MM-dd").parse(buyDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		// 对比注册时间
		Date userCreate = loginUser.getCreateDate();
		// 重置为第二天天凌晨
		userCreate.setDate(userCreate.getDate() + 1);
		userCreate.setHours(0);
		userCreate.setMinutes(0);
		userCreate.setSeconds(0);
		logger.info("时间比较######:" + userCreate + ">" + buyTime);

		if (userCreate.getTime() > buyTime.getTime() && false) {// 小于注册时间，则返回一个
			json.setStatus("0");//
			json.setMessage("必须在关注凯特猫第二天后,才能返利");
			model.addAttribute("json", JSONUtil.object2json(json));
			return "json";
		}

		File parent = new File(imgPath + "order/");
		if (!parent.exists()) {
			parent.mkdirs();
		}
		String filename = UuidUtils.getImgUUID();
		File target = new File(parent, filename);

		InputStream imgIn = openIdUtil.getFile(token, wechatImgId);
		ImgUtil.compressPic(imgIn, target.getPath());
		// ImgUtil.compressPic(file.getInputStream(), target.getPath());
		Order order = new Order();
		order.setCreateDate(new Date());

		order.setBuyDate(buyTime);// 初始化购买时间

		order.setGetMoreId(loginUser.getGetMoreId());
		order.setOrderImg("/imgStore/order/" + filename);
		order.setPhone(phone);
		order.setFare(fare);
		order.setHasPay(hasPay);
		order.setUsername(username);
		order.setStoreId(storeId);
		if (backType != null && backType.matches("[01]")) {
			order.setBackType(backType);
			order.setStatus("1");// 直接凯特猫审核
		} else {
			order.setStatus("0");// 确认支付方式中
		}

		orderService.saveOrder(order);
		json.setStatus("1");// 提交成功
		json.setData(order);
		model.addAttribute("json", JSONUtil.object2json(json));

		return "json";
	}

	// 确认支付方式
	@RequestMapping(value = "/saveOrder2")
	public String saveOrder2(HttpServletRequest request, HttpServletResponse response, Model model) {
		String orderId = request.getParameter("orderId");
		OrderDTO temp = orderService.getOrderById(orderId);
		model.addAttribute("order", temp);
		return "wechat/addorder2";
	}

	// 确认银行卡信息
	@RequestMapping(value = "/saveOrder3")
	public String saveOrder3(HttpServletRequest request, HttpServletResponse response, Model model) {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);

		String orderId = request.getParameter("orderId");
		String backType = request.getParameter("backType");
		UserCardDTO card = userCardService.getCardByGetMoreId(loginUser.getGetMoreId());
		Order order = new Order();
		order.setOrderId(orderId);
		order.setBackType(backType);
		order.setStatus("1");// 支付方式确认完毕，交给凯特猫审核
		orderService.updateOrder(order);

		// return "wechat/addorder3";
		if ("0".equals(backType)) {// 微信支付，直接显示结果
			return "wechat/addorder4";
		} else {// 确认银行信息
			model.addAttribute("card", card);
			return "wechat/addorder3";
		}

	}

	// 管理我的银行卡号
	@RequestMapping(value = "/userCard")
	public String userCard(HttpServletRequest request, HttpServletResponse response, Model model)
			throws UnsupportedEncodingException {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		UserCardDTO card = userCardService.getCardByGetMoreId(loginUser.getGetMoreId());
		model.addAttribute("card", card);
		return "wechat/userCard";
	}

	// 确认银行卡信息
	@RequestMapping(value = "/saveCard")
	public String saveCard(HttpServletRequest request, HttpServletResponse response, Model model)
			throws UnsupportedEncodingException {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String tag = request.getParameter("tag");
		String userCardId = request.getParameter("userCardId");
		String bankName = request.getParameter("bankName");
		if (bankName != null) {
			bankName = URLDecoder.decode(bankName, "utf-8");
		}
		String bankAddress = request.getParameter("bankAddress");
		if (bankAddress != null) {
			bankAddress = URLDecoder.decode(bankAddress, "utf-8");
		}
		String cardNum = request.getParameter("cardNum");
		if (cardNum != null) {
			cardNum = URLDecoder.decode(cardNum, "utf-8");
		}
		String cardUsername = request.getParameter("cardUsername");
		if (cardUsername != null) {
			cardUsername = URLDecoder.decode(cardUsername, "utf-8");
		}

		UserCard userCard = new UserCard();
		userCard.setAccountAddr(bankAddress);
		userCard.setBankName(bankName);
		userCard.setGetMoreId(loginUser.getGetMoreId());

		userCard.setCardNo(cardNum);
		userCard.setUsername(cardUsername);
		if (userCardId != null) {// 更新
			userCard.setUserCardId(userCardId);
			if (bankName != null || bankAddress != null || cardNum != null || cardUsername != null) {
				userCardService.updateCard(userCard);
			}
		} else {// 保存
			userCard.setStatu("1");
			userCardService.saveCard(userCard);
		}
		if (tag != null) {// 如果是卡号维护
			UserCardDTO card = userCardService.getCardByGetMoreId(loginUser.getGetMoreId());
			model.addAttribute("card", card);
			return "wechat/userCard";
		}
		return "wechat/addorder4";
	}

	// 根据品牌获取店铺
	@RequestMapping(value = "/getStoreByBrand")
	public String getStoreByBrand(HttpServletRequest request, HttpServletResponse response, Model model) {
		String brandId = request.getParameter("brandId");
		List<StoreDTO> stores = storeService.getStoreByBrandId(brandId);
		model.addAttribute("json", JSONUtil.object2json(stores));
		return "json";
	}

	// 获得家具的所有功能区域，与家具品类
	@RequestMapping(value = "/allZoneAndType")
	public String allZoneAndType(HttpServletRequest request, HttpServletResponse response, Model model) {
		String param = request.getParameter("param");
		// 查询所有的功能区域
		List<FurnitureZoneDTO> zoneList = furnitureZoneService.getAllZone();
		List<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
		for (FurnitureZoneDTO zone : zoneList) {
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("zoneName", zone.getZoneName());
			result.put("zoneId", zone.getZoneId());
			result.put("types", furnitureTypeService.getTypeByZone(zone.getZoneId()));
			jsonList.add(result);
		}
		model.addAttribute("json", JSONUtil.object2json(jsonList));
		model.addAttribute("name", param);
		return "wechat/allZoneAndType";
	}

	// 个人中心跳转
	@RequestMapping(value = "/center")
	public String center(HttpServletRequest request, HttpServletResponse response, Model model) {
		// 新注册用户
		String channelCode = request.getParameter("channelCode");// 渠道编码
		if (channelCode != null) {
			ThirdChannel param = new ThirdChannel();
			param.setCode(channelCode);
			int count = channelService.getCountByParam(param);
			if (count != 0) {
				model.addAttribute("channelCode", channelCode);
			} else {
				channelCode = null;
			}
		}
		if (Constant.NORMAL.equals(request.getSession().getAttribute(Constant.ROLE))) {
			try {
				if (channelCode != null) {
					GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
					if (loginUser.getCode() != null) {
						if (loginUser.getCode().equals(channelCode)) {
							request.setAttribute("tips", "您已经绑定过该推荐码了，无需重复操作");
						} else {
							request.setAttribute("tips", "您已经绑定过推荐码了，不能更换推荐码");
						}
						request.getRequestDispatcher("noaccess.html").forward(request, response);
					} else {
						// 绑定渠道商
						if (channelCode != null) {
							/**
							 * GetMoreUser user = new GetMoreUser();
							 * user.setCode(channelCode);
							 * user.setGetMoreId(loginUser.getGetMoreId());
							 * getMoreUserService.updateGetMoreUser(user);
							 * loginUser =
							 * getMoreUserService.getUserById(loginUser.
							 * getGetMoreId());
							 * request.getSession().setAttribute(LOGIN_USER,
							 * loginUser); request.setAttribute("tips",
							 * "绑定成功！");
							 */
							ThirdChannelDTO thirdChannelDTO = channelService.getByCode(channelCode);
							// 跳转确认页面
							request.setAttribute("channel", thirdChannelDTO);
							request.getRequestDispatcher("codeConfirm.html").forward(request, response);
						}
					}
				} else {
					request.getRequestDispatcher("toNormal.html").forward(request, response);
				}
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}

		if (Constant.GUIDE.equals(request.getSession().getAttribute(Constant.ROLE))) {
			try {
				if (channelCode != null) {
					request.setAttribute("tips", "您已是导购，没有绑定权限");
					request.getRequestDispatcher("noaccess.html").forward(request, response);
				} else {
					request.getRequestDispatcher("toGuide.html").forward(request, response);
				}
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}

		if (Constant.CHANNEL.equals(request.getSession().getAttribute(Constant.ROLE))) {
			try {
				if (channelCode != null) {
					request.setAttribute("tips", "您已是渠道商，没有绑定权限");
					request.getRequestDispatcher("noaccess.html").forward(request, response);
				} else {
					request.getRequestDispatcher("toChannel.html").forward(request, response);
				}
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}

		return "wechat/center";
	}

	// 普通个人中心
	@RequestMapping(value = "/toNormal")
	public String toNormal(HttpServletRequest request, HttpServletResponse response, Model model) {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role != null && !role.equals(Constant.NORMAL)) {// 如果不是普通用户
			try {
				request.setAttribute("role", Constant.NORMAL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}

		ThirdNormal normal = normalService.getByGetMoreId(loginUser.getGetMoreId());
		if (normal == null) {
			normal = new ThirdNormal();
			normal.setGetMoreId(loginUser.getGetMoreId());
			normalService.save(normal);
			request.getSession().setAttribute(Constant.ROLE, Constant.NORMAL);
		}
		// 绑定渠道商
		String channelCode = request.getParameter("channelCode");// 渠道编码
		if (channelCode != null) {
			ThirdChannel param = new ThirdChannel();
			param.setCode(channelCode);
			int count = channelService.getCountByParam(param);
			if (count > 0) {
				GetMoreUser user = new GetMoreUser();
				user.setCode(channelCode);
				user.setGetMoreId(loginUser.getGetMoreId());
				getMoreUserService.updateGetMoreUser(user);
				loginUser = getMoreUserService.getUserById(loginUser.getGetMoreId());
				request.getSession().setAttribute(LOGIN_USER, loginUser);

				request.setAttribute("tips", "绑定成功！");
				try {
					request.getRequestDispatcher("noaccess.html").forward(request, response);
				} catch (ServletException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				return null;
			}
		}

		model.addAttribute("user", loginUser);
		// 订单总数
		List<OrderDTO> allOrders = orderService.getOrderByGetMoreId(loginUser.getGetMoreId());
		model.addAttribute("orderCount", allOrders == null ? 0 : allOrders.size());
		List<OrderDTO> myOrders = orderService.getOrderByGetMoreId(loginUser.getGetMoreId());
		float totalPay = 0f;
		for (OrderDTO order : myOrders) {
			if ("3".equals(order.getStatus())) {
				float rate = order.getBrand().getRate();
				float hasPay = order.getHasPay();
				totalPay += rate * hasPay;
			}
		}
		model.addAttribute("totalPay", totalPay);

		// 咨询数目
		model.addAttribute("questionNum", thirdGuideService.getQuestionCountByGetMoreId(loginUser.getGetMoreId()));
		model.addAttribute("uncheckQuestionNum",
				thirdGuideService.getUncheckQuestionCountByGetMoreId(loginUser.getGetMoreId()));

		// 我的导购
		List<ThirdGuideDTO> guides = thirdGuideService.getGuideByUserId(loginUser.getGetMoreId());
		if (guides == null) {
			model.addAttribute("guides", 0);
		} else {
			model.addAttribute("guides", guides.size());
		}

		// 我的银行帐号
		List<UserCardDTO> cards = userCardService.getListByGetMoreId(loginUser.getGetMoreId());
		if (guides == null) {
			model.addAttribute("cards", 0);
		} else {
			model.addAttribute("cards", cards.size());
		}
		return "wechat/normal";
	}

	// 跳转提交订单
	@RequestMapping(value = "/toOrder")
	public String toOrder(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.NORMAL)) {// 如果不是普通用户,或是新用户
			try {
				request.setAttribute("role", Constant.NORMAL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}

		List<BrandDTO> allBrands = brandService.getAllBrand();
		model.addAttribute("brands", allBrands);
		return "wechat/toOrder";
	}

	// 渠道商个人中心
	@RequestMapping(value = "/channel")
	public String channel(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.CHANNEL)) {// 如果不是渠道用户
			try {
				request.setAttribute("role", Constant.CHANNEL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		ThirdChannelDTO channelDTO = channelService.getByGetMoreId(loginUser.getGetMoreId());
		model.addAttribute("channel", channelDTO);
		// 查询推荐的总人数
		GetMoreUser param = new GetMoreUser();
		param.setCode(channelDTO.getCode());
		List<UserCardDTO> cards = userCardService.getListByGetMoreId(loginUser.getGetMoreId());

		model.addAttribute("accounts", cards.size());
		model.addAttribute("count", channelService.getFriendCount(channelDTO.getId()));
		model.addAttribute("user", loginUser);
		model.addAttribute("peoples", getMoreUserService.getCountByParam(param));
		model.addAttribute("total", orderChannelService.getCount(channelDTO.getId()));
		return "wechat/channel";
	}

	// 渠道商佣金记录个人中心
	@RequestMapping(value = "/channelHistory")
	public String channelHistory(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		Integer status = (Integer) request.getSession().getAttribute(Constant.STATUS);
		if (role == null || !role.equals(Constant.CHANNEL)) {// 如果不是渠道用户
			try {
				request.setAttribute("role", Constant.CHANNEL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		} else if (status != 1) {
			try {
				request.getRequestDispatcher("verifying.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
				return null;
			}
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		ThirdChannelDTO channelDTO = channelService.getByGetMoreId(loginUser.getGetMoreId());
		PageDTO<Order> page = new PageDTO<Order>();
		page.setPageIndex(1);
		page.setPageSize(100);// 前100条
		Order param = new Order();
		page.setParam(param);
		PageDTO<List<OrderDTO>> result = orderChannelService.getOrderByChannelIdAndPageForRead(page,
				channelDTO.getId());
		model.addAttribute("pageResult", result);
		model.addAttribute("channel", channelDTO);
		model.addAttribute("user", loginUser);
		return "wechat/channelHistory";
	}

	// 保存图片，并生成路径
	private String saveImg(MultipartFile img, String root) {
		String temp = UuidUtils.getImgUUID();
		String introImgPath = imgPath + "/" + root + "/" + temp;

		File parent = new File(imgPath + "/" + root);
		if (!parent.exists()) {
			parent.mkdirs();
		}
		try {
			ImgUtil.compressPic(img.getInputStream(), introImgPath);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		return "/imgStore/" + root + "/" + temp;

	}

	// 更换个人头像
	@RequestMapping(value = "/headImgInfo")
	public String headImgInfo(HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam(value = "headImg") MultipartFile headImg) {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		JsonObject json = new JsonObject();
		// 单独更新头像
		String temp = UuidUtils.getImgUUID();
		String introImgPath = imgPath + "/headImg/" + temp;

		File parent = new File(imgPath + "/headImg");
		if (!parent.exists()) {
			parent.mkdirs();
		}

		try {
			ImgUtil.compressPic(headImg.getInputStream(), introImgPath, 100);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		introImgPath = "/imgStore/headImg/" + temp;
		GetMoreUser user = new GetMoreUser();
		user.setGetMoreId(loginUser.getGetMoreId());
		user.setPhoto(introImgPath);
		// 刷新session
		try {
			getMoreUserService.updateGetMoreUser(user);
			json.setStatus("1").setMessage("更新头像成功");
			loginUser = getMoreUserService.getUserById(loginUser.getGetMoreId());
			request.getSession().setAttribute(LOGIN_USER, loginUser);
		} catch (Exception e) {
			e.printStackTrace();
			json.setStatus("0").setMessage("更新头像失败");
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}

	// 普通用户个人信息
	@RequestMapping(value = "/myInfo")
	public String myInfo(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.NORMAL)) {// 如果不是普通用户,或是新用户
			try {
				request.setAttribute("role", Constant.NORMAL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}

		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		loginUser = getMoreUserService.getUserById(loginUser.getGetMoreId());
		model.addAttribute("user", loginUser);
		WechatUser user = wechatUserService.getWechatUserByGetMoreId(loginUser.getGetMoreId());
		model.addAttribute("weuser", user);
		return "wechat/myInfo";
	}

	// 渠道商个人信息
	@RequestMapping(value = "/channelInfo")
	public String channelInfo(HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam(value = "introImg", required = false) MultipartFile introImg) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.CHANNEL)) {// 如果不是渠道用户
			try {
				request.setAttribute("role", Constant.CHANNEL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		// 信息展示
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		ThirdChannelDTO channelDTO = channelService.getByGetMoreId(loginUser.getGetMoreId());
		String operator = request.getParameter("operator");
		if ("update".equals(operator)) {// 如果是修改
			JsonObject json = new JsonObject();
			String phone = request.getParameter("phone");
			String company = request.getParameter("company");
			String job = request.getParameter("job");

			ThirdChannel channel = new ThirdChannel();
			channel.setId(channelDTO.getId());
			// 基本信息更新
			if (phone != null) {
				channel.setPhone(phone);
				json.setMessage("更新号码成功！");
			}
			// 职业信息更新，需要重新审核
			if (company != null && company.matches("\\d+")) {
				channel.setParentId(Integer.parseInt(company));
				json.setMessage("公司信息更新成功");
			}
			if (job != null) {
				channel.setJob(job);
				json.setMessage("职业信息更新成功");
			}
			if (introImg != null) {
				String path = saveImg(introImg, "channel");
				channel.setIntroImg(path);
				json.setMessage("名片信息更新成功");
			}
			if (company != null || job != null || introImg != null) {
				channel.setStatus(0);// 重置为审核中！
			}

			try {
				channelService.update(channel);
				json.setStatus("1");
			} catch (Exception e) {
				e.printStackTrace();
				json.setStatus("0").setMessage("更新失败，请稍后再试");
			}
			model.addAttribute("json", JSONUtil.object2json(json));
			return "json";
		}
		// 查出所有的公司
		ThirdChannel company = new ThirdChannel();
		company.setIsCompany(1);
		company.setStatus(1);// 申请通过的
		List<ThirdChannelDTO> companys = channelService.getList(company);
		model.addAttribute("companys", companys);

		model.addAttribute("user", loginUser);
		model.addAttribute("channel", channelDTO);
		return "wechat/channelInfo";
	}

	// 渠道商账户
	@RequestMapping(value = "/channelAccount")
	public String channelAccount(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || (!role.equals(Constant.NORMAL) && !role.equals(Constant.CHANNEL))) {// 如果不是普通用户,或是新用户
			try {
				request.setAttribute("role", Constant.CHANNEL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}

		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		List<UserCardDTO> cards = userCardService.getListByGetMoreId(loginUser.getGetMoreId());

		model.addAttribute("cards", cards);
		model.addAttribute("wechat", wechatUserService.getWechatUserByGetMoreId(loginUser.getGetMoreId()));
		return "wechat/channelAccount";
	}

	// 渠道商账户增加
	@RequestMapping(value = "/channelCard")
	public String channelCard(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || (!role.equals(Constant.NORMAL) && !role.equals(Constant.CHANNEL))) {// 如果不是普通用户,或是新用户
			try {
				request.getRequestDispatcher("center.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}

		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String operator = request.getParameter("operator");
		String bankName = request.getParameter("bankName");
		String cardNo = request.getParameter("cardNo");

		String status = request.getParameter("status");
		String userCardId = request.getParameter("userCardId");

		JsonObject json = new JsonObject();
		if ("save".equals(operator) && bankName != null && cardNo != null && cardNo.matches("\\d+")) {
			UserCard newCard = new UserCard();
			newCard.setBankName(bankName);
			newCard.setCardNo(cardNo);
			newCard.setStatu("1");// 新建默认为选中
			newCard.setGetMoreId(loginUser.getGetMoreId());
			try {
				userCardService.saveCard(newCard);
				json.setMessage("操作成功！").setStatus("1");
			} catch (Exception e) {
				e.printStackTrace();
				json.setMessage("操作失败" + e.getMessage()).setStatus("0");
			}
		} else if ("update".equals(operator) && userCardId != null) {
			UserCard card = new UserCard();
			card.setUserCardId(userCardId);
			card.setGetMoreId(loginUser.getGetMoreId());
			card.setStatu(status);
			try {
				userCardService.updateCard(card);
				json.setMessage("操作成功！").setStatus("1");
			} catch (Exception e) {
				e.printStackTrace();
				json.setMessage("操作失败" + e.getMessage()).setStatus("0");
			}
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}

	// 渠道商推荐好友
	@RequestMapping(value = "/channelFriend")
	public String channelFriend(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		Integer status = (Integer) request.getSession().getAttribute(Constant.STATUS);
		if (role == null || !role.equals(Constant.CHANNEL)) {// 如果不是渠道用户
			try {
				request.setAttribute("role", Constant.CHANNEL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		} else if (status != 1) {
			try {
				request.getRequestDispatcher("verifying.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
				return null;
			}
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		ThirdChannelDTO channelDTO = channelService.getByGetMoreId(loginUser.getGetMoreId());
		// 微信好友
		List<WechatUser> weList = channelService.getFriendByChannelId(channelDTO.getId());

		model.addAttribute("weList", weList);
		model.addAttribute("channel", channelDTO);
		model.addAttribute("wechat", wechatUserService.getWechatUserByGetMoreId(loginUser.getGetMoreId()));
		return "wechat/channelFriend";
	}

	// 渠道商推广
	@RequestMapping(value = "/channelBroad")
	public String channelBroad(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		Integer status = (Integer) request.getSession().getAttribute(Constant.STATUS);
		if (role == null || !role.equals(Constant.CHANNEL)) {// 如果不是渠道用户
			try {
				request.setAttribute("role", Constant.CHANNEL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		} else if (status != 1) {
			try {
				request.getRequestDispatcher("verifying.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
				return null;
			}
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		ThirdChannelDTO channelDTO = channelService.getByGetMoreId(loginUser.getGetMoreId());
		// 生成二维码
		model.addAttribute("channel", channelDTO);
		model.addAttribute("user", loginUser);
		return "wechat/channelBroad";
	}

	// 渠道商推广
	@RequestMapping(value = "/getCode")
	public void getCode(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.CHANNEL)) {// 如果不是渠道用户
			try {
				request.setAttribute("role", Constant.CHANNEL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return;
		}
		String code = request.getParameter("code");
		String host = request.getRequestURL().toString();
		while (host.lastIndexOf("/") > 6) {
			host = host.substring(0, host.lastIndexOf("/"));
		}
		String text = host + "/" + request.getContextPath() + "/wechat/center.html?channelCode=" + code;
		int width = 300;
		int height = 300;
		Hashtable<EncodeHintType, String> hints = new Hashtable<EncodeHintType, String>();
		// 内容所使用编码
		hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
		BitMatrix bitMatrix = null;
		try {
			bitMatrix = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, width, height, hints);
		} catch (WriterException e1) {
			e1.printStackTrace();
		}
		// 生成二维码
		BufferedImage buffImg = MatrixToImageWriter.toBufferedImage(bitMatrix);
		// 禁止图像缓存。
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("image/gif");// 将图像输出到Servlet输出流中。
		ServletOutputStream sos = null;
		try {
			sos = response.getOutputStream();
			ImageIO.write(buffImg, "jpeg", sos);
			sos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 导购信息页面
	@RequestMapping(value = "/guide")
	public String guide(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.GUIDE)) {// 不是导购
			try {
				request.setAttribute("role", Constant.GUIDE);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		model.addAttribute("user", loginUser);
		// 导购
		ThirdGuideDTO guide = thirdGuideService.getByGetMoreId(loginUser.getGetMoreId());
		// 导购数目
		model.addAttribute("talkNum", thirdGuideService.getTalkCountByGetMoreId(loginUser.getGetMoreId()));
		model.addAttribute("unChecktalkNum",
				thirdGuideService.getUncheckTalkCountByGetMoreId(loginUser.getGetMoreId()));

		// 客户数目
		model.addAttribute("customNum", thirdGuideService.getCustomCountByGuideId(guide.getGuideId()));
		model.addAttribute("guide", guide);
		return "wechat/guide";
	}

	// 导购详细信息页面
	@RequestMapping(value = "/guideInfo")
	public String guideInfo(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);

		if (role == null || !role.equals(Constant.GUIDE)) {// 不是导购
			try {
				request.setAttribute("role", Constant.GUIDE);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		ThirdGuideDTO guide = thirdGuideService.getByGetMoreId(loginUser.getGetMoreId());
		model.addAttribute("user", loginUser);
		model.addAttribute("guide", guide);

		model.addAttribute("brands", brandService.getAllBrand());
		model.addAttribute("stores", storeService.getStoreByBrandId(guide.getBrand().getBrandId()));
		return "wechat/guideInfo";
	}

	@RequestMapping(value = "/customerUpdate")
	public String customerUpdate(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.NORMAL)) {// 如果不是普通用户,或是新用户
			return null;
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String cphone = request.getParameter("cphone");
		String ccode = request.getParameter("ccode");
		JsonObject json = new JsonObject();
		GetMoreUser param = new GetMoreUser();
		String message = null;
		if (cphone != null) {
			param.setPhone(cphone);
			message = "号码更换成功！";
		} else if (ccode != null) {
			ThirdChannel channelParam = new ThirdChannel();
			channelParam.setCode(ccode);
			int count = channelService.getCountByParam(channelParam);
			if (count == 0) {
				message = "该推荐码不存在！";
				json.setStatus("0").setMessage(message);
				model.addAttribute("json", JSONUtil.object2json(json));
				return "json";
			} else {
				param.setCode(ccode);
				message = "绑定推荐码成功！";
			}
		}

		param.setGetMoreId(loginUser.getGetMoreId());
		try {
			getMoreUserService.updateGetMoreUser(param);
			json.setStatus("1");
			json.setMessage(message);
		} catch (Exception e) {
			json.setStatus("0");
			json.setMessage("更新过程中失败");
			e.printStackTrace();
		}

		model.addAttribute("json", JSONUtil.object2json(json));

		return "json";
	}

	@RequestMapping(value = "/guideUpdate")
	public String guideUpdate(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.GUIDE)) {// 不是导购
			return null;
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String cphone = request.getParameter("cphone");
		String cshop = request.getParameter("cshop");
		String cposition = request.getParameter("cposition");
		ThirdGuideDTO guide = thirdGuideService.getByGetMoreId(loginUser.getGetMoreId());
		JsonObject json = new JsonObject();
		if (guide == null) {
			json.setStatus("0");
			json.setMessage("该导购不存在！");
		} else {
			ThirdGuide param = new ThirdGuide();
			param.setGuideId(guide.getGuideId());
			param.setPhone(cphone);
			param.setJob(cposition);
			param.setStoreId(cshop);
			param.setStatus(0);// 需要重新审核
			try {
				thirdGuideService.update(param);
				json.setStatus("1");
				json.setMessage("信息更新成功");
			} catch (Exception e) {
				json.setStatus("0");
				json.setMessage("更新过程中失败");
				e.printStackTrace();
			}

		}
		model.addAttribute("json", JSONUtil.object2json(json));

		return "json";
	}

	// 问题历史页面
	@RequestMapping(value = "/myQuestion")
	public String myQuestion(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.NORMAL)) {// 不是普通用户
			try {
				request.setAttribute("role", Constant.NORMAL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		List<ThirdGuideHistoryDTO> guideHistory = thirdGuideService.getHistoryGetMoreId(loginUser.getGetMoreId());

		model.addAttribute("guideHistory", guideHistory);
		return "wechat/myQuestion";
	}

	// 导购员历史页面
	@RequestMapping(value = "/guideHistory")
	public String guideTalkHistory(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		Integer status = (Integer) request.getSession().getAttribute(Constant.STATUS);
		if (role == null || !role.equals(Constant.GUIDE)) {// 不是导购
			try {
				request.setAttribute("role", Constant.GUIDE);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		} else if (status != 1) {
			try {
				request.getRequestDispatcher("verifying.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
				return null;
			}
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		ThirdGuideDTO guide = thirdGuideService.getByGetMoreId(loginUser.getGetMoreId());
		List<ThirdGuideHistoryDTO> guideHistory = thirdGuideService.getHistoryGuideId(guide.getGuideId());

		model.addAttribute("guideHistory", guideHistory);
		return "wechat/guideHistory";
	}

	// 导购员客户页面
	@RequestMapping(value = "/guideCustom")
	public String guideCustom(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		Integer status = (Integer) request.getSession().getAttribute(Constant.STATUS);
		if (role == null || !role.equals(Constant.GUIDE)) {// 不是导购
			try {
				request.setAttribute("role", Constant.GUIDE);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		} else if (status != 1) {
			try {
				request.getRequestDispatcher("verifying.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
				return null;
			}
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		model.addAttribute("wechat", wechatUserService.getWechatUserByGetMoreId(loginUser.getGetMoreId()));
		// 订单总数
		ThirdGuideDTO guide = thirdGuideService.getByGetMoreId(loginUser.getGetMoreId());
		List<ThirdGuideCustomDTO> guideCustom = thirdGuideService.getCustomByGuideId(guide.getGuideId());
		model.addAttribute("guide", guide);
		model.addAttribute("guideCustom", guideCustom);
		return "wechat/guideCustom";
	}

	// 获取用户信息c
	@RequestMapping(value = "/socketLogin")
	public String userinfo(HttpServletRequest request, HttpServletResponse response, Model model) {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		loginUser = getMoreUserService.getUserById(loginUser.getGetMoreId());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user", loginUser);
		map.put("role", role);
		String url = "http://" + request.getServerName();
		map.put("url", url + ":14080");

		String host = request.getRequestURL().toString();
		while (host.lastIndexOf("/") > 6) {
			host = host.substring(0, host.lastIndexOf("/"));
		}
		map.put("serverhost", host + request.getContextPath());
		String callback = request.getParameter("jsoncallback");
		if (callback != null) {
			model.addAttribute("json", callback + "(" + JSONUtil.object2json(map) + ")");
		} else {
			model.addAttribute("json", JSONUtil.object2json(map));
		}
		return "json";
	}

	// 我的导购
	@RequestMapping(value = "/myGuide")
	public String myGuide(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.NORMAL)) {// 如果不是普通用户,或是新用户
			try {
				request.setAttribute("role", Constant.NORMAL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}

		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		List<ThirdGuideDTO> guides = thirdGuideService.getGuideByUserId(loginUser.getGetMoreId());
		model.addAttribute("guides", guides);
		return "wechat/myGuide";
	}

	// 保存guide
	@RequestMapping(value = "/getSaveGuide")
	public synchronized String getSaveGuide(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.NORMAL)) {// 如果不是普通用户,或是新用户
			return null;
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String guideId = request.getParameter("guideId");// 导购员id
		JsonObject json = new JsonObject();
		if (guideId != null && guideId.matches("\\d+")) {
			ThirdGuideDTO guide = thirdGuideService.getById(Integer.parseInt(guideId));
			// 检测是否已添加该导购
			int count = thirdGuideService.check(loginUser.getGetMoreId(), Integer.parseInt(guideId));

			if (guide != null && count == 0) {
				// 检测该品牌下是否已经添加了导购员
				String brandId = guide.getBrand().getBrandId();
				int brandcheck = thirdGuideService.checkByBrandId(loginUser.getGetMoreId(), brandId);
				if (brandcheck > 0) {
					json.setStatus("0").setMessage("该品牌下已经有导购员了。");
				} else {
					try {
						thirdGuideService.userSetGuide(loginUser.getGetMoreId(), Integer.parseInt(guideId));
						json.setStatus("1").setMessage("添加导购成功！");
					} catch (Exception e) {
						e.printStackTrace();
						json.setStatus("0").setMessage("添加导购失败，请稍后再试！");
					}
				}
			} else {
				json.setStatus("0").setMessage("非法操作！");
			}
		} else {
			json.setStatus("0").setMessage("数据错误！");
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}

	@RequestMapping(value = "/getGuideByUserId")
	public String getGuideByUserId(HttpServletRequest request, HttpServletResponse response, Model model) {
		String userId = request.getParameter("userId");
		if (userId != null && userId.matches("\\d+")) {
			ThirdGuideDTO guide = thirdGuideService.getByGetMoreId(Integer.parseInt(userId));
			if (guide != null) {
				JsonObject json = new JsonObject();
				json.setData(guide.getGuideId());
				json.setStatus("1");
				model.addAttribute("json", JSONUtil.object2json(json));
			}
		}
		return "json";
	}

	// 跳转添加导购
	@RequestMapping(value = "/getGuide")
	public String getGuide(HttpServletRequest request, HttpServletResponse response, Model model) {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String role = (String) request.getSession().getAttribute(Constant.ROLE);

		if (role == null || !role.equals(Constant.NORMAL)) {// 如果不是普通用户,或是新用户
			try {
				request.setAttribute("role", Constant.NORMAL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}

		String guideId = request.getParameter("guideId");// 导购员id

		if (guideId != null && guideId.matches("\\d+")) {
			ThirdGuideDTO guide = thirdGuideService.getById(Integer.parseInt(guideId));
			model.addAttribute("guide", guide);
			// 检测是否已添加该导购
			int count = thirdGuideService.check(loginUser.getGetMoreId(), Integer.parseInt(guideId));
			model.addAttribute("count_", count);
			// 客户数目
			model.addAttribute("customNum", thirdGuideService.getCustomCountByGuideId(guide.getGuideId()));
			//

			model.addAttribute("user", getMoreUserService.getUserById(guide.getGetMoreUser().getGetMoreId()));
		}

		return "wechat/getGuide";
	}

	// 导购转单
	@RequestMapping(value = "/guideShop")
	public String guideShop(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.GUIDE)) {// 不是导购
			try {
				request.setAttribute("role", Constant.GUIDE);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		ThirdGuideDTO guide = thirdGuideService.getByGetMoreId(loginUser.getGetMoreId());
		JsonObject json = new JsonObject();
		String brandId = request.getParameter("brandId");
		if (brandId != null) {
			// 如果不是总导购，则返回店铺
			List<StoreDTO> stores = storeService.getStoreByBrandId(brandId);
			json.setStatus("1");
			json.setData(stores);

		} else if (guide != null && getMoreGuideId.equals(guide.getGuideId() + "")) {
			// 如果是总导购，则返回品牌
			Brand brand = new Brand();
			brand.setStatus("1");// 有效地
			List<BrandDTO> brands = brandService.getBrandList(brand);

			json.setStatus("2");
			json.setData(brands);

		} else if (guide != null) {
			// 如果不是总导购，则返回店铺
			List<StoreDTO> stores = storeService.getStoreByBrandId(guide.getBrand().getBrandId());
			json.setStatus("1");
			json.setData(stores);

		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}

	// 凯特猫导购
	private String getMoreGuideId = "1";

	private String chosenGuide(String brandName) {
		ThirdGuide guide = new ThirdGuide();
		guide.setBrandName(brandName);
		List<ThirdGuideDTO> guides = thirdGuideService.getList(guide);

		List<ThirdGuideDTO> onlines = new ArrayList<ThirdGuideDTO>();
		if (guides != null && guides.size() > 0) {

			for (ThirdGuideDTO temp : guides) {
				Integer getMoreId = temp.getGetMoreUser().getGetMoreId();
				// 优先选择在线的
				if (ServerSocket.isOnline(getMoreId)) {
					onlines.add(temp);
				}
			}

			if (onlines.size() > 0) {// 有在线的
				return onlines.get(new Random().nextInt(onlines.size())).getGuideId() + "";
			} else {
				return guides.get(new Random().nextInt(guides.size())).getGuideId() + "";
			}
		} else {
			return getMoreGuideId;
		}
	}

	// 客户对话页面
	@RequestMapping(value = "/customerChat")
	public String customerChat(HttpServletRequest request, HttpServletResponse response, Model model) {

		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role == null || !role.equals(Constant.NORMAL)) {// 如果不是普通用户,或是新用户
			try {
				request.setAttribute("role", Constant.NORMAL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}

		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String imgUrl = request.getParameter("imgUrl");// 图片标记
		if (imgUrl != null && !"".equals(imgUrl)) {
			model.addAttribute("imgUrl", imgUrl);
		}

		String backUrl = request.getParameter("backUrl");// 返回标记
		if (backUrl != null && !"".equals(backUrl)) {
			model.addAttribute("backUrl", backUrl);
		}

		// 两种情况，传导购id或者品牌
		String guideId = request.getParameter("guideId");// 导购员id
		String brandName = request.getParameter("brandName");
		if (brandName != null) {
			String tempId = chosenGuide(brandName);
			if (tempId != null) {
				guideId = tempId;
			}

		}

		if (guideId != null && guideId.matches("\\d+")) {// 初始化导购信息
			ThirdGuideDTO toguide = thirdGuideService.getById(Integer.parseInt(guideId));
			if (toguide == null) {
				return null;
			}

			model.addAttribute("toguide", toguide);
			GetMoreUserDTO user = getMoreUserService.getUserById(toguide.getGetMoreUser().getGetMoreId());
			model.addAttribute("toUser", user);
			// 检测是否已添加导购
			int count = thirdGuideService.check(loginUser.getGetMoreId(), Integer.parseInt(guideId));
			model.addAttribute("check", count);

			// 查询未接受的历史信息数据
			int pageIndex = 1;
			int pageSize = 5;
			GuideChatHistory param = new GuideChatHistory();
			param.setStatus(1);
			param.setToId(user.getGetMoreId());
			param.setFromId(loginUser.getGetMoreId());
			PageDTO<GuideChatHistory> page = new PageDTO<GuideChatHistory>();
			page.setPageSize(pageSize);
			page.setPageIndex(pageIndex);
			page.setParam(param);

			model.addAttribute("pageIndex", 1);
			model.addAttribute("pageSize", 5);
			model.addAttribute("totalPage", chatService.loadCountByParam(page));
		}

		// 生成微信凭证
		Date putDate = time.get("ticket_time");
		Long dual = new Date().getTime() - putDate.getTime();
		if (dual > 7200 * 900) {// 重置ticket
			initJsapiSign();
		}
		String queryString = request.getQueryString();

		String url = request.getRequestURL().toString();
		if (queryString != null) {
			url = url + "?" + queryString;
		}
		String sign = openIdUtil.getJsSign(nonceStr, timestamp, ticket, url);

		model.addAttribute("appId", appId);
		model.addAttribute("timestamp", timestamp);
		model.addAttribute("signature", sign);
		model.addAttribute("nonceStr", nonceStr);

		return "wechat/customerChat";
	}

	// 导购员对话页面
	@RequestMapping(value = "/guideChat")
	public String guideChat(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		Integer status = (Integer) request.getSession().getAttribute(Constant.STATUS);
		if (role == null || !role.equals(Constant.GUIDE)) {// 不是导购
			try {
				request.setAttribute("role", Constant.GUIDE);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		} else if (status != 1) {
			try {
				request.getRequestDispatcher("verifying.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
				return null;
			}
		}

		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);

		String toId = request.getParameter("toId");// 导购员给谁说话
		if (toId != null && toId.matches("\\d+")) {// 我是导购
			GetMoreUserDTO user = getMoreUserService.getUserById(Integer.parseInt(toId));
			ThirdGuideDTO guide = thirdGuideService.getByGetMoreId(loginUser.getGetMoreId());
			model.addAttribute("toUser", user);
			model.addAttribute("guide", guide);
			// 查询未接受的历史信息数据
			int pageIndex = 1;
			int pageSize = 5;
			GuideChatHistory param = new GuideChatHistory();
			param.setStatus(1);
			param.setToId(Integer.parseInt(toId));
			param.setFromId(loginUser.getGetMoreId());
			PageDTO<GuideChatHistory> page = new PageDTO<GuideChatHistory>();
			page.setPageSize(pageSize);
			page.setPageIndex(pageIndex);
			page.setParam(param);

			model.addAttribute("pageIndex", 1);
			model.addAttribute("pageSize", 5);
			model.addAttribute("totalPage", chatService.loadCountByParam(page));
		}

		// 生成微信凭证
		Date putDate = time.get("ticket_time");
		Long dual = new Date().getTime() - putDate.getTime();
		if (dual > 7200 * 900) {// 重置ticket
			initJsapiSign();
		}
		String queryString = request.getQueryString();

		String url = request.getRequestURL().toString();
		if (queryString != null) {
			url = url + "?" + queryString;
		}
		String sign = openIdUtil.getJsSign(nonceStr, timestamp, ticket, url);

		model.addAttribute("appId", appId);
		model.addAttribute("timestamp", timestamp);
		model.addAttribute("signature", sign);
		model.addAttribute("nonceStr", nonceStr);

		return "wechat/guideChat";

	}

	// 加载所有未接受历史信息
	@RequestMapping(value = "/loadUncheck")
	public String loadUncheck(HttpServletRequest request, HttpServletResponse response, Model model) {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String toId = request.getParameter("toId");
		JsonObject json = new JsonObject();
		if (toId.matches("\\d+")) {
			GuideChatHistory param = new GuideChatHistory();
			param.setStatus(0);// 未接受
			param.setToId(Integer.parseInt(toId));
			param.setFromId(loginUser.getGetMoreId());

			List<GuideChatHistoryDTO> result = chatService.loadListByParam(param);
			if (result != null) {
				for (GuideChatHistoryDTO temp : result) {
					temp.setTimeStamp(temp.getCreateDate().getTime());
					if (loginUser.getGetMoreId().equals(temp.getToUser().getGetMoreId())) {// 对方发过来的
						GuideChatHistory update = new GuideChatHistory();
						update.setHistoryId(temp.getHistoryId());
						update.setStatus(1);
						chatService.update(update);
					}

				}
			}
			json.setStatus("1").setData(result);

		} else {
			json.setStatus("0").setMessage("数据异常！");
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";

	}

	// 加载历史信息
	@RequestMapping(value = "/loadHistory")
	public String loadHistory(HttpServletRequest request, HttpServletResponse response, Model model) {
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		// TODO
		String toId = request.getParameter("toId");
		String pageIndex = request.getParameter("pageIndex");
		String pageSize = request.getParameter("pageSize");
		String tempId = request.getParameter("tempId");

		JsonObject json = new JsonObject();
		if (toId.matches("\\d+") && pageIndex.matches("\\d+") && pageSize.matches("\\d+")) {
			GuideChatHistory param = new GuideChatHistory();
			if (tempId != null && tempId.matches("\\d+")) {
				param.setTempId(Integer.parseInt(tempId));
			}
			param.setStatus(1);
			param.setToId(Integer.parseInt(toId));
			param.setFromId(loginUser.getGetMoreId());
			PageDTO<GuideChatHistory> page = new PageDTO<GuideChatHistory>();
			page.setPageSize(Integer.parseInt(pageSize));
			page.setPageIndex(Integer.parseInt(pageIndex));
			page.setParam(param);
			PageDTO<List<GuideChatHistoryDTO>> result = chatService.loadByParam(page);
			if (result != null && result.getParam() != null && result.getParam().size() > 0) {
				for (GuideChatHistoryDTO temp : result.getParam()) {
					temp.setTimeStamp(temp.getCreateDate().getTime());
				}
				if (tempId == null || !tempId.matches("\\d+")) {
					json.setMessage(result.getParam().get(0).getHistoryId() + "");// 初始化tempid
				}
			}
			json.setStatus("1").setData(result);
		} else {
			json.setStatus("0").setMessage("数据异常！");
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}

	// 导购对话
	@RequestMapping(value = "/guideSay")
	public String guideSay(HttpServletRequest request, HttpServletResponse response, Model model) {

		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String toId = request.getParameter("toId");
		String content = request.getParameter("content");
		JsonObject json = new JsonObject();
		if (toId.matches("\\d+") && content != null) {
			GuideChatHistory chatHistory = new GuideChatHistory();
			chatHistory.setToId(Integer.parseInt(toId));
			chatHistory.setCreateDate(new Date());
			chatHistory.setFromId(loginUser.getGetMoreId());
			// 处理content中带图片的情况
			chatHistory.setContent(content);
			chatHistory.setStatus(0);// 处于未接受状态
			try {
				chatService.save(chatHistory);
				GuideChatHistoryDTO history = chatService.getById(chatHistory.getHistoryId());
				// 转换时间戳
				history.setTimeStamp(chatHistory.getCreateDate().getTime());
				json.setStatus("1").setMessage("发送成功！");
				json.setData(history);
			} catch (Exception e) {
				json.setStatus("0").setMessage("发送失败！" + e.getMessage());
				e.printStackTrace();
			}

		} else {
			json.setStatus("0").setMessage("数据错误！");
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}

	@RequestMapping(value = "/hasRead")
	public String hasRead(HttpServletRequest request, HttpServletResponse response, Model model) {
		String messageId = request.getParameter("messageId");
		if (messageId != null && messageId.matches("\\d+")) {
			GuideChatHistory history = new GuideChatHistory();
			history.setHistoryId(Integer.parseInt(messageId));
			history.setStatus(1);
			chatService.update(history);
		}
		return "";
	}

	// 导购页面
	@RequestMapping(value = "/toGuide")
	public String toGuide(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role != null && !role.equals(Constant.GUIDE)) {// 如果不是导购用户
			try {
				request.setAttribute("role", Constant.GUIDE);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		// 查询是否已经是导购
		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		ThirdGuideDTO guide = thirdGuideService.getByGetMoreId(loginUser.getGetMoreId());
		if (guide != null) {
			try {
				request.getRequestDispatcher("guide.html").forward(request, response);
				return null;
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		model.addAttribute("brands", brandService.getAllBrand());
		return "wechat/toGuide";
	}

	// 申请导购
	@RequestMapping(value = "/saveGuide")
	public String saveGuide(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role != null) {// 如果不是导购用户
			return null;
		}

		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String sex = request.getParameter("sex");
		String storeId = request.getParameter("storeId");
		String job = request.getParameter("job");

		JsonObject json = new JsonObject();
		ThirdGuideDTO old = thirdGuideService.getByGetMoreId(loginUser.getGetMoreId());
		if (old != null) {
			json.setStatus("0").setMessage("导购已经申请了，请勿重复提交");
			model.addAttribute("json", JSONUtil.object2json(json));
			return "json";
		}
		if (name != null && phone != null && sex != null && sex.matches("[01]") && storeId != null && job != null) {
			ThirdGuide guide = new ThirdGuide();
			guide.setCreateDate(new Date());
			guide.setGetMoreId(loginUser.getGetMoreId());
			guide.setJob(job);
			guide.setName(name);
			guide.setStoreId(storeId);
			guide.setStatus(0);
			guide.setPhone(phone);
			guide.setSex(Integer.parseInt(sex));

			try {
				thirdGuideService.save(guide);
				request.getSession().setAttribute(Constant.ROLE, Constant.GUIDE);
				json.setStatus("1").setMessage("导购员申请成功！");
			} catch (Exception e) {
				json.setStatus("0").setMessage("申请失败，请稍后再试！");
				e.printStackTrace();
			}

		} else {
			json.setStatus("0").setMessage("数据异常！");
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}

	// 渠道商页面
	@RequestMapping(value = "/toChannel")
	public String toChannel(HttpServletRequest request, HttpServletResponse response, Model model) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role != null && !role.equals(Constant.CHANNEL)) {// 如果不是导购用户
			try {
				request.setAttribute("role", Constant.CHANNEL);
				request.getRequestDispatcher("noaccess.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}

		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
		ThirdChannelDTO channelDTO = channelService.getByGetMoreId(loginUser.getGetMoreId());
		if (channelDTO != null) {// 如果渠道不为空，则重定向到渠道商个人中心
			try {
				request.getRequestDispatcher("channel.html").forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		// 查出所有的公司
		ThirdChannel company = new ThirdChannel();
		company.setIsCompany(1);
		company.setStatus(1);// 申请通过的
		List<ThirdChannelDTO> companys = channelService.getList(company);
		model.addAttribute("companys", companys);
		return "wechat/toChannel";
	}

	// 渠道商申请
	@RequestMapping(value = "/saveChannel")
	public String saveChannel(HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam(value = "introImg") MultipartFile introImg) {
		String role = (String) request.getSession().getAttribute(Constant.ROLE);
		if (role != null) {// 如果不是渠道用户
			try {
				request.getRequestDispatcher("center.html").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return null;
		}

		GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);

		ThirdChannelDTO old = channelService.getByGetMoreId(loginUser.getGetMoreId());
		if (old != null) {
			JsonObject result = new JsonObject();
			result.setStatus("0").setMessage("请求已提交，请勿重复提交");
			model.addAttribute("json", JSONUtil.object2json(result));
			return "json";
		}

		String temp = UuidUtils.getImgUUID();
		String introImgPath = imgPath + "/channel/" + temp;

		File parent = new File(imgPath + "/channel");
		if (!parent.exists()) {
			parent.mkdirs();
		}

		try {
			ImgUtil.compressPic(introImg.getInputStream(), introImgPath);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		introImgPath = "/imgStore/channel/" + temp;

		String name = request.getParameter("name");// 名字
		String job = request.getParameter("job");// 工作
		String sex = request.getParameter("sex");
		String phone = request.getParameter("phone");
		String type = request.getParameter("type");// 0-个人名义，1-公司名义
		String companyName = request.getParameter("companyName");// 新建公司名字
		String parentId = request.getParameter("company");// 公司ID
		JsonObject result = new JsonObject();
		// 拦截数据
		if (!StringUtils.isEmptyOrWhitespaceOnly(name) && name.length() <= 10
				&& !StringUtils.isEmptyOrWhitespaceOnly(job) && !StringUtils.isEmptyOrWhitespaceOnly(sex)
				&& sex.matches("[01]") && !StringUtils.isEmptyOrWhitespaceOnly(phone) && phone.matches("\\d+")
				&& !StringUtils.isEmptyOrWhitespaceOnly(type) && type.matches("[01]")
				&& (companyName != null || (parentId != null && parentId.matches("\\d+")))) {
			ThirdChannel saveParam = new ThirdChannel();
			saveParam.setName(name);
			saveParam.setSex(Integer.parseInt(sex));
			saveParam.setPhone(phone);
			saveParam.setJob(job);
			saveParam.setType(Integer.parseInt(type));
			saveParam.setStatus(0);
			saveParam.setIsCompany(0);
			saveParam.setCreateDate(new Date());
			saveParam.setGetMoreId(loginUser.getGetMoreId());
			saveParam.setIntroImg(introImgPath);// 保存名片
			saveParam.setRate(0.01f);// 初始化为0.01
			if (parentId != null)
				saveParam.setParentId(Integer.parseInt(parentId));
			saveParam.setParentName(companyName);
			try {
				channelService.save(saveParam);
				result.setStatus("1");
				result.setMessage("申请成功");
				request.getSession().setAttribute(Constant.ROLE, Constant.CHANNEL);
			} catch (Exception e) {
				e.printStackTrace();
				result.setStatus("0");
				result.setMessage("申请失败：" + e.getMessage());
			}

		} else {
			result.setStatus("0");
			result.setMessage("数据异常");
		}

		model.addAttribute("json", JSONUtil.object2json(result));
		return "json";
	}

	@RequestMapping(value = "/miniorder")
	public String miniorder(HttpServletRequest request, HttpServletResponse response, Model model) {
		Date putDate = time.get("ticket_time");
		Long dual = new Date().getTime() - putDate.getTime();
		if (dual > 7200 * 900) {// 重置ticket
			initJsapiSign();
		}
		String queryString = request.getQueryString();
		String url = request.getRequestURL().toString().replace("miniorder", "index");
		if (queryString != null) {
			url = url + "?" + queryString;
		}
		// 生成微信凭证
		model.addAttribute("appId", request.getAttribute("appId"));
		model.addAttribute("timestamp", request.getAttribute("timestamp"));
		model.addAttribute("signature", request.getAttribute("signature"));
		model.addAttribute("nonceStr", request.getAttribute("nonceStr"));
		return "minisite/yuandan_order";
	}

	private static String create_nonce_str() {
		return UUID.randomUUID().toString();
	}

	private static String create_timestamp() {
		return Long.toString(System.currentTimeMillis() / 1000);
	}

	// 无权限界面
	@RequestMapping(value = "/noaccess")
	public String noaccess(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "wechat/noaccess/error";

	}

	// 确认界面
	@RequestMapping(value = "/codeConfirm")
	public String codeConfirm(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "wechat/noaccess/codeConfirm";

	}

	// 绑定推荐码
	@RequestMapping(value = "/bindCode")
	public String bindCode(HttpServletRequest request, HttpServletResponse response, Model model) {
		JsonObject json=new JsonObject();
		// 新注册用户
		String channelCode = request.getParameter("channelCode");// 渠道编码
		if (channelCode != null) {
			ThirdChannel param = new ThirdChannel();
			param.setCode(channelCode);
			int count = channelService.getCountByParam(param);
			if (count != 0) {
				model.addAttribute("channelCode", channelCode);
			} else {
				json.setStatus("0").setMessage("该推荐码不存在！");
				channelCode = null;
			}
		}
		if (Constant.NORMAL.equals(request.getSession().getAttribute(Constant.ROLE))) {
				if (channelCode != null) {
					GetMoreUserDTO loginUser = (GetMoreUserDTO) request.getSession().getAttribute(LOGIN_USER);
					if (loginUser.getCode() != null) {
						if (loginUser.getCode().equals(channelCode)) {
							json.setStatus("0").setMessage("您已经绑定过该推荐码了，无需重复操作");
						} else {
							json.setStatus("0").setMessage("您已经绑定过推荐码了，不能更换推荐码");
						}
					} else {
						// 绑定渠道商
						if (channelCode != null) {

							GetMoreUser user = new GetMoreUser();
							user.setCode(channelCode);
							user.setGetMoreId(loginUser.getGetMoreId());
							getMoreUserService.updateGetMoreUser(user);
							loginUser = getMoreUserService.getUserById(loginUser.getGetMoreId());
							request.getSession().setAttribute(LOGIN_USER, loginUser);
							json.setStatus("1").setMessage("绑定推荐码成功！");
						}
					}
				} 
		}else{
			json.setStatus("0").setMessage("只有普通用户才能绑定推荐码！");
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}

	@RequestMapping(value = "/verifying")
	public String verifying(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "wechat/noaccess/verifying";

	}
}
