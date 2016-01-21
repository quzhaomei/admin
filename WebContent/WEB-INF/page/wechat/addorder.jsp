<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div class="navbar">

    <div class="navbar-inner">
  
        
        <div class="center sliding">提交订单</div>

        <div class="right">
             <a href="#" class="link icon-only open-panel"> <i class="icon icon-menu-1"></i></a>
            </div>
    </div>
</div>
<div class="pages">
    <div class="page contact-page">
    	<div class="page-content">
    <!--    <div class="slides" id="orderSlides">
             <div><img src="images/inslide1.jpg" alt=""></div>
              <div><img src="images/inslide2.jpg" alt=""></div>
              <div><img src="images/inslide3.jpg" alt=""></div>
            </div> -->
            
      <div class="list-block">
      <ul id="addreq">
      <li>
        <div class="item-content">
        <div class="item-media"><i class="icon icon-user"></i></div>
        <div class="item-inner">
        <div class="item-title label">姓名</div>
        <div class="item-input">
        <input type="text" class="" id="username" placeholder="必须与订单一致">
        </div>
        </div>
        </div>
        </li>
         <li>
        <div class="item-content">
        <div class="item-media"><i class="icon icon-mobile-2"></i></div>
        <div class="item-inner">
        <div class="item-title label">电话</div>
        <div class="item-input">
        <input class="" type="text" id="phone" maxlength="11" placeholder="必须与订单一致">
        </div>
        </div>
        </div>
        </li>
        
         <li>
        <div class="item-content">
        <div class="item-media"><i class="icon icon-clock"></i></div>
        <div class="item-inner">
        <div class="item-title label">购买时间</div>
        <div class="item-input">
        <input class="" type="text" id="buyDate"  placeholder="必须与订单一致">
        </div>
        </div>
        </div>
        </li>
                    
       <li>
      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup" data-back-on-select="true">
        <!-- select -->
        <select name="function" id="brands">
        	<option value="-1">请选择</option>
        <c:forEach items="${brands }" var="brand">
        	<c:if test="${ brand.status!='0'}">
        		<option value="${brand.brandId }" rate="${brand.rate }">${brand.brandName } </option>
        	</c:if>
        </c:forEach>
        </select>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-info"></i></div>
          <div class="item-inner">
            <!-- Select label -->
            <div class="item-title">品牌</div>
            <!-- Selected value, not required -->
            <div class="item-after"></div>
          </div>
        </div>
      </a>
    </li>



       <li>
      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup" data-back-on-select="true">
        <!-- select -->
        <select name="function" id="stores">
 
        </select>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-basket-1"></i></div>
          <div class="item-inner">
            <!-- Select label -->
            <div class="item-title">店铺</div>
            <!-- Selected value, not required -->
            <div class="item-after"></div>
          </div>
        </div>
      </a>
    </li>


    <li>
<div class="item-content">
<div class="item-media"><i class="icon"></i></div>
<div class="item-inner">
<div class="item-title backrate">返利比例</div>
<div class="item-after" id="rate"></div>
</div>
</div>
</li>


<li>
        <div class="item-content">
        <div class="item-media"><i class="icon icon-yen"></i></div>
        <div class="item-inner">
        <div class="item-title label">消费金额</div>
        <div class="item-input">
        <input type="number" id="fare" placeholder="元" class="">
        </div>
        </div>
        </div>
        </li>


        <li>
        <div class="item-content">
        <div class="item-media"><i class="icon icon-credit-card"></i></div>
        <div class="item-inner">
        <div class="item-title label">已付金额</div>
        <div class="item-input">
        <input type="number" placeholder="元" class="" id="hasPay">
        </div>
        </div>
        </div>
        </li>



            <li>
            <div class="item-content">
            <div class="item-media"><i class="icon"></i></div>
            <div class="item-inner">
            <div class="item-title totalamount">返利金额</div>
            <div class="item-after" id="reFare"></div>
            </div>
            </div>
            </li>

          

            <li class="uploadimages">
        <div class="item-content">
        <div class="item-media"><i class="icon icon-camera2"></i></div>
        <div class="item-inner">
        <div class="item-title label">订单照片</div>
        <div class="item-input">
        <label id="cameraInput"><i class="icon icon-plus-1"></i>
      <!--   <input type="file" capture="camera" accept="image/*" id="cameraInput" name="cameraInput"> -->
        </label>

        </div>
        <div class="item-after"><img src="images/19jia.png" alt="" style="display:none" id="imgReviw"></div>
        </div>
        </div>
        </li>

            

                    </ul>

                    <div class="content-block notice">
                     <i class="icon icon-info-circled"></i> 尾款支付后将继续返利<br/>
                     <i class="icon icon-info-circled"></i>订单信息必须与订单照片一致
                    </div>


                    <div class="content-block">
                    <p>
                    <a href="#" class="button button-big button-fill" disabled="disabled" id="submitOrder">提交订单 </a>
                    </p>
                    </div>
                  </div> 


             
            </div>







    </div>


</div>


