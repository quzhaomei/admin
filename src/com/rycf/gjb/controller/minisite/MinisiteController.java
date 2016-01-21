package com.rycf.gjb.controller.minisite;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.BrandDTO;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.entity.minisite.DesignApply;
import com.rycf.gjb.entity.minisite.NineteenActivity;
import com.rycf.gjb.entity.minisite.PhoneRegister;
import com.rycf.gjb.pay.MD5Util;
import com.rycf.gjb.util.HttpSender;
import com.rycf.gjb.util.JSONUtil;
import com.rycf.gjb.util.UuidUtils;

/**
 * 微信
 * 
 * @author Administrator
 */
@RequestMapping(value = "/")
@Controller
public class MinisiteController extends BaseController {
	@RequestMapping(value = "/index.html")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		List<BrandDTO> brands = brandService.getAllBrand();
		for (BrandDTO brandDTO : brands) {
			brandDTO.setStores(storeService.getStoreByBrandId(brandDTO
					.getBrandId()));
		}
		model.addAttribute("brands", brands);
		return "minisite/index";
	}

	@RequestMapping(value = "/19jia.html")
	public String nine(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String source = request.getParameter("source");
		model.addAttribute("source", source);
		if ("3".equals(source) || "5".equals(source) || "1".equals(source)) {
			return "minisite/19jia_mobile";
		} else {
			return "minisite/19jia";
		}
	}

	@RequestMapping(value = "/nineteen.html")
	public String nineteen(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		// TYPE=0,19家活动
		String relName = request.getParameter("relName");
		String phone = request.getParameter("phone");
		String takeBus = request.getParameter("takeBus");
		String source = request.getParameter("source");

		NineteenActivity old = nineteenActivityService.getByPhoneAndType(phone,
				0);
		JsonObject jsonObject = new JsonObject();
		if (old == null) {
			if (relName != null) {
				NineteenActivity data = new NineteenActivity();
				data.setCreateDate(new Date());
				data.setRelName(relName);
				data.setTakeBus(takeBus);
				data.setSource(source);
				data.setPhone(phone);
				nineteenActivityService.saveNineteenActivity(data);
			}
			jsonObject.setStatus("1");
		} else {
			jsonObject.setStatus("0");// 手机号已经存在
		}
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}

	// 年末活动.报名
	@RequestMapping(value = "/year.html")
	public String year(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		// TYPE=1,年末活动
		String name=request.getParameter("name");
		String phone=request.getParameter("phone");

		JsonObject jsonObject = new JsonObject();
		int type=1;
		if(name!=null&&phone!=null){
			PhoneRegister saveParam=new PhoneRegister();
	
			saveParam.setName(name);
			saveParam.setPhone(phone);
			saveParam.setType(type);//元旦活动
			//查看手机号是否重复
			PhoneRegister oldParam=registerService.getByParam(saveParam);
			if(oldParam!=null){
				jsonObject.setStatus("0");
				jsonObject.setMessage("该用户已报名过！无需再次报名。");
				model.addAttribute("json", JSONUtil.object2json(jsonObject));
				return "json";
			}
			String content="【吉盛伟邦家具村】您参加家具清仓活动的验证码: KTM0001，" +
					"1月1-2日前往现场D2馆-3楼，免费领取凳子等。嘉松中路5369号 69755600，详情点击：" +
					" http://dwz.cn/2qSW8A";
			//发送短信
			try {
				HttpSender.sendMsg(phone, content);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			saveParam.setRegisterId(UuidUtils.getObjectUUID("register"));
			saveParam.setCreateDate(new Date());
			saveParam.setRegisterCode(MD5Util.GetMD5Code(phone));
			saveParam.setStatus("0");
			try {
				registerService.save(saveParam);
				jsonObject.setStatus("1");
				jsonObject.setMessage("报名成功");
			} catch (Exception e) {
				e.printStackTrace();
				jsonObject.setStatus("0");
				jsonObject.setMessage("保存时候，系统出现异常！");
			}
		}else{
			jsonObject.setStatus("0");
			jsonObject.setMessage("数据错误！");
		}
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}

	@RequestMapping(value = "/phoneRegister.html")
	public String phoneRegister(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String registerCode = request.getParameter("registerCode");
		if (registerCode != null) {
			PhoneRegister register = new PhoneRegister();
			register.setRegisterCode(registerCode);
			register = registerService.getByParam(register);
			if (register != null) {
				if (!"1".equals(register.getStatus())) {
					register.setStatus("1");
					register.setUpdateDate(new Date());
					registerService.update(register);
				}
			}
			try {
				response.sendRedirect("minisite/advertise");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	@RequestMapping(value = "/buyRegister.html")
	public String buyRegister(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String readyTime = request.getParameter("readyTime");
		JsonObject json = new JsonObject();
		if (name != null && phone != null) {
			PhoneRegister saveParam = new PhoneRegister();
			if (readyTime != null && readyTime.matches("\\d{4}-\\d{2}-\\d{2}")) {// 设置预购时间
				try {
					saveParam.setReadyTime(dateFormat.parse(readyTime));
				} catch (ParseException e) {
					e.printStackTrace();
					json.setStatus("0");
					json.setMessage("时间格式不正确，例如：2015-09-22");
					model.addAttribute("json", JSONUtil.object2json(json));
					return "json";
				}
			}
			saveParam.setName(name);
			saveParam.setPhone(phone);
			// 查看手机号是否重复
			PhoneRegister oldParam = registerService.getByParam(saveParam);
			if (oldParam != null) {
				json.setStatus("0");
				json.setMessage("该手机号已经注册过了。");
				model.addAttribute("json", JSONUtil.object2json(json));
				return "json";
			}

			saveParam.setRegisterId(UuidUtils.getObjectUUID("register"));
			saveParam.setCreateDate(new Date());
			saveParam.setRegisterCode(MD5Util.GetMD5Code(phone));
			saveParam.setStatus("0");
			try {
				registerService.save(saveParam);
				json.setStatus("1");
				json.setMessage("注册成功");
			} catch (Exception e) {
				e.printStackTrace();
				json.setStatus("0");
				json.setMessage("保存时候，系统出现异常！");
			}
		} else {
			json.setStatus("0");
			json.setMessage("数据错误！");
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}
	//量房申请
	@RequestMapping(value = "/designApply.html")
	public String designApply(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String phone=request.getParameter("phone");
		if(phone!=null&&phone.matches("\\d+")){//更新用户状态
			DesignApply apply=new DesignApply();
			apply.setPhone(phone);
			apply.setStatus(1);
			DesignApply checkDate=applyService.getByParam(apply);//检查数据是否存在
			if(checkDate!=null){//则更新
				String description=checkDate.getDescription();
				description+=" # "+new SimpleDateFormat("yyyy/MM/DD HH:mm").format(new Date())+
						" 打开短信页面浏览";
				checkDate.setDescription(description);
				checkDate.setStatus(2);
				try {
					applyService.update(checkDate);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		}
		return "minisite/designApply";
	}
	@RequestMapping(value = "/saveDesignApply")
	public String saveDesignApply(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String username=request.getParameter("username");
		String phone=request.getParameter("phone");
		String location=request.getParameter("location");
		String size=request.getParameter("size");
		JsonObject json=new JsonObject();
		if(username!=null&&username.length()<=20
				&&phone!=null&&phone.matches("\\d+")
				&&location!=null&&location.length()<=100
				&&size!=null&&size.length()<=100){
			DesignApply apply=new DesignApply();
			apply.setPhone(phone);
			DesignApply data=applyService.getByParam(apply);
			if(data!=null){
				//判断是否是重复报名
				if(data.getStatus()!=3){//进行更新
					data.setLocation(location);
					data.setStatus(3);//报名
					data.setSize(size);
					data.setUsername(username);
					data.setDescription(data.getDescription()+" # "+new SimpleDateFormat("yyyy/MM/DD HH:mm").format(new Date())+
						" 报名成功");
					try {
						applyService.update(data);
						json.setStatus("1").setMessage("报名成功！");
					} catch (Exception e) {
						e.printStackTrace();
						json.setStatus("0").setMessage("报名失败，系统异常："+e.getMessage());
					}
					
				}else{
					json.setStatus("0").setMessage("该用户已经报名过了！");
				}
			}else{
				apply.setCreateDate(new Date());
				apply.setUsername(username);
				apply.setPhone(phone);
				apply.setSize(size);
				apply.setLocation(location);
				apply.setDescription(new SimpleDateFormat("yyyy/MM/DD HH:mm").format(new Date())+
						" 直接进入页面报名");
				apply.setStatus(3);
				try {
					applyService.save(apply);
					json.setStatus("1").setMessage("报名成功！");
				} catch (Exception e) {
					e.printStackTrace();
					json.setStatus("0").setMessage(e.getMessage());
				}
			}
		}else{
			json.setStatus("0").setMessage("数据错误！");
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}

}
