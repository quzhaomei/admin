<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div id="sidebar-left" class="span2">
	<div class="nav-collapse sidebar-nav">
		<ul class="nav nav-tabs nav-stacked main-menu">
			<c:forEach items="${allMenu}" var="menu">
				<c:set var="menuId" value="${menu.menuId }"/>
				<c:if test="${menu.parentId=='-1'&&menu.menuId!='-1'&&(sessionScope.user.menuList[menuId]!=null||sessionScope.user.phone==initParam.godPhone) }">
					<li>
						<a href="${menu.url }" class="dropmenu"><i class="icon-asterisk"></i> <span class="hidden-tablet"> ${menu.menuName } </span> 
						 </a>
						 <c:if test="${menu.type!='1'}"><!-- 不为操作 -->
						 <ul>
						 	<c:forEach items="${allMenu}" var="innerMenu">
						 		<c:set var="innerId" value="${innerMenu.menuId }"/>
						 		<c:if test="${innerMenu.parentId==menu.menuId&&(sessionScope.user.menuList[innerId]!=null||sessionScope.user.phone==initParam.godPhone) }">
						 			<li>
										<a href="${innerMenu.url }"> <i class="icon-table"></i>  ${innerMenu.menuName }</span> </a></li>
						 		</c:if>
						 	</c:forEach>
						 </ul>
						 </c:if>
					</li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</div>
