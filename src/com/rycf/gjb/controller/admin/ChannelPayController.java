package com.rycf.gjb.controller.admin;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.GetMoreUserDTO;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.OrderDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.dto.ThirdChannelDTO;
import com.rycf.gjb.dto.UserCardDTO;
import com.rycf.gjb.entity.Order;
import com.rycf.gjb.entity.OrderChannel;
import com.rycf.gjb.entity.ThirdChannel;
import com.rycf.gjb.entity.WechatUser;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.pay.RedPaper;
import com.rycf.gjb.pay.SendResult;
import com.rycf.gjb.pay.SendUtil;
import com.rycf.gjb.util.JSONUtil;
/**
 * 第三方渠道支付管理
 * @author Administrator
 */
@Controller
@RequestMapping(value="/channelPay")
@LimitTag
public class ChannelPayController extends BaseController{
	@RequestMapping(value="/list")
	public String getRoleList(HttpServletRequest request,
			HttpServletResponse response, Model model){
		
		String tempId=request.getParameter("tempId");
		String operator=request.getParameter("operator");
		JsonObject json=new JsonObject();
		if(operator!=null&&tempId!=null&&tempId.matches("\\d+")){
			//查询所有的订单
			String pageIndex=request.getParameter("pageIndex");
			String pageSize=request.getParameter("pageSize");
			if(pageIndex==null){
				pageIndex="1";
			}
			if(pageSize==null){
				pageSize="5";
			}
			PageDTO<Order> page=new PageDTO<Order>();
			page.setPageIndex(Integer.parseInt(pageIndex.trim()));
			page.setPageSize(Integer.parseInt(pageSize.trim()));
			Order param=new Order();
			page.setParam(param);
			PageDTO<List<OrderDTO>> result= orderChannelService.
					getOrderByPageAndParam(page, Integer.parseInt(tempId));
			model.addAttribute("pageResult", result);
			model.addAttribute("tempId", tempId);
			
			model.addAttribute("channel", channelService.getById( Integer.parseInt(tempId)));
			//计算已总结算金额
			model.addAttribute("total_pay", orderChannelService.getPayedCount(Integer.parseInt(tempId)));
			//计算未结算金额
			model.addAttribute("total_unpay", orderChannelService.getUnPayedCount(Integer.parseInt(tempId)));
			return "channelPay_do";
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String pageIndex=request.getParameter("pageIndex");
		String pageSize=request.getParameter("pageSize");
		if(pageIndex==null){
			pageIndex="1";
		}
		if(pageSize==null){
			pageSize="7";
		}
		PageDTO<ThirdChannel> page=new PageDTO<ThirdChannel>();
		page.setPageIndex(Integer.parseInt(pageIndex.trim()));
		page.setPageSize(Integer.parseInt(pageSize.trim()));
		ThirdChannel param=new ThirdChannel();
		page.setParam(param);
		param.setIsCompany(0);//不是公司
		param.setStatus(1);//审核通过的
		PageDTO<List<ThirdChannelDTO>> result= channelService.getByPageAndParam(page);
		model.addAttribute("pageResult", result);
		return "channelPay";
	}
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		SystemUserDTO sysUser = (SystemUserDTO) request.getSession()
				.getAttribute("user");
		String operator = request.getParameter("operator");
		JsonObject jsonObject = new JsonObject();
		if ("call-all".equals(operator)) {//结算所有
			String tempId = request.getParameter("tempId");
			if(tempId!=null&&tempId.matches("\\d+")){
			//结算所有的
			ThirdChannelDTO channel=channelService.getById(Integer.parseInt(tempId));
			Float rate=channel.getRate();
			Float total=orderChannelService.getUnPayedCount(Integer.parseInt(tempId));
			//本次需要支付的
			Float needPay=rate*total+(channel.getUnpay()==null?0f:channel.getUnpay());
			
			
			  
			
			
			
			ThirdChannel updateParam=new ThirdChannel();
			updateParam.setId(Integer.parseInt(tempId));
			//累计历史记录
//			updateParam.setTotalPay(hasPay+(channel.getTotalPay()==null?0.0f:channel.getTotalPay()));
			//更新未支付的
			updateParam.setUnpay(needPay);
			channelService.update(updateParam);
			orderChannelService.batchPayed(Integer.parseInt(tempId));//更新所有
			jsonObject.setStatus("1");
			jsonObject.setMessage("批量结算成功！");
			}
		}else if("call-per".equals(operator)){
			String orderId = request.getParameter("orderId");//订单
			String tempId = request.getParameter("tempId");//渠道ID
			if(tempId!=null&&tempId.matches("\\d+")&&orderId!=null){
				OrderDTO order=orderService.getOrderById(orderId);//取出该条订单
				ThirdChannelDTO channel=channelService.getById(Integer.parseInt(tempId));
				if(order!=null&&channel!=null){
					if("3".equals(order.getStatus())){
						Float rate=channel.getRate();
						OrderChannel orderChannel=new OrderChannel();
						orderChannel.setChannelId(Integer.parseInt(tempId));
						orderChannel.setOrderId(orderId);
						try {
							orderChannelService.save(orderChannel);
							ThirdChannel updateParam=new ThirdChannel();
							updateParam.setId(Integer.parseInt(tempId));
							//更新未支付的
							Float unpay=channel.getUnpay();
							if(unpay==null){unpay=0f;}
							updateParam.setUnpay(unpay+rate*order.getHasPay());//结算
							channelService.update(updateParam);
							jsonObject.setStatus("1").setMessage("结算成功");
						} catch (Exception e) {
							e.printStackTrace();
							jsonObject.setStatus("0").setMessage(e.getMessage());
						}
						
					}else{
						jsonObject.setStatus("0").setMessage("订单有误！");
					}
				}else{
					jsonObject.setStatus("0").setMessage("该订单不存在！");
				}
			}
		}else{
			jsonObject.setStatus("0").setMessage("数据有误");
		}

		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}
	//佣金付款
		@RequestMapping(value="/money")
		public String money(HttpServletRequest request,
				HttpServletResponse response, Model model){
			String operator=request.getParameter("operator");
			String tempId=request.getParameter("tempId");//获取渠道商ID
			JsonObject json=new JsonObject();
			
			if("toMoney".equals(operator)){//查找付款方式
				if(tempId!=null&&tempId.matches("\\d+")){
					ThirdChannelDTO channel=channelService.getById(Integer.parseInt(tempId));
					GetMoreUserDTO getMore=channel.getUserDTO();
					UserCardDTO card= userCardService.getCardByGetMoreId(getMore.getGetMoreId());
					Float unpay=channel.getUnpay();//获取需要支付的、
					unpay=Math.round(unpay*100)/100f;
					if(card!=null){//银行卡付款
						
						json.setStatus("1").setMessage(unpay+""). setData(card);
					}else{//微信付款
						WechatUser wUser=wechatUserService.getWechatUserByGetMoreId(getMore.getGetMoreId());
						json.setStatus("2").setMessage(unpay+"").setData(wUser);
					}
				}
			}else if("doPay".equals(operator)){
				if(tempId!=null&&tempId.matches("\\d+")){
					ThirdChannelDTO channel=channelService.getById(Integer.parseInt(tempId));
					GetMoreUserDTO getMore=channel.getUserDTO();
					UserCardDTO card= userCardService.getCardByGetMoreId(getMore.getGetMoreId());
					Float unpay=channel.getUnpay();//获取需要支付的、
					Float totalPay=channel.getTotalPay()==null?0:channel.getTotalPay();
					unpay=Math.round(unpay*100)/100f;
					
					if(card!=null){//银行卡付款
						//直接更新
						ThirdChannel update=new ThirdChannel();
						update.setTotalPay(totalPay+unpay);
						update.setUnpay(0f);
						update.setId(channel.getId());
						channelService.update(update);
						json.setStatus("1").setMessage("结算成功！");
					}else{//微信付款
						WechatUser wUser=wechatUserService.getWechatUserByGetMoreId(channel.getUserDTO().getGetMoreId());
						String openId=wUser.getOpenid();
						String wish="凯特猫返利,给您更多";
						float hasPay=0.0f;
						boolean successTag=true;
						String message=null;
						while(unpay>=200){
							RedPaper redPaper= redPaperFactory.getInstance(openId, 200, request,wish);
							SendResult sendResult=SendUtil.sendPaper(redPaper);
							try {
								Thread.sleep(30000);//休眠30秒，再发第二个
							} catch (InterruptedException e) {
								e.printStackTrace();
							}
							if(SendResult.SUCCESS.equals(sendResult.getReturn_code())){//如果发送成功
								unpay=unpay-200;//更新需要发送的。
								hasPay=hasPay+200;//已发送的
							}else{//发送失败
								message=sendResult.getReturn_msg();
								successTag=false;
								break;//停止发送
							}
							
						}
						if(successTag){//前面支付200 都没有问题时候，支付余下的。
							if(unpay>=1){
								RedPaper redPaper= redPaperFactory.getInstance(openId, unpay, request,wish);
								SendResult sendResult=SendUtil.sendPaper(redPaper);
								if(SendResult.FAIL.equals(sendResult.getReturn_code())){//如果发送成功
									message="支付剩下"+unpay+" 元时："+sendResult.getReturn_msg();
									successTag=false;
								}else{
									hasPay=hasPay+unpay;//已发送的
									unpay=0f;//更新需要发送的。
									message="支付"+hasPay+"成功！";
								}
							}
						}
						ThirdChannel update=new ThirdChannel();
						update.setTotalPay(totalPay+hasPay);
						update.setUnpay(unpay);
						update.setId(channel.getId());
						channelService.update(update);
						json.setStatus("1").setMessage(message);
						//WechatUser wUser=wechatUserService.getWechatUserByGetMoreId(getMore.getGetMoreId());
						//json.setStatus("2").setMessage(unpay+"").setData(wUser);
					}
				}
			}else{
				json.setStatus("0").setMessage("数据有误！");
			}
			model.addAttribute("json", JSONUtil.object2json(json));
			return "json";
		}
}
