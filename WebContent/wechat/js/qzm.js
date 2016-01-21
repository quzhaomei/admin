(function(){

var index;
	$(document).ajaxStart(function(){
		index=layer.load();
	});
	$(document).ajaxStop(function(){
		layer.close(index);
	});
})();