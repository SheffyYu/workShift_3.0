/* 
 * Copyright (C) 2016 HuaDong CO.,LTD.
 * Author:jason <caiyj@huadong.net>
 */

$.extend($.fn.datetimebox.methods, {
	/**
	 * 设置时间戳。
	 * 
	 * @function
	 * @param string ts 时间戳。
	 * @name datetimebox#setTsValue
	 */
	setTsValue : function(jq, ts) {
		return jq.each(function() {
			// TODO 需要撰写国际化格式。
			$(this).datetimebox("setValue", new Date(ts).format("yyyy-MM-dd hh:mm:ss"));
		});
	},
	/**
	 * 获取时间戳。
	 * 
	 * @function
	 * @name datetimebox#getTsValue
	 */
	getTsValue : function(jq) {
		var ret = -1;
		jq.each(function() {
			ret = new Date($(this).datetimebox("getValue")).getTime();
		});
		return ret;
	}
});