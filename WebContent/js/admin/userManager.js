//事件绑定
	$(function(){
	$("#roleFilterSelect").on("change",function(){
		$("#pageIndex").val(1);
		reset()
	});
	//新增用户的数据验证
	$("#addForm").validate({
		rules:{
			add_loginName:{
				required:true,
				isLoginname:true,
				remote:{//验证用户名重复
				    url: "list.html",     //后台处理程序
				    type: "post",               //数据发送方式
				    dataType: "json",           //接受数据格式   
				    data: {                     //要传递的数据
				        loginname: function() {
				            return $("#add_loginName").val();
				        },
				        type:"check"
				    }
				}
			},
			add_phone:{
				required:true,
				isPhone:true,
				remote:{//验证电话号码重复
				    url: "list.html",     //后台处理程序
				    type: "post",               //数据发送方式
				    dataType: "json",           //接受数据格式   
				    data: {                     //要传递的数据
				        phone: function() {
				            return $("#add_phone").val();
				        },
				        type:"check"
				    }
				}
			},
			add_userName:{
				required:true				
			},
			add_email:{
				isEmail:true
			}
		},
		messages:{
			add_loginName:{
				required:"请输入用户名",
				isLoginname:"6-12位中英文字符",
				maxlength:"字数过多",
				remote:"用户名已经存在！"
			},
			add_phone:{
				required:"请输入电话号码",
				maxlength:"字数过多",
				isPhone:"请输入正确号码",
				remote:"该号码已经存在"
			},
			add_userName:{
				required:"请输入真实名字",
				maxlength:"字数过多"
			},
			add_email:{
				maxlength:"字数过多",
				isEmail:"请输入正确email"
			}
		},
		errorPlacement: function(error, element) {  
   		 error.appendTo(element.parent().find("div.errorDiv"));  
		}
	});
	
	$(".addSubmit").on("click",function(){//提交添加
			if($("#addForm").valid()){//验证通过！
				var param={};
				param.operator="add";
				param.userName=$("#add_userName").val();
				if($("#add_roleArr").val()){
					param.rolesArrStr=$("#add_roleArr").val().join(",");
				}
				param.loginName=$("#add_loginName").val();
				param.phone=$("#add_phone").val();
				param.email=$("#add_email").val();
				param.wechatId=$("#add_wechatId").val();
				param.description=$("#description").val();
				$.post("saveOrUpdate.html",param,function(json){//发送数据
					if(json.status=="ok"){
						layer.msg("添加成功",{ icon: 1,time: 1000 },function(){
						reset();
						
					});
					}
				},"json");
			}
		});
	$(".updateSubmit").on("click",function(){//提交修改
		var param={};
		param.operator="update";
		param.userName=$("#edit_userName").val();
		if($("#edit_roleArr").val()){
			param.rolesArrStr=$("#edit_roleArr").val().join(",");
		}else{
			param.rolesArrStr="";
		}
		param.systemUserId=$("#edit_userId").val();
		param.email=$("#edit_email").val();
		param.loginname=$("#edit_loginName").val();
		param.phone=$("#edit_phone").val();
		param.description=$("#edit_description").val();
		param.status=$("#updateModal .userStatus:checked").val();
		param.wechatId=$("#edit_wechatId").val();
		$.post("saveOrUpdate.html",param,function(json){//发送数据
			if(json.status=="ok"){
				layer.msg("更新成功",{ icon: 1,time: 1000 },function(){
					reset();
					});
				}	
			},"json");
	
	});
});
	//切换状态
	$(".changeStatu").click(function(){
		var status=$(this).attr("status");
		var userId=$(this).attr("userId");
		var param={};
		param.systemUserId=userId;
		param.operator="update";
		var tip="";
		if(status=="2"){//激活操作
			param.status="1";
			tip="确认激活吗？";
		}else if(status=="1"){//冻结操作
			param.status="2";
			tip="确认冻结吗？";
		}else if(status=="0"){//删除操作
			param.status="0";
			tip="确认删除吗？";
		}
		layer.confirm(tip, {
			title:"状态切换",
		    btn: ["确定","返回"], //按钮
		    shade: false //不显示遮罩
		}, function(){
			$.post("saveOrUpdate.html",param,function(data){
			if(data.status=="ok"){
				layer.msg("更新成功",{ icon: 1,time: 1000 },function(){
					reset();
				});
			}else{
				layer.msg("更新失败");
			}
		},"json");
		
		}, function(){
			
		});
	});
	
	//重置密码 
	$(".reset").click(function(){
		var userId=$(this).attr("userId");
		var param={};
		param.systemUserId=userId;
		param.operator="reset";
		layer.confirm("确定重置密码吗？", {
			title:"密码重置",
		    btn: ["确定","返回"], //按钮
		    shade: false //不显示遮罩
		}, function(){
			$.post("saveOrUpdate.html",param,function(data){
			if(data.status=="ok"){
				layer.msg("密码成功重置为该用户的手机号码！",{ icon: 1,time: 1000 },function(){
					reset();
				});
			}else{
				layer.msg("重置失败");
			}
		},"json");
		
		}, function(){
			
		});
	});
	
	//增加
	$(".addUser").click(function(){		
		$("#addModal").modal("show");//展示modal
	});

	//修改
	$(".edit").click(function(){
		var userId=$(this).attr("userId");
	 	if(userId){
			$.post("list.html",{"userId":userId,"type":"get"},function(json){
						//修改框 数据初始化
					$("#edit_userName").val(json.data.userName);
					$("#edit_userId").val(json.data.systemUserId);
					$("#edit_loginName").val(json.data.loginname);
					$("#edit_phone").val(json.data.phone);
					$("#edit_email").val(json.data.email);
					$("#edit_description").val(json.data.description);
					$("#edit_wechatId").val(json.data.wechatId);
					if(json.data.status==1){//有效
						$("#updateModal #edit_open").click();
					}else if(json.data.status==2){//冻结
						$("#updateModal #edit_close").click();
					}
					$("#edit_roleArr option").removeAttr("selected");
					$("#edit_roleArr option").each(function(){
						var _this=this;
						$(json.data.rolesArr).each(function(){
							if(this.roleId==$(_this).val()){
								$(_this).attr("selected","selected");
							}
						});
					});
					
					$("#edit_roleArr").trigger("liszt:updated");
					$("#updateModal").modal("show");
				}
			,"json");		
		} 
	});
	
	//刷新页面
	function reset(){
		$("#myform").submit();
	}