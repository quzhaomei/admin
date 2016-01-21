<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script src="<%=basePath %>/js/jquery-1.9.1.min.js"></script>
	<script src="<%=basePath %>/js/jquery-migrate-1.0.0.min.js"></script>
	<script src="<%=basePath %>/js/jquery-ui-1.10.0.custom.min.js"></script>
	<script src="<%=basePath %>/js/jquery.validate.min.js"></script>
	<script src="<%=basePath %>/js/jquery.ui.touch-punch.js"></script>
	<script src="<%=basePath %>/js/modernizr.js"></script>
	<script src="<%=basePath %>/js/bootstrap.min.js"></script>
	<script src="<%=basePath %>/js/jquery.cookie.js"></script>
	<script src="<%=basePath %>/js/jquery.chosen.min.js"></script>
	<script src="<%=basePath %>/js/jquery.cleditor.min.js"></script>
	<script src='<%=basePath %>/js/jquery.dataTables.min.js'></script>
	<script src="<%=basePath %>/js/jquery.iphone.toggle.js"></script>
	<script src="<%=basePath %>/js/jquery.uploadify-3.1.min.js"></script>
	<script src="<%=basePath %>/js/jquery.uniform.min.js"></script>
	<script src="<%=basePath %>/js/jquery.gritter.min.js"></script>
	<script src="<%=basePath %>/js/jquery.imagesloaded.js"></script>
	<script src="<%=basePath %>/js/jquery.masonry.min.js"></script>
	<script src="<%=basePath %>/js/layer/layer.js"></script>
	
	<script src="<%=basePath %>/js/custom.js?version=1"></script>
	<script src="<%=basePath %>/js/admin.js?version=1"></script>
	<script>
	Date.prototype.Format = function(fmt)   
	{ //author: meizz   
	  var o = {   
	    "M+" : this.getMonth()+1,                 
	    "d+" : this.getDate(),                      
	    "h+" : this.getHours(),                  
	    "m+" : this.getMinutes(),                  
	    "s+" : this.getSeconds(),                 
	    "q+" : Math.floor((this.getMonth()+3)/3), 
	    "S"  : this.getMilliseconds()              
	  };   
	  if(/(y+)/.test(fmt))   
	    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
	  for(var k in o)   
	    if(new RegExp("("+ k +")").test(fmt))   
	  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
	  return fmt;   
	} 
	
	var index;
	$(document).ajaxStart(function(){
		index=layer.load();
	});
	$(document).ajaxStop(function(){
		layer.close(index);
	});
	</script>
