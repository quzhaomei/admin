<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div class="navbar">

    <div class="navbar-inner">
  
        
        <div class="center sliding">完成订单</div>

        <div class="right">
             <a href="#" class="link icon-only open-panel"> <i class="icon icon-menu-1"></i></a>
            </div>
    </div>
</div>
<div class="pages">
    <div class="page contact-page">
    	<div class="page-content">
       <div class="content-block-title ordercount"> 返利总额(元): <span>¥<fmt:formatNumber value="${order.hasPay*order.brand.rate }"  maxFractionDigits="2"/></span></div>
       
      <div class="list-block">
      <ul id="addreq">
     

       <li>
      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup" data-back-on-select="true">
        <!-- select -->
        <select name="backmoney" id="backType">
          <option value="-1" selected>请选择</option>
          <c:if test="${order.hasPay*order.brand.rate <1000}">
          <option value="0">微信红包(推荐)</option>
          <option value="1">银行返利</option>
          </c:if>
           <c:if test="${order.hasPay*order.brand.rate >=1000}">
          <option value="0">微信红包(推荐)</option>
          <option value="1" >银行返利</option>
          </c:if>
        
        </select>
        <input type="hidden" id="orderAdd2" value="${order.orderId }"/>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-yen"></i></div>
          <div class="item-inner">
            <div class="item-title">返利方式</div>
            <div class="item-after"></div>
          </div>
        </div>
      </a>
    </li>
    <li>
      
    </li>
        

</ul>

<div class="content-block legal">
<div class="content-block-inner">
<p>
  返利声明:<br>
1. 凯特猫返利平台的返利由银行转账、微信红包、礼品等组成，如果消费者退货，本平台将扣除返利现金或同等价值的现金礼品<br>
2. 凯特猫返利平台的返利途径只返利到与购物订单相对应的本人，礼品及礼品券只配送到订单的送货地址<br>
3. 一个返利账号仅限购物本人使用，会员必须向凯特猫返利平台提供真实有效的返利信息，对于由资料提
供不正确、不真实导致返利无法收到等后果，凯特猫凯特猫返利平台不承担责任；
<br>
4. 一张订单只能返利一次，订单时间不得早于品牌上线时间；<br/>
5. 微信返利，需通过购物本人确认才能获取返利，其他机构和个人不得以任何名义窃取他人订单，获取返利，凯
特猫如有发现非购物本人返利，凯特猫有权追回返利金额，对于金额较大的返利，凯特猫有权追究相关法律责任<br/>
6. 凯特猫返利平台上所有品牌商品均由消费者与品牌之间进行交易，本平台只提供相关的链接和推广，凯特猫返利平台不承担商品质量及售后服务
</p>

</div>
</div>

<ul>
    <li>
       
        <div class="item-content">
                  <div class="item-media"></div>

          <div class="item-inner">
                                <div class="item-title">我已阅读并同意返利条款</div>

            <label class="label-switch">
              <input type="checkbox" name="agree" id="titleAgree">
              <div class="checkbox"></div>
            </label>
          </div>
        </div>
    </li>
  </ul>





                   

                    <div class="content-block">
                    <p>
                    <a href="#" class="button button-big button-fill order2Btn">确认并提交订单 </a>
                    </p>
                    </div>
                  </div> 


             
            </div>







    </div>


</div>


