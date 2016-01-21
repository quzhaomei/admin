package com.rycf.gjb.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rycf.gjb.controller.BaseController;
import com.rycf.gjb.dto.BrandScanDTO;
import com.rycf.gjb.dto.PageDTO;
import com.rycf.gjb.entity.BrandScan;
import com.rycf.gjb.interceptor.LimitTag;

/**
 * 凯特猫浏览记录
 */
@Controller
@RequestMapping(value="/getMoreScan")
@LimitTag
public class GetMoreScanController extends BaseController {
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request,
			HttpServletResponse response, Model model){
		String pageIndex=request.getParameter("pageIndex");//页面
		String pageSize=request.getParameter("pageSize");//页数量
		
		int pageIndexc=pageIndex==null||"".equals(pageIndex.trim())?1:Integer.parseInt(pageIndex);
		int pageSizec=pageSize==null||"".equals(pageSize.trim())?10:Integer.parseInt(pageSize);
		
		PageDTO<BrandScan> pageParam=new PageDTO<BrandScan>();
		BrandScan param=new BrandScan();
		
		pageParam.setParam(param);
		
		pageParam.setPageIndex(pageIndexc);
		pageParam.setPageSize(pageSizec);
		
		PageDTO<List<BrandScanDTO>> pageResult=scanService.getGetMoreScanByPage(pageParam);
		
		
		model.addAttribute("pageResult", pageResult);
		return "getMoreScan";
	}
}
