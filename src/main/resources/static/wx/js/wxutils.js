/**
 * 取url中的参数 url=www.baidu.com?id=1 用法：getUrlParams("id")的值是1
 * 
 * @param {type}
 *            name
 * @returns {unresolved}
 */
function getUrlParams(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);
	if (r !== null)
		return decodeURI(r[2]);
	return null;
}

/**
 * 给url增加参数配置时间戳、锚；记住浏览器状态
 * @param url
 * @returns
 */
function loadIFrame(url){
　　token = new Date().getTime();
    if(url.indexOf("?")==-1){
        url+="?timestamp="+getMillisecond()+"#";
    }else{
        url+="&timestamp="+getMillisecond()+"#";
    }
    return url;
}
function loadPage(){
	
}
/**
 * 判断是否null
 * 
 * @param data
 */
function isNull(data) {
	return (data == "" || data == undefined || data == null) ? "" : data;
}
function numberFixed(number,fix) {
	if(number == undefined || number == null){
		return '';
	}
	return number.toFixed(fix);
}
/*
 * formatNum(s,type) 功能：数字显示千分位
 */
function formatNum(str) {
	if (str == "" || str == undefined || str == null) {
		return "";
	} else {
		str=str+"";
		var newStr = "";
		var count = 0;
		if (str.indexOf(".") == -1) {
			for (var i = str.length - 1; i >= 0; i--) {
				if (count % 3 == 0 && count != 0) {
					newStr = str.charAt(i) + "," + newStr;
				} else {
					newStr = str.charAt(i) + newStr;
				}
				count++;
			}
			return newStr;
		} else {
			for (var i = str.indexOf(".") - 1; i >= 0; i--) {
				if (count % 3 == 0 && count != 0) {
					newStr = str.charAt(i) + "," + newStr;
				} else {
					newStr = str.charAt(i) + newStr; // 逐个字符相接起来
				}
				count++;
			}
			return newStr + (str + "00").substr((str + "00").indexOf("."), 3);
		}
	}
}

/**
 * 当前月份
 * @returns
 */
function getNowMonth(){
	var now = new Date() ;	
	var nowYear = now.getFullYear() ; //年
	var nowMonth = now.getMonth()+1<10?"0"+(now.getMonth()+1):(now.getMonth()+1) ; //月
	return nowYear+"-"+nowMonth;
}
/**
 * 当前时间
 * @returns
 */
function getNowDay(){
	var now = new Date() ;	
	var nowYear = now.getFullYear() ; //年
	var nowMonth = now.getMonth()+1<10?"0"+(now.getMonth()+1):(now.getMonth()+1) ; //月
	var nowDay = (now.getDate()<10)?"0"+(now.getDate()):(now.getDate());
	return nowYear+"-"+nowMonth+"-"+nowDay;
}
/*
* 获取上一个月 
* 
* @date 格式为yyyy-mm-dd的日期，如：2014-01-25 
*/  
function getPreMonth() {  
   var now = new Date() ;	
   var pre =new Date(now.setMonth(now.getMonth() - 1));
   var preYear = pre.getFullYear() ; //年
   var preMonth = pre.getMonth()+1<10?"0"+(pre.getMonth()+1):(pre.getMonth()+1) ; //月
   return preYear+"-"+preMonth;
}  

function getMillisecond(){
	 var now= new Date() ;
	 var millisecond=now.getTime();
	 return millisecond;
}