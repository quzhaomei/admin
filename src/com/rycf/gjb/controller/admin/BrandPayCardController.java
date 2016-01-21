package com.rycf.gjb.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.BrandPayCardDTO;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.BrandPayCard;
import com.rycf.gjb.epay.ZGTService;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.JSONUtil;
import com.rycf.gjb.util.UuidUtils;

@LimitTag
@Controller
@RequestMapping(value="/payCard")
/**
 * 品牌管理员支付账号
 * @author Administrator
 */
public class BrandPayCardController extends BaseController{
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		List<BrandPayCardDTO> result=null;
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
		if(isSuper||isGetMore){
			result=brandPayCardService.getAllBrandPayCard();
		}else if(isBrand){
			result=new ArrayList<BrandPayCardDTO>();
			result.add(brandPayCardService.getBrandPayCardByUserId(sysUser.getSystemUserId()));
		}
		model.addAttribute("payCardList", result);
		return "payCardManager";
	}
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String userId=request.getParameter("userId");
		
		String bankaccountnumber=request.getParameter("bankaccountnumber");//银行卡号
		String bankaccounttype=request.getParameter("bankaccounttype");//开户类别
		String accountname=request.getParameter("accountname");//开户姓名
		String idcard=request.getParameter("idcard");//身份证号
		String bankprovince=request.getParameter("bankprovince");//开户省
		String bankcity=request.getParameter("bankcity");//开户市
		String bankname=request.getParameter("bankname");//开户行
		String bindmobile=request.getParameter("bindmobile");//绑定的手机
		SystemUserDTO user=systemUserService.getSystemUserById(userId);
		BrandPayCard brandPayCard=new BrandPayCard();
		brandPayCard.setUserId(userId);
		brandPayCard.setBankaccountnumber(bankaccountnumber);
		brandPayCard.setBankaccounttype(bankaccounttype);
		brandPayCard.setAccountname(accountname);
		brandPayCard.setLegalperson(user.getUserName());
		
		brandPayCard.setIdcard(idcard);
		brandPayCard.setBankprovince(bankprovince);
		brandPayCard.setBankcity(bankcity);
		brandPayCard.setBankname(bankname);
		brandPayCard.setBindmobile(bindmobile);
		
		BrandPayCardDTO old=brandPayCardService.getBrandPayCardByUserId(userId);
		if(old.getPayCardId()==null){
			brandPayCardService.saveBrandPayCard(brandPayCard);
		}else{
			brandPayCardService.updateBrandPayCard(brandPayCard);
		}
		
		JsonObject result=new JsonObject();
		result.setStatus("ok");
		model.addAttribute("json", JSONUtil.object2json(result));
		return "json";
	}
	@RequestMapping(value="/list")
	public String list(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String userId=request.getParameter("userId");
		String operator=request.getParameter("operator");
		if("registerBrand".equals(operator)){//验证商户注册
			BrandPayCardDTO brandPayCardDTO=brandPayCardService.getBrandPayCardByUserId(userId);
			String bankaccountnumber=brandPayCardDTO.getBankaccountnumber();
			JsonObject jsonObject=new JsonObject();
			if(bankaccountnumber==null){
				jsonObject.setStatus("no");
				jsonObject.setMessage("银行卡未绑定");
			}else{
				//开始发送注册信息
				String requestid=UuidUtils.getRequirstId();
				Map<String,String> registerParams=new HashMap<String, String>();
				registerParams.put("requestid", requestid);
				registerParams.put("bindmobile", brandPayCardDTO.getBindmobile());
				registerParams.put("customertype", "PERSON");
				registerParams.put("signedname","凯特猫返利");
				registerParams.put("linkman", brandPayCardDTO.getSystemUserDTO().getUserName());
				registerParams.put("idcard", brandPayCardDTO.getIdcard());
				registerParams.put("legalperson", brandPayCardDTO.getLegalperson());
				registerParams.put("minsettleamount", "0.1");
				registerParams.put("riskreserveday", "7");
				registerParams.put("bankaccountnumber", brandPayCardDTO.getBankaccountnumber());
				registerParams.put("bankname", brandPayCardDTO.getBankname());
				registerParams.put("accountname", brandPayCardDTO.getAccountname());
				registerParams.put("bankaccounttype", brandPayCardDTO.getBankaccounttype());
				registerParams.put("bankprovince", brandPayCardDTO.getBankprovince());
				registerParams.put("bankcity", brandPayCardDTO.getBankcity());
			
				Map<String, String> register=ZGTService.registerAccount(registerParams);
				if(!"1".equals(register.get("code"))){//注册子商户失败
					jsonObject.setStatus("no");
					jsonObject.setMessage("注册失败："+register.get("msg"));
				}else{
					//注册成功，清空秘钥
					String brandCode=register.get("ledgerno");
					BrandPayCard brandPayCard=new BrandPayCard();
					brandPayCard.setBrandCode(brandCode);
					brandPayCard.setBrandKey("");
					brandPayCard.setUserId(brandPayCardDTO.getUserId());
					brandPayCardService.updateBrandPayCard(brandPayCard);
					jsonObject.setStatus("ok");
					jsonObject.setMessage("注册成功");
				}
			}
			model.addAttribute("json", JSONUtil.object2json(jsonObject));
			return "json";
		}else if("registerKey".equals(operator)){//注册商户秘钥
			String key=request.getParameter("key");
			
			BrandPayCardDTO brandPayCardDTO=brandPayCardService.getBrandPayCardByUserId(userId);
			String bankaccountnumber=brandPayCardDTO.getBankaccountnumber();
			JsonObject jsonObject=new JsonObject();
			if(bankaccountnumber==null){
				jsonObject.setStatus("no");
				jsonObject.setMessage("银行卡未绑定");
			}else{
				BrandPayCard brandPayCard=new BrandPayCard();
				brandPayCard.setBrandKey(key);
				brandPayCard.setUserId(userId);
				brandPayCardService.updateBrandPayCard(brandPayCard);
				jsonObject.setStatus("ok");
				jsonObject.setMessage("更新成功");
			}
			model.addAttribute("json", JSONUtil.object2json(jsonObject));
			return "json";
		}
		BrandPayCardDTO result=brandPayCardService.getBrandPayCardByUserId(userId);
		model.addAttribute("json", JSONUtil.object2json(result));
		return "json";
	}

}
