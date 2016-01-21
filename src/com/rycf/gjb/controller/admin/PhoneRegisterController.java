package com.rycf.gjb.controller.admin;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.minisite.PhoneRegister;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.pay.MD5Util;
import com.rycf.gjb.util.HttpSendResult;
import com.rycf.gjb.util.HttpSender;
import com.rycf.gjb.util.JSONUtil;
import com.rycf.gjb.util.ShortUrlUtil;
import com.rycf.gjb.util.UuidUtils;
/**
 * 品牌controller
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/register")
@LimitTag
public class PhoneRegisterController extends BaseController{
	private static final Integer TYPE=0;//第一期活动
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		
		String status=request.getParameter("status");//状态
		String pageIndex=request.getParameter("pageIndex");//页面
		String pageSize=request.getParameter("pageSize");//页数量
		
		String startTimeStr=request.getParameter("startTime");//起始时间
		Date startTime=null;
		String endTimeStr=request.getParameter("endTime");//结束时间
		Date endTime=null;
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		if(startTimeStr!=null&&startTimeStr.matches("\\d{4}-\\d{2}-\\d{2}")){
			try {
				startTime=format.parse(startTimeStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(endTimeStr!=null&&endTimeStr.matches("\\d{4}-\\d{2}-\\d{2}")){
			try {
				endTime=format.parse(endTimeStr);//初始化为下一天
				endTime.setDate(endTime.getDate()+1);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		if(pageIndex==null){//每页十条
			pageIndex="1";
		}
		if(pageSize==null){
			pageSize="10";
		}
		int pageIndexInt=Integer.parseInt(pageIndex);
		int pageSizeInt=Integer.parseInt(pageSize);
		
		PageDTO<PhoneRegister> pageParam=new PageDTO<PhoneRegister>();
		pageParam.setPageIndex(pageIndexInt);
		pageParam.setPageSize(pageSizeInt);
		PhoneRegister param=new PhoneRegister();
		param.setType(TYPE);//第一期活动
		pageParam.setParam(param);
		if(!"-1".equals(status))
		param.setStatus(status);
		
		
		PageDTO<List<PhoneRegister>> pageData=
				registerService.getPageByParamAndTime(pageParam, startTime, endTime);
		
		String host=request.getRequestURL().toString();
		host=host.substring(0, host.lastIndexOf("/"));
		host=host.substring(0, host.lastIndexOf("/"));
		host+="/phoneRegister.html?registerCode=";
		
		for(PhoneRegister temp:pageData.getParam()){
			if(temp.getShortUrl()==null){//如果短地址为空，则去请求接口
				String shortUrl=ShortUrlUtil.getShotUrl(host+temp.getRegisterCode());
				temp.setShortUrl(shortUrl);
				//更新到数据库
				registerService.update(temp);
			}
		}
		
		model.addAttribute("pageResult", pageData);
		model.addAttribute("status", status);
		model.addAttribute("startTime", startTimeStr);
		model.addAttribute("endTime", endTimeStr);
		return "minisite/phoneRegister";
	}
	@RequestMapping(value="/list")
	public String list(HttpServletRequest request,
			HttpServletResponse response, Model model){
		List<PhoneRegister> result=registerService.getAllByType(TYPE);//第一期活动
		String host=request.getRequestURL().toString();
		host=host.substring(0, host.lastIndexOf("/"));
		host=host.substring(0, host.lastIndexOf("/"));
		host+="/phoneRegister.html?registerCode=";
		
		 WritableWorkbook wwb=null;
		 String fileName="活动注册名单.xls";
		try {
			wwb = Workbook.createWorkbook(new File(fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
		
		  WritableSheet ws = wwb.createSheet("注册名单", 0);// 建立工作簿
		  // 写表头
		   jxl.write.Label label1 = new jxl.write.Label(0, 0, "序列");
		   jxl.write.Label label2 = new jxl.write.Label(1, 0, "姓名");
		   jxl.write.Label label3 = new jxl.write.Label(2, 0, "电话号码");
		   jxl.write.Label label4 = new jxl.write.Label(4, 0, "发起时间");
		   jxl.write.Label label5 = new jxl.write.Label(3, 0, "预购时间");
		   jxl.write.Label label6 = new jxl.write.Label(5, 0, "状态");
		   jxl.write.Label label7 = new jxl.write.Label(6, 0, "链接");
		
		   ws.addCell(label1);// 放入工作簿
		   ws.addCell(label2);
		   ws.addCell(label3);
		   ws.addCell(label4);
		   ws.addCell(label5);
		   ws.addCell(label6);
		   ws.addCell(label7);
		   SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		   for (int i = 0; i < result.size(); i++) {
			   PhoneRegister temp=result.get(i);
			   // 写表头
			   jxl.write.Label temp1 = new jxl.write.Label(0, i+1, ""+(i+1));
			   jxl.write.Label temp2 = new jxl.write.Label(1, i+1, temp.getName());
			   jxl.write.Label temp3 = new jxl.write.Label(2, i+1, temp.getPhone());
			   jxl.write.Label temp4 = new jxl.write.Label(4, i+1, dateFormat.format(temp.getCreateDate()));
			   String readyTime="";
			   if(temp.getReadyTime()!=null){
				   readyTime=dateFormat.format(temp.getReadyTime());
			   }
			   String status="发起中";
			   if("1".equals(temp.getStatus())){
				   status="已接受";
			   }else if("2".equals(temp.getStatus())){
				   status="短信中";
			   }
			   jxl.write.Label temp5 = new jxl.write.Label(3, i+1, readyTime);
			   jxl.write.Label temp6 = new jxl.write.Label(5, i+1, status);
			   jxl.write.Label temp7 = new jxl.write.Label(6, i+1, 
					   temp.getShortUrl()!=null?temp.getShortUrl(): host+temp.getRegisterCode());
			   ws.addCell(temp1);// 放入工作簿
			   ws.addCell(temp2);
			   ws.addCell(temp3);
			   ws.addCell(temp4);
			   ws.addCell(temp5);
			   ws.addCell(temp6);
			   ws.addCell(temp7);
		   }
		   // 写入Exel工作表
		   wwb.write();
		   // 关闭Excel工作薄对象
		   wwb.close();
		   
		   // 下载
		   String contentType = "application/x-download";
		   response.setContentType(contentType);
		   response.setHeader("Content-Disposition", "attachment;filename="
		     + new String(fileName.getBytes("gb2312"), "ISO8859-1"));

		   ServletOutputStream out = response.getOutputStream();

		   byte[] bytes = new byte[0xffff];
		   InputStream is = new FileInputStream(new File(fileName));
		   int b = 0;
		   while ((b = is.read(bytes, 0, 0xffff)) > 0) {
		    out.write(bytes, 0, b);
		   }
		   is.close();
		   out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	private SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String name=request.getParameter("name");
		String phone=request.getParameter("phone");
		String readyTime=request.getParameter("readyTime");
		JsonObject json=new JsonObject();
		String operator=request.getParameter("operator");
		if("add".equals(operator)){
			if(name!=null&&phone!=null){
				PhoneRegister saveParam=new PhoneRegister();
				if(readyTime!=null&&readyTime.matches("\\d{4}-\\d{2}-\\d{2}")){//设置预购时间
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
				saveParam.setType(TYPE);//第一期活动
				//查看手机号是否重复
				PhoneRegister oldParam=registerService.getByParam(saveParam);
				if(oldParam!=null){
					json.setStatus("0");
					json.setMessage("手机号重复");
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
					json.setMessage("保存注册信息成功");
				} catch (Exception e) {
					e.printStackTrace();
					json.setStatus("0");
					json.setMessage("保存时候，系统出现异常！");
				}
			}else{
				json.setStatus("0");
				json.setMessage("数据错误！");
			}
		}else if("findById".equals(operator)){//查找单个
			String registerId=request.getParameter("registerId");
			if(registerId!=null){
				PhoneRegister data=registerService.getById(registerId);
				model.addAttribute("data", data);
				return "minisite/phoneRegisterEdit";
			}
		}else if("sendMsg".equals(operator)){//发送短信
			String registerId=request.getParameter("registerId");
			String content=request.getParameter("content");
			
			if(registerId!=null){
				PhoneRegister data=registerService.getById(registerId);
				if(data!=null){
					String toPhone=data.getPhone();//获取电话号码
					try {
						//去掉content中的标签
						content=content.replaceAll("<[/]*name>", "").replaceAll("<[/]*url>", "")
								.replaceAll("\\s+", "\n");
								System.out.println(content);
						//为null，发送测试数据
						HttpSendResult result=HttpSender.sendMsg(toPhone, content);
						if(result.getIsSuccess()){//成功，则更新状态
							PhoneRegister updateParam=new PhoneRegister();
							updateParam.setRegisterId(registerId);
							updateParam.setStatus("2");//短信发送中
							registerService.update(updateParam);
						}
						model.addAttribute("json", JSONUtil.object2json(result));
					} catch (Exception e) {
						model.addAttribute("json", 
								JSONUtil.object2json(new HttpSendResult(false, "系统出现异常")));
						e.printStackTrace();
					}
				}
			} 
			return "json";
		}else if("edit".equals(operator)){
			String registerId=request.getParameter("registerId");
			PhoneRegister updateParam=new PhoneRegister();
			updateParam.setRegisterId(registerId);
			if(readyTime!=null&&readyTime.matches("\\d{4}-\\d{2}-\\d{2}")){//设置预购时间
				try {
					updateParam.setReadyTime(dateFormat.parse(readyTime));
				} catch (ParseException e) {
					e.printStackTrace();
					json.setStatus("0");
					json.setMessage("时间格式不正确，例如：2015-09-22");
					model.addAttribute("json", JSONUtil.object2json(json));
					return "json";
				}
			}
			updateParam.setName(name);
			updateParam.setType(TYPE);
			if(phone!=null){
				updateParam.setPhone(phone);
				//查看手机号是否重复
				PhoneRegister oldParam=registerService.getByParam(updateParam);
			
			if(oldParam!=null){
				json.setStatus("0");
				json.setMessage("手机号重复");
				model.addAttribute("json", JSONUtil.object2json(json));
				return "json";
			}
			}
			try {
				registerService.update(updateParam);
				json.setStatus("1");
				json.setMessage("更新注册信息成功");
			} catch (Exception e) {
				e.printStackTrace();
				json.setStatus("0");
				json.setMessage("更新时候，系统出现异常！");
			}
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}
}
