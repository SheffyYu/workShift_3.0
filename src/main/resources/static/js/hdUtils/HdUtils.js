
/**
 * 将sysCode初始化，取到缓存数据
 * @param {type} params
 * @returns Array
 * @author zhangdh
 */
Array.prototype.query = function(params) {
	  if(HdUtils.global.scode.length==0) {
		  HdUtils.global.flushScode(params.fieldCod);
	  } else {
		  for (var i=HdUtils.global.scode.length-1;i>=0;i--) {
			 if(HdUtils.global.scode[i].fieldCod == params.fieldCod) {
				 break;
			 } else if(i==0&&HdUtils.global.scode[i].fieldCod != params.fieldCod){
				 HdUtils.global.flushScode(params.fieldCod);
			 }
		  }
	  }
	  var center = HdUtils.global.scode;
	  var center2 = eval(center);
	  HdUtils.global.scode = center2;
	  if (params==null||params==undefined) return [];
	  var result = [];
	  for (var i=0;i<HdUtils.global.scode.length;i++) {
	    result.push(HdUtils.global.scode[i]);
	  }
	  for (var n in params) {
	    result = result.query1(n, params[n]);
	  } 
      return result;
};


/**
 * 将sysCode初始化，取到缓存数据-专用MAP
 * @param {type} params
 * @returns Array
 * @author zhangdh
 */
Array.prototype.queryMap = function(params) {
	  if(HdUtils.global.scode.length==0) {
		  HdUtils.global.mapScode(params.fieldCod);
	  } else {
		  for (var i=HdUtils.global.scode.length-1;i>=0;i--) {
			 if(HdUtils.global.scode[i].fieldCod == params.fieldCod) {
				 break;
			 } else if(i==0&&HdUtils.global.scode[i].fieldCod != params.fieldCod){
				 HdUtils.global.mapScode(params.fieldCod);
			 }
		  }
	  }
	  var center = HdUtils.global.scode;
	  var center2 = eval(center);
	  HdUtils.global.scode = center2;
	  if (params==null||params==undefined) return [];
	  var result = [];
	  for (var i=0;i<HdUtils.global.scode.length;i++) {
	    result.push(HdUtils.global.scode[i]);
	  }
	  for (var n in params) {
	    result = result.query1(n, params[n]);
	  } 
    return result;
};
/**
 * 通过数组中每一个对象的某些属性及值过滤对象
 * @param {type} params
 * @returns Array
 * @author zhangdh
 */
Array.prototype.query2 = function(params) {
	  if (params==null||params==undefined) return [];
	  var result = [];
	  for (var i=0;i<this.length;i++) {
	    result.push(this[i]);
	  }
	  for (var n in params) {
	    result = result.query1(n, params[n]);
	  } 
      return result;
};
/**
 * 通过数组中每一个对象的某个属性及值过滤对象
 * @param {type} name
 * @param {type} value
 * @returns Array
 * @author zhangdh
 */
Array.prototype.query1 = function(name, value) {
  if (name==null||value==null) return [];
  var result = [];
  for(var i = 0; i < this.length; i++){
    var data = this[i];
    if (data[name]&&data[name]==value) {
      result.push(data);
    }
  }
  return result;
};
/* 
 * Copyright (C) 2013-2014 HUADONG CO.,LTD.
 * Author:jason <caiyj@huadong.net>
 */
/**
 * @fileOverview 常用工具类文件。
 */
/**
 * @class
 * @static
 * @description 静态工具类。
 * @author jason <caiyj@huadong.net>
 */
function HdUtils() {


}

/**
 * @namespace 全局变量
 * @memberOf HdUtils#
 */
HdUtils.global = {};
/**
 * 通用配置属性
 */
HdUtils.global.config={};
//地图内网地址：
//HdUtils.global.config.geoIp ="http://10.197.32.164:8080/geoserver"; 
//地图外网地址：
//HdUtils.global.config.geoIp ="http://113.108.190.168:8004/geoserver"; 
//HdUtils.global.config.geoIp ="http://192.168.1.200:8004/geoserver"; 
//HdUtils.global.config.geoIp ="http://geo.gzport.com/geoserver"; 

//地图地址：
HdUtils.global.config.geoIp=function ()
{
	var hostUrl=window.location.hostname;
	var pamUrl=hostUrl.split(".");
	//内外网判断
	if(pamUrl&&pamUrl[0])
	{
		//外网
		if(pamUrl[0]=="inner"){
			return "http://geo.gzport.com/geoserver"; //地图		
		}else{
			return "http://10.197.32.164:8080/geoserver"; //地图
		}
	}
	//return "http://113.108.190.168:8004/geoserver"; 
}

