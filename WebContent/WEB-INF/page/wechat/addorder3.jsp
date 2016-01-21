<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div class="navbar">

    <div class="navbar-inner">
  
        
        <div class="center sliding">银行转账确认</div>

        <div class="right">
             <a href="#" class="link icon-only open-panel"> <i class="icon icon-menu-1"></i></a>
            </div>
    </div>
</div>
<div class="pages">
    <div class="page contact-page">
    	<div class="page-content">
       
      <div class="list-block">
      <ul id="addreq">
     

       <li>
      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup" data-back-on-select="true">
      <input type="hidden" id="userCardId" value='${card.userCardId }'/>
        <!-- select -->
        <select name="backmoney" id="bankName" bak='${card.bankName }'>
          <option value="noselect" selected>请选择</option>
          <option value="bank1" ${card.bankName=='中国工商银行'?'selected':'' }>中国工商银行</option>
          <option value="bank2" ${card.bankName=='中国农业银行'?'selected':'' }>中国农业银行</option>
          <option value="bank3" ${card.bankName=='中国银行'?'selected':'' }>中国银行</option>
          <option value="bank4" ${card.bankName=='中国建设银行'?'selected':'' }>中国建设银行</option>
          <option value="bank5" ${card.bankName=='上海浦东发展银行'?'selected':'' }>上海浦东发展银行</option>
          <option value="bank6" ${card.bankName=='招商银行'?'selected':'' }>招商银行</option>
          <option value="bank7" ${card.bankName=='平安银行'?'selected':'' }>平安银行</option>
          <option value="bank8" ${card.bankName=='兴业银行'?'selected':'' }>兴业银行</option>
          <option value="bank9" ${card.bankName=='中国民生银行'?'selected':'' }>中国民生银行</option>
        </select>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-info"></i></div>
          <div class="item-inner">
            <div class="item-title">银行名称</div>
            <div class="item-after"></div>
          </div>
        </div>
      </a>
    </li>
    <li>
        <div class="item-content">
        <div class="item-media"><i class="icon icon-location"></i></div>
        <div class="item-inner">
        <div class="item-title label">开户行</div>
        <div class="item-input">
        <input type="text" class="" name="subname" id="bankAddress" value="${card.accountAddr }" bak="${card.accountAddr }" placeholder="请输入">
        </div>
        </div>
        </div>
        </li>
      <li>
        <div class="item-content">
        <div class="item-media"><i class="icon icon-credit-card"></i></div>
        <div class="item-inner">
        <div class="item-title label">卡号</div>
        <div class="item-input">
        <input type="text" class="" name="cardnum" id="cardNum" value="${card.cardNo }" bak='${card.cardNo }' placeholder="请输入">
        </div>
        </div>
        </div>
        </li>

        <li>
        <div class="item-content">
        <div class="item-media"><i class="icon icon-user"></i></div>
        <div class="item-inner">
        <div class="item-title label">户名</div>
        <div class="item-input">
        <input type="text" class="" placeholder="请输入" id="cardUsername" value="${card.username }" bak='${card.username }'>
        </div>
        </div>
        </div>
        </li>
        

</ul>
<div class="content-block notice">
                     <i class="icon icon-info-circled"></i> 收款人姓名必须对应订单购买人
                    </div>

        <div class="content-block">
                    <p>
                    <a href="#" class="button button-big button-fill saveCard">确认提交</a>
                    </p>
                    </div>
                  </div> 


             
            </div>







    </div>


</div>


