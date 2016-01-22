package com.rycf.gjb.controller.admin;


import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.BrandDTO;
import com.rycf.gjb.dto.GetMoreUserDTO;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.OrderDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.dto.UserCardDTO;
import com.rycf.gjb.entity.Order;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.pay.RedPaper;
import com.rycf.gjb.pay.SendResult;
import com.rycf.gjb.pay.SendUtil;
import com.rycf.gjb.util.JSONUtil;
/**
 * 订单返利controller
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/orderPay")
@LimitTag
public class OrderPayController extends BaseController{
	
	@RequestMapping(value="/list")
	public String getRoleList(HttpServletRequest request,
			HttpServletResponse response, Model model){

		String getMoreId=request.getParameter("getMoreId");
		UserCardDTO cardDTO=
			userCardService.getCardByGetMoreId(Integer.parseInt(getMoreId));
		
		model.addAttribute("json",JSONUtil.object2json(cardDTO));
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
		boolean isStore=false;//店长
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
			if(storeId.equals(role.getRoleId())){
				isStore=true;
			}
		}
		PageDTO<List<OrderDTO>> pageList=null;
		String returnName="orderManager";
		//超级管理员拥有所有权限
		if(isSuper||isGetMore){//超级管理员管理
			Order order=new Order();
			order.setStatus("2.5");//查询所有返利中的订单
//			order.setBackType("0");
			page.setParam(order);
			pageList=orderService.getOrderByPageAndParam(page);
			returnName="orderPay";
			model.addAttribute("nextstatus", "3");
		}
		List<BrandDTO> brands=brandService.getAllBrand();
		model.addAttribute("brands", brands);
		model.addAttribute("pageResult", pageList);
		return returnName;
	}
	/**
	 * 支付订单
	 * @return
	 */
	@RequestMapping(value="/saveOrUpdate")
	public synchronized String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		//username phone  store fare hasPay backType statu
		String orderId=request.getParameter("orderId");
		String status=request.getParameter("status");
		Order param=new Order();
		param.setOrderId(orderId);
		JsonObject jsonObject=new JsonObject();
		if("3".equals(status)){	//	完成支付
			OrderDTO orderDTO=orderService.getOrderById(orderId);
			if("0".equals(orderDTO.getBackType())){//如果是微信支付，考虑到微信红包限制，多次支付
				//获取返利的品牌信息
				String brandName=orderDTO.getBrand().getBrandName();
				//生成返利红包语
				String wish="凯特猫返利(品牌："+brandName+"),给您更多";
				Integer getMoreId=orderDTO.getGetMoreId();
				GetMoreUserDTO getMoreUser=getMoreUserService.getUserById(getMoreId);
				if(getMoreUser.getType()==2){//如果是PC用户，则无法返利,进行拦截
					return null;
				}
				String openId=wechatUserService.getWechatUserByGetMoreId
						(getMoreUser.getGetMoreId()).getOpenid();
				
				Float getMorePay=orderDTO.getGetMorePay();//获取还需要支付的
				float money=0.0f;//所总共需要支付的金额
				if(getMorePay!=null&&getMorePay!=0.0f){
					money=getMorePay;
				}else{
					money=orderDTO.getBrand().getRate()*orderDTO.getHasPay();//已分为单位
				}
				String message=null;
				if(money>200){
					RedPaper redPaper= redPaperFactory.getInstance(openId, 200, request,wish);
					SendResult sendResult=SendUtil.sendPaper(redPaper);
					
					if(SendResult.SUCCESS.equals(sendResult.getReturn_code())){//如果发送成功\
						money=money-200;
						
						Float fixed=((int)(money*100))/100f;
						message="单人每分钟只能发送一个红包，单次发送最高限额200元，本次以发送200元，"
								+ "余下的"+ fixed+"元，请于一分钟后再次分批发送！";
						
					}else{//发送失败
						message=sendResult.getReturn_msg();
					}
					
				}else{
					RedPaper redPaper= redPaperFactory.getInstance(openId, money, request,wish);
					SendResult sendResult=SendUtil.sendPaper(redPaper);
					if(SendResult.FAIL.equals(sendResult.getReturn_code())){//如果发送fail
						message="支付剩下"+money+" 元时："+sendResult.getReturn_msg();
					}else{//success
						money=0;
						message=sendResult.getReturn_msg();
					}
				}
				  
				if(money==0f){
					param.setStatus(status);
					param.setGetMorePay(0.0f);//凯特猫还需返还的红包数量为0
					param.setUpdateDate(new Date());
					orderService.updateOrder(param);
					jsonObject.setStatus("ok");
				}else{
					//更新返回的数量
					param.setGetMorePay(money);
					param.setUpdateDate(new Date());
					orderService.updateOrder(param);//直接更新
					
					jsonObject.setStatus("no");
					jsonObject.setMessage(message);
				}
			}else if("1".equals(orderDTO.getBackType())){//如果是银行支付，
				param.setStatus(status);
				orderService.updateOrder(param);//直接更新
				jsonObject.setStatus("ok");
			}
			
		}
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}
}
