/*
 说明： 	通用的辅助工具类，在  datagrid-helper.js 和  extension.js之前被加载，实现基本功能

 author: fuxinqi 傅新奇 2013-06-05
  
 Modifications:

    1.8 2015-08-29 by fuxinqi 定义多个div切换编辑的默认动作，消除重复的代码,于9.1修订增加内嵌datagrid点击也触发切换的代码
    1.7 2015-05-07 by fuxinqi 重构，解决$.hd.commonUtils空间定义问题
    1.6 2014-08-20 by CHENYANHUI: 解决在数据中存在单引号，导致JSON解析失败的问题
    1.5 2013-11-21 by fuxinqi: 将datagrid的重载load方法提取到本文件，以便同时支持treeGrid
    1.4 2013-11-11 by fuxinqi: 将对话框的基类移动到本.js中,dialog系列js按功能分开
    1.3 2013-9-23 by fuxinqi: 增加了公式求值的功能。并防范了公式/变量定义有问题时出错的问题。
    1.2 2013-8-16 by fuxinqi: 消除0值被输出为空的问题
    1.1 2013-8-14 by fuxinqi: 引入此文件，解决不同对象、命名空间的交叉引用，并规范工具类的名字。
 					                  抽取通用的UTIL类被 datagrid-helper.js 和  extension.js公用，并防止多个命名空间存在。
    1.0  2013-06-05  by 傅新奇 : 在extension.js中创建commonUtils命名空间，并包含公共对话框等资源，后续不断扩展。
 *  
 * web:http://www.huadong.net
 */

/**
 * 
 * 定义$.hd命名空间，并加入commonUtils包。考虑到修改冲突，将多个子空间分为不同的文件，将来稳定后考虑合并
 * 
 * 子命名空间包括： $.hd.commonDialogs ， $.hd.commonUtils， $.hd.ezui（又分为 code, datagrid,
 * editor, formatter等子包） $.hd.search， $.hd.form, $.hd.combogrid.options ,
 * $.hd.droppable 等
 * 
 * 本文件存放commonUtils子空间的对象
 * 
 * 
 * 结构： $.hd.commonUtils 与业务相关的工具类，原为plugin/common/GctosUtil.js
 * $.hd.commonUtils.getRandomId 根据毫秒数随机初始化，然后得到递增的ID $.hd.commonUtils.minus
 * 工具方法，获得两个字段相减后的值（已经考虑了字段为空等情况） $.hd.commonUtils.AuditChain
 * 审核链对象，通过add(key,value)的方式构建审核次序并通过isHaveAuthority()方法检查在某个阶段是否有权限 ......
 */

$.hd=$.hd||{};
$.hd.commonUtils={
    __id : 0  // 工作变量，用于递增序号
};

//由于函数一用问题，$.hd.commonDialogs.base放在本文件中了
$.hd.commonDialogs={}; 

/**
 * 获得一个递增的ID值，用于生成ID值、动态编码等
 * 
 * @returns 毫秒数代表的ID
 */

$.hd.commonUtils.getRandomId =function() {
        if ($.hd.commonUtils.__id === 0) {
                $.hd.commonUtils.__id = (new Date()).getTime();
        }
        return $.hd.commonUtils.__id++;
};

/**
 * 根据指定的ID，安全得到对应的JQUERY对象
 * @param {} id
 */
$.hd.commonUtils.getJqObject=function(id){
    if(!id){
        return $($.hd.commonUtils.getRandomId());
    }
    if ('#' === id.charAt(0)) {
        return $(id);
    } else {
        return $('#' + id);
    }
};
/**
 * 判断两个对象是否相等，考虑为空的情况
 * @param {any} firstV
 * @param {any} secondV
 */
$.hd.commonUtils.equals = function(firstV, secondV){
        if(undefined===firstV || undefined ===secondV){
              return false;
        }
        if(firstV===null && secondV===null){
            return true;
        }else {  //此时obj1为空， obj2 非空
            return firstV == secondV;
        }   
};
/**
 * 获得两个字段相减后的值（已经考虑了字段为空等情况）
 * 
 * @param {Number}
 *            firstNum 被减数，如果格式不对被解释为0
 * @param {Number}
 *            secondNum 减数，如果格式不对被解释为0
 * @returns {Number} 差
 */
$.hd.commonUtils.minus = function(firstNum, secondNum, precision) {
        if (!precision) {
                precision = 3;
        }
        if (!$.isNumeric(firstNum)) {
                firstNum = 0;
        }
        if (!$.isNumeric(secondNum)) {
                secondNum = 0;
        }
        return firstNum - secondNum;
};
/**
 * 获得两个字段相加后的值（已经考虑了字段为空等情况）
 * 
 * @param {Number}
 *            firstNum 被减数，如果格式不对被解释为0
 * @param {Number}
 *            secondNum 减数，如果格式不对被解释为0
 * @returns {Number} 和
 */
$.hd.commonUtils.plus = function(firstNum, secondNum, precision) {
        if (!precision) {
                precision = 3;
        }
        if (!$.isNumeric(firstNum)) {
                firstNum = 0;
        }
        if (!$.isNumeric(secondNum)) {
                secondNum = 0;
        }
        return (1.0 * firstNum + 1.0 * secondNum).toFixed(precision); // 防止为字符串被相加
};
/**
 * 获得两个字段相成后的值（已经考虑了字段为空等情况）
 * 
 * @param {Number}
 *            firstNum 被减数，如果格式不对被解释为0
 * @param {Number}
 *            secondNum 减数，如果格式不对被解释为0
 * @returns {Number} 积
 */
$.hd.commonUtils.multiply = function(firstNum, secondNum, precision) {
        if (!precision) {
                precision = 3;
        }
        if ($.isNumeric(firstNum) && $.isNumeric(secondNum)) {
                return (firstNum * secondNum).toFixed(precision);
        }
        return ""; // 无法相乘，保持字段为空
};
/**
 * 比较时间 
 * @param {type} begDt
 * @param {type} endDt
 * @returns
 */
$.hd.commonUtils.ltDate= function(begDt, endDt) {
    if (Date.CreateDateTime(begDt) - Date.CreateDateTime(endDt) > 0) {
        return false;
    } else {
        return true;
    }
};
/**
 * 数字格式化
 * @param value 原始数据
 * @param precision 精度
 * @returns
 */
$.hd.commonUtils.precisionCommon= function(value, precision) {
    var v = parseFloat(value).toFixed(precision).split(".");
    var ret = v[0].replace(/\d+?(?=(?:\d{3})+$)/img, "$&,");
    if (v.length > 1) {
        ret += "." + v[1];
    }
    return ret;
};
/**
 * 在任何页面中，得到main.jsp所在的url地址。
 * @return {}
 */
$.hd.commonUtils.getWebContext =function() {
    try {
            var curWwwPath = window.document.location.href;
            //获取主机地址之后的目录，如： /ems/Pages/Basic/Person.jsp
            var pathName = window.document.location.pathname;
            var pos = curWwwPath.indexOf(pathName);
            //获取主机地址，如： http://localhost:8080 这个暂时用不到，使用相对路径/ems就可以了
            var localhostPath = curWwwPath.substring(0, pos);

            //获取带"/"的项目名，如：/ems
            var webContext = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
                        return webContext;
        } catch (e) {
                return "";
        }
};
/**
 * 在任何页面中，得到main.jsp所在的url地址。
 * @return {}
 */
$.hd.commonUtils.getUrlBase =function() {
    var webContext = $.hd.commonUtils.getWebContext();
    var urlBase = webContext==""? "../webresources/login/": webContext+"/login/";
    return urlBase;
};

