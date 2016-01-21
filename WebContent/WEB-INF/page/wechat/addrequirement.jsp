<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div class="navbar">
	<div class="navbar-inner">
		<div class="center sliding">添加新需求</div>
		<div class="right">
			<a href="#" class="link icon-only open-panel"> <i
				class="icon icon-menu-1"></i></a>
		</div>
	</div>
</div>
<div class="pages">
	<div class="page contact-page">
		<div class="page-content">
			<!-- <div class="slides" id="requiredSlides">
				 <div>
					<img src="images/inslide1.jpg" alt="">
				</div>
				<div>
					<img src="images/inslide2.jpg" alt="">
				</div>
				<div>
					<img src="images/inslide3.jpg" alt="">
				</div> 
			</div> -->
			<div class="list-block">
				<ul id="addreq">
					<li><a href="#" class="item-link smart-select"
						data-back-text="返回" data-open-in="popup"
						data-back-on-select="true"> 
						<!-- select --> 
						<select name="function" id="zones">
						</select>
							<div class="item-content">
								<div class="item-media">
									<i class="icon icon-layers"></i>
								</div>
								<div class="item-inner">
									<!-- Select label -->
									<div class="item-title">功能区域</div>
									<!-- Selected value, not required -->
									<div class="item-after"></div>
								</div>
							</div>
					</a></li>
					<li><a href="#" class="item-link smart-select"
						data-back-text="返回" data-open-in="popup"> <!-- select --> <select
							name="type" multiple id="types">
								<option value="-1" selected>请选择</option>
						</select>
							<div class="item-content">
								<div class="item-media">
									<i class="icon icon-th-thumb"></i>
								</div>
								<div class="item-inner">
									<!-- Select label -->
									<div class="item-title">家居品类</div>
									<!-- Selected value, not required -->
									<div class="item-after"></div>
								</div>
							</div>
					</a></li>
					<li><a href="#" class="item-link smart-select"
						data-back-text="确认" data-open-in="popup" > <!-- "multiple" attribute for multiple select-->
							<select name="style" multiple id="styles">
							<c:forEach items="${styles }" var="style" varStatus="index">
								<option value="${style.styleId }" ${index.count==1?"selected":"" }>${style.styleName }</option>
							</c:forEach>
						</select>
							<div class="item-content">
								<div class="item-media">
									<i class="icon icon-skyatlas"></i>
								</div>
								<div class="item-inner">
									<div class="item-title">家居风格</div>
								</div>
							</div></a></li>
					<li><a href="#" class="item-link smart-select"
						data-back-text="返回" data-open-in="popup"
						data-back-on-select="true"> <!-- select --> <select
							name="price" id="budgets">
							<c:forEach items="${budgets }" var="budget">
							<c:if test="${budget.startNum<0 }">
								<option value="${budget.budgetId }">不限制</option>
							</c:if>
							<c:if test="${budget.startNum>=0 }">
								<option value="${budget.budgetId }">${budget.startNum }-${budget.endNum } 万</option>
							</c:if>
							</c:forEach>
						</select>
							<div class="item-content">
								<div class="item-media">
									<i class="icon icon-money"></i>
								</div>
								<div class="item-inner">
									<!-- Select label -->
									<div class="item-title">购买预算（万元）</div>
									<!-- Selected value, not required -->
									<div class="item-after"></div>
								</div>
							</div>
					</a></li>
					<!-- Additional "align-top" class for correct textarea alignment -->
					<li class="align-top">
						<div class="item-content">
							<div class="item-media">
								<i class="icon icon-pencil"></i>
							</div>
							<div class="item-inner">
								<div class="item-title label textarea">文字描述</div>
								<div class="item-input">
									<textarea id="description" placeholder="请点击输入" maxlength="70"></textarea>
								</div>
								<div style="font-size:12px;color:#888;">您还可以输入<span id="inputcount" style="color:red;">70</span>个字</div>
							</div>
						</div>
					</li>
				</ul>
				   <div class="content-block notice">
                     <i class="icon icon-info-circled"></i> 请您填写以上需求，以便资深导购为您免费配置方案
                    </div>
				<div class="content-block">
					<p>
						<a href="#" class="button button-big button-fill" id="submitReq" >提交需求方案</a>
						
					</p>
				</div>
				
			</div>
		</div>


	</div>


</div>


