	<script src="../js/jquery-1.9.1.min.js"></script>
	<script src="../js/jquery-migrate-1.0.0.min.js"></script>
	<script src="../js/jquery-ui-1.10.0.custom.min.js"></script>
	<script src="../js/jquery.validate.min.js"></script>
	<script src="../js/jquery.ui.touch-punch.js"></script>
	<script src="../js/modernizr.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	<script src="../js/jquery.cookie.js"></script>
	<script src="../js/jquery.chosen.min.js"></script>
	<script src="../js/jquery.cleditor.min.js"></script>
	<script src='../js/jquery.dataTables.min.js'></script>
	<script src="../js/jquery.iphone.toggle.js"></script>
	<script src="../js/jquery.uploadify-3.1.min.js"></script>
	<script src="../js/jquery.uniform.min.js"></script>
	<script src="../js/jquery.gritter.min.js"></script><!-- 消息弹出的插件 -->
	<script src="../js/jquery.imagesloaded.js"></script><!-- 判断图片是否成功加载的插件 -->
	<script src="../js/jquery.masonry.min.js"></script>
	<script src="../js/layer/layer.js"></script>
	
	
	
	<script src="../js/custom.js"></script>
	<script>
	Date.prototype.Format = function(fmt)   
	{ //author: meizz   
	  var o = {   
	    "M+" : this.getMonth()+1,                 //月份   
	    "d+" : this.getDate(),                    //日   
	    "h+" : this.getHours(),                   //小时   
	    "m+" : this.getMinutes(),                 //分   
	    "s+" : this.getSeconds(),                 //秒   
	    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
	    "S"  : this.getMilliseconds()             //毫秒   
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