/**
 * 执行AJAX请求，返回数据后执行回调函数。出错则进行标准提示。
 * 约定，此AJAX请求采用POST调用，返回hdMessgeCode对象，数据在data字段，可以为任意对象，本方法不解释之
 * 
 */
$.hd.commonUtils.doAjaxCall = function(url, data, callback, failCallback) {
    if (!url || !data || "" === url) {
            alert('[对编程人员提示]使用$.hd.commonUtils.doAjaxCall但调用参数为空');
            return;
    }
    $.ajax({
            url : url, // 约定，此URL采用POST调用，返回hdMessgeCode
            data : $.toJSON(data),
            dataType : "json",
            type : 'POST',
            success : function(response) {
                    if (response !== undefined && response !== null
                                    && !(MSG_CODE_QUREY_SUCCESS === response.code || MSG_CODE_PERSIST_SUCCESS === response.code)) { // 查询无数据OR出错，提示后台信息
                            if (MSG_CODE_QUREY_NODATA === response.code) {
                                    $.hd.ezui.messager.status("没有查询到符合条件的后台数据");
                            } else {
                                    $.hd.ezui.messager.show(response);
                            }
                    } else {
                            if (MSG_CODE_QUREY_SUCCESS === response.code) {
                                    $.hd.ezui.messager.status("成功读取后台数据。");
                            } else {
                                    $.hd.ezui.messager.status("执行异步更新成功。");
                            }
                            if ($.isFunction(callback)) {
                                    callback(response.data);
                            }
                    }
            }, //end success
            error : function(XMLHttpRequest, textStatus, errorThrown) {
                     if ($.isFunction(failCallback)) {
                    failCallback(XMLHttpRequest, textStatus, errorThrown);
                   } else {
                       $.messager.alert("发现错误", "动态获取/更新后台数据失败。"
                               + $.hd.ezui.messager.getDetail(errorThrown), 'error');
                   }
               } //END error
    }); //end $.ajax
};

/**
 * 防止重复提交
 */
$.hd.commonUtils.safeAjaxButtonClick = function(button, ajaxFunc, timeout) {
        if (button.linkbutton("options").disabled) {
                alert("按钮已被按下，请耐心等待。");
                return;
        }

        function beginAction() {
                button.linkbutton("disable");
                $.messager.progress({
                        title : "正在处理",
                        text : "请求正在处理中，请稍候..."
                });
        }
        function endAction() {
                button.linkbutton("enable");
                $.messager.progress('close');
        }

        // 正式的动作
        beginAction();
        setTimeout(function() { // 防止传入的ajaxFunc出错导致长时间不可用
                if (button.linkbutton("options").disabled) {
                        endAction();
                }
        }, timeout?timeout*1000:10*1000); // 10S
        if (jQuery.isFunction(ajaxFunc)) {
                ajaxFunc(endAction);
        }
};

/**
 * 审核链对象，通过add(key,value)的方式构建审核次序并通过isHaveAuthority()方法检查在某个阶段是否有权限 by fuxinqi
 * moved from GctosUtils.js on 2013-6-5
 * 
 * 示例代码： var UtilObj=new $.hd.commonUtils.AuditChain();
 * UtilObj.add("input",'0'); UtilObj.add("stat_id",cargoData.STAT_ID);
 * UtilObj.add("biz_id",cargoData.BIZ_ID);
 * UtilObj.add("fin_id",cargoData.FIN_ID);
 * UtilObj.add("stat_id2",cargoData.STAT_ID2);
 * 然后可以调用isHaveAuthority()进行判断（参数可以是此阶段的标识或者序号），例如
 * if(UtilObj.isHaveAuthority(0)){ //第一个环节，即input环节 enableEdit(); //从未审核，视为录入界面
 * .... } if(false===isBusinessVerify){
 * $("#portCargoSplitVerify_doBusinessVerify").hide();
 * $("#portCargoSplitVerify_cancelBusinessVerify").hide();
 * if(UtilObj.isHaveAuthority("stat_id")){ //检算员初次审核，且后续未审核，可以录入
 * $("#portCargoSplit_doReview").show();
 * $("#portCargoSplit_cancelReview").show(); ... } ...... }
 */

$.hd.commonUtils.AuditChain = function() {

	/* 工作变量： 存放审核链条上数据库的值， 元素类型为对象{key, value} */
	var stages = [];

	/**
	 * 增加审核阶段，以便后续判断。
	 * 
	 * 
	 * @param {String}
	 *            keyStr 此阶段的标识，一般是字段名或者给定的’录入‘环节
	 * @param {String}
	 *            valueStr
	 *            此阶段的值，对应数据库的Char(1)类型。如果是'1'认为已经审核，为'0'或其他格被解释为'0'代表未审核 无返回值
	 */
	this.add = function(keyStr, valueStr) {
		var stage = {};
		stage.key = keyStr ? keyStr : 'unknownStage';
		stage.value = '0';
		if (valueStr && '1' === valueStr) { // 防范数据库无值
			stage.value = '1';
		}
		stages.push(stage);
	};

	/**
	 * 判断在某个阶段是否有修改权限（如果后续阶段存在'1'标志，则不可以修改）
	 * 
	 * @param {String/numnber}
	 *            currentStage 此阶段的标识或者序号
	 * @returns {boolean} 是否有修改权限
	 */
	this.isHaveAuthority = function(currentStage) {
		if (undefined === currentStage || null === currentStage) {
			return false;
		}

		// 如果给定参数是KEY，首先翻译为index
		var currentStageIndex = -1;
		if (!$.isNumeric(currentStage)) {
			$.each(stages, function(i, stage) {
				if (currentStage === stage.key) {
					currentStageIndex = i;
				}
			});
		} else {
			currentStageIndex = currentStage;
		}
		// 容错代码
		if (currentStageIndex < 0 || currentStageIndex >= stages.length) {
			return false;
		}
		// 在审核链中从当前环节开始向后查找，次判断是否有权限
		for ( var i = currentStageIndex + 1; i < stages.length; i++) {
			var stage = stages[i];
			if ('1' === stage.value) { // 只要后续有审核标志，则本环节不能再修改
				return false;
			}
		}
		// 再按审核链向前找，如果前一环节没处理，也没有权限
		if (currentStageIndex === 0) {
			return true;
		} else {
			if ('1' !== stages[currentStageIndex - 1].value) {
				return false;
			}
		}
		return true;
	};
};

/**
 * 检查报表插件是否安装，如果没有安装给予协助
 */
$.hd.commonUtils.checkReportInstall = function() {

	var agent = navigator.userAgent.toLowerCase();
	if (agent.indexOf("msie") > 0) {
		return; // IE环境中组件可自动安装，因此直接打开报表显示网页即可
	}

	if (navigator.mimeTypes["application/supcan-plugin"]) {
		return; // 组件已经安装，打开报表网页即可
	}

	if (agent.indexOf("chrome") > 0) //在chrome中不能自动安装,改为弹出安装提示
		//由于checkReportInstall可能会在main.jsp中也可能在弹出iframe中调用,为了都不出错，这里使用准绝对路径代替../login/plugin/system/ReportInstallChrome.html
		window.location.href = ($.hd.commonUtils.getUrlBase()+"../pages/ReportInstallChrome.html"); // chrome不能自动安装，给用户提示安装指南
	else
		window.location.href = ($.hd.commonUtils.getUrlBase()+"../reports/binary/supcan.xpi");
};

/**
 * 在数据行中，根据主键字段，得到键值对作为该行的ID标识
 * @param {Object} ros 数据行的对象数组
 * @param {array} pkFields 
 * @return {object} keyValueMap 键值对, key:value
 */
