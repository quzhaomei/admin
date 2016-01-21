package com.rycf.gjb.jsp;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.rycf.gjb.dto.RoleManagerDTO;
import com.rycf.gjb.dto.SystemUserDTO;

/**
 * Ȩ�޿��Ʊ�ǩ
 */
public class PowerTag extends BodyTagSupport {
	private static final long serialVersionUID = 1L;
	private String uri;// 
	private String roleId;// 

	public String getUri() {
		return uri;
	}

	public void setUri(String uri) {
		this.uri = uri;
	}

	

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int doStartTag() throws JspException {
		HttpServletRequest request = (HttpServletRequest) pageContext
				.getRequest();
		SystemUserDTO user = (SystemUserDTO) request.getSession().getAttribute("user");//
		String godPhone = request.getSession().getServletContext()
				.getInitParameter("godPhone");
		if (godPhone.equals(user.getPhone())) {//
			return super.doStartTag();
		} else if (roleId != null) {//
			if (user.getRolesArr() != null) {
				for (RoleManagerDTO temp : user.getRolesArr()) {
					if (temp.getRoleId().equals(roleId)) {
						return super.doStartTag();
					}
				}
			}
			return SKIP_BODY;
		} else if (uri != null) {// 
			String tempUri = uri.substring(3);
			if (user.getMenuList().get(tempUri) != null) {
				return super.doStartTag();
			}
			return SKIP_BODY;
		} else {// ���߶�Ϊ��
			return super.doStartTag();
		}
	}

	@Override
	public int doAfterBody() throws JspException {
		JspWriter out = bodyContent.getEnclosingWriter();
		// ȡ�ñ�ǩ�����
		BodyContent body = getBodyContent();
		// ȡ�ñ�ǩ����ַ�����
		String content = body.getString();
		try {
			out.print(content);
			body.clearBody();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// ����Ա�ǩ��Ĵ���
		return SKIP_BODY;
	}

	@Override
	public int doEndTag() throws JspException {
		return super.doEndTag();
	}

	@Override
	public void release() {
		super.release();
	}
}
