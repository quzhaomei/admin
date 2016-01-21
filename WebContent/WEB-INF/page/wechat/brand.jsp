<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div class="navbar">

    <div class="navbar-inner">
        <div class="left sliding">
            <a href="#" class="back link">
				<i class="icon icon-left-open-1"></i>
				<span>返回</span>
			</a>
        </div>
        <div class="center sliding">${brand.brandName }</div>

        <div class="right contact-edit-link">
            <a href="#" class="link icon-only">
				<i class="icon ion-compose"></i>
			</a>
        </div>
    </div>
</div>
<div class="pages">
    <div data-page="branddetail" class="page">
    	<div class="page-content branddetail">
              <div class="content-block">
                    <div class="content-block-inner">
                        <div class="logo "><img class="white" src="${brand.imgPath }" alt=""></div>
                            <div class="info">
                                <div class="brandname">
                                    ${brand.brandName }
                                </div>
                               <div class="backrate">
                               		    返利
                                   <fmt:formatNumber value="${brand.rate*100}"  maxFractionDigits="2"/> %
                                  
                               </div> 
                               <div style="font-size:15px;color:#888;line-height:25px;">
                               <i class="icon icon-heart-1"></i> 浏览量:
                               	<span style="color:#CF000E;font-size:15px;">${brand.scanNum }</span>
                               </div>

                            </div>

                            <div class="bttn">
                                   <a href="#" class="button button-fill open-detail"><i class="icon  icon-compass"></i> 展厅地址</a>
                               </div> 
                    </div>

                    <div class="content-block-inner" >
                    
                        <p>
                        <c:if test="${brand.introduce==null  }">
                    	     暂缺
                        </c:if>
                        <c:if test="${brand.introduce!=null  }">
                       		<c:if test="${fn:length(brand.introduce)>150 }">
                       			<span>
                       			${fn:substring(brand.introduce,0,150)}...
                       			<a href="#" style="color:#CF000E" ontouchstart="$(this).parent().hide();$(this).parent().next('span').show();">查看全部</a>
                       			</span>
                       			<span style="display:none;">
                       			${brand.introduce }
                       			<a href="#" style="color:#CF000E" ontouchstart="$(this).parent().hide();$(this).parent().prev('span').show();">收起</a>
                       			</span>
                       		</c:if>
                       		<c:if test="${fn:length(brand.introduce)<=150 }">
                       			${brand.introduce }
                       		</c:if>
                        </c:if>
                        </p>
                    </div>
                    
                 
              </div>

              <div class="content-block-title">案例展示</div>
              <c:if test="${fn:length(brand.proImgList)==0 }">
              	暂缺
              </c:if>
              <c:if test="${fn:length(brand.proImgList)!=0 }">
              <div class="swiper-container swiper-between">
                <div class="swiper-pagination"></div>
                <div class="swiper-wrapper">
                <c:forEach items="${brand.proImgList }" var="imgpath">
               		 <div class="swiper-slide"><img src="${imgpath }" alt=""></div>
                </c:forEach>
                </div>
              </div>
               </c:if>
            </div>

	<div class="popup popup-detail">
      <div class="content-block-title"><i class='icon-location-1 icon'></i> ${brand.brandName }门店信息</div>
        <div class="list-block accordion-list inset">
        <ul>
        <c:forEach items="${brand.stores }" var="store">
        <li class="accordion-item"><a href="#" class="item-link item-content">
        <div class="item-inner">
        <div class="item-title">${store.storeName }</div>
        </div></a>
        <div class="accordion-item-content">
        <div class="content-block">
        <p>
        	地址：${store.address }
        <br/>
    	    展位号：${store.doorCode }
    	  <br/>
    	   店长名字：${store.user.userName }
    	 <br/>
    	   店长手机：<a class="tel" ontouchstart="window.location.href='tel:'+$(this).text()" href="#">${store.user.phone }</a>
    	<br/>
    	   店长微信号：<a href="#" ontouchstart="">${store.user.wechatId }</a>
        </p>
        </div>
        </div>
        </li>
        </c:forEach>
        </ul>
        </div>
        <div class="content-block-title"><a href="#" class="close-popup button active">关闭</a></div>
    </div> 
    
	 <div class="latest" style="display:none">
	  <div class="content-block-inner">
                <c:if test="${empty scanHistory}">
                	<div>无</div>
                </c:if>
                <c:forEach items="${scanHistory }" var="scan">
                <c:if test="${scan.brand.status!='0' }">
                	<div id="${scan.brand.brandId }"><a href="brandDetail.html?brandId=${scan.brand.brandId }" class="item-link"><img src="${scan.brand.imgPath }" alt="" class="white"></a></div>
                </c:if>
                </c:forEach>
                </div>
               </div>

    </div>
</div>
