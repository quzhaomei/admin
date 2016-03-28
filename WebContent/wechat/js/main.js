// 默认银行卡更换成功后调用该方法
function changeCard(){
		$('.bankcard .default').removeClass('default');
		$(cardid).addClass('default');
}



// 提交信息及返回处理结果后调用该方法，
// status分别对应三种状态：submitting：提交中 ／ success: 操作成功 ／ error: 操作失败
// msg为提示信息，置空则提示三个状态的默认信息）
function showProgress(status,msg) {
	var progresslayer = $(".popup:not('.offstage') .progress");
	var progresstext = '';

	if(msg != '') {
		progresstext = msg;
	} else {
		switch(status)
		{
			case 'submitting':
			  	progresstext = "更新中...";
			  break;
			case 'success':
				progresstext = "操作成功";
			  break;
			case 'error':
				progresstext = "提交出错，请稍后再试";
			  break;
			default:
			  progresstext = "提交出错，请稍后再试";
			  	
		}
	}

	progresslayer.addClass('shown').children('.'+status).removeClass('hide').attr('id',status).siblings('div').attr('id','').addClass('hide');
	progresslayer.children('.progresstext').html(progresstext);
	if(status != 'submitting') {
		setTimeout(function() {
		  	 closePopup();
		}, 2200);
	}	
}


// 需要关闭弹出窗口，可调用该方法，在提示窗口状态下不必调用
function closePopup() {
		var currentpopup = $(".popup:not('.offstage')");
		var progresslayer = $(currentpopup).children('.progress');
		currentpopup.addClass('offstage');
		progresslayer.removeClass('shown').children('div').addClass('hide').attr('id','');
		progresslayer.children('.progresstext').html('');
		$('.overlay').addClass('hide');
}



function showAjaxWaiting() {
	if(!$(".olay_trans")[0]){//初始化
		$("body").append([
				'<div class="popup waiting offstage">',
				'<div class="hide" id="submitting">',
					
				'</div>',

				'</div>',

				'<div class="olay_trans overlay hide">',

				'</div>'].join("")
		);
	}
	var overlay = $(".olay_trans");
	var icon = $(".popup.waiting");
	icon.find('#submitting').removeClass('hide');
	icon.removeClass('offstage');
	overlay.removeClass('hide');
}

function closeAjaxWaiting() {
	var overlay = $(".olay_trans");
	var icon = $(".popup.waiting");
	icon.find('#submitting').addClass('hide');
	icon.addClass('offstage');
	overlay.addClass('hide');
}




$(document).ready(function() {
	$('.tabs').on('click', "li:not('.active')", function() {
		var target = $(this).attr("class");
		$('.tabs .active').removeClass('active');
		$(this).addClass('active');
		$('.tabcontents .active').removeClass('active');
		$('.tabcontents #'+target).addClass('active');
	});



$('.callpopup').on('click', '', function(event) {
	var target = $(this).data('target'),
	 	popup = $(target),
		overlay = $('.overlay');
	popup.removeClass('offstage').find('.close').one('click', closePopup);
	overlay.removeClass('hide');
});

$('#navbttn').on('click', '', function(event) {
	event.preventDefault();
	$(this).toggleClass('closemenu');
	$('#megamenu').toggleClass('shown');
	$('.olay_dark').toggleClass('hide');
});

var ajax_time_task
$(document).ajaxStart(function(){
		ajax_time_task=setTimeout(function(){
			showAjaxWaiting();
		}, 500);
	}).ajaxStop(function(){
		if(ajax_time_task){
			clearTimeout(ajax_time_task);
		}
			closeAjaxWaiting();
	});
	
});
