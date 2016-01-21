package com.rycf.gjb.controller.admin;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.BrandDTO;
import com.rycf.gjb.dto.BrandScanDTO;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.Brand;
import com.rycf.gjb.entity.BrandScan;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.JSONUtil;

/**
 * 品牌浏览记录
 */
@Controller
@RequestMapping(value="/BrandScan")
@LimitTag
public class BrandScanController extends BaseController {
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String brandId=request.getParameter("brandId");//
		String pageIndex=request.getParameter("pageIndex");//页面
		String pageSize=request.getParameter("pageSize");//页数量
		//获取所有的品牌
		List<BrandDTO> brands=null;
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
		//初始化查看的品牌
		if(isSuper||isGetMore){//如果是凯特猫管理员，查看所有品牌
			brands=brandService.getAllBrand();
		}else if(isBrand){//查看本人品牌
			brands=brandService.getBrandByUserId(sysUser.getSystemUserId());
		}
		if("-1".equals(brandId)||brandId==null){//默认选择第一个品牌
			brandId=brands.get(0).getBrandId();
		}
		
		int pageIndexc=pageIndex==null||"".equals(pageIndex.trim())?1:Integer.parseInt(pageIndex);
		int pageSizec=pageSize==null||"".equals(pageSize.trim())?10:Integer.parseInt(pageSize);
		PageDTO<BrandScan> pageParam=new PageDTO<BrandScan>();
		BrandScan param=new BrandScan();
		param.setBrandId(brandId);//访问某一个品牌
		pageParam.setParam(param);
		pageParam.setPageIndex(pageIndexc);
		pageParam.setPageSize(pageSizec);
		
		PageDTO<List<BrandScanDTO>> pageResult=null;
		if(isSuper||isGetMore){//如果是凯特猫管理员，或者是品牌管理员，则获取真实数据
			pageResult=scanService.getScanByPage(pageParam);
		}else if(isBrand){//伪造数据
			pageResult=scanService.getScanByPage(pageParam);
		}
		
		model.addAttribute("isBrand", isBrand);
		model.addAttribute("brandId", brandId);
		model.addAttribute("brands", brands);
		model.addAttribute("pageResult", pageResult);
		return "brandScan";
	}
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String operator=request.getParameter("operator");
		String brandScanId=request.getParameter("scanId");
		String getMoreId=request.getParameter("getMoreId");//凯特号
		String brandId=request.getParameter("brandId");//品牌
		String seeDate=request.getParameter("seeDate");//时间
		BrandScan scan=new BrandScan(); 
		
		scan.setBrandScanId(brandScanId);
		
		if(getMoreId!=null&&getMoreId.matches("\\d+")){
			scan.setGetMoreId(Integer.parseInt(getMoreId));
		}
		scan.setBrandId(brandId);
		if(seeDate!=null){
			try {
				scan.setSeeDate(new SimpleDateFormat("yyyy-MM-dd").parse(seeDate));
				scan.setTime(seeDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		JsonObject json=new JsonObject();
		if("add".equals(operator)){
			try {
				scanService.saveScan(scan);
				json.setStatus("1");
				json.setMessage("添加记录成功！");
				
				//更新品牌的浏览记录次数
				BrandDTO brandDTO=brandService.getBrandById(brandId);
				if(brandDTO!=null){
					Brand brand=new Brand();
					brand.setBrandId(brandId);
					brand.setScanNum(brandDTO.getScanNum()+1);
					brandService.updateBrand(brand);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				json.setStatus("0");
				json.setMessage("添加记录失败！:该用户当天已存在记录");
			}
			
		}else if("toUpdate".equals(operator)){//更新
			BrandScanDTO scanHistory=scanService.getScanById(brandScanId);
			json.setData(scanHistory);
		}else if("update".equals(operator)){
			try {
				scanService.updateScan(scan);
				json.setStatus("1");
				json.setMessage("修改记录成功！");
				
			} catch (Exception e) {
				e.printStackTrace();
				json.setStatus("0");
				json.setMessage("修改记录失败！:该用户当天已存在记录");
			}
			
		}else if("delete".equals(operator)){
			try {
				scanService.deleteScan(brandScanId);
				json.setStatus("1");
				json.setMessage("删除记录成功！");
				//更新品牌的浏览记录次数
				BrandDTO brandDTO=brandService.getBrandById(brandId);
				if(brandDTO!=null){
					Brand brand=new Brand();
					brand.setBrandId(brandId);
					brand.setScanNum(brandDTO.getScanNum()-1);
					brandService.updateBrand(brand);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				json.setStatus("0");
				json.setMessage("删除记录失败！:该用户当天已存在记录");
			}
			
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}
}
