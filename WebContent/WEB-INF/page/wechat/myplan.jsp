<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div class="navbar">

    <div class="navbar-inner">
        
        <div class="center sliding">我的方案</div>

        <div class="right">
             <a href="#" class="link icon-only open-panel"> <i class="icon icon-menu-1"></i></a>
            </div>
    </div>
</div>
<div class="pages">
    <div data-page="contact" class="page contact-page">
    	   <div class="page-content infinite-scroll">
    	   <div class="list-block" id="orderList" style="margin-top:0px;">
    	    <input type="hidden" id="totalPage" value="${page.totalPage }"/>
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
         </div> 
             <c:if test="${page.totalPage >1}">    
			  	 <!--下拉  --> 
			    <div class="infinite-scroll-preloader">
				    <div class="preloader"></div>
				  </div>
		     </c:if>      
         </div>                       

    </div>
</div>
