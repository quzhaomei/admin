package com.rycf.gjb.controller.admin;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.BrandDTO;
import com.rycf.gjb.dto.BrandPayCardDTO;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.OrderDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.dto.StoreDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.Order;
import com.rycf.gjb.epay.ZGTService;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.JSONUtil;
/**
 * 品牌controller
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/order")
@LimitTag
public class OrderController extends BaseController{
	@RequestMapping(value="/list")
	public String getRoleList(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String brandId=request.getParameter("brandId");
		if(brandId!=null){
			List<StoreDTO> stores=storeService.getStoreByBrandId(brandId);
			model.addAttribute("json",JSONUtil.object2json(stores));
			return "json";
		}
		String orderId=request.getParameter("orderId");
		OrderDTO order=orderService.getOrderById(orderId);
		model.addAttribute("json",JSONUtil.object2json(order));
		return "json";
	}
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String pageSize=request.getParameter("pageSize");
		String pageIndex=request.getParameter("pageIndex");
		if(pageSize==null){
			pageSize="7";
		}
		if(pageIndex==null){
			pageIndex="1";
		}
		Order param=new Order();
		PageDTO<Order> page=new PageDTO<Order>();
		page.setParam(param);
		
		page.setPageIndex(Integer.parseInt(pageIndex));
		page.setPageSize(Integer.parseInt(pageSize));
		
		SystemUserDTO sysUser=(SystemUserDTO) request.getSession().getAttribute("user");
		boolean isSuper=false;//超级管理员
		boolean isGetMore=false;
		boolean isBrand=false;//品牌管理员
		for(RoleManagerDTO role:sysUser.getRolesArr()){
			if(superId.equals(role.getRoleId())){
				isSuper=true;
			}
			if(getMoreId.equals(role.getRoleId())){
				isGetMore=true;
			}
			if(brandRoleId.equals(role.getRoleId())){
				isBrand=true;
			}
		
		}
		PageDTO<List<OrderDTO>> pageList=null;
		String returnName="orderManager";
		//超级管理员拥有所有权限
		if(isSuper){//超级管理员管理
			pageList=orderService.getOrderByPageAndParam(page);
		}else if(isGetMore){//凯特毛审核
			Order order=new Order();
			order.setStatus("1");
			page.setParam(order);
			pageList=orderService.getOrderByPageAndParam(page);
			returnName="orderManager_1";
			model.addAttribute("nextstatus", "2");
		}else if(isBrand){//品牌审核
			Order order=new Order();
			order.setUserId(sysUser.getSystemUserId());
			order.setStatus("2");
			page.setParam(order);
			pageList=orderService.getOrderByPageAndParam(page);
			returnName="orderManager_1";
			model.addAttribute("nextstatus", "2.5");
			
		}
		List<BrandDTO> brands=brandService.getAllBrand();
		model.addAttribute("brands", brands);
		model.addAttribute("pageResult", pageList);
		return returnName;
	}
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		//username phone  store fare hasPay backType statu
		String orderId=request.getParameter("orderId");
		String username=request.getParameter("username");
		String phone=request.getParameter("phone");
		String store=request.getParameter("store");
		String fare=request.getParameter("fare");
		String hasPay=request.getParameter("hasPay");
		String backType=request.getParameter("backType");
		String info=request.getParameter("info");
		String status=request.getParameter("status");
		Order param=new Order();
		param.setOrderId(orderId);
		param.setUsername(username);
		param.setPhone(phone);
		param.setStoreId(store);
		param.setFare(fare);
		param.setInfo(info);
		param.setHasPay(hasPay);
		param.setBackType(backType);
		param.setStatus(status);
		//如果当前用户为该品牌的品牌管理员，则跳转支付返利页面
		SystemUserDTO sysUser=(SystemUserDTO) request.getSession().getAttribute("user");
		boolean isBrand=false;//品牌管理员
		for(RoleManagerDTO role:sysUser.getRolesArr()){
			if(brandRoleId.equals(role.getRoleId())){
				isBrand=true;
			}
		}
	
		if(isBrand&&"2.5".equals(status)){//比对是否是品牌账号,是品牌账号，则拦截支付
			JsonObject payResult=new JsonObject();
			OrderDTO order=orderService.getOrderById(orderId);
			String brandId=order.getBrand().getBrandId();//获取brandId；
			List<BrandDTO> result=brandService.getBrandByUserId(sysUser.getSystemUserId());
			boolean isRightBrand=false;
			for(BrandDTO brandDTO:result){
				if(brandId.equals(brandDTO.getBrandId())){
					isRightBrand=true;
				}
			}
			if(isRightBrand){//获取支付的秘钥，
				BrandPayCardDTO cardDTO=brandPayCardService.getBrandPayCardByUserId(sysUser.getSystemUserId());
				Float backRate=order.getBrand().getBrandRate();
				String brandCode=cardDTO.getBrandCode();
				if(backRate==null||brandCode==null){//没有绑定银行卡
					String str="";
					if(backRate==null){
						str+="佣金比例未设置";
					}
					if(brandCode==null){
						str+="商户未注册";
					}
					payResult.setMessage(str+",请先联系凯特猫管理员注册子商户");
					model.addAttribute("json", JSONUtil.object2json(payResult));	
					return "json";//订单确认页面
				}
				float money=backRate*order.getHasPay();//需要支付的，以元为单位
				String payMoney=Math.round(money*100)/100f+"";
				//转账流程
				String requestid= getReByBrand(order.getBrand().getBrandName());
				Map<String, String> transferParams = new HashMap<String, String>();
				transferParams.put("requestid", requestid);
				transferParams.put("ledgerno", "");
				transferParams.put("amount", payMoney);
				transferParams.put("sourceledgerno", brandCode);
				

				Map<String, String> transferResult = ZGTService.transfer(transferParams);
				String code 				= formatString(transferResult.get("code"));
				String msg					= formatString(transferResult.get("msg"));
			
				if("1".equals(code)) {//成功
					//更定订单状态
					param.setExternalid(requestid);
					orderService.updateOrder(param);
					payResult.setStatus("ok");
				} else if(!"".equals(code)) {
					payResult.setMessage("支付"+money+"时："+msg);
				}
				model.addAttribute("json", JSONUtil.object2json(payResult));
				return "json";
			}
			return null;
		}
		orderService.updateOrder(param);
		JsonObject jsonObject=new JsonObject();
		jsonObject.setStatus("ok");
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}
	

	public static String formatString(String text) {
		return (text == null ? "" : text.trim());
	}
	private SimpleDateFormat dateFormat=new SimpleDateFormat("yyyyMMdd hh:mm:ss");
	private Random random=new Random();
	public  String getReByBrand(String brandName) {
		Date date=new Date();
		return brandName+"/"+dateFormat.format(date)+"/"+random.nextInt(10)+random.nextInt(10);
	}
}
