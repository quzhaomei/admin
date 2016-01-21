/**
qzm write
by 2015-11-14
*/
$(function(){
	
	admin.initEmail($("input[rel='admin-email']"));
	//绑定分页
	$("#page[rel='admin-page'] li").click(function(){
		var index=$(this).attr("index");
		if(index){
			admin.toPage(index);
		}
	});
	//选择事件
	$("#page[rel='admin-page'] li #pageSelect").on("change",function(){
		var index=$("#pageSelect").val();
		admin.toPage(index);
	});
	
});
var admin={};
admin.toPage=function(pageIndex){
	if(pageIndex&&pageIndex.match(/^\d+$/)){
		$("form[rel='admin-form'] #pageIndex").val(pageIndex);
		
		$("form[rel='admin-form']").submit();
	}
}
//邮箱自动填充
admin.initEmail=function($email){
    var MailList = ["qq.com", "hotmail.com", "163.com", "yahoo.com"];
    $email.autocomplete({
        autoFocus: true,
        source: function (request, response) {
            var KeyValue = request.term,
                index = KeyValue.indexOf("@"),
                Address = KeyValue,
                host = "",
                result = [];

            result.push(KeyValue);
            if (index > -1) {
                Address = KeyValue.slice(0, index);
                host = KeyValue.slice(index + 1);
            }
            if (Address) {
                var findedHosts = (host ? $.grep(MailList, function (value) {
                    return value.indexOf(host) > -1;
                }) : MailList),
                findedResults = $.map(findedHosts, function (value) {
                    return Address + "@" + value;
                });
                result = result.concat($.makeArray(findedResults));
            }
            response(result);
        }
    });
}
//扩展jquery.validate
$.validator.addMethod("isLoginname", function(value, element) {   
  	 var name = /^[\d\w]{6,12}$/;
  	 return this.optional(element) || (name.test(value));
	});
	$.validator.addMethod("isPhone", function(value, element) {   
  	 var tel = /^1[3|4|5|8][0-9]\d{4,8}$/;
  	 return this.optional(element) || (tel.test(value)&&value.length==11);
	});
	$.validator.addMethod("isEmail", function(value, element) {   
  	 var email = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/ ;
  	 return this.optional(element) || (email.test(value));
	});