//流媒体服务器
HdUtils.global.config.fmpegRtspIp="rtsp://192.168.1.9:554/";
HdUtils.global.config.fmpegRtmpIp="rtmp://localhost:1935/";

//报表外网地址：

////报表外网地址：
//HdUtils.global.config.ip = "http://report.gzport.com";
//HdUtils.global.config.pdfIp = HdUtils.global.config.ip+"/pdf/viewer.html";//报表pdf展示
//HdUtils.global.config.htmlIp = HdUtils.global.config.ip+"/report/html";//报表html展示
//HdUtils.global.config.chartsIp = HdUtils.global.config.ip+"/report/htmlimg";//图表html展示
//HdUtils.global.config.excelIp = HdUtils.global.config.ip+"/report/excel";//报表excel导出

//测试库
//HdUtils.global.config.ip = "http://113.108.190.168";
//HdUtils.global.config.pdfIp = HdUtils.global.config.ip+":8007/pdf/viewer.html";//报表pdf展示
//HdUtils.global.config.htmlIp = HdUtils.global.config.ip+":8007/report/html";//报表html展示
//HdUtils.global.config.chartsIp = HdUtils.global.config.ip+":8007/report/htmlimg";//图表html展示
//HdUtils.global.config.excelIp = HdUtils.global.config.ip+":8007/report/excel";//报表excel导出
//HdUtils.global.config.jtgIp = HdUtils.global.config.ip+":8003/jtgbb/";//交统港报表展示

////报表内网地址：
//HdUtils.global.config.ip = "http://10.197.32.165";
//HdUtils.global.config.pdfIp = HdUtils.global.config.ip+":8080/pdf/viewer.html";//报表pdf展示
//HdUtils.global.config.htmlIp = HdUtils.global.config.ip+":8080/report/html";//报表html展示
//HdUtils.global.config.chartsIp = HdUtils.global.config.ip+":8080/report/htmlimg";//图表html展示
//HdUtils.global.config.excelIp = HdUtils.global.config.ip+":8080/report/excel";//报表excel导出
//HdUtils.global.config.jtgIp = HdUtils.global.config.ip+":8080/jtgbb/";//交统港报表展示

//报表地址：正式库 请不要随便修改
HdUtils.global.config.ip =function()
{
	var hostUrl=window.location.hostname;
	var pamUrl=hostUrl.split(".");
	//内外网判断
	if(pamUrl&&pamUrl[0])
	{
		//外网
		if(pamUrl[0]=="inner"){
			return "http://report.gzport.com"; //报表	
		}else{
			return "http://10.197.32.165:8080"; //报表
		}
	}
}
HdUtils.global.config.pdfIp = HdUtils.global.config.ip()+"/pdf/viewer.html";//报表pdf展示
HdUtils.global.config.htmlIp = HdUtils.global.config.ip()+"/report/html";//报表html展示
HdUtils.global.config.chartsIp = HdUtils.global.config.ip()+"/report/htmlimg";//图表html展示
HdUtils.global.config.excelIp = HdUtils.global.config.ip()+"/report/excel";//报表excel导出


HdUtils.global.config.account = function(){
	 var account;
	  $.ajax({
	    method: "GET",
	    url: '/login/PrivilegeController/getLoginAccount?t=11&s=' +Math.random(),
	    dataType: "json",
	    async: false,
	    contentType: "application/json",
	    success: function (data) {
	    	account = data.account;
	    }
	 });
	return account;
}

HdUtils.global.config.username = function(){
	 var username;
	  $.ajax({
	    method: "GET",
	    url: '/login/PrivilegeController/getLoginAccount?t=11&s=' +Math.random(),
	    dataType: "json",
	    async: false,
	    contentType: "application/json",
	    success: function (data) {
	    	username = data.name;
	    }
	 });
	return username;
}

