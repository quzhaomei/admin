package com.rycf.gjb.controller.admin;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.FurnitureBudgetDTO;
import com.rycf.gjb.dto.FurnitureStyleDTO;
import com.rycf.gjb.dto.FurnitureTypeDTO;
import com.rycf.gjb.dto.FurnitureZoneDTO;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.BrandType;
import com.rycf.gjb.entity.FurnitureBudget;
import com.rycf.gjb.entity.FurnitureStyle;
import com.rycf.gjb.entity.FurnitureType;
import com.rycf.gjb.entity.FurnitureZone;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.JSONUtil;

import freemarker.template.utility.StringUtil;
@Controller
@RequestMapping(value="/furnitureSet")
@LimitTag
public class FurnitureSetController extends BaseController{
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		//品牌类型查询
		BrandType param1=new BrandType();
		param1.setStatus("1");
		List<BrandType> brandTypeList=brandTypeService.getBrandByParam(param1);
		for(BrandType temp:brandTypeList){
			String html=temp.getHtml();
			if(html!=null){
				String html_=StringUtil.HTMLEnc(html);
				temp.setHtml(html_);
			}
		}
		model.addAttribute("brandTypeList",brandTypeList);
		
		//功能区域查询
		List<FurnitureZoneDTO> zoneList=furnitureZoneService.getAllZone();
		model.addAttribute("zoneList",zoneList);
		
		//品类查询
		List<FurnitureTypeDTO> typeList=furnitureTypeService.getAllType();
		model.addAttribute("typeList",typeList);
		
		//风格查询
		List<FurnitureStyleDTO> styleList=furnitureStyleService.getAllStyle();
		model.addAttribute("styleList",styleList);
		
		//预算查询
		List<FurnitureBudgetDTO> budgetList=furnitureBudgetService.getAllBudget();
		model.addAttribute("budgetList",budgetList);
		
