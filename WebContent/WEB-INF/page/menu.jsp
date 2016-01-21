<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div id="sidebar-left" class="span2">
	<div class="nav-collapse sidebar-nav">
		<ul class="nav nav-tabs nav-stacked main-menu">
			
			<li><a href="<%=path %>/user/index.html"><i
					class="halflings-icon white user"></i><span class="hidden-tablet">
						系统用户管理</span> </a></li>
			<li><a class="dropmenu" href="#"><i class="icon-asterisk"></i><span
					class="hidden-tablet"> 系统设置 </span> &nbsp;&nbsp;&nbsp; <i
					class='halflings-icon chevron-right white'> </i> <!-- 	<span class="label label-success"> 3 </span> -->
			</a>
				<ul>
					<li><a class="submenu" href="<%=path %>/menu/index.html"><i
							class="icon-table"></i><span class="hidden-tablet"> 菜单管理</span> </a>
					</li>
					<li><a class="submenu" href="<%=path %>/role/index.html"><i
							class="icon-group"></i><span class="hidden-tablet"> 角色管理</span> </a>
					</li>
					<li><a class="submenu" href="<%=path %>/power/index.html"><i
							class="icon-user"></i><span class="hidden-tablet"> 权限管理</span> </a></li>
					<!-- <li><a class="submenu" href="submenu3.jsp"><i
							class="icon-leaf"></i><span class="hidden-tablet"> 用户授权管理</span>
					</a></li> -->
				</ul>
			</li>

		</ul>
	</div>
</div>