HdUtils.global.config.companyNam = function(){
	 var companyNam;
	  $.ajax({
	    method: "GET",
	    url: '/login/PrivilegeController/getLoginAccount?t=11&s=' +Math.random(),
	    dataType: "json",
	    async: false,
	    contentType: "application/json",
	    success: function (data) {
	    	companyNam = data.companyNam;
	    }
	 });
	return companyNam;
}
HdUtils.global.config.companyCod = function(){
	 var companyNam;
	  $.ajax({
	    method: "GET",
	    url: '/login/PrivilegeController/getLoginAccount?t=11&s=' +Math.random(),
	    dataType: "json",
	    async: false,
	    contentType: "application/json",
	    success: function (data) {
	    	companyCod = data.companyCod;
	    	
	    }
	 });
	return companyCod;
}
HdUtils.global.config.token = function(account){
	 var token;
	  $.ajax({
	    method: "GET",
	    url: '/login/PrivilegeController/getLoginToken?name='+account,
	    dataType: "json",
	    async: false,
	    contentType: "application/json",
	    success: function (data) {
	    	token = data.token;
	    }
	 });
	return token;
	 }
/**
 * @namespace code
 * @memberOf HdUtils#
 */
HdUtils.code = {};

/**
 * 系统代码编辑控件data-options
 * @param {type} params 系统代码过滤条件
 * @param {type} options 控件自定义options
 * @returns data-options
 */
HdUtils.global.scode = [];
HdUtils.global.flushScode = function (params) {
  var scode;
  $.ajax({
    method: "POST",
    url: '/webresources/login/SysCode/findAll?fieldCod=' + params,
    dataType: "text",
    async: false,
    contentType: "application/json",
    success: function (data) {
    	scode = data;
    }
  });
  var betweenScode = scode;
  var scodeNew = eval(betweenScode);
  var scodeOld = [];
  for(var i=0;i<HdUtils.global.scode.length;i++) {
	  scodeNew.push(HdUtils.global.scode[i]);
  }
  HdUtils.global.scode = scodeNew;
};

HdUtils.global.mapScode = function (params) {
	  var scode;
	  $.ajax({
	    method: "POST",
	    url: '/webresources/login/SysCode/findAll?fieldCod=' + params,
	    dataType: "text",
	    async: false,
	    contentType: "application/json",
	    success: function (data) {
	    	scode = data;
	    }
	  });
	  var betweenScode = scode;
	  var scodeNew = eval(betweenScode);
	  var scodeOld = [];
	  for(var i=0;i<HdUtils.global.scode.length;i++) {
		  scodeNew.push(HdUtils.global.scode[i]);
	  }
	  HdUtils.global.scode = scodeNew;
};

HdUtils.code.scode = function (params, options, addNull) {
  if(HdUtils.global.scode.length==0) {
	  HdUtils.global.flushScode(params.fieldCod);
  } else {
	  for (var i=HdUtils.global.scode.length-1;i>=0;i--) {
		 if(HdUtils.global.scode[i].fieldCod == params.fieldCod) {
			 break;
		 } else if(i==0&&HdUtils.global.scode[i].fieldCod != params.fieldCod){
			 HdUtils.global.flushScode(params.fieldCod);
		 }
	  }
  }
  var scode1 = HdUtils.global.scode;
  var scode2 = eval(scode1);
  HdUtils.global.scode = scode2;
  var data = null;
  var dArr = scode2.query2(params);
  if (addNull === true) {
    data = [{name: '-', code: ''}];
    for (var i = 0; i < dArr.length; i++) {
      data.push(dArr[i]);
    }
  } else {
    data = dArr;
  }
  var ret = {
		  textField:'name',
	        valueField:'code',
	        data : data,
	        panelWidth:100,
	        editable:false,
	        panelHeight:'auto'
  };
  $.extend(ret, options);
  return ret;
};

/**
 * 代码表基础数据。
 * @memberOf HdUtils#code
 * @param {object} params ezui combogrid参数。
 * @returns {object} 返回ezui combogrid参数。
 */
