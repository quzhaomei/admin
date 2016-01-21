<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div class="navbar">

    <div class="navbar-inner">
        
        <div class="center sliding">方案详细</div>

        <div class="right">
             <a href="#" class="link icon-only open-panel"> <i class="icon icon-menu-1"></i></a>
            </div>
    </div>
</div>
<div class="pages">
    <div data-page="contact" class="page contact-page">
    	   <div class="page-content">
    	   <c:forEach items="${answers}" var="answer">
    	   		 <div class="card demo-card-header-pic">
                   <a href="#" class="link">
                    <div style="background-image: url(${answer.imgs })" valign="bottom" class="card-header color-white no-border">
                   	${answer.zones[0].zoneName }-${answer.requiredDto.description }
                    </div>
                    <div class="card-content">
                    <div class="card-content-inner">
                    <p class="color-gray">曲美 （${answer.user.userName }） 发布于     <fmt:formatDate value="${answer.createDate }" pattern="MM月dd日，yyyy"/></p>
                    <p>${answer.description }</p>
                    </div>
                    </div>
                    </a>
                    </div>
    	    </c:forEach>
                  

            <!--          <div class="card demo-card-header-pic">
                     <a href="#" class="link">
                    <div style="background-image:url(images/slide2.jpg)" valign="bottom" class="card-header color-white no-border">方案对应需求标题</div>
                    <div class="card-content">
                    <div class="card-content-inner">
                    <p class="color-gray">品牌分店名 发布于 6月16日, 2015</p>
                    <p>方案推荐描述，方案推荐描述，方案推...</p>
                    </div>
                    </div>
                   </a>
                    </div> -->

             <!--         <div class="card demo-card-header-pic">
                     <a href="#" class="link">
                    <div style="background-image:url(images/slide3.jpg)" valign="bottom" class="card-header color-white no-border">方案对应需求标题</div>
                    <div class="card-content">
                    <div class="card-content-inner">
                    <p class="color-gray">品牌分店名 发布于 6月13日, 2015</p>
                    <p>方案推荐描述，方案推荐描述，方案推...</p>
                    </div>
                    </div>
                    </a>
                    </div> -->
                 
                 
            </div>

             
                  
           
           
                  
                 
            

    </div>
</div>