$.hd.commonUtils.findRowId= function(row,pkFields) {
	   if(!$.isPlainObject(row)){
	   	   return null;
	   }
       var rowId={}; 
       $.each(pkFields,function(j,key) {  
            var pkValue=row[key];  rowId[key]=pkValue;
       });
       return rowId;
};

/**
 * 检查数组中是否有指定的行，如果有则返回，没有则返回空对象
 * @param {array} rows 数据行的对象数组
 * @param {object} keyValueMap 键值对,key:value
 * @return {object} 找到的行，如果找不到则返回空
 */
$.hd.commonUtils.findRow= function(rows,keyValueMap) {
	var result={};
	if(!$.isPlainObject(keyValueMap)){
		return result;
	}
	$.each(rows,function(i,row){
		var keyEquals=true;
		for (var key in keyValueMap) {  
			if(!$.hd.commonUtils.equals(keyValueMap[key],row[key])){
				keyEquals=false; break;
			}
		}
		if(keyEquals){    //每个KEY列相同，返回找到的行
			result=row;
			return false; //这个return只是跳出each循环
		}
	});
	return result;  //找不到，返回空
};

/**
 * 将datagrid的数据改变，通过RESt服务记录到后台数据库
 * @param {jqueryObj} datagrid 已经创建完毕的daatagrid对象，其数据被改变，但尚未reload
 * @param {String} name 在功能界面中，此datagrid的名字， 例如功能名=“进口委托单”， datagrid名=“主数据”或“控货数据”
 * @param {array} idFields 主键字段的数组
 * @param {function} callBack 记录成功后的回调函数
 */
$.hd.commonUtils.auditDatagridRowModification=function(datagrid,name,idFields,callBack){
    var changedRows = datagrid.datagrid('getChanges');
    if (changedRows.length <= 0){
    	return;    //数据未改变
    }
    var dataInfo=$.hd.commonUtils.getDatagridColumnDef(datagrid);
    $.extend(dataInfo , {     //最终包含的属性  columnTitles,columnNames, dataName，idFields .
        dataName:name,
        idFields:idFields});  //增加数据名：主键字段属性
        
    var originalRows = datagrid.datagrid('getOrginalData');   
    var deletedRows= datagrid.datagrid('getChanges', 'deleted');
    var insertedRows= datagrid.datagrid('getChanges', 'inserted');
    var updatedRows = datagrid.datagrid('getChanges', 'updated');
    
	return $_hd_commonUtils_realAuditModification(dataInfo,originalRows,insertedRows,deletedRows,updatedRows,callBack);
};

/**
 * 将datagrid的数据改变，通过RESt服务记录到后台数据库
 * @param {jqueryObj} form 界面Form对象对应的jquery对象，其数据已被改变，但改变前，取得了原始数据
 * @param {String} name 在功能界面中，此datagrid的名字， 例如功能名=“进口委托单”， datagrid名=“主数据”或“控货数据”
 * @param {object} originalData FORM的原始数据，如果为{}则认为当前FORM数据是插入。另当前FORM清空,而originalData非空，记录日志认为是删除（此约定保留，实际记录删除日志是通过FormOperation的doDelete动作）
 * @param {array} idFields 主键字段的数组
 * @param {function} callBack 记录成功后的回调函数
 */
$.hd.commonUtils.auditFormDataModification=function(form,name,originalData,idFields,callBack){
	var dataInfo=$.hd.commonUtils.getFormColumnDef(form);
    $.extend(dataInfo , {     //最终包含的属性  columnTitles,columnNames, dataName，idFields .
        dataName:name,
        idFields:idFields});  //FORM只有一行，对于判定数据修改无用，后台可能有用
   
	var newData= $.hd.form.getDataAsObject(form); //当前FROM数据，定义为一行，一个对象表示
    if(!$.isPlainObject(newData)){
    	alert("不应发生，extension中hd.form.getData被错误修改？无法得到FORM数据对象"); return;
    }
	var originalRows=[];
	var deletedRows= [];
    var insertedRows=[];
    var updatedRows =[];
    
    if(!originalData){                              //没有给原始值，当前FORM数据按插入处理
    	insertedRows.push(newData);
    }else{
    	if(!$.isPlainObject(originalData)){               
            originalData=$.evalJSON(originalData);  //确保是对象
        }
    	
        if(!$.isPlainObject(originalData)){   
        	alert("发现编程错误：调用$.hd.commonUtils.auditFormDataModification给定参数不是对象也不是JSON格式"); 
        	return;    //不是对象，也不是对象JSON无法处理了
        }
    	if($.isEmptyObject(originalData)){    //原始值为空，按插入处理。 不用 !originalData||$.isEmptyObject()判断防止未给定originalData的情况进入else分支
    	   insertedRows.push(newData);
        } else{                               //给定了原始值，且非空
    		if($.isEmptyObject(newData)){     //此时originalData非空，FORM被清空，认为是删除。 
    			deletedRows.push(originalData);
    		}else{
    			originalRows.push(originalData);  //问题，如果根据pkFields在originalData并不匹配newData中数值？ 不管，目前不会有问题
    			updatedRows.push(newData);
    		}
        } //END IF NOT $.isEmptyObject(originalData)
	}
    return $_hd_commonUtils_realAuditModification(dataInfo,originalRows,insertedRows,deletedRows,updatedRows,callBack);
};

