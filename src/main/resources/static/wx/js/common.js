/**
 * 微信返回按钮
 */
$('.app_head_back').on('click', function(){
	history.back();
});
/**
 * 判断是否是微信客户端
 */
$(function(){
//    var ua = navigator.userAgent.toLowerCase();
//    var isWeixin = ua.indexOf('micromessenger') != -1;
//    var isAndroid = ua.indexOf('android') != -1;
//    var isIos = (ua.indexOf('iphone') != -1) || (ua.indexOf('ipad') != -1);
//    if (!isWeixin) {
//        document.head.innerHTML = '<title>抱歉，出错了</title><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0"><link rel="stylesheet" type="text/css" href="https://res.wx.qq.com/open/libs/weui/0.4.1/weui.css">';
//        document.body.innerHTML = '<div class="weui_msg"><div class="weui_icon_area"><i class="weui_icon_info weui_icon_msg"></i></div><div class="weui_text_area"><h4 class="weui_msg_title">请在微信客户端打开链接</h4></div></div>';
//    }	
});
/**
 * 公司下拉加载
 * @returns
 */
function loadSelectWorkCompany(id){
 	jQuery.axs("/webresources/wx/common/findWorkCompany",null, 
 		function(result){
			var html='';
			for(var i=0;i<result.data.length;i++){
				 var data=result.data[i];
				 html+='<option value="'+data.COMPANY_COD+'"><span style="font-size:14px;">'+data.COMPANY_NAM+'</span></option>';

			}
			$("#"+id).html(html);
			return html;
		}
 	);  
}
function loadSelectSbcCntrWorkCorp(id){
 	jQuery.axs("/webresources/wx/common/findCntrCorp",null, 
 		function(result){
			var html='<option value="%%">请选择箱公司</option>';
			for(var i=0;i<result.data.length;i++){
				 var data=result.data[i];
				 html+='<option value="'+data.CNTR_CORP_COD+'">'+data.CN_CNTR_CORP_NAM+'</option>';
			}
			$("#"+id).html(html);
			return html;
		}
 	);  
}