HdUtils.code.base = function(params) {
    var ret = {};
    var valueField = "";
    var textField = "";
    var i = 0;
    if (params != undefined && params.fieldMapping != undefined) {
        $.each(params.fieldMapping, function(idx, val) {
            if (i == 0) {
                valueField = val;
            }
            if (i == 1) {
                textField = val;
            }
            i += 1;
        });
    }
    /*params.fieldMapping 只有一个值时textField会被赋为空字符串,因此手动赋值textField.实现显示与保存同一字段*/
    if(textField==null||textField==""||textField==undefined){
    	textField=valueField;
    }
    ret.mapping = params.parentId ? {
        parent: params.parentId,
        fields: params.fieldMapping
    } : null;

  //update by huxj 2016-10-17 为了兼容idev7 去掉andItems 以及自动添加queryColumns
    if (params != undefined && params.queryParams != undefined) {
   	 params.queryParams.queryColumns = params.filterColumns ? params.filterColumns : valueField + "," + textField;
    };
    ret.queryParams = (params && params.queryParams) ? params.queryParams : 
            {
                queryColumns: params.filterColumns ? params.filterColumns : valueField + "," + textField,
                hdConditions: params.hdConditions ? params.hdConditions : {}
            };
   // ret.queryParams = queryParams;
    ret.required = "false";
    ret.idField = valueField;
    ret.valueField = valueField;
    ret.textField = textField;
    ret.sortName = valueField;
    ret.remoteSort = "false";
    ret.sortOrder = "asc";
    ret.mode = "remote";
    ret.pagination = true;
    ret.pageSize = "20";
    ret.method = "POST";
    ret.fitColumns = "true";
    //ret.filterColumns = valueField + "," + textField;
    ret.striped = "true";
    ret.width = "120";
    ret.singleSelect = "true";
    ret.panelWidth = params.pagination ? 500 : 250;
    //是否校验，默认为true(校验)
    ret.isValid = params.isValid === undefined ? true : params.isValid;
    
    if(ret.isValid){
        ret.onHidePanel = function() {
            var isPaging = $(this).combogrid('options').pagination;

            var selections = $(this).combogrid('grid').datagrid('getSelections');  //得到当前值

            if($(this).combogrid('options').parentId){
            	var parentDataGrad=$(this).combogrid('options').parentId;            	
            	if(parentDataGrad!=null&&parentDataGrad!="")
            	{
            		var sValueField=$(this).combogrid('options').valueField;
            		var sTextField=$(this).combogrid('options').textField;
            		var editRow=$(parentDataGrad).datagrid("getSelected");
            		editRow[sValueField] =selections[0][sValueField];
            		editRow[sTextField]=selections[0][sTextField];
            	}
            }
            if (selections == null || selections.length == 0) { //没有对应行
                if(!isPaging){
                    $(this).combogrid('clear');
                    return ;
                }else{
                    var _this = $(this);
                    var value = _this.combogrid('getValue');
                    var valueField = _this.combogrid('options').idField;
                    if(value !== ''){
                        var opts = _this.combogrid('grid').datagrid("options");
                        var params = new HdEzuiQueryParamsBuilder();
                        params.setHdEzuiQueryParams($.extend(true, {}, opts.queryParams));
                        params.setAndClause(valueField, value, '=' , 'and');
                        
                        $.ajax({type: "get", url: opts.url, data: params.buildGet(), dataType: "json",
                            contentType: "application/json",
                            success: function(data) {
                                if(data.total <= 0){  //非法数据（后台也查不到）清空
                                    _this.combogrid('clear');
                                }else{ //合法数据，但不再当页，插入一行(以便不再显示代码。多的行不会产生影响，用户如果编辑过滤有得到原始数据）
                                    var grid = _this.combogrid('grid');
                                    _this.combogrid('setValue', data.rows[0][valueField]); 
                                    _this.combogrid('setText', data.rows[0][textField]);
                                    if(grid.datagrid('getRows').length == grid.datagrid('options').pageSize){
                                        grid.datagrid('appendRow', data.rows[0]);
                                    }
                                }
                            },
                            error: function() {}
                        });
                    }
                }
            }
        };
    }
    /**
     * insertRows 为要插入的列[{},{}]
     */
    if (params.insertRows) {
        ret.onLoadSuccess = function(data) {
            for (var i = 0; i < params.insertRows.length; i++) {
                $(this).combogrid("grid").datagrid("insertRow", {index: i, row: params.insertRows[i]});
                $(this).combogrid("grid").datagrid("selectRow", 0);
            }
        };
    }
    if (params.multiple && params.columns) {
        _columns = [[{checkbox: true}]];
        params.columns[0] = _columns[0].concat(params.columns[0]);
//                    console.log(params.columns);
    }
    // from 处理方法：parendId = formId, fieldMapping = input name
//    if (params.isForm) {
//        params.parentId
//    }
    // 是否有必要删除datagrid不支持的参数？
    $.extend(ret, params);
    return ret;
};

/**
 * @namespace messager
 * @memberOf HdUtils#
 */
HdUtils.messager = {};
/**
 * 右下角弹出窗口消息。
 * @param {string} msg 消息体。
 * @param {string} title 消息标题。
 * @param {string} timeout 窗口多少毫秒消失。
 * @param {string} showType 显示类型：slide默认。
 * @returns {undefined}
 * @memberOf HdUtils#messager
 */
