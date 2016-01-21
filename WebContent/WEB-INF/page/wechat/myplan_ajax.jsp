<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
    	    <c:forEach items="${page.param }" var="required">
    	    	<c:if test="${required.status=='1' }">
    	    	<div class="card demo-card-header-pic">
                    <div class="card-content">
                    <div class="card-content-inner">
                    <p class="color-gray"><fmt:formatDate value="${required.createDate }" pattern="yyyy-MM-dd"/>
                      共有<span>${required.count }</span>套方案</p>
                    <p>${required.zoneDTO.zoneName }|
							<c:forEach items="${required.typeDTOs }" var="type" varStatus="status">
		                 	<c:if test="${status.count==1 }">
		                 		${type.typeName }
		                 	</c:if>
		                 	<c:if test="${status.count!=1 }">
		                 		,${type.typeName }
		                 	</c:if>
		                 </c:forEach>
		                 |${required.description }
							</p>
                <a href="#" class="del" requiredId="${required.requiredId }">删除当前需求</a>
                    </div>
                    </div>
                    </div>
    	    	</c:if>
    	    	<c:if test="${required.status=='2' }">
    	    	 <div class="card demo-card-header-pic">
                     <a href="myplan2.html?requiredId=${required.requiredId }" class="link">
                    <div style="background-image:url(${required.img })" valign="bottom" class="card-header color-white no-border"></div>
                    <div class="card-content">
                    <div class="card-content-inner">
                    <p class="color-gray"><fmt:formatDate value="${required.createDate }" pattern="yyyy-MM-dd"/>  共有<span>${required.count }</span>套方案</p>
                    <p>${required.zoneDTO.zoneName }|
							<c:forEach items="${required.typeDTOs }" var="type" varStatus="status">
		                 	<c:if test="${status.count==1 }">
		                 		${type.typeName }
		                 	</c:if>
		                 	<c:if test="${status.count!=1 }">
		                 		,${type.typeName }
		                 	</c:if>
		                 </c:forEach>
		                 |${required.description }</p>
                    </div>
                    </div>
                   </a>
                    </div>
    	    	</c:if>
    	    </c:forEach>

