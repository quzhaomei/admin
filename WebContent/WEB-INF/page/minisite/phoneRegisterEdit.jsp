<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<p>
	<small class="text-success">修改记录</small>
</p>
<table class="table" style="width:100%;">
	<tr>
		<td width="20%"><label>姓名:</label></td>
		<td width="80%"><input type="text" id="edit_name" value="${data.name }" maxlength="10"
			placeholder="请输入姓名" bak=${data.name }>
			<input type="hidden" id="edit_registerId" value="${data.registerId }"></td>
	</tr>
	<tr>
		<td><label>手机:</label></td>
		<td><input type="text" id="edit_phone" maxlength="11" value="${data.phone }"
			placeholder="请输入手机号" bak=${data.phone }></td>
	</tr>
	<tr>
		<td><label>预购时间:</label></td>
		<td><input type="text" id="edit_readyTime" class="datepicker" value="<fmt:formatDate value="${data.readyTime }" pattern="yyyy-MM-dd"/>"
			placeholder="请输入预购时间" bak="<fmt:formatDate value="${data.readyTime }" pattern="yyyy-MM-dd"/>"/></td>
	</tr>
</table>
