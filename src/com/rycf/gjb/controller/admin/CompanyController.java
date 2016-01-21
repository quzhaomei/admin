package com.rycf.gjb.controller.admin;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.JsonObject;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.dto.SystemUserDTO;
import com.rycf.gjb.dto.ThirdChannelDTO;
import com.rycf.gjb.entity.ThirdChannel;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.JSONUtil;

/**
 * 公司
 * 
 * @author Administrator
 */
@Controller
@RequestMapping(value = "/company")
@LimitTag
public class CompanyController extends BaseController {

	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String pageIndex = request.getParameter("pageIndex");
		String pageSize = request.getParameter("pageSize");
		if (pageIndex == null) {
			pageIndex = "1";
		}
		if (pageSize == null) {
			pageSize = "7";
		}
		PageDTO<ThirdChannel> page = new PageDTO<ThirdChannel>();
		page.setPageIndex(Integer.parseInt(pageIndex.trim()));
		page.setPageSize(Integer.parseInt(pageSize.trim()));
		ThirdChannel param = new ThirdChannel();
		param.setIsCompany(1);// 是公司
		page.setParam(param);
		PageDTO<List<ThirdChannelDTO>> result = channelService
				.getByPageAndParam(page);
		model.addAttribute("pageResult", result);
		return "company";
	}

	@RequestMapping(value = "/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		SystemUserDTO sysUser = (SystemUserDTO) request.getSession()
				.getAttribute("user");
		String tempId = request.getParameter("tempId");
		String status = request.getParameter("status");
		String operator = request.getParameter("operator");
		String description = request.getParameter("description");
		String name = request.getParameter("name");
		JsonObject jsonObject = new JsonObject();
		if (operator != null) {
			
			if (operator.equals("update")) {
				if (tempId != null && tempId.matches("\\d+")
						&& (status == null || status.matches("[012]"))
						&& (name == null || name.length()<=50)
						&& (description == null || description.length() <= 200)) {
					ThirdChannel channel = new ThirdChannel();
					channel.setUpdateDate(new Date());
					channel.setUpdateUserId(sysUser.getSystemUserId());
					channel.setDescription(description);
					channel.setId(Integer.parseInt(tempId));
					channel.setName(name);
					if(status!=null)
					channel.setStatus(Integer.parseInt(status));
					try {
						channelService.update(channel);
						jsonObject.setStatus("1");
						jsonObject.setMessage("更新成功");
					} catch (Exception e) {
						e.printStackTrace();
						jsonObject.setStatus("0");
						jsonObject.setMessage("更新失败："+e.getMessage());
					}
				}
			}else if (operator.equals("add")) {//新增
				if (name != null &&name.length()<=50) {
					ThirdChannel channel = new ThirdChannel();
					channel.setName(name);
					channel.setStatus(1);
					channel.setIsCompany(1);
					channel.setRate(0.01f);
					channel.setType(0);
					channel.setCreateDate(new Date());
					try {
						channelService.save(channel);
						jsonObject.setStatus("1");
						jsonObject.setMessage("添加成功");
					} catch (Exception e) {
						e.printStackTrace();
						jsonObject.setStatus("0");
						jsonObject.setMessage("添加失败："+e.getMessage());
					}
				}
				
			}else if("findById".equals(operator)){
				if (tempId != null && tempId.matches("\\d+")){
					ThirdChannelDTO channel = channelService.getById(Integer.parseInt(tempId));
					if(channel!=null){
						jsonObject.setStatus("1");
						jsonObject.setData(channel);
					}else{
						jsonObject.setStatus("0");
						jsonObject.setMessage("查不到指定的信息");
					}
					
				}
			}
		} else {
			jsonObject.setStatus("0");
			jsonObject.setMessage("数据缺失");
		}

		model.addAttribute("json", JSONUtil.object2json(jsonObject));
		return "json";
	}
}