//工作方法，不对外开放。转化数据格式，提交后台
function $_hd_commonUtils_realAuditModification(dataInfo,originalRows,insertedRows,deletedRows,updatedRows,callBack){
	var params=$.extend(true,{},dataInfo);
	
    var columnNames = dataInfo.columnNames;    // 列名， 逗号分割的串
    var columnTitles = dataInfo.columnTitles ; // 标题， 逗号分割的串
    if(columnTitles){
    	columnTitles=columnTitles.replace(/\"/g, "'").replace(/<[^>]*>/g, ""); // 过滤双引号和HTML修饰，防止语法干扰
    }
  
	var pkFields=params.idFields;  //数组
    params.insertedRows =[];  //每行对象格式   cols:[],colNames:[],rowId:{key:value,key:value},data:{}
    params.deletedRows =[];   //格式同insertedRows
    params.modifiedRows=[];   //每行对象格式  cols:[],colNames:[], rowId:{key:value,key:value},orginalData:{},updatedData:{}
 
    $.each(insertedRows,function(i,row){
        var rowId=$.hd.commonUtils.findRowId(row,pkFields); 
        //【重要说明】这里每一行的对象,保存时变为JSON串,后台存盘不作解释.日志查看时在前端反序列化为对象使用! delte/update数据同理
        params.insertedRows.push($.toJSON({data: simplify(row),cols:columnNames,colNames:columnTitles,rowId:rowId}));  
    });
    
    $.each(deletedRows,function(i,row){
        var rowId=$.hd.commonUtils.findRowId(row,pkFields); 
        params.deletedRows.push($.toJSON({data: simplify(row),cols:columnNames,colNames:columnTitles,rowId:rowId}));
    });    
    
    $.each(updatedRows,function(i,row){
        var rowId=$.hd.commonUtils.findRowId(row,pkFields); 
        var orignalRow =$.hd.commonUtils.findRow(originalRows,rowId);  //根据主键从原始数据找到对应行
        params.modifiedRows.push($.toJSON({updatedData:simplify(row), orginalData:simplify(orignalRow), 
                                       cols:columnNames,colNames:columnTitles, rowId:rowId}));
    });     
    
	$.hd.commonUtils.doAjaxCall("../webresources/login/common/DataModificationAuditREST/save",params,function(){
		if($.isFunction(callBack)){
			callBack();
		}
	});
	
	//内部函数，清除数据列中嵌套的对象，防止数据日志超长（数据操作日志针对字段即可，嵌套对象的修改暂不考虑）
	function simplify(orgObj){
		if(!$.isPlainObject(orgObj)){
			return orgObj;
		}
		var resultObj={};
		$.each(orgObj,function(key,value){
			if(!$.isPlainObject(value)){
				if(value && ""!==value){
				    resultObj[key]=value;   //普通变量。空值忽略
				}
			}else{
				resultObj[key]="{...}"; //嵌套对象，简化，只记录数据日志所以可行。
			}
		});
		return resultObj;
	}
}

/**
 * 根据一个datagrid,复制其定义,在另一个ID上创建新的datagrid对象(此新datagrid不能检索数据)
 * @param {JqueryObj} datagridJqo 选择器选中的JQ对象，datagrid已经定义并可能有数据
 * @param {String} newDatagridId 新对象的ID
 * @param {object} overrideOpts 这些选项作用于新对象，覆盖原datagrid的设置
 * @returns 本方法根据新的ID构建一个JQ对象，datagrid初始化。
 */
$.hd.commonUtils.copyConstructDatagrid= function(datagridJqo,newDatagridId,overrideOpts) {
	if (!datagridJqo) {
        return undefined;
    }
    if(!overrideOpts||!$.isPlainObject(overrideOpts)){
    	overrideOpts={};
    }
    var opts = datagridJqo.datagrid("options");
    opts = $.extend(true,{},opts,  //防止影响原datagrid
    	{
            url:null,
            method:undefined,
            autoLoad:false,
            data:{total:0,rows:[]},
            ___hasLoaded:false
        },overrideOpts);    //以用户最终给定的overrideOpts为准
    var newDatagridJqo=$.hd.commonUtils.getJqObject(newDatagridId);
    newDatagridJqo.datagrid(opts);
    return newDatagridJqo;
};

/**
 * 得到FORM中的的字段标题和字段名. 调试完善中
 * @param {jQuery ojbect} formJqo 用Jquery选择器选中的FORM对象 
 * @returns 数据列定义 map of array 两个属性columnTitles，columnNames分别对应标题和列名 数组。
 */
$.hd.commonUtils.getFormColumnDef = function(formJqo) {
    var colDefs = {
        columnTitles : "", // 标题， 逗号分割的串
        columnNames  : ""   // 列名， 逗号分割的串
    };
    if (!formJqo) {
        return colDefs;
    }
    var formData= $.hd.form.getDataAsObject(formJqo);  //对象格式的数据
    if (!$.isPlainObject(formData)) {
        return colDefs;
    }
    $.each(formData,function(key,value){
        colDefs.columnNames += "," + key;
        colDefs.columnTitles += "," + findTitle(formJqo,key);
    });
    colDefs.columnTitles = colDefs.columnTitles.substr(1); // 去掉第一个逗号
    colDefs.columnNames = colDefs.columnNames.substr(1);
    return colDefs;
    //私有函数，在指定FORM中找到字段对应的TITLE文字
    function findTitle(formJqo,fieldName){
        var labelText=null;              //查找到的标签原文字
        var isCombo=false;               //是否combogrid,datetimebox等, 用于判断是否真正的hidden字段
    	var formId=formJqo.attr('id');   //通过formJqo.children()方式不能遍历所有的表单元素，因此使用ID方式
    	var fieldJqo=$('#'+formId+' [comboname="'+fieldName+'"]'); // 对于combogrid/datebox，如果用name找到的是隐藏字段，VALUE值和前序标签都不对
    	if(fieldJqo.size()<1){
    		fieldJqo=$('#'+formId+' [name="'+fieldName+'"]');       //不是combogrid再按name查找
    	}else{
    		isCombo=true;   //此时fieldJqo是一个hidden字段,但是要取其前部标签
    	}
 
    	if(fieldJqo.size()<1){     //找不到指定的元素
    	    return fieldName;
    	}else{    //一般的输入框 和 combogrid等   -- 找到前序元素，处理其text
    		var labelContainerJqo=fieldJqo.parent().prev();
            if(labelContainerJqo.size()>0 && labelContainerJqo.is('td') 
                            && !(fieldJqo.is(':checkbox')|| !isCombo && fieldJqo.is(':hidden')) ) { //checkbox无法判定标签在前还是在后，会引起混乱. 
            	labelText=labelContainerJqo.text();
            }else{
            	 labelText=fieldJqo.attr('label');   //不是表格元素的无法判定 前后标签，约定：必须使用label属性作为名字注解
            }
    	}
            
        if(!labelText||""===labelText){       //没有找到或设置不对
            return fieldName;
        }
    	
    	return labelText.replace(/<[^>]*>/g, "").replace(/[\n|：|:]/g,""); // 过滤HTML修饰留下文本，消除回车和冒号（全角半角）
    }
};

/**
 * 得到Datagrid的列标题和列名（包括冻结的列），隐藏字段除外
 * @param {jQuery ojbect} datagridJqo 选择器选中的JQ对象，datagrid
 * @returns 数据列定义 map of array 两个属性columnTitles，columnNames分别对应标题和列名 数组。
 */
$.hd.commonUtils.getDatagridColumnDef = function(datagridJqo) {
	var colDefs = {
        columnTitles : "", // 标题， 逗号分割的串
        columnNames : ""   // 列名， 逗号分割的串
    };
	if (!datagridJqo) {
        return colDefs;
    }
    var opts = datagridJqo.datagrid("options");

    if (opts.frozenColumns[0]) {
        $.each(opts.frozenColumns[0], function(idx, val) { // 冻结的列，不考虑复合表头
            if (val.hidden != true) {
                colDefs.columnTitles += "," + val.title;
                colDefs.columnNames += "," + val.field;
            }
        });
    }
    $.each(opts.columns[0], function(idx, val) { // 一般的列，不考虑复合表头
        if (val.hidden != true) {
            colDefs.columnTitles += "," + val.title;
            colDefs.columnNames += "," + val.field;
        }
    });

    colDefs.columnTitles = colDefs.columnTitles.substr(1); // 去掉第一个逗号
    colDefs.columnNames = colDefs.columnNames.substr(1);
    return colDefs;
};
/**
 * 获得datagrid当前页显示内容的工具类。
 * formatter被执行，返回数组。[提取公共函数，便于开发者将其他数据转换为数组，作为otherParams传入exportExcel]
 * 
 * @param {jQuery ojbect} datagridJqo 选择器选中的JQ对象，datagrid
 * @returns 显示数据（对象格式）的数组。
 */
$.hd.commonUtils.getDatagridDisplayData = function(datagridJqo) {
	var rowData = []; // 显示的数据行。 对象数组
	if (!datagridJqo) {
		return rowData;
	}
	var opts = datagridJqo.datagrid("options");
	var columndef = []; // 本dataGrid的列定义，包含 options定义中的frozenColumns 和columns 列
    if(opts.frozenColumns[0]){
	$.each(opts.frozenColumns[0], function(idx, val) { // 冻结的列，不考虑复合表头
		columndef.push(val);
	});
   }
	$.each(opts.columns[0], function(idx, val) { // 一般的列，不考虑复合表头
		columndef.push(val);
	});

	var rows = datagridJqo.datagrid('getRows');
	if (rows.length > 0) {
		$.each(rows, function(i, gridRow) { // 按行循环。为了简化代码，隐藏列也输出到前端
			var row = {}; // 处理后的一行数据
			$.each(columndef, function(colIndex, def) { // 按列循环,不能直接对gridRow以反射方式循环，因为其次序与columndef不一致。
				var colName = def.field;
				var colValue = gridRow[colName]; // gridRow是对象,反射取值
				if ($.isFunction(def.formatter)) { // 格式化字段显示
					var display = def.formatter(colValue, gridRow, i); // value,row,index
																		// //.call(datagridJqObject,colValue,gridRow,i);
					display = display ? "" + display : (0 === display ? "0"
							: ""); // 解决0被误判和非字符型返回值的问题，并消除null,undefined 注意 0
									// 也被判为false
					row[colName] = "" === display ? "" : display.replace(
							/<[^>]*>/g, ""); // 过滤HTML修饰，保证导出数据只有显示的具体内容
				} else {
					//陈言辉 2014-8-20 解决在数据中存在单引号，导致JSON解析失败的问题
					var colValue_ = colValue ? "" + colValue : (0 === colValue ? "0" : "");
					if(colValue_){
						colValue_ = colValue_.replace('\'','’');
					}
					row[colName] = colValue_; // 没有formatter，直接输出对应的字符串，若为null或undefined则输入空串
//OLD代码
//					row[colName] = colValue ? "" + colValue
//							: (0 === colValue ? "0" : ""); // 没有formatter，直接输出对应的字符串，若为null或undefined则输入空串
				}
			});
			rowData.push(row);
		});
	}
	return rowData;
};

/**
 * 本方法重载datagrid/treegid默认的jsonloader 支持POST请求，并增加了autoLoad变量，防止在初始化时就加载数据
 * @param {object} opts 调用本方法的datagrid/treegid的options对象
 * @param {object} param 加载数据时的queryParams对象
 * @param {function} successCallback 来自easyUI实现机制的成功回调函数
 * @param {function} errorCallback 来自easyUI实现机制的失败回调函数
 * @returns {boolean} 如果发现问题或者设置了autoLoad=false，不能再加载数据，返回false, 否则允许easyUI继续正常处理。 同jsonLoader约定
 */
$.hd.commonUtils.jsonLoadWithPost=function(opts,param, successCallback, errorCallback) {
    if (!opts.url) {
        return false;
    } else {      // V2 增加延迟加载的支持，防止在打开界面时datagrid就加载数据
        if (false === opts.autoLoad) {         //autoLoad属性，默认为TRUE。 只生效一次
            if (!opts.___hasLoaded) {
                opts.___hasLoaded = true;      //在options中增加标志串
                var data = {total: 0, rows: []};  //强制赋值，防止访问rows为空
                successCallback(data);
                return false;
            }
        }
    }

    if (!opts.method || "post" === opts.method.toLowerCase()) {  //V1 对POST的行为进行修正，消除服务器端不能解析JSON的问题
        $.ajax({type: "post", url: opts.url, data: $.toJSON(param), dataType: "json", //以JSON发送全部参数，方便服务端统一处理
            contentType: "application/json", processData: false, //此为所加限定，见jQuery.ajax(url,[settings])说明文档
            success: function(data) {
                opts.___originalRows=$.extend(true,{},data);     //保存原始数据，辅助后台判定并发修改---由datagrid('getData')获得的是最终数据而不是原始值
                successCallback(data);
            },
            error: function() {
                errorCallback.apply(this, arguments);
            }
        });
    } else {
        //以下为dataGrid jasonLoader的标准代码，从\js\jquery.easyui.min_132.js 第8466行得到
        $.ajax({type: opts.method, url: opts.url, data: param, dataType: "json",
            success: function(data) {
                opts.___originalRows=$.extend(true,{},data);
                successCallback(data);
            },
            error: function() {
                errorCallback.apply(this, arguments);
            }
        });
    }
    return true;
};
/**
 * 以FORM形式提交向后台提交数据，以便获得二进制下载流的方法（不使用AJAX，因为它使用扩展的XmlHttp而不是纯HTTP协议，无法接受下载文件）
 * 
 * @param {string}
 *            url 后台服务的URL，必须是POST请求，以@FormParam接受参数
 * @param {object}
 *            params 传到后台的参数，其中的双引号将被改为单引号（服务端负责替换回来）
 * @return 无返回，直接提交，结果为二进制下载。
 */
$.hd.commonUtils.postDataForDownload = function(url, params) {
	if (!url || !params || !$.isPlainObject(params)) {
		return;
	}

	// 动态创建一个FORM准备将params提交到后台
	var form = $('<form method="POST" action="' + url + '" enctype="multipart/form-data" >');  //不用默认的enctype="application/www-form-urlencoded"防止字段超长
	$.each(params, function(key, v) { // key 就是params中各字段名，无需处理
		var value; //
		if (!v) { // 字段无值，不处理
			value = "";
		} else { // params全部属性，按字符串处理
			value = v.replace(/\"/g, "'").replace(/<[^>]*>/g, ""); // 过滤双引号和HTML修饰，防止语法干扰
		}

		form.append($("<input type='hidden' name=\"" + key + "\" value=\""
				+ value + "\">"));
	});

	$('body').append(form); // 主网页，强制加入创建的FORM

	//正常情况下，submit之后response为下载的流，这里不会返回信息。 但如果后台REST报错，这里需要提示出来【约定】出错时body的内容为错误信息
	form.form('defaultSubmit', {   //FXQ2015-0723 公司ezui.ex.form.js重载submit导致mulitpart方式提交无效，这里必须使用保留的副本 
		success : function(responseBody) {
			if(responseBody){
		    	   $.messager.alert(INFO, responseBody, "warning");
		    }
			$('body').remove(form);
		}
	}); // end form
};

/**
 * 将datagrid内容输出EXCEL的服务类
 * 
 * @param {jQuery
 *            ojbect} datagridJqo 选择器选中的JQ对象，datagrid
 * @param {string}
 *            excelFileName 要导出的EXCEL文件名
 */
$.hd.commonUtils.exportExcel = function(datagridJqo, excelFileName) {
	if (!datagridJqo) {
		return;
	}
	var opts = datagridJqo.datagrid("options");
	var url = "../webresources/login/common/UtilsREST/exportExcel"; // 提交,数据服务REST

	var params = {
		excelName : excelFileName, // 输出的EXCEL文件名
		columnTitles : "", // 标题， 逗号分割的串
		columnNames : "", // 列名， 逗号分割的串
		rowData : "" // JSON字符串，对应于datagrid当前页的所有行。
	};
	
	$.extend(params,$.hd.commonUtils.getDatagridColumnDef(datagridJqo));  //填充columnTitles和columnNames两个字段
	params.rowData = $.toJSON($.hd.commonUtils.getDatagridDisplayData(datagridJqo)) // rowData显示数据是对象格式，这里转换为JSON,以便能在FORM字段中提交;

	$.hd.commonUtils.postDataForDownload(url, params);
}; // end _exportExcel

/**
 * 将datagrid内容输出EXCEL的服务类(只输出有限的列名）
 * 
 * @param {jQuery
 *            ojbect} datagridJqo 选择器选中的JQ对象，datagrid
 * @param {string}
 *            excelFileName 要导出的EXCEL文件名
 */
$.hd.commonUtils.exportExcelWithGivenCols = function(datagridJqo, fileName, columnTitles, columnNames) {
	if (!datagridJqo) {
		return;
	}
	var url = "../webresources/login/common/UtilsREST/exportExcel"; // 提交,数据服务REST

	var params = {
		excelName : fileName, // 输出的EXCEL文件名
		columnTitles : columnTitles, // 标题， 逗号分割的串
		columnNames : columnNames, // 列名， 逗号分割的串
		rowData : "" // JSON字符串，对应于datagrid当前页的所有行。
	};
	params.rowData = $.toJSON($.hd.commonUtils.getDatagridDisplayData(datagridJqo)) // rowData显示数据是对象格式，这里转换为JSON,以便能在FORM字段中提交;
	$.hd.commonUtils.postDataForDownload(url, params);
}; // end _exportExcel

/**
 * 将datagrid内容，按后台格式输出EXCEL的服务类(指定模版文件）
 * 
 * @param {jQuery ojbect} datagridJqo 选择器选中的JQ对象，datagrid
 * @param {string} excelFileName 要导出的EXCEL文件名
 * @param {string}  templateFullName
 *            模版文件的全路径（服务器端），如果不给定则不使用模版。如果给定但不是以.xls结尾，则使用默认模版路径，模版文件名取excelFileName
 * @param {object} otherParams 传到后台的参数，除当前表格数据之外的其他参数（其他数据行，或者简单值，最终封装为一个对象）
 */
$.hd.commonUtils.exportExcelWithTemplate = function(datagridJqo, excelFileName,
		templateFullName, otherParams) {
	if (!datagridJqo) {
		return;
	}
	var url = "../webresources/login/common/UtilsREST/exportExcelWithTemplate"; // 提交,数据服务REST

	var params = {
		excelName : excelFileName, // 输出的EXCEL文件名
		'templateName' : (templateFullName ? templateFullName : undefined),
		'rowData' : $.toJSON($.hd.commonUtils
				.getDatagridDisplayData(datagridJqo)), // rowData显示数据是对象格式，这里转换为JSON,以便能在FORM字段中提交;
		'otherParams' : undefined
	};

	if (otherParams && $.isPlainObject(otherParams)) {
		params.otherParams = $.toJSON(otherParams);
	}

	$.hd.commonUtils.postDataForDownload(url, params);
}; // end _exportExcel

/**
 * 将datagrid内容，后台提供数据，按模版文件输出EXCEL
 * 
 * @param {string} urlForExcelStream 后台服务的URL，此服务生成数据，并生成EXCEL二进制流
 *                （可调用 ExcelImportExportUtil.formMultiPartToConditions 和 ExcelImportExportUtil.euiDataToExcelStream 辅助）
 * @param {object} queryParam 传到后台的检索参数，（此参数作为form的queryParams字段，被urlForExcelStream服务解析并使用）
 */
$.hd.commonUtils.backenExportExcelWithTemplate = function(urlForExcelStream,queryParam){
	var andItemStr="[]";
	var qParamStr="";
	if(!queryParam){
		queryParam={};
	}

	if(queryParam.andItems){      //已经是JSON, 分离出来(后台再组合),防止TOJSON过程中出现字符解析异常
		andItemStr=queryParam.andItems;
		queryParam.andItems=undefined;
	}
	
	var qParamStr=$.toJSON(queryParam);
	queryParam.andItems=andItemStr;		//2014-02-11 使用后还原andItems，防止下一次取到的andItems为空
	qParamStr=qParamStr.replace(/\"/g, "'");     //防止双引号对FORM语法产生影响
	andItemStr=andItemStr.replace(/\"/g, "~'~"); //由于andItems中有单引号,也有双引号,这样避免混淆.到服务器端再转化为双引号
    
    $.hd.commonUtils.postDataForDownload(urlForExcelStream, {queryParams:qParamStr,andItems:andItemStr});
};

/**
 * 动态加载js文件并执行js 这样：可以实现HTML与JS代码的分离，方便Js调试
 * 
 * 典型代码如下：
 * 
 * <script type="text/javascript"> $(document).ready(function(){
 * $.hd.commonUtils.JSLoader.load('plugin/gbiz/PortCargoSplit.js'[,callback1,callback2,....]);
 * }); </script>
 */
$.hd.commonUtils.JSLoaderClass = function() {
	var scripts = {}; // scripts['a.js'] = {loaded:false,funs:[]}

	//根据URL,从列表中得到脚本定义信息。如果尚未加载，则创建一个新的入口，并加载此代码
	function getScript(url) {
		var script = scripts[url];
		if (!script) {
			script = {
				loaded : false,
				funs : []
			};
			scripts[url] = script;
			add(script, url);
		}
		return script;
	}

	//运行一段脚本的初始化代码
	function run(script) {
		var funs = script.funs, len = funs.length, i = 0;

		for (; i < len; i++) {
			var fun = funs.pop();
			fun();
		}
	}

	//增加一个脚本的定义，动态加载到header中。 在加载结束后自动执行之
	function add(script, url) {
		var scriptdom = document.createElement('script');
		scriptdom.type = 'text/javascript';
		scriptdom.loaded = false;
		scriptdom.src = url;

		scriptdom.onload = function() {
			scriptdom.loaded = true;
			run(script);
			scriptdom.onload = scriptdom.onreadystatechange = null;
		};

		// for ie
		scriptdom.onreadystatechange = function() {
			if ((scriptdom.readyState === 'loaded' || scriptdom.readyState === 'complete')
					&& !scriptdom.loaded) {

				run(script);
				scriptdom.onload = scriptdom.onreadystatechange = null;
			}
		};

		document.getElementsByTagName('head')[0].appendChild(scriptdom);
	}
	return {
		load : function(url) {
			var arg = arguments, len = arg.length, i = 1;  //序号i=0对应url参数， 1对应第一个回调函数，可以有多个
			var script = getScript(url), loaded = script.loaded;

			for (; i < len; i++) {  //对系列回调函数的调用
				var fun = arg[i];
				if (typeof fun === 'function') {
					if (loaded) {
						fun();
					} else {
						script.funs.push(fun);
					}
				}
			}
		}
	};
};

// 直接可用的对象，方便编程。
$.hd.commonUtils.JSLoader = new $.hd.commonUtils.JSLoaderClass();

$.hd.commonUtils.formula = {
	/**
	 * 公式计算器
	 */
	calculator : {
		/**
		 * 给定变量及其取值，执行公式计算(使用局部变量，防止变量冲突。 使用自定义函数并立即执行)
		 * 
		 * @param {string}
		 *            formulaExp 公式表达式，文本
		 * @param {array}
		 *            variableValues 变量及其取值的键值对, 或者{KEY:x, VALUE:y}型对象的数组
		 * @param {boolean}
         *            throwError 是否抛出异常？ 默认不会抛出异常
		 */
		calculate : function(formulaExp, variableValues, throwError) {
			var prog = "(function(){ \n "; // 定义闭包函数
			if ($.isArray(variableValues)) { // 定义局部变量，暂时只支持字符串和数字
				$.each(variableValues, function(i, row) { // 这里如果使用for循环，i不是数组元素，而是下标，
															// 但i会取值
															// distinct等怪异的值，放弃
					var property = row.KEY;
					var value = row.VALUE;
					if (!value) {
						value = "null";
					} else if (typeof value !== 'number') {
						value = "'" + value + "'";
					}
					prog += " var " + property + " = " + value + ";\n"
				});
			} else {
				for ( var property in variableValues) {
					var value = variableValues[property];
					if (!value) {
						value = "null";
					} else if (typeof value !== 'number') {
						value = "'" + value + "'";
					}
					prog += " var " + property + " = " + value + ";\n"
				}
			}
			prog += " return " + formulaExp + ";\n"; // 函数体返回值，就是公式本身
			prog += " })();";
			try {
				return eval(prog); // 闭包函数的定义形如：(function(){a=2;return a+1;})();
			} catch (e) {
				if(throwError){
					throw e;
				}else{
    				$.hd.ezui.messager.status("根据公式(" + formulaExp + ")计算失败(已忽略):"
    						+ e);
    				return "";
				}
			}
		}
	},
	/**
	 * 词法分析器
	 * 
	 * @type type
	 */
	spliter : {
		split_rules : [ "(\\/\\/.*)", // 单行注释
		"(\\/\\*(\\/|\\**[^\\*])*\\*+\\/)", // 多行注释
		"(\\\"[^\\\"]\\\")|(\\'[^\\']*\\')", // 字符串
		"\\w+\\d*", // 标识符
		"\\d+", // 数字
		"(\\|\\|)|(&&)|\\|&|!|\\^", // 逻辑运算符
		"(<=)|(>=)|(==)|<|>", // 关系运算符
		"=|\\.|,|;|\\\|\\/", // 赋值，成员，逗号，斜杠
		"\\{|\\}|\\[|\\]|\\(|\\)" // 各种括号
		].join('|'),

		tokens : function(input) {
			var ret = [], r = null, regex = new RegExp(this.split_rules, "g");
			while ((r = regex.exec(input)) !== null) {
				ret.push(r[0]);
			}
			return ret;
		}
	},
	/**
	 * 调用JAVA后台的词法分析器，以便获得标识符的类型等信息。同时可保持与后台规则一致
	 * 
	 * @type type
	 */
	spliterInServer : {
		tokens : function(input) {
			if (!input || '' === input) {
				return [];
			}
			$.ajax({
				url : $.hd.commonUtils.getUrlBase()
						+ '../webresources/login/common/UtilsREST/splitFormula',
				type : "POST",
				dataType : "json",
				data : $.toJSON({
					formula : input
				}), // 目前只有这一个参数
				success : function(data) {
					return data.data;
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					$.hd.ezui.messager.status("公式解析失败:" + errorThrown);
					return [];
				}
			});// end ajax
		}
	}
};

/**
 * 
 * 发布消息,前台调用(独立事务). 如果要保证更新与发送消息的事务完整性,建议使用NewsReleaseUtil.publishNewsforTemplateCod方法
 * @param {object} newsObj 消息对象,必须包含tempCod和newsTxt字段,否则本函数将报错
 * 
 */
 $.hd.commonUtils.news={
     //FXQ2013-12-31增加消息发布的内容。如果直接写在commonUtils空间，空的对象不能构成命名空间
 }; 
 $.hd.commonUtils.news.publishNews=function(newsObj){
     if (!newsObj || !$.isPlainObject(newsObj)) {
        alert('[对编程人员提示]使用$.hd.commonUtils.news.publishNews但调用参数不是{}对象');
        return;
     }else if(!newsObj.tempCod || !newsObj.newsTxt){
        alert('[对编程人员提示]调用$.hd.commonUtils.news.publishNews参数对象中必须包含tempCod和newsTxt字段');
        return;
     }

     if(!newsObj.newsTitle){
     	newsObj.newsTitle="消息通知"; 
     }
     if(!newsObj.validDte){ //默认5天失效，与模版定义相同
        newsObj.validDte = new Date(new Date().getTime()+ 5*24*60*60*1000).format("yyyy-MM-dd hh:mm:ss");
     }
     if(!newsObj.newsTyp){
        newsObj.newsTyp="0";  //必须赋值，否则界面不会显示出来
     }
      
     /*  消息发布    */
     $.hd.commonUtils.doAjaxCall("../webresources/login/news/NewsReleaseREST/newsPublish",
            newsObj, //此参数应为非JSON格式对象
            function(data){
            	//这里的data来自messageCode对象的data，必为空，忽略  。正常则暂不提示了
//              $.messager.alert("发送信息", "消息["+newsObj.newsTitle+"]已经成功发送。", 'info');
                $.hd.ezui.messager.status("消息["+newsObj.newsTitle+"]已经成功发送。");
            },
            function(XMLHttpRequest, textStatus, errorThrown){
                $.messager.alert('错误','消息发布失败!'+ $.hd.ezui.messager.getDetail(errorThrown),'error');
            }
       );
 }

//由于dialog系列js分类别存放,公共部分放到本文件中了.
/**
 * 三类选船对象的公共代码，完成动态加载、ID增加后缀、清理dialog垃圾等功能
 * @param {String} url 工作JSP的URL，含动态条件&a=b（派生类提供）,但不包含&idSufix=_idSufix（本基类自动添加）
 * @returns {object} 对象本身
 */
$.hd.commonDialogs.DynamicDialogBase = function(url) {  //这里定义超类对象
  var _idSufix;              //实例变量：当前实例的ID后缀（由于实例缓存，当多个选船DIALOG存在时，靠后缀防止冲突）
        var _hasLoaded = false;    //实例变量：dialog是否已经被加载，用于缓存页面和Dialog对象及其数据，提高界面响应速度
        var theEzObjDialog = null; //实例变量：保存ezui创建的Dialog对象实例，不再每次创建
         
        var _dialogMethodSubGiven= undefined; //弹出对话框的工作方法，实现类设置。原型为 theEzObjDialog = showDialog(container, onOk, onCancel);
        var _dialogDivNameSubGiven ="";       //实现类DIV的ID，不包含动态添加的 _sufix， 对应于jsp文件中定义dialog的 <div>的ID
        
        /**
         * 获取设置的dialog实现方法，原型为showDialog(container, onOk, onCancel) 返回值为 theEzObjDialog
         */
        this.getDialogMethod=function(){
            return _dialogMethodSubGiven;
        }
        
        /**
         * 获得自动生成的id后缀，只在首次打开jsp时确定，后续不再变化，除非调用了destroy
         */
        this.getIdSurfix=function(){
            return _idSufix;
        }
        /**
         * 子类调用此方法设置DIALOG工作函数，此函数原型为showDialog(container, onOk, onCancel) 返回值为 theEzObjDialog
         */
        this.setDialogMethod=function(methodFunc){
            _dialogMethodSubGiven=methodFunc;
        }

        /**
         * 子类调用此方法设置div的ID，不包含动态添加的 _sufix， 对应于jsp文件中定义dialog的 <div>的ID
         */
        this.setDialogDivName=function(id){
            if("#"===id.charAt(0)){
                id=id.substr(1);
            }
            _dialogDivNameSubGiven=id;
        }
        //防止选船按钮连续点击导致选船弹出两个导致冲突的问题
        function beginAction() {
			$.messager.progress({
				title : "正在处理",
				text : "请求正在处理中，请稍候..."
			});
			setTimeout(function() {
				endAction();
			},20*1000);
		}
		function endAction() {
			$.messager.progress('close');
		}
			
        /**
         * 加载船舶选择网页并以对话框显示
         * @param {div} container 容器DIV（jquery对象），应定义ID或者NAME
         * @param {function(currentRowData/selectedRows)} onOk 成功时的回调函数
         * @param {function()} onCancel
         * 没有返回值
         */
        this.show = function(container, onOk, onCancel) {
            //若此前打开过此对话框，为防止与新LOAD的对话框ID冲突，删除之（由于查询条件_impOrExp等不同，不能重用只能重新LOAD)
            if(!_hasLoaded){
            	beginAction();
	            //初始化后缀串，此串只要加载成功，就不再变化！
	            _idSufix=container.attr('id');
	            if(!_idSufix){  //container没有定义ID
	                 _idSufix=container.attr('name'); 
	            }
	            if(!_idSufix){  //container也没有定义name,只好用随机的ID作为后缀了
	                 _idSufix='_'+$.hd.commonUtils.getRandomId(); 
	            }else{
	                 _idSufix='_'+_idSufix;
	            }
            
                var jqObjDialogPrev  = $('#'+ _dialogDivNameSubGiven + _idSufix);
                if(jqObjDialogPrev.size()>0){ 
                    jqObjDialogPrev.dialog('destroy'); 
//                  $.hd.ezui.messager.status("previous ShipSelection Dialog instance destroyed!");
                }
                
                loadAndShow(container,  //加载并打开对话框
                        function() {
                            if($.isFunction(_dialogMethodSubGiven)){
                                theEzObjDialog=_dialogMethodSubGiven(container, onOk, onCancel);
                            }
                            endAction();
                        }); //end of loadAndShow
//     说明：         不在这里设置_hasLoaded=true;而是在div.Load的回调中设置，确保只有在加载成功时此变量才为TRUE          
            }else{
                if($.isFunction(_dialogMethodSubGiven)){
                    theEzObjDialog=_dialogMethodSubGiven(container, onOk, onCancel);
                }
            } // end if _hasLoaded

        }; //end of funciton show

        /**
         * 关闭船舶显示对话框，一般在回调函数中使用
         * 没有参数；
         * 没有返回值
         */
        this.hide = function() {
            if(!_hasLoaded){  //防范代码
                return;  
            }
            theEzObjDialog.dialog({closed: true});
        };
        
        /**
         * 在关闭窗口前，清除网页中的 <div>实例
         */
        this.destroy=function(){
             if(!_hasLoaded){  //防范代码
                 return;  
             }
             theEzObjDialog.dialog('destroy');      
             _hasLoaded=false;
        }        
        
        /**
         * 工作方法，加载弹出页面到div，并赋予随机的ID（防止多次加载造成冲突）
         * @param {string} url 工作对象的url
         * @param {div} container 容器DIV（jquery对象），应定义ID或者NAME
         * @param {fucntion()} 加载成功后的回调函数
         * @returns 无返回值
         */        
        function loadAndShow(container, callback) {
            container.load(//为保证DIALG在加载之后才能显示（正确的时序），在回调函数中真正打开DIALOG
                    ( url.indexOf('?')>0 ? url+'&idSufix='+_idSufix : url+'?idSufix='+_idSufix),
                    {random:$.hd.commonUtils.getRandomId()},
                    function (){
                            $.parser.parse(container.selector);  //防止ezUI的 data-options型代码 未执行
                            _hasLoaded=true;    //加载成功才设置此标志，防止重复加载
                            if($.isFunction(callback)){
                                callback();
                            }else{
                                alert('编程错误，调用loadAndShow时没有给定callback方法，或者给定方法无效！');
                            }
                    } 
               );
        }
};

/**
* 检查是否有残留的DIALOG实例，如果有，先删除它（本方法在对话框打开之前调用， $('#id').dialog({...});）
* @param dialogId
*/
$.hd.commonDialogs.safeOpenDialog=function(dialogId){
       if(!dialogId){
           return;
       }else if("#"===dialogId.charAt(0)){
           dialogId=dialogId.substr(1);
       }
       
       var caller=$.hd.commonDialogs.safeOpenDialog.caller;  //在调用本方法的对象中增加标志，防止重复调用
       if(caller){
           if(caller.___alreadyDestroyed){    ///标志变量，保证此方法只对一个功能实例仅调用一次，且保证第二次打开此功能时能正常清除垃圾
               $.hd.ezui.messager.status('safeOpenDialog aleready callered. nothing todo');
               return;
           }
       }
       
       var jqInstances  = $('body div[id="'+dialogId+'"]');   //不能使用 $('#id') 这样只能找到一个DIV
       if(jqInstances.size()>1){     //如果只有一个实例，可能是定义div或者class="easyui-dialog"自动生成的window,不必清除
           $.each(jqInstances, function(i, element){
               var parent=$(element).parent();
               if(parent && parent.hasClass("panel")&& parent.hasClass("window")){  //这个DIV是panel+window ,认为是对话框实例
                   if("New Dialog"===$(element).dialog('options').title){
                       return true ; //这是 class="easyui-dialog"自动生成的dialog实例，继续找下一个 
//  问题：这样可以防止初次打开功能页时class="easyui-dialog"型dialog被删除的问题，但第二次打开将导致有2个"New Dialog"实例存在，导致程序混乱。要彻底解决这个遗留问题，建议通过修改dialog定义方式解决                     
                   }else{
                       parent.next(".window-shadow").remove();  //根据观察，这2个DIV是与DIALOG配合用的，dialog删除后，它们成为垃圾
                       parent.next(".window-mask").remove();

                       $(element).dialog('destroy');   
//  这样貌似也可以        parent.empty();   parent.remove();  
//                     $.hd.ezui.messager.status("previous dialog instance found and destroyed!");
                       return false;  //退出循环。删掉一个就可以了，如果两个都删，一般对应 class="easyui-dialog"的情形，会导致所有dialog实例被清除，程序不能工作了
                   }
               } //END if parent
           }); //end each
       } //end if size()
       
      if(caller){
         caller.___alreadyDestroyed=true;
      }
};
 

/**
 * 定义多个div切换编辑的默认动作 [警告]此方法必须在datagrid初始化完毕之后调用
 * @param {array} divArray  div对一个的jquery对象的数组
 * @param {function} selectionChageCallback 回调函数，返回当前选中的div的Id或者序号
 * @returns {undefined}
 */
$.hd.commonUtils.switchedDivs=function(divArray,selectionChageCallback){
    if(!$.isArray(divArray)|| !$.isFunction(divArray[0].size) || divArray[0].size()<1){
        alert('编程错误，$.hd.commonUtils.switchedDivs第一个参数应该是div对一个的jquery对象的数组。');
        return;
    }
    if(!selectionChageCallback){
        selectionChageCallback=function(selected){lg('selected:'+selected);};
    }else if(!$.isFunction(selectionChageCallback)){
        alert('编程错误，$.hd.commonUtils.switchedDivs第2个参数应该是接受选中div的回调函数。');
        return;
    }
    //对数组中的每个div定义切换的事件，并对其中包含的datagrid也注入切换事件
    $.each(divArray,function(i,jq){
        var selected= jq.attr('id')?jq.attr('id'):(function(){return i;})() ; //如果没有ID就返回序号
        var dg=findInsideDatagrid(jq);
        if(dg!=undefined){
            modiDatagridClickEvent($(dg),jq,selected);
        }
        jq.on("click",function(){
            selectDiv(jq,selected);
        });
    });
    //选中某个特定的div
    function selectDiv(div,selected){
        div.css('border', '2px solid #0092DC'); //设置选中状态
        $.each(divArray,function(i,jq2){ //其他的div都没有选中色
            if(jq2==div){return true;}
            jq2.css('border', '1px solid #d3d3d3');
            jq2.css('border', '1px solid #d3d3d3');
        });  
        selectionChageCallback(selected);
    }
    
    //找到div中的datagrid
    function findInsideDatagrid(div){
        var childs=div.find('table[id]:hidden'); //有Id属性，且具有style="display:none">  //children('.datagrid');    //
        return childs.length>0? childs[0]:undefined;
    }
    //在datagrid点击时，认为是div点击了
    function modiDatagridClickEvent(dg,div,selected){
        var opt=dg.datagrid('options');
        var oldCallback=opt.onClickRow;
        if(!oldCallback){
            opt.onClickRow=function(rowIndex, field, value){
                selectDiv(div,selected);
            };
        }else{
            opt.onClickRow=function(rowIndex, field, value){
                selectDiv(div,selected);
                oldCallback(rowIndex, field, value);
            };  
        }
    }
};