HdUtils.messager.bottomRight = function(msg, title, timeout, showType) {
    $.messager.show({
        title: title ? title : '提示消息',
        msg: msg,
        timeout: timeout ? timeout : 2000,
        showType: showType ? showType : 'slide',
        height: 150
    });
};
/**
 * 状态栏消息。
 * @param {string} msg 消息
 * @returns {undefined}
 * @memberOf HdUtils#messager
 */
HdUtils.messager.status = function(msg) {
    $('#mainBody').layout('panel', 'south').panel({title: msg});
};
/**
 * 标准窗口提示。
 * @param {string} data 标准消息体。
 * @param {string} callback 回调函数。
 * @returns {undefined}
 * @memberOf HdUtils#messager
 */
HdUtils.messager.show = function(data, callback) {
    if (data) {
        if (data.code && data.code.charAt(3) === '1') {
            // success
           // this.bottomRight(data.message,"["+HdUtils.ezui.getCurrTabName()+"]");
        	this.bottomRight(data.message,'提示');
//            this.status(data.message);
            if ($.isFunction(callback)) {
                callback();
            }
        } else if( data.code&&data.message) {
            // error
            var msg = "";
            msg += "代码：" + data.code + "<br />";
            msg += "信息：" + data.message + "<br />";
            if (data.detail) {
                var content = data.detail.replace(/\"/g, "").replace(/\'/g, "");
                msg += "详细：" + "<span title=\"" + content + "\" onClick=\"alert(\'" + content.replace(/\n/g, "\\n") + "\')\">点击查看</span>"
            }
            $.messager.alert("返回信息", msg, "info");
            
            if ($.isFunction(callback)) {
                callback();
            }
        }else
        {
        	$.messager.alert("返回信息", "系统内部问题", "info");
        }
    } else {
        $.messager.alert("返回信息", "无消息！", "info");
    }

};
/**
 * 普通串口提示。
 * @param {string} msg 消息体。
 * @returns {undefined}
 * @memberOf HdUtils#messager
 */
HdUtils.messager.info = function(msg) {
    $.messager.alert("提示", msg, "info");
};

/**
 * 跑马灯显示。
 * @param {string} msg 跑马灯消息。
 * @returns {undefined}
 */
HdUtils.messager.marquee = function(msg) {
    $('#mainMarquee').html("<marquee scrollamount='3'>" + msg + "</marquee>");
};

/**
 * @namespace formatter
 * @memberOf HdUtils#
 */
HdUtils.formatter = {};
/**
 * 数字通用格式化。
 * @param {type} value
 * @param {type} precision
 * @returns {String}
 * @memberOf HdUtils#formatter
 */
HdUtils.formatter.precisionCommon = function(value, precision) {
    if (value==null||value==undefined) {
        return "";
    } 
    var v = parseFloat(value).toFixed(parseInt(precision)).split(".");
    var ret = v[0].replace(/\d+?(?=(?:\d{3})+$)/img, "$&,");
    if (v.length > 1) {
        ret += "." + v[1];
    }
    return ret;
};
/**
 * 数字通用格式化。
 * @param {type} value
 * @returns {String}
 * @memberOf HdUtils#formatter
 */
HdUtils.formatter.date = function(value) {
	return value ? new Date(value).format('yyyy-MM-dd') : '';
}
/**
 * 数字通用格式化。
 * @param {type} value
 * @returns {String}
 * @memberOf HdUtils#formatter
 */
HdUtils.formatter.datetime = function(value) {
	return value ? new Date(value).format('yyyy-MM-dd hh:mm:ss') : '';
}

/**
 * @namespace dialog
 * @memberOf HdUtils#
 */
HdUtils.dialog = {};
HdUtils.dialog2 = {};
HdUtils.dialog3 = {};
HdUtils.dialog4 = {};
/**
 * 显示对话框。
 * @param {object} params 例：{title:标题,href:module/内容.html,width:800,height:500}
 * @returns {undefined}
 * @memberOf HdUtils#dialog
 */
HdUtils.dialog.closeHanlder="";
//这个方法做了一些操作、然后调用回调函数    
function doDialogCloseCallback(fn,args)    
{    
    fn.apply(this, args);  
}
HdUtils.dialog.show = function(params) {
	
    var _def = {
        title: "标题", // 标题
        width: 800,
        height: 500,
        closed: false,
        cache: false,
        resizable: true,
        modal: true,
        // 关闭窗口的时候，unbind键。
        onClose: function() {
            $(document).unbind("keyup");          
        	if(HdUtils.dialog.closeHanlder!="")
        	{
        		doDialogCloseCallback(eval(HdUtils.dialog.closeHanlder),[]); 
        		HdUtils.dialog.closeHanlder="";
        	}
        }
    }; 
    var str = "?";

    if (params != undefined && params.href != undefined && params.href.indexOf("?") >= 0) {
        str = "&";
    }
    params.href = params.href + str + "timestamp=" + new Date().getTime();
    if (params.global != undefined) {
        params.hdGlobal = params.global;
    }
    if(params.openWithIframe) {
        params.content = '<iframe scrolling="no" frameborder="0"  src="'+encodeURI(params.href)+'" style="width:100%;height:100%;"></iframe>';
        delete params.href;
    }
    $.extend(_def, params);
    if (params.callback != undefined) {
        _def.buttons = [{
                text: '确认',
                iconCls: 'icon-ok',
                handler: function() {
                    // 回掉函数
                    if (params.callback != undefined) {
                        var data = $("#mainDlgDatagrid").datagrid("getSelections");
                        if (data.length == 0) {
                            $.hd.ezui.messager.info("请选择一条数据！");
                        } else {
                            params.callback(data);
                            $("#mainDlg").dialog("options").callback = null;
                            $("#mainDlg").dialog("close");
                        }
                    } else {
                        $("#mainDlg").dialog("close");
                    }
                }
            }, {
                text: '取消',
                iconCls: "icon-cancel",
                handler: function() {
                    $("#mainDlg").dialog("close");
                }
            }];
    } else if (params.isSaveHandler) {
        _def.buttons = [{
                text: '保存',
                iconCls: 'icon-ok',
                handler: function() {
                    HdUtils.dialog.getValue("saveHandler")();
//                                $.hd.ezui.dialog.saveHandler = undefined;
                }
            }, {
                text: '关闭',
                iconCls: "icon-cancel",
                handler: function() {
//                                $.hd.ezui.dialog.formHandler = undefined;
                    //$("#mainDlg").dialog("close");//.hd.ezui.dialog.close();
                    HdUtils.dialog.close();
                }
            }];
    } else if (params.isShowExitBtn) {
        _def.buttons = [{
                text: '关闭',
                iconCls: "icon-cancel",
                handler: function() {
                	HdUtils.dialog.close();
                    //$("#mainDlg").dialog("close");
                }}];
    }
    // 绑定enter,esc键。
    $(document).bind("keyup", function(event) {
        if (event.which == 27) {
            $("#mainDlg").dialog("options").callback = undefined;
            $("#mainDlg").dialog("close");
        }

    });
    $("#mainDlg").dialog(_def);
};
/**
 * 显示对话框。
 * @param {object} params 例：{title:标题,href:module/内容.html,width:800,height:500}
 * @returns {undefined}
 * @memberOf HdUtils#dialog
 */
HdUtils.dialog2.show = function(params) {
    var _def = {
        title: "标题", // 标题
        width: 800,
        height: 500,
        closed: false,
        cache: false,
        resizable: true,
        modal: true,
        // 关闭窗口的时候，unbind键。
        onClose: function() {
            $(document).unbind("keyup");
        }
    };
    var str = "?";

    if (params != undefined && params.href != undefined && params.href.indexOf("?") >= 0) {
        str = "&";
    }
    params.href = params.href + str + "timestamp=" + new Date().getTime();
    if (params.global != undefined) {
        params.hdGlobal = params.global;
    }
    if (params.openWithIframe) {
        params.content = '<iframe scrolling="no" frameborder="0"  src="' + encodeURI(params.href) + '" style="width:100%;height:100%;"></iframe>';
        delete params.href;
    }
    $.extend(_def, params);
    if (params.callback != undefined) {
        _def.buttons = [{
                text: '确认',
                iconCls: 'icon-ok',
                handler: function() {
                    // 回掉函数
                    if (params.callback != undefined) {
                        var data = $("#mainDlgDatagrid").datagrid("getSelections");
                        if (data.length == 0) {
                            $.hd.ezui.messager.info("请选择一条数据！");
                        } else {
                            params.callback(data);
                            $("#mainDlg2").dialog("options").callback = null;
                            $("#mainDlg2").dialog("close");
                        }
                    } else {
                        $("#mainDlg2").dialog("close");
                    }
                }
            }, {
                text: '取消',
                iconCls: "icon-cancel",
                handler: function() {
                    $("#mainDlg2").dialog("close");
                }
            }];
    } else if (params.isSaveHandler) {
        _def.buttons = [{
                text: '保存',
                iconCls: 'icon-ok',
                handler: function() {
                    HdUtils.dialog2.getValue("saveHandler")();
//                                $.hd.ezui.dialog.saveHandler = undefined;
                }
            }, {
                text: '关闭',
                iconCls: "icon-cancel",
                handler: function() {
//                                $.hd.ezui.dialog.formHandler = undefined;
                    $("#mainDlg2").dialog("close");//.hd.ezui.dialog.close();
                }
            }];
    } else if (params.isShowExitBtn) {
        _def.buttons = [{
                text: '关闭',
                iconCls: "icon-cancel",
                handler: function() {
                    $("#mainDlg2").dialog("close");
                }}];
    }
    // 绑定enter,esc键。
    $(document).bind("keyup", function(event) {
        if (event.which == 27) {
            $("#mainDlg2").dialog("options").callback = undefined;
            $("#mainDlg2").dialog("close");
        }
    });
    $("#mainDlg2").dialog(_def);
};
HdUtils.dialog3.show = function(params) {
    var _def = {
        title: "标题", // 标题
        width: 800,
        height: 500,
        closed: false,
        cache: false,
        resizable: true,
        modal: true,
        // 关闭窗口的时候，unbind键。
        onClose: function() {
            $(document).unbind("keyup");
        }
    };
    var str = "?";

    if (params != undefined && params.href != undefined && params.href.indexOf("?") >= 0) {
        str = "&";
    }
    params.href = params.href + str + "timestamp=" + new Date().getTime();
    if (params.global != undefined) {
        params.hdGlobal = params.global;
    }
    if (params.openWithIframe) {
        params.content = '<iframe scrolling="no" frameborder="0"  src="' + encodeURI(params.href) + '" style="width:100%;height:100%;"></iframe>';
        delete params.href;
    }
    $.extend(_def, params);
    if (params.callback != undefined) {
    } 
    // 绑定enter,esc键。
    $(document).bind("keyup", function(event) {
        if (event.which == 27) {
            $("#mainDlg3").dialog("options").callback = undefined;
            $("#mainDlg3").dialog("close");
        }
    });
    $("#mainDlg3").dialog(_def);
};
/**
 * 为dialog设置全局变量。
 * @param {object} param 参数
 * @returns {undefined}
 * @memberOf HdUtils#dialog
 */
HdUtils.dialog.setValue = function(params) {
    var opts = $("#mainDlg").dialog("options");
    if (opts != undefined) {
        opts.hdGlobal = params;
    }
};
HdUtils.dialog2.setValue = function(params) {
    var opts = $("#mainDlg2").dialog("options");
    if (opts != undefined) {
        opts.hdGlobal = params;
    }
};
HdUtils.dialog3.setValue = function(params) {
    var opts = $("#mainDlg3").dialog("options");
    if (opts != undefined) {
        opts.hdGlobal = params;
    }
};
HdUtils.dialog4.setValue = function(params) {
    var opts = $("#mainDlg4").dialog("options");
    if (opts != undefined) {
        opts.hdGlobal = params;
    }
};
/**
 * 获得dialog的全局变量。
 * @param {string} param
 * @returns {HdUtils.dialog.getValue.p}
 * @memberOf HdUtils#dialog
 */
HdUtils.dialog.getValue = function(param) {
    var opts = $("#mainDlg").dialog("options");
    if (opts != undefined) {

        var p = eval("opts.hdGlobal." + param);
        return p;
    } else {
        return undefined;
    }
};
HdUtils.dialog2.getValue = function(param) {
    var opts = $("#mainDlg2").dialog("options");
    if (opts != undefined) {

        var p = eval("opts.hdGlobal." + param);
        return p;
    } else {
        return undefined;
    }
};
HdUtils.dialog3.getValue = function(param) {
    var opts = $("#mainDlg3").dialog("options");
    if (opts != undefined) {

        var p = eval("opts.hdGlobal." + param);
        return p;
    } else {
        return undefined;
    }
};
/**
 * 关闭窗口。
 * @returns {undefined}
 * @memberOf HdUtils#dialog
 */
HdUtils.dialog.close = function() {
    var opts = $("#mainDlg").dialog("options");
    if (opts != undefined) {
        opts.params = undefined;
        opts.buttons = [];
    }
    $("#mainDlg").dialog("close");
};
HdUtils.dialog2.close = function() {
    var opts = $("#mainDlg2").dialog("options");
    if (opts != undefined) {
        opts.params = undefined;
    }
    $("#mainDlg2").dialog("close");
};
HdUtils.dialog3.close = function() {
    var opts = $("#mainDlg3").dialog("options");
    if (opts != undefined) {
        opts.params = undefined;
    }
    $("#mainDlg3").dialog("close");
};
/**
 * @namespace ajax 发送与后台相对应的get、post，避免忘记细节属性。
 * @memberOf HdUtils#
 */
HdUtils.ajax = {};

HdUtils.ajax.get = function(p) {
    var ajaxP = {
        url: "",
        type: "GET",
        success: function(data) {
            HdUtils.messager.info(data);
        },
        error: function(data) {
            HdUtils.messager.show(data);
        }
    };
    $.extend(ajaxP, p);
    $.ajax(ajaxP);
};
/**
 * ezui与后台的post。
 * @param {object} p {url:"",data:{},success:function(data){},error:function(data){}};   data可以为对象，也可以为json字符串。
 * @returns {undefined}
 */
HdUtils.ajax.post = function(p) {
    if (p != undefined && p.data != undefined && $.isPlainObject(p.data)) {
        p.data = $.toJSON(p.data);
    }
    var ajaxP = {
        url: "",
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        success: function(data) {
            HdUtils.messager.info(data);
        },
        error: function(data) {
            HdUtils.messager.show(data);
        }
    };
    $.extend(ajaxP, p);
    $.ajax(ajaxP);
};


/**
 * @namespace ezui相关操作
 * @memberOf HdUtils#
 */
HdUtils.ezui = {};

/**
 * 获取当前打开的tab的名字。
 * @returns {unresolved}
 */
HdUtils.ezui.getCurrTabName = function() {
    return $('#main').tabs('getSelected').panel("options").title;
};
HdUtils.ezui.lastMonth = {};
HdUtils.ezui.lastMonth.getlastMonth =function()
{
	var mydate = new Date();
	var myMonth;
	if ((mydate.getMonth()+1)==1){
		myMonth = (mydate.getFullYear()-1)+"年"+"12月";
	}else if((mydate.getMonth()+1)>=10){
		myMonth = mydate.getFullYear()+"-"+((mydate.getMonth()+1)-1);
	}else{
		myMonth = mydate.getFullYear()+"-0"+((mydate.getMonth()+1)-1);
	}
	return myMonth;
};

HdUtils.ezui.dateBox = {};
HdUtils.ezui.dateBox.selectMonth = function(param) {
	 var db = $(param);
	 var lastMonth = HdUtils.ezui.lastMonth.getlastMonth();
	 var isClick = false;
     db.datebox({
         onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
             span.trigger('click'); //触发click事件弹出月份层
             if (!tds) setTimeout(function () {//延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
                 tds = p.find('div.calendar-menu-month-inner td');
                 tds.click(function (e) {
                	 isClick = true;
                     e.stopPropagation(); //禁止冒泡执行easyui给月份绑定的事件
                     var year = /\d{4}/.exec(span.html())[0]//得到年份
                     , month = parseInt($(this).attr('abbr'), 10);//月份，这里不需要+1
                     if(month<10){
                    	 month = "0"+month;       
                    	}
                     db.datebox('hidePanel')//隐藏日期对象
                     .datebox('setValue', year + '-' + month); //设置日期的值
                 });
                 setTimeout(function () {span.trigger('click')}, 0);
             }, 0);
             if(isClick == false){
            	 setTimeout(function () {span.trigger('click')}, 0);
             }
             isClick = false;
             yearIpt.unbind();//解绑年份输入框中任何事件
             
         },
         parser: function (s) {
             if (!s) return new Date();
             var arr = s.split('-');
             return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);
         },
         formatter: function (d) { return d.getFullYear() + '-' + (d.getMonth() + 1);/*getMonth返回的是0开始的，忘记了。。已修正*/ }
     });
     db.datebox("setValue",lastMonth);
     var p = db.datebox('panel'), //日期选择对象
         tds = false, //日期选择对象中月份
         aToday = p.find('a.datebox-current'),
         yearIpt = p.find('input.calendar-menu-year'),//年份输入框
         //显示月份层的触发控件
         span = aToday.length ? p.find('div.calendar-title span') ://1.3.x版本
         p.find('span.calendar-text'); //1.4.x版本

};
Array.prototype.removeByValue = function(val) {
  for(var i=0; i<this.length; i++) {
    if(this[i] == val) {
      this.splice(i, 1);
      break;
    }
  }
};
