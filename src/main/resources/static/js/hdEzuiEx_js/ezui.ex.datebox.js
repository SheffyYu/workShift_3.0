/* 
 * Copyright (C) 2016 HuaDong CO.,LTD.
 * Author:jason <caiyj@huadong.net>
 */

$.extend($.fn.datebox.methods, {
	/**
	 * 设置时间戳。
	 * 
	 * @function
	 * @param string
	 *            ts 时间戳。
	 * @name datebox#setTsValue
	 */
	setTsValue : function(jq, ts) {
		return jq.each(function() {
			// TODO 需要撰写国际化格式。
			$(this).datebox("setValue", new Date(ts).format("yyyy-MM-dd"));
		});
	},
	/**
	 * 获取时间戳。
	 * 
	 * @function
	 * @name datebox#getTsValue
	 */
	getTsValue : function(jq) {
		var ret = -1;
		jq.each(function() {
			ret = new Date($(this).datebox("getValue")).getTime();
		});
		return ret;
	}
});