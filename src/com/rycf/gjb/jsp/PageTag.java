package com.rycf.gjb.jsp;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class PageTag extends SimpleTagSupport {
	private  Integer pageSize;//总页数
	private	 Integer pageIndex;//单前页数
	private  Integer totalPage;//总页数


	@Override
	public void doTag() throws JspException, IOException {
		String pageHtml=null;
		pageHtml=getHtml(pageSize, pageIndex, totalPage);
		getJspContext().getOut().print(pageHtml);
		super.doTag();
	}
	private String getHtml(Integer pageSize,Integer pageIndex,Integer totalPage){
		if(totalPage<2){
			return "";
		}
		StringBuilder html=new StringBuilder();
		//打印跳转的
		//选择
		html.append("<div class=\"span12 center\">");
		html.append("<div class=\"pagination\" >");
		html.append("<ul id=\"page\" rel='admin-page'>");
		html.append("<li ");
		if(pageIndex==1){
			html.append("class=\"disabled\" ");
		}else{
			html.append("index=\""+1+"\" ");
		}
		html.append("><a href=\"#\">首页</a></li>");
		html.append("<li ");
		if(pageIndex>1){
			html.append("index=\""+(pageIndex-1)+"\" ");
		}else{
			html.append("class=\"disabled\"");
		}
		html.append("><a href=\"#\">上一页</a></li>");
		
		for(int page=1;page<=totalPage;page++){
			if(page+3>pageIndex&&page-3<pageIndex){
				html.append("<li");
				if(page!=pageIndex){
					html.append(" index=\""+page+"\"");
				}else{
					html.append(" class=\"active\"");
				}
				
				html.append("><a href=\"#\">"+page+"</a></li>");
			}
		}
		html.append("<li");	
		if(pageIndex>=totalPage){
			html.append(" class=\"disabled\"");
		}else{
			html.append(" index=\""+(pageIndex+1)+"\"");
		}
		html.append("><a href=\"#\">下一页</a></li>");
		
		html.append("<li ");
		if(pageIndex>=totalPage){
			html.append("class=\"disabled\"");
		}else{
			html.append("index=\""+totalPage+"\"");
		}
		html.append("><a href=\"#\">尾页</a></li>");
		//直接分页
		html.append("<li class=\"disabled\" ><a  href=\"#\" >共"+totalPage+"页 </a></li>");
		html.append("<li class=\"disabled\"><a href=\"#\" > 跳转  </a></li>");
		html.append("<li >");
		html.append("<select id=\"pageSelect\" style='width:70px;' >");
		for(int index=1;index<=totalPage;index++){
			html.append("<option  value=\""+index+"\" "+(index==pageIndex?"selected='selected'":"")+">&nbsp; "+index+"</option>");
		}
		html.append("</select></li>");
		
		
			
		html.append("</ul></div>");
		html.append("</div>");
		return html.toString();
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}
	public Integer getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
	
}
