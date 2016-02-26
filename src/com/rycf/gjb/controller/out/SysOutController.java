package com.rycf.gjb.controller.out;

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
import com.rycf.gjb.dto.StoreDTO;
import com.rycf.gjb.dto.ThirdGuideDTO;
import com.rycf.gjb.entity.ThirdGuide;
import com.rycf.gjb.util.JSONUtil;
/**
 * 外部接口调用controller
 * @author quzhaomei
 *
 */
@Controller
@RequestMapping(value="/out")
public class SysOutController extends BaseController{
	/**
	 * 根据关键词获取指定品牌的店铺
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/getBrandByKey")
	public String getBrandByKey(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String host=request.getServerName();
		int port=request.getServerPort();
		String headUrl="http://"+host+":"+port+"/";
		String key=request.getParameter("key");
		Map<String,Object> data=new HashMap<String,Object>();
		if(key==null){
			data.put("status", 0);
		}else{
			data.put("status", 1);
			List<StoreDTO> stores=storeService.getStoreByBrandKey(key);
			List<Map<String,Object>> remote=new ArrayList<Map<String,Object>>();
			if(stores!=null){
				for(StoreDTO temp:stores){
					Map<String,Object> result=new HashMap<String, Object>();
					result.put("storeId", temp.getStoreId());
					result.put("storeName", temp.getStoreName());
					result.put("address", temp.getAddress());
					result.put("phone", temp.getUser().getPhone());
					result.put("wechatId", temp.getUser().getWechatId());
					//获取所有店铺下的导购
					ThirdGuide param=new ThirdGuide();
					param.setStoreId(temp.getStoreId());
					List<ThirdGuideDTO> guides=thirdGuideService.getList(param);
					List<Map<String,Object>> guidesDate=new ArrayList<Map<String,Object>>();
					if(guides!=null){
						for(ThirdGuideDTO temp_:guides){
							Map<String,Object> outMap=new HashMap<String, Object>();
							outMap.put("guideId", temp_.getGuideId());
							outMap.put("photo", temp_.getGetMoreUser().getPhoto());
							outMap.put("name", temp_.getName());
							outMap.put("url", headUrl+"wechat/customerChat.html?guideId="+temp_.getGuideId());
							guidesDate.add(outMap);
						}
					}
					result.put("guides", guidesDate);
					remote.add(result);
				}
			}
			data.put("data", remote);
		}
		model.addAttribute("json", JSONUtil.object2json(data));
		return "json";
	}
	/**
	 * 根据品牌获取所有店铺导购
	 */
	@RequestMapping(value="/getGuideByStore")
	public String getGuirdeByStore(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String storeId=request.getParameter("storeId");
		String host=request.getServerName();
		int port=request.getServerPort();
		String headUrl="http://"+host+":"+port+"/";
		Map<String,Object> data=new HashMap<String,Object>();
		if(storeId==null){
			data.put("status", 0);
		}else{
			data.put("status", 1);
			ThirdGuide param=new ThirdGuide();
			param.setStoreId(storeId);
			List<ThirdGuideDTO> guides=thirdGuideService.getList(param);
			List<Map<String,Object>> remote=new ArrayList<Map<String,Object>>();
			if(guides!=null){
				for(ThirdGuideDTO temp:guides){
					Map<String,Object> result=new HashMap<String, Object>();
					result.put("guideId", temp.getGuideId());
					result.put("photo", temp.getGetMoreUser().getPhoto());
					result.put("name", temp.getName());
					result.put("url", headUrl+"wechat/customerChat.html?guideId="+temp.getGuideId());
					remote.add(result);
				}
			}
			
			data.put("data", remote);
		}
		model.addAttribute("json", JSONUtil.object2json(data));
		return "json";
	}
	
}
