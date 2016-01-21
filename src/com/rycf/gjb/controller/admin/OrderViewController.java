package com.rycf.gjb.controller.admin;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
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
import com.rycf.gjb.dto.OrderDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.Order;
import com.rycf.gjb.interceptor.LimitTag;
/**
 * 订单一览表
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/orderView")
@LimitTag
public class OrderViewController extends BaseController{
	//订单
	@RequestMapping(value="/load-excel")
	public String load(HttpServletRequest request,
			HttpServletResponse response, Model model){
		SystemUserDTO sysUser=(SystemUserDTO) request.getSession().getAttribute("user");
		boolean isSuper=false;//超级管理员
		boolean isGetMore=false;
		for(RoleManagerDTO role:sysUser.getRolesArr()){
			if(superId.equals(role.getRoleId())){
				isSuper=true;
			}
			if(getMoreId.equals(role.getRoleId())){
				isGetMore=true;
			}
		}
		if(isSuper||isGetMore){
		List<OrderDTO> result=orderService.getAllOrder();
		
		 WritableWorkbook wwb=null;
		 String fileName="家具订单列表.xls";
		try {
			wwb = Workbook.createWorkbook(new File(fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
		
		  WritableSheet ws = wwb.createSheet("家具订单列表单", 0);// 建立工作簿
		  // 写表头
		   jxl.write.Label label0 = new jxl.write.Label(0, 0, "序列");
		   jxl.write.Label label1 = new jxl.write.Label(1, 0, "姓名");
		   jxl.write.Label label2 = new jxl.write.Label(2, 0, "电话");
		   jxl.write.Label label3 = new jxl.write.Label(3, 0, "品牌");
		   jxl.write.Label label4 = new jxl.write.Label(4, 0, "店铺");
		   jxl.write.Label label5 = new jxl.write.Label(5, 0, "总费用");
		   jxl.write.Label label6 = new jxl.write.Label(6, 0, "已支付");
		   jxl.write.Label label7 = new jxl.write.Label(7, 0, "申请时间");
		   jxl.write.Label label8 = new jxl.write.Label(8, 0, "订单时间");
		   jxl.write.Label label9 = new jxl.write.Label(9, 0, "状态");
		
		   ws.addCell(label0);// 放入工作簿
		   ws.addCell(label1);
		   ws.addCell(label2);
		   ws.addCell(label3);
		   ws.addCell(label4);
		   ws.addCell(label5);
		   ws.addCell(label6);
		   ws.addCell(label7);
		   ws.addCell(label8);
		   ws.addCell(label9);
		   
		   SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		   for (int i = 0; i < result.size(); i++) {
			   OrderDTO temp=result.get(i);
			   // 写表头
			   jxl.write.Label temp0 = new jxl.write.Label(0, i+1, ""+(i+1));
			   jxl.write.Label temp1 = new jxl.write.Label(1, i+1, temp.getUsername());
			   jxl.write.Label temp2 = new jxl.write.Label(2, i+1, temp.getPhone());
			   String branName="";
			   if(temp.getBrand()!=null){
				   branName=temp.getBrand().getBrandName();
			   }
			   jxl.write.Label temp3 = new jxl.write.Label(3, i+1, branName);
			   String storeName="";
			   if(temp.getStore()!=null){
				   storeName=temp.getStore().getStoreName();
			   }
			   jxl.write.Label temp4 = new jxl.write.Label(4, i+1, storeName);
			   
			   jxl.write.Label temp5 = new jxl.write.Label(5, i+1, temp.getFare()+"");
			   jxl.write.Label temp6 = new jxl.write.Label(6, i+1, temp.getHasPay()+"");
			   jxl.write.Label temp7 = new jxl.write.Label(7, i+1, dateFormat.format(temp.getCreateDate()));
			   String buyDate="";
			   if(temp.getBuyDate()!=null){
				   buyDate=dateFormat.format(temp.getBuyDate());
			   }
			   jxl.write.Label temp8 = new jxl.write.Label(8, i+1, buyDate);
			   String statuStr="";
			   if("0".equals(temp.getStatus())){
				   statuStr="确定支付方式中";
			   }else if("1".equals(temp.getStatus())){
				   statuStr="凯特猫审核中";
			   }else if("2".equals(temp.getStatus())){
				   statuStr="品牌审核中";
			   }else if("3".equals(temp.getStatus())){
				   statuStr="返利完成";
			   }else if("4".equals(temp.getStatus())){
				   statuStr="审核退回";
			   }else{
				   statuStr="返利完成";
			   }
			   jxl.write.Label temp9 = new jxl.write.Label(9, i+1, statuStr);
			   ws.addCell(temp0);
			   ws.addCell(temp1);// 放入工作簿
			   ws.addCell(temp2);
			   ws.addCell(temp3);
			   ws.addCell(temp4);
			   ws.addCell(temp5);
			   ws.addCell(temp6);
			   ws.addCell(temp7);
			   ws.addCell(temp8);
			   ws.addCell(temp9);
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
		}
		return null;

	}
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String pageSize=request.getParameter("pageSize");
		String pageIndex=request.getParameter("pageIndex");
		String status=request.getParameter("status");
		if("-1".equals(status)){
			status=null;
		}
		if(pageSize==null){
			pageSize="7";
		}
		if(pageIndex==null){
			pageIndex="1";
		}
		PageDTO<Order> page=new PageDTO<Order>();
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
		//超级管理员拥有所有权限
		if(isSuper||isGetMore){//超级管理员,
			Order order=new Order();
			order.setStatus(status);
			page.setParam(order);
			pageList=orderService.getOrderByPageAndParam(page);
		}else if(isBrand){//品牌审核
			Order order=new Order();
			order.setStatus(status);
			order.setUserId(sysUser.getSystemUserId());
			page.setParam(order);
			pageList=orderService.getOrderByPageAndParam(page);
		}

		model.addAttribute("isSuper", isSuper);
		model.addAttribute("isGetMore", isGetMore);
		model.addAttribute("isBrand", isBrand);
		model.addAttribute("pageResult", pageList);
		model.addAttribute("status",status);
		return "orderManagerView";
	}
	
	
}
