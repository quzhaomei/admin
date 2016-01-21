package com.rycf.gjb.controller.admin;


import java.io.File;
import java.io.FileOutputStream;
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
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.entity.Brand;
import com.rycf.gjb.entity.BrandType;
import com.rycf.gjb.entity.BrandUser;
import com.rycf.gjb.entity.SystemUser;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.ChineseToCharUtil;
import com.rycf.gjb.util.JSONUtil;
import com.rycf.gjb.util.PasswordUtil;
import com.rycf.gjb.util.UuidUtils;

import freemarker.template.utility.StringUtil;
/**
 * 品牌controller
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/brand")
@LimitTag
public class BrandController extends BaseController{
	@RequestMapping(value="/list")
	public String getRoleList(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String brandId=request.getParameter("brandId");
		if(brandId!=null){
			BrandDTO brand=brandService.getBrandById(brandId);
			model.addAttribute("json", JSONUtil.object2json(brand));
		}
		
		return "json";
	}
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String phone=request.getParameter("phone");
		String brandName=request.getParameter("brandName");
		if(phone!=null){
			SystemUser systemUser=new SystemUser();
			systemUser.setPhone(phone);
			SystemUserDTO user=systemUserService.getUserByParam(systemUser);
			JsonObject jsonObject=new JsonObject();
			jsonObject.setData(user);
			if(user!=null)
				jsonObject.setStatus("1");//已经存在
			else
				jsonObject.setStatus("0");//不存在
			model.addAttribute("json", JSONUtil.object2json(jsonObject));
			return "json";
		}else if(brandName!=null){//验证品牌名字
			Brand brand=new Brand();
			brand.setBrandName(brandName);
			BrandDTO brandDTO=brandService.getBrandByName(brandName);
			JsonObject jsonObject=new JsonObject();
			jsonObject.setData(brandDTO);
			if(brandDTO!=null)
				jsonObject.setStatus("1");//已经存在
			else
				jsonObject.setStatus("0");//不存在
			model.addAttribute("json", JSONUtil.object2json(jsonObject));
			return "json";
		}
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
		List<BrandDTO> brands=null;
		if(isSuper||isGetMore){
			brands=brandService.getAllBrand();
		}else if(isBrand){//能管理自己品牌
			brands=brandService.getBrandByUserId(sysUser.getSystemUserId());
		}
		model.addAttribute("brandList", brands);
		model.addAttribute("permit",isSuper||isGetMore);
		//所有的品牌类别
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
		return "brandManager";
	}
	@RequestMapping(value="/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model,@RequestParam(value="logo",required=false) MultipartFile logo
			,@RequestParam(value="images[]",required=false) MultipartFile[] images){
		SystemUserDTO sysUser=(SystemUserDTO) request.getSession().getAttribute("user");
		String rate=request.getParameter("rate");
		String brandRate=request.getParameter("brandRate");
		String brandName=request.getParameter("brandName");
		String brandTypeIds=request.getParameter("brandTypeIds");
		String descript=request.getParameter("descript");
		String status=request.getParameter("status");
		String wechatId=request.getParameter("wechatId");
		String pinying_new=request.getParameter("pinying");//修改拼音
		String scanNum=request.getParameter("scanNum");
		String brandId=request.getParameter("brandId");
		
		String username=request.getParameter("username");	
		String phone=request.getParameter("phone");
		String userId=request.getParameter("userId");
		String logoPath=imgPath+"/logo/";
		String proPath=imgPath+"/proImg/";
		//创建文件夹
		File logoFile=new File(logoPath);
		File proFile=new File(proPath);
		if(!logoFile.exists()){//创建logo文件夹
			logoFile.mkdirs();
		}
		if(!proFile.exists()){//创建产品文件夹
			proFile.mkdirs();
		}
		
		try {
			String tempLogoPath=null;
			if(logo!=null){
				String logoUUid=UuidUtils.getImgUUID();
				String relLogoPath=logoPath+logoUUid;
				tempLogoPath="/imgStore/logo/"+logoUUid;
				File target=new File(relLogoPath);
				FileCopyUtils.copy(logo.getInputStream(), new FileOutputStream(target));
			}
			String tempProPath=null;
			if(images!=null){
				tempProPath="";
				for(int index=0;index<images.length;index++){
					String proUuid=UuidUtils.getImgUUID();
					File temp=new File(proFile, proUuid);
					FileCopyUtils.copy(images[index].getInputStream(), new FileOutputStream(temp));
					if(index==0){
						tempProPath="/imgStore/proImg/"+proUuid;
					}else{
						tempProPath+=",/imgStore/proImg/"+proUuid;
					}
				}
			}
			String brandRoleId="role143486930117862";//   品牌管理人ID
			if(brandId!=null){//更新操作
				String[] oldProImg=request.getParameterValues("oldProImg");
				Brand brand=new Brand();
				brand.setBrandId(brandId);
				brand.setBrandTypeIds(brandTypeIds);
				if(brandName!=null&&!"".equals(brandName)){
					brand.setBrandName(brandName);
					String pinying =ChineseToCharUtil.converterToSpell(brandName);
					brand.setPinying(pinying);
					brand.setIndexWord(pinying.substring(0,1).toUpperCase());
				}
				//如果传入了拼音，则以输入的拼音为主
				if(pinying_new!=null){
					brand.setPinying(pinying_new);
					brand.setIndexWord(pinying_new.substring(0,1).toUpperCase());
				}
				if(brandRate!=null){
					brand.setBrandRate(Float.parseFloat(brandRate));
				}
				if(rate!=null){
					brand.setRate(Float.parseFloat(rate));
				}
				brand.setImgPath(tempLogoPath);//设置logo路径
				if(oldProImg!=null){
					for(int i=0;i<oldProImg.length;i++){
						if(i==0&&tempProPath==null){
							tempProPath=oldProImg[i];
						}else{
							tempProPath+=","+oldProImg[i];
						}
					}
				}
				brand.setProImgs(tempProPath);
				brand.setIntroduce(descript);
				brand.setUpdateDate(new Date());
				brand.setUpdateUserId(sysUser.getSystemUserId());
				brand.setStatus(status);//更新品牌
				if(scanNum!=null&&scanNum.matches("\\d+")){
					brand.setScanNum(Integer.parseInt(scanNum));	
				}
				brandService.updateBrand(brand);
				if(userId!=null){
					//如果换了一个人，但是已经存在，保存改关系，且此人变为品牌管理员，接触前面的关系
					BrandDTO brandDTO=brandService.getBrandById(brandId);
					BrandUser param=new BrandUser();
					param.setBrandId(brandId);
					if(brandDTO.getUser()!=null){
						String oldUserId=brandDTO.getUser().getSystemUserId();
						param.setUserId(oldUserId);
						//解除关系，
						BrandUser oldTemp=brandUserService.getBrandUserByParam(param);
						if(oldTemp!=null){
							oldTemp.setStatus("0");
							brandUserService.updateBrand(oldTemp);
						}
					}
					param.setUserId(userId);
					BrandUser newTemp=brandUserService.getBrandUserByParam(param);
					if(newTemp!=null&&"0".equals(newTemp.getStatus())){//如果存在,
						newTemp.setStatus("1");
						brandUserService.updateBrand(newTemp);
					}else if(newTemp==null){
						param.setStatus("1");
						brandUserService.saveBrand(param);
					}
					//把此人变为品牌管理员
					SystemUserDTO newUser=systemUserService.getSystemUserById(userId);
					boolean isBrandManager=false;
					if(newUser.getRolesArr()!=null){
						for(RoleManagerDTO temp:newUser.getRolesArr()){
							if(brandRoleId.equals(temp.getRoleId())){
								isBrandManager=true;
							}
						}
					}
					if(!isBrandManager){
						SystemUser systemUser=new SystemUser();
						if(newUser.getRolesArrStr()==null||"".equals(newUser.getRolesArrStr())){
							systemUser.setRolesArrStr(brandRoleId);
						}else{
							systemUser.setRolesArrStr(newUser.getRolesArrStr()+","+brandRoleId);
						}
						systemUser.setSystemUserId(userId);
						systemUserService.updateSystemUser(systemUser);
					}
				}else{
					BrandDTO brandDTO=brandService.getBrandById(brandId);
					//如果没换人，但是名字信息变了，更新该人的信息
					if(brandDTO.getUser()!=null&&phone==null){
						if(username!=null||wechatId!=null){
							SystemUser systemUser=new SystemUser();
							systemUser.setSystemUserId(brandDTO.getUser().getSystemUserId());
							systemUser.setUserName(username);
							systemUser.setWechatId(wechatId);
							systemUserService.updateSystemUser(systemUser);
						}
					}else{
						//如果换了一个新人，注册该人保存该保存该关系，接触前面的关系
						//1.解除前面的关系
						if(brandDTO.getUser()!=null){
							BrandUser oldBrandUser=new BrandUser();
							oldBrandUser.setBrandId(brandId);
							oldBrandUser.setStatus("1");
							oldBrandUser.setUserId(brandDTO.getUser().getSystemUserId());
							BrandUser temp=brandUserService.getBrandUserByParam(oldBrandUser);
							if(temp!=null){
								oldBrandUser.setStatus("0");
								oldBrandUser.setBrandUserId(temp.getBrandUserId());
								brandUserService.updateBrand(oldBrandUser);
							}
						}
						//2.注册该新人
						SystemUser paramUser=new SystemUser();
						paramUser.setCreateDate(new Date());
						paramUser.setCreateUserId(sysUser.getSystemUserId());
						paramUser.setUserName(username);
						paramUser.setPhone(phone);
						paramUser.setLoginname(phone);
						paramUser.setWechatId(wechatId);
						paramUser.setPassword(PasswordUtil.encodePsw(phone));
						paramUser.setStatus("1");
						paramUser.setRolesArrStr(brandRoleId);
						paramUser.setDescription("品牌创建时初始化~");
						systemUserService.saveSystemUser(paramUser);//保存用户
						userId=paramUser.getSystemUserId();
						
						//保存品牌管理人-品牌 中间表记录
						BrandUser brandUser=new BrandUser();
						brandUser.setUserId(userId);
						brandUser.setStatus("1");
						brandUser.setBrandId(brand.getBrandId());
						brandUserService.saveBrand(brandUser);
					}
					
				}
			}else{//保存操作
				Brand brand=new Brand();
				brand.setBrandName(brandName);
				brand.setCreateDate(new Date());
				brand.setCreateUserId(sysUser.getSystemUserId());
				brand.setRate(Float.parseFloat(rate));
				brand.setBrandRate(Float.parseFloat(brandRate));
				brand.setIntroduce(descript);
				brand.setBrandTypeIds(brandTypeIds);
				brand.setImgPath(tempLogoPath);
				brand.setProImgs(tempProPath);
				brand.setStatus("1");
				
				String pinying=ChineseToCharUtil.converterToSpell(brandName);
				brand.setPinying(pinying);
				String IndexWord=pinying.substring(0, 1).toUpperCase();
				brand.setIndexWord(IndexWord);
				brandService.saveBrand(brand);
				//处理品牌负责人
			
				if(userId!=null){//如果该用户存在
					SystemUserDTO userDTO=systemUserService.getSystemUserById(userId);
					boolean isBrandManager=false;
					for(RoleManagerDTO role:userDTO.getRolesArr()){
						if("role143486930117862".equals(role.getRoleId())){
							isBrandManager=true;
						}
					}
					if(!isBrandManager){
						SystemUser paramUser=new SystemUser();
						paramUser.setSystemUserId(userId);
						if(userDTO.getRolesArrStr()==null){
							paramUser.setRolesArrStr(brandRoleId);
						}else{
							paramUser.setRolesArrStr(userDTO.getRolesArrStr()+","+brandRoleId);
						}
						systemUserService.updateSystemUser(paramUser);
					}
				}else{//如果用户不存在，则新建用户，且变为品牌管理员
					SystemUser paramUser=new SystemUser();
					paramUser.setCreateDate(new Date());
					paramUser.setCreateUserId(sysUser.getSystemUserId());
					paramUser.setUserName(username);
					paramUser.setWechatId(wechatId);
					paramUser.setPhone(phone);
					paramUser.setLoginname(phone);
					paramUser.setPassword(PasswordUtil.encodePsw(phone));
					paramUser.setStatus("1");
					paramUser.setRolesArrStr(brandRoleId);
					paramUser.setDescription("品牌创建时初始化~");
					systemUserService.saveSystemUser(paramUser);//保存用户
					userId=paramUser.getSystemUserId();
				}
				//保存品牌管理人-品牌 中间表记录
				BrandUser brandUser=new BrandUser();
				brandUser.setUserId(userId);
				brandUser.setStatus("1");
				brandUser.setBrandId(brand.getBrandId());
				brandUserService.saveBrand(brandUser);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		JsonObject jsonObject=new JsonObject();
		jsonObject.setStatus("ok");
		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}
}
