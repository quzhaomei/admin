package com.rycf.gjb.controller.admin;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.BrandDTO;
import com.rycf.gjb.dto.FurnitureRequiredDTO;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.RequiredAnswerDTO;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.FurnitureRequired;
import com.rycf.gjb.entity.RequiredAnswer;
import com.rycf.gjb.entity.RequiredAnswerHistoryImg;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.JSONUtil;
import com.rycf.gjb.util.UuidUtils;
/**
 * 品牌controller
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/require")
@LimitTag
public class RequireController extends BaseController{
	@RequestMapping(value="/index")
	public String getRoleList(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String pageSize=request.getParameter("pageSize");
		String pageIndex=request.getParameter("pageIndex");
		if(pageSize==null){
			pageSize="7";
		}
		if(pageIndex==null){
			pageIndex="1";
		}
		FurnitureRequired param=new FurnitureRequired();
		PageDTO<FurnitureRequired> page=new PageDTO<FurnitureRequired>();
		page.setParam(param);
		
		page.setPageIndex(Integer.parseInt(pageIndex));
		page.setPageSize(Integer.parseInt(pageSize));
		
		PageDTO<List<FurnitureRequiredDTO>> pageList=
				furnitureRequiredService.getRequiredByPageAndParam(page);
		model.addAttribute("pageResult", pageList);
		return "requireManager";
	}
	@RequestMapping(value="/list")
	public String list(HttpServletRequest request,
			HttpServletResponse response, Model model){
		SystemUserDTO sysUser=(SystemUserDTO) request.getSession().getAttribute("user");
		String operator=request.getParameter("operator"); 
		JsonObject jsonObject=new JsonObject();
		String requiredId=request.getParameter("requiredId");
		if("check-power".equals(operator)){//查询回复方案的权限
			
			List<RoleManagerDTO> roles=sysUser.getRolesArr();
			if(roles==null){
				jsonObject.setStatus("0");
				jsonObject.setMessage("没有权限！");
			}else{
				boolean isBrand=false;
				boolean isStore=false;
				for(RoleManagerDTO temp:roles){
					if(temp.getRoleId().equals(storeId)){
						isBrand=true;
					}
					if(temp.getRoleId().equals(brandRoleId)){
						isStore=true;
					}
				}
				if((!isBrand)&&!(isStore)){
					jsonObject.setStatus("0");
					jsonObject.setMessage("只有店长或品牌管理员能够上传方案");
				}else{//验证是否已经发送过
					if(isBrand||isStore){//如果是品牌管理员,查出所有未回答过的品牌
						RequiredAnswer param=new RequiredAnswer();
						param.setRequiredId(requiredId);
						param.setUserId(sysUser.getSystemUserId());
						List<BrandDTO> result=requiredAnswerService.getUserNoAnswerBrand(param);
						if(result.size()==0){
							jsonObject.setStatus("0");
							jsonObject.setMessage("您的品牌已经提供了方案");
						}else{
							jsonObject.setData(result);
						}
					}
				}
			}
			
		}else if("show-answer".equals(operator)){//查询方案
			//如果是系统管理员与凯特猫管理员，显示全部
			List<RoleManagerDTO> roles=sysUser.getRolesArr();
			boolean isSuper=false;//超级管理员
			boolean isGetMore=false;
			boolean isBrand=false;//品牌管理员
			boolean isStore=false;//店长
			for(RoleManagerDTO role:roles){
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
			if(isSuper||isGetMore){//显示全部
				List<RequiredAnswerDTO> requires=requiredAnswerService.getAnswerByRequiredId(requiredId);
				jsonObject.setData(requires);
			}else if(isBrand||isStore){//如果是品牌管理员或者店长，查询所有与店长有关的品牌
				RequiredAnswer param=new RequiredAnswer();
				param.setUserId(sysUser.getSystemUserId());
				param.setRequiredId(requiredId);
				List<RequiredAnswerDTO> requires=requiredAnswerService.getAnswerByUserId(param);
				jsonObject.setData(requires);
			}
			jsonObject.setStatus("ok");
			
		}else if("get-history-img".equals(operator)){
			List<RequiredAnswerHistoryImg> historyImg=
					historyImgService.getHistoryByUserId(sysUser.getSystemUserId());
			jsonObject.setData(historyImg);
			jsonObject.setStatus("ok");
		}
		model.addAttribute("json",JSONUtil.object2json(jsonObject));
		return "json";
	}
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model,@RequestParam(value="proImg[]",required=false) MultipartFile[] images){
		SystemUserDTO sysUser=(SystemUserDTO) request.getSession().getAttribute("user");
		//判断是否是品牌管理员，或者是店长
		String brandId=request.getParameter("brandId");
		String requiredId=request.getParameter("requiredId");
		String[] zoneIds=request.getParameterValues("zoneId");
		String[] typeId=request.getParameterValues("typeId");
		String[] styleId=request.getParameterValues("styleId");
		String description=request.getParameter("description");
		String[] historyImgs=request.getParameterValues("historyImgs");//旧添加的产品图
		//保存产品图
		String anwerPath=imgPath+"/answer/";
		File answers=new File(anwerPath);
		if(!answers.exists()){//创建answer文件夹
			answers.mkdirs();
		}
		String tempAnswerPath=null;
		if(images!=null){
			for(int index=0;index<images.length;index++){
				String ansUuid=UuidUtils.getImgUUID();
				File temp=new File(answers, ansUuid);
				try {
					FileCopyUtils.copy(images[index].getInputStream(), new FileOutputStream(temp));
				}catch (IOException e) {
					e.printStackTrace();
				}
				if(index==0){
					tempAnswerPath="/imgStore/answer/"+ansUuid;
				}else{
					tempAnswerPath+=",/imgStore/answer/"+ansUuid;
				}
				//创建历史图片记录
				String tempPath="/imgStore/answer/"+ansUuid;
				RequiredAnswerHistoryImg historyImg=new RequiredAnswerHistoryImg();
				historyImg.setImgPath(tempPath);
				historyImg.setStatus("1");
				historyImg.setUpdateTime(new Date());
				historyImg.setUserId(sysUser.getSystemUserId());
				historyImgService.saveHistoryImg(historyImg);
			}
			
		}
		//如果使用了历史图片
		if(historyImgs!=null){
			String historytemp="";
			for(int i=0;i<historyImgs.length;i++){
				if(i==0){
					historytemp=historyImgs[i];
				}else{
					historytemp+=","+historyImgs[i];
				}
			}
			if(tempAnswerPath==null){
				tempAnswerPath=historytemp;
			}else{
				tempAnswerPath+=","+historytemp;
			}
		}
		
		RequiredAnswer saveParam=new RequiredAnswer();
		saveParam.setImgs(tempAnswerPath);
		saveParam.setCreateDate(new Date());
		saveParam.setUserId(sysUser.getSystemUserId());
		saveParam.setDescription(description);
		saveParam.setBrandId(brandId);
		saveParam.setStatus("0");
		saveParam.setZoneIds(arrToString(zoneIds));
		saveParam.setStyleIds(arrToString(styleId));
		saveParam.setRequiredId(requiredId);
		saveParam.setTypeIds(arrToString(typeId));
		requiredAnswerService.saveAnswer(saveParam);
		//更新需求为已回答状态
		FurnitureRequired required=new FurnitureRequired();
		required.setRequiredId(requiredId);
		required.setStatus("2");
		furnitureRequiredService.updateRequired(required);
		return null;
	}
	private String arrToString(String[] str){
		StringBuilder builder=new StringBuilder();
		for(int index=0;index<str.length;index++){
			if(index==0){
				builder.append(str[index]);
			}else{
				builder.append(",").append(str[index]);
			}
		}
		return builder.toString();
	}
}