		return "furnitureSet";
	}
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String operator=request.getParameter("operator");
		SystemUserDTO sysUser=(SystemUserDTO) request.getSession().getAttribute("user");
		JsonObject jsonObject=new JsonObject();
		if("addBrandType".equals(operator)){//新增品牌类型
			String name=request.getParameter("name");
			String html=request.getParameter("html");
			BrandType param=new BrandType();
			param.setName(name);
			param.setHtml(html);
			param.setStatus("1");
			brandTypeService.saveBrandType(param);
			jsonObject.setStatus("ok");
		}else if("updateBrandType".equals(operator)){
			String id=request.getParameter("brandTypeId");
			String name=request.getParameter("name");
			String html=request.getParameter("html");
			String status=request.getParameter("status");
			BrandType param=new BrandType();
			param.setBrandTypeId(id);
			param.setName(name);
			param.setHtml(html);
			param.setStatus(status);
			brandTypeService.updateBrandType(param);
			jsonObject.setStatus("ok");
		}else if("addBudget".equals(operator)){//新增预算
			String startNum=request.getParameter("startNum");
			String endNum=request.getParameter("endNum");
			FurnitureBudget furnitureBudget=new FurnitureBudget();
			furnitureBudget.setStartNum(Float.parseFloat(startNum));
			furnitureBudget.setEndNum(Float.parseFloat(endNum));
			furnitureBudget.setStatus("1");
			furnitureBudget.setCreateDate(new Date());
			furnitureBudget.setCreateUserId(sysUser.getSystemUserId());
			furnitureBudgetService.saveBudget(furnitureBudget);
			jsonObject.setStatus("ok");
		}else if("updateBudget".equals(operator)){
			String startNum=request.getParameter("startNum");
			String endNum=request.getParameter("endNum");
			String budgetId=request.getParameter("budgetId");
			String status=request.getParameter("status");
			if(budgetId!=null){
				FurnitureBudget furnitureBudget=new FurnitureBudget();
				if(startNum!=null)
				furnitureBudget.setStartNum(Float.parseFloat(startNum));
				if(endNum!=null)
				furnitureBudget.setEndNum(Float.parseFloat(endNum));
				furnitureBudget.setStatus(status);
				furnitureBudget.setUpdateDate(new Date());
				furnitureBudget.setBudgetId(budgetId);
				furnitureBudget.setUpdateUserId(sysUser.getSystemUserId());
				furnitureBudgetService.updateBudget(furnitureBudget);
				jsonObject.setStatus("ok");
			}
		}else if("addStyle".equals(operator)){//新增风格
			String styleName=request.getParameter("styleName");
			if(styleName!=null){
				FurnitureStyle furnitureStyle=new FurnitureStyle();
				furnitureStyle.setStyleName(styleName);
				furnitureStyle.setCreateDate(new Date());
				furnitureStyle.setCreateUserId(sysUser.getSystemUserId());
				furnitureStyle.setStatus("1");
				furnitureStyleService.saveStyle(furnitureStyle);
				jsonObject.setStatus("ok");
			}
			
		}else if("updateStyle".equals(operator)){
			String styleName=request.getParameter("styleName");
			String styleId=request.getParameter("styleId");
			String status=request.getParameter("status");
			if(styleId!=null){
				FurnitureStyle furnitureStyle=new FurnitureStyle();
				furnitureStyle.setStyleId(styleId);
				furnitureStyle.setStyleName(styleName);
				furnitureStyle.setStatus(status);
				furnitureStyle.setUpdateDate(new Date());
				furnitureStyle.setCreateUserId(sysUser.getSystemUserId());
				furnitureStyleService.updateStyle(furnitureStyle);
				jsonObject.setStatus("ok");
			}
		}else if("addType".equals(operator)){
			String typeName=request.getParameter("typeName");
			String zoneIds=request.getParameter("zoneIds");
			FurnitureType furnitureType=new FurnitureType();
			furnitureType.setCreateDate(new Date());
			furnitureType.setCreateUserId(sysUser.getSystemUserId());
			furnitureType.setTypeName(typeName);
			furnitureType.setStatus("1");
			furnitureType.setZoneIds(zoneIds);
			furnitureTypeService.saveType(furnitureType);
			jsonObject.setStatus("ok");
			
		}else if("updateType".equals(operator)){//更新品类
			String typeName=request.getParameter("typeName");
			String zoneIds=request.getParameter("zoneIds");
			String typeId=request.getParameter("typeId");
			String status=request.getParameter("status");
			if(typeId!=null){
				FurnitureType furnitureType=new FurnitureType();
				furnitureType.setZoneIds(zoneIds);
				furnitureType.setTypeId(typeId);
				furnitureType.setTypeName(typeName);
				furnitureType.setStatus(status);
				furnitureType.setUpdateDate(new Date());
				furnitureType.setUpdateUserId(sysUser.getSystemUserId());
				furnitureTypeService.updateType(furnitureType);
			}
			jsonObject.setStatus("ok");
		}else if("addZone".equals(operator)){//添加功能区域
			String zoneName=request.getParameter("zoneName");
			if(zoneName!=null){
				FurnitureZone saveParam=new FurnitureZone();
				saveParam.setCreateUserId(sysUser.getSystemUserId());
				saveParam.setZoneName(zoneName);
				saveParam.setCreateDate(new Date());
				saveParam.setStatus("1");
				furnitureZoneService.saveZone(saveParam);
				jsonObject.setStatus("ok");
			}
			
		}else if("updateZone".equals(operator)){//修改功能区域
			String zoneName=request.getParameter("zoneName");
			String zoneId=request.getParameter("zoneId");
			String status=request.getParameter("status");
			if(zoneId!=null){
				FurnitureZone updateParam=new FurnitureZone();
				updateParam.setCreateUserId(sysUser.getSystemUserId());
				updateParam.setZoneName(zoneName);
				updateParam.setUpdateDate(new Date());
				updateParam.setUpdateUserId(sysUser.getSystemUserId());
				updateParam.setStatus(status);
				updateParam.setZoneId(zoneId);
				furnitureZoneService.updateZone(updateParam);
				jsonObject.setStatus("ok");
			}
		}
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}
	@RequestMapping(value="/list")
	public String list(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String operator=request.getParameter("operator");//查询单个
		if("findbrandTypeById".equals(operator)){
			String brandTypeId=request.getParameter("brandTypeId");
			if(brandTypeId!=null){
				BrandType brandType=brandTypeService.getById(brandTypeId);
				model.addAttribute("json", JSONUtil.object2json(brandType));
			}
		}else if("findBudgetById".equals(operator)){
			String budgetId=request.getParameter("budgetId");
			if(budgetId!=null){
				FurnitureBudgetDTO furnitureBudgetDTO=furnitureBudgetService.getBudgetById(budgetId);
				model.addAttribute("json", JSONUtil.object2json(furnitureBudgetDTO));
			}
			
		}else if("findStyleById".equals(operator)){
			String styleId=request.getParameter("styleId");
			if(styleId!=null){
				FurnitureStyleDTO furnitureStyleDTO=furnitureStyleService.getStyleById(styleId);
				model.addAttribute("json", JSONUtil.object2json(furnitureStyleDTO));
			}
		}else if("findZoneById".equals(operator)){//查询单个功能区域
			String zoneId=request.getParameter("zoneId");
			if(zoneId!=null){
				FurnitureZoneDTO furnitureZoneDTO=furnitureZoneService.getZoneById(zoneId);
				model.addAttribute("json",JSONUtil.object2json(furnitureZoneDTO));
			}
		}else if("findTypeById".equals(operator)){//查询单个品类
			String typeId=request.getParameter("typeId");
			if(typeId!=null){
				FurnitureTypeDTO furnitureTypeDTO=furnitureTypeService.getTypeById(typeId);
				model.addAttribute("json",JSONUtil.object2json(furnitureTypeDTO));
			}
		}
		return "json";
	}
}
