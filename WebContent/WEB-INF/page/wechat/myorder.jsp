<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div class="navbar">
    <div class="navbar-inner">
        <div class="center sliding">我的返利记录</div>
        <div class="right">
             <a href="#" class="link icon-only open-panel"> <i class="icon icon-menu-1"></i></a>
            </div>
    </div>
</div>
<div class="pages">
    <div class="page contact-page">
    	<div class="page-content">
              <div class="content-block-title info">
              <span><i class="icon-money"></i> 支付方式确认 </span><!-- 0 -->
              <span><i class="icon-search-1"></i> 凯特猫审核 </span><!-- 1 -->
               <span><i class="icon-users"></i> 品牌审核 </span><!-- 2-->
              <br/>
               <span><i class="icon-heart-empty-1"></i> 凯特猫返利中</span><!-- 2.5 -->
               <span><i class="icon-heart-1"></i> 返利已完成</span><!-- 3 -->
               <span><i class="icon-cancel"></i> 审核退回</span><!-- 4 -->
               </div>
            <div class="list-block">
              <ul class="orderlist">
              <c:set var="temp" value="0"></c:set>
              <c:forEach items="${orders }" var="order" varStatus="status">
              	<li class="swipeout" orderId="${order.orderId }">
              <a href="#" class="item-content swipeout-content" >
              <div class="item-media">
              <img src="${order.brand.imgPath }" alt="" class="white">
              </div>
              <c:if test="${order.status=='2.5'||order.status=='3' }"><!-- 只计算返利完成的 -->
             	<c:set var="temp" value="${order.brand.rate*order.hasPay+temp }"></c:set> 
              </c:if>
             
              <div class="item-inner">
              <div class="item-title"><span class="name">${order.brand.brandName }</span>
             <span class="amount">
              ¥ <fmt:formatNumber value="${order.brand.rate*order.hasPay }"  maxFractionDigits="2"/>
              </span> <span class="time"><fmt:formatDate value="${order.createDate }" pattern="yyyy-MM-dd"/> 
              </span></div>
              <div class="item-after">
              <c:choose >
              	<c:when test="${order.status=='0' }">
              		<i class="icon-money" style="color:#CF000E;"></i>
              	</c:when>
              	<c:when test="${order.status=='1'}">
              		<i class="icon-search-1" style="color:#CF000E;"></i>
              	</c:when>
              	<c:when test="${order.status=='2'}">
              		<i class="icon-users" style="color:#CF000E;"></i>
              	</c:when>
              	<c:when test="${order.status=='2.5'}">
					<i class="icon-heart-empty-1" style="color:#CF000E;"></i>
				</c:when>
              	<c:when test="${order.status=='3'}">
              		<i class="icon-heart-1" style="color:#CF000E;"></i>
              	</c:when>
              	<c:when test="${order.status=='4'}">
              		<i class="icon-cancel" style="color:#CF000E;"></i>
              	</c:when>
              </c:choose>

			</div>
              </div>
              </a>
             
             <c:if test="${order.status=='0'||order.status=='1'||order.status=='4'}">
              <div class="swipeout-actions-right">
              Swipeout actions links/buttons
               <c:if test="${order.status=='0'}">
               <a href="saveOrder2.html?orderId=${order.orderId }" class="edit">编辑</a>
              </c:if>
                <c:if test="${order.status=='4'}"><!-- 删除 -->
               <a href="#" info="${order.info }" class="del-info">查看原因</a>
              </c:if>
             <!--  <a href="#" class="swipeout-delete delete" data-confirm="确认删除本订单?" data-confirm-title="删除确认?">删除</a> -->
              </div>
              </c:if>
              </li>
              
              </c:forEach>
              </ul>
              </div>
             <div class="content-block-title total">
                	共返利: <span>¥<fmt:formatNumber value="${temp }"  maxFractionDigits="2"/></span>
              </div>
            </div>

    </div>


</div>


