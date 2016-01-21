<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div class="navbar">
    <div class="navbar-inner">
        <div class="center sliding">我的需求</div>
        <div class="right">
             <a href="#" class="link icon-only open-panel"> <i class="icon icon-menu-1"></i></a>
            </div>
    </div>
</div>
<div class="pages">
    <div class="page contact-page">
    	<div class="page-content">
              <div class="content-block-title">需求列表［ <i class="icon-bookmark-1"></i> 已有回答方案］</div>
            <div class="list-block accordion-list">
              <ul>
              <c:forEach items="${page.param }" var="required">
              	  <li class="accordion-item swipeout"  requiredId="${required.requiredId }">
		              <a href="#" class="item-link item-content swipeout-content">
		              <div class="item-media"><i class="icon icon-f8 icon-bookmark-empty"></i></div>
		              <div class="item-inner">
		              <div class="item-title">
		              ${required.zoneDTO.zoneName } |
						 <c:forEach items="${required.typeDTOs }" var="type" varStatus="status">
		                 	<c:if test="${status.count==1 }">
		                 		${type.typeName }
		                 	</c:if>
		                 	<c:if test="${status.count!=1 }">
		                 		,${type.typeName }
		                 	</c:if>
		                 </c:forEach>
		              
					</div>
		              <div class="item-after"><fmt:formatDate value="${required.createDate }" pattern="yyyy-MM-dd"/> </div>
		              </div>
		              </a>
		              <div class="accordion-item-content">
		              <div class="content-block intend">
		                 <p><strong>功能区域:</strong> ${required.zoneDTO.zoneName }</p>
		                 <p><strong>家具品类:</strong>
		                 <c:forEach items="${required.typeDTOs }" var="type" varStatus="status">
		                 	<c:if test="${status.count==1 }">
		                 		${type.typeName }
		                 	</c:if>
		                 	<c:if test="${status.count!=1 }">
		                 		,${type.typeName }
		                 	</c:if>
		                 </c:forEach>
		                 </p>
		                 <p><strong>家具风格:</strong>
		                 <c:forEach items="${required.styleDTOs }" var="style" varStatus="status">
		                 	<c:if test="${status.count==1 }">
		                 		${style.styleName }
		                 	</c:if>
		                 	<c:if test="${status.count!=1 }">
		                 		,${style.styleName }
		                 	</c:if>
		                 </c:forEach>
		                 
		                 </p>
		                  <p><strong>购买预算:</strong>
		                  <c:if test="${required.budgetDTO.startNum<0 }">不限</c:if>
		                  <c:if test="${required.budgetDTO.startNum>=0 }">${required.budgetDTO.startNum }-${required.budgetDTO.endNum } 万</c:if>
		                  </p>
		                  <p><strong>文字描述:</strong> ${required.description }</p>
		              </div>
		              </div>
		              <div class="swipeout-actions-right">
		              <a href="#" class="swipeout-delete delete" data-confirm="确认删除本需求?" data-confirm-title="删除确认?">删除</a>
		              </div>
            	  </li>
              </c:forEach>
              </ul>
              </div>
            </div>
    </div>
</div>
