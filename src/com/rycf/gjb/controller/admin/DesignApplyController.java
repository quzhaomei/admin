package com.rycf.gjb.controller.admin;

import java.text.SimpleDateFormat;
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
import com.rycf.gjb.entity.minisite.DesignApply;
import com.rycf.gjb.interceptor.LimitTag;
import com.rycf.gjb.util.HttpSendResult;
import com.rycf.gjb.util.HttpSender;
import com.rycf.gjb.util.JSONUtil;
import com.rycf.gjb.util.ShortUrlUtil;

@Controller
@RequestMapping(value = "designApply")
@LimitTag
public class DesignApplyController extends BaseController {
	// 负责跳转菜单页面,并查出用户列表
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String pageIndex = request.getParameter("pageIndex");// 页码
		String pageSize = request.getParameter("pageSize");// 页容量
		if (pageIndex == null) {
			pageIndex = "1";
		}
		if (pageSize == null) {
			pageSize = "10";
		}
		if (pageIndex.matches("\\d+") && pageSize.matches("\\d+")) {
			Integer pageIndexInt = Integer.parseInt(pageIndex);
			Integer pageSizeInt = Integer.parseInt(pageSize);
			PageDTO<DesignApply> page = new PageDTO<DesignApply>();
			if (pageIndexInt != 0 && pageSizeInt != 0) {
				page.setPageIndex(pageIndexInt);
				page.setPageSize(pageSizeInt);
				DesignApply selectParam = new DesignApply();
				page.setParam(selectParam);

				PageDTO<List<DesignApply>> pageDate = applyService
						.findByPage(page);
				model.addAttribute("pageResult", pageDate);
				return "designApply";
			}
		}
		return "designApply";
	}

	@RequestMapping(value = "/sendMsg")
	public String sendMsg(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		//发送短信
		String applyId=request.getParameter("applyId");
		String content=request.getParameter("content");
		
		if(applyId!=null&&applyId.matches("\\d+")){
			DesignApply apply = new DesignApply();
			apply.setApplyId(Integer.parseInt(applyId));
			apply=applyService.getByParam(apply);
			if(apply!=null){
				String toPhone=apply.getPhone();//获取电话号码
				try {
					//去掉content中的标签
					content=content.replaceAll("<[/]*url>", "");
					//为null，发送测试数据
					HttpSendResult result=HttpSender.sendMsg(toPhone, content);
					if(result.getIsSuccess()){//成功，则更新状态
						apply.setStatus(1);
						apply.setDescription(apply.getDescription()+
								" # "+dateFormat.format(new Date()) + " 发送短信");
					}
					try {
						applyService.update(apply);
					} catch (Exception e) {
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
	}

	// 更新
	@RequestMapping(value = "/saveOrUpdate")
	public String saveOrUpdate(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		JsonObject json = new JsonObject();
		if (phone != null && phone.matches("\\d+") && name != null) {
			DesignApply apply = new DesignApply();
			apply.setPhone(phone);
			DesignApply checkDate = applyService.getByParam(apply);// 检查数据是否重复
			if (checkDate != null) {
				json.setStatus("0").setMessage("该用户已经注册过");
			} else {
				// 初始化
				apply.setUsername(name);
				apply.setCreateDate(new Date());
				apply.setStatus(0);
				apply.setDescription(dateFormat.format(new Date()) + " 经后台创建");
				String host = request.getRequestURL().toString();
				host = host.substring(0, host.lastIndexOf("/"));
				host = host.substring(0, host.lastIndexOf("/"));
				host += "/designApply.html?phone=" + phone;
				String shortUrl = ShortUrlUtil.getShotUrl(host);
				apply.setShortUrl(shortUrl);// 占位
				try {
					applyService.save(apply);
					json.setStatus("1").setMessage("添加成功！");
				} catch (Exception e) {
					json.setStatus("0").setMessage("新建失败：" + e.getMessage());
					e.printStackTrace();
				}
			}
		} else {
			json.setStatus("0").setMessage("数据异常！");
		}
		model.addAttribute("json", JSONUtil.object2json(json));
		return "json";
	}

	private SimpleDateFormat dateFormat = new SimpleDateFormat(
			"yyyy/MM/DD HH:mm");
}
