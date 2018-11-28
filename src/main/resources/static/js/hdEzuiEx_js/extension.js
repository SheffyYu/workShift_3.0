/*
 * copyright@2016 HUADONG

 * author:jason <caiyj@huadong.net>
 */
/**
 *判断是否为空
 */
var isEmpty = function(target){
  if (target==undefined||target==null||target=='') {
    return true;
  } else {
    return false;
  }
};
/**
 * 重载四舍五入的方法（因为toFixed的默认规则是“4舍6入5取双”，重载为严格的四舍五入）
 * @param {int} len 小数位数
 * @return {Number} 舍入后的数字
 */
Number.prototype.toFixed = function(d){
	var s = this + "";
	if (!d) {
		d = 0;
	}
	if (s.indexOf(".") == -1)
		s += ".";
	s += new Array(d + 1).join("0");
	if (new RegExp("^(-|\\+)?(\\d+(\\.\\d{0," + (d + 1) + "})?)\\d*$").test(s)) {
		var s = "0" + RegExp.$2, pm = RegExp.$1, a = RegExp.$3.length, b = true;
		if (a == d + 2) {
			a = s.match(/\d/g);
			if (parseInt(a[a.length - 1]) > 4) {
				for (var i = a.length - 2; i >= 0; i--) {
					a[i] = parseInt(a[i]) + 1;
					if (a[i] == 10) {
						a[i] = 0;
						b = i != 1;
					} else
						break;
				}
			}
			s = a.join("").replace(new RegExp("(\\d+)(\\d{" + d + "})\\d$"), "$1.$2");
		}
		if (b){
			s = s.substr(1);
		}
		return (pm + s).replace(/\.$/, "");
	}
	return this + "";
};

/** 
 * 时间对象的格式化; 
 */  
Date.prototype.format = function(format) {
    var o = {
        "M+": this.getMonth() + 1, //month
        "d+": this.getDate(), //day
        "h+": this.getHours(), //hour
        "m+": this.getMinutes(), //minute
        "s+": this.getSeconds(), //second
        "q+": Math.floor((this.getMonth() + 3) / 3), //quarter
        "S": this.getMilliseconds() //millisecond
    };
    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length === 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
};


/**
 * by hecb 数组包含函数
 */
Array.prototype.contains = function(element) {
    for (var i = 0, len = this.length; i < len; i++) {
        if (this[i] == element) {
            return true;
        }
    }
    return false;
}
/**
 * 数组去重复函数
 */
Array.prototype.distinct = function() {
	var ret = [];
	var hash = {};
	var len = this.length;
	for(var i = 0; i < len; i++) {
	    var item = this[i];
	    if (hash[item] !== 1) {
	    	ret.push(item);
	    	hash[item] = 1;
	    }
	}
	return ret;
};

/**
 * 第一个数组减去第二个数组
 */
Array.prototype.diffWith=function(bArr){   
    if(bArr.length==0){
        return this;
    }
    var diff=[];
    var len = this.length;
    for(var i = 0; i < len; i++){
        if(!bArr.contains(this[i])){
            diff.push(this[i]);
        }
    }
    return diff;
}
/*
 * ------------------------------ 以下全局formatter等全局应用，被hdUtils替代             jason@20160929-------------------------------------------
 */
/**
 * 扩展validatebox的校验规则
 * @param {type} value 当前validatebox的值
 * @param {type} param 传递给validateTyp的参数，用于控制校验行为 
 */
$.extend($.fn.validatebox.defaults.rules, {  
	//判断输入内容的字节数不超过指定范围，如lengthb[0,100]
    lengthb: {  
        validator: function(value, param){
            var len = value.replace(/[^\x00-\xff]/g, "**").length;
            return len >= param[0] && len <= param[1];  
        },  
        message: 'Please enter a value between {0} and {1}.'  
    },
    checkSpace: {
    	validator: function(value, param){
            return value.search(/[\s]/g) == -1;  
        },  
        message: '不允许输入空格'
    },
    valNumber: {
        validator: function(value, param) {
            return 1.0*value == parseFloat(value);
        },
        message: '请输入数字！'
    },
    valDate: {
        validator: function(value, param) {
            return /^(\d{4})-(\d{2})-(\d{2})$/.test(value);
        },
        message: '日期格式不正确！'
    },
    valDatetime: {
        validator: function(value, param) {
            return /^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2})$/.test(value);
        },
        message: '日期时间格式不正确！'
    },
    maxLength: {
        validator: function(value, param) {
            return value.length <= param[0];
        },
        message: '最多输入{0}个字符'
    },
    telephone: {
        validator: function(value) {
            var pattern = new RegExp(/^((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)$/);
            return pattern.exec(value);
        },
        message: '请输入有效格式的座机号码、手机号或传真'
    },
    postcode: {
        validator: function(value) {
            var pattern = new RegExp(/^[1-9]{1}(\d+){5}$/);
            return pattern.exec(value);
        },
        message: '请输入有效格式的邮政编码'
    }
});


/**
 * modification log:
 * 
 *  v2   by fuxinqi  2013-8 to 2013-11  保持命名空间统一，对代码拆解，便于维护
 *  v1   by jason  on 2013-06-04， 规范命名空间，所有方法统一到此下。   
 *                     
 * 结构：$.hd.ezui              easyui相关操作
 *       $.hd.ezui.formatter    格式化
 *       $.hd.ezui.editor       编辑器
 */
$.extend($.hd, {
    ezui: {
        formatter: {
            /**
             * @param {type} value
             * @returns {Number}
             */
        	number: function(value, row, index) {
                return !value ? '' : '' + value;
            },
            number0: function(value, row, index) {  
                return  !value? '' : parseFloat(value).toFixed(0);//|| 0 === parseFloat(value)
            },
            number1: function(value, row, index) { 
                if (!value) {
                    return "";
                } else {
                    var v = parseFloat(value).toFixed(1).split(".");
                    var ret = v[0].replace(/\d+?(?=(?:\d{3})+$)/img, "$&,");
                    if (v.length > 1) {
                        ret += "." + v[1];
                    }
                    return ret;
                }
            },
            number2: function(value, row, index) {
                if (!value) {
                    return "";
                } else {
                    var v = parseFloat(value).toFixed(2).split(".");
                    var ret = v[0].replace(/\d+?(?=(?:\d{3})+$)/img, "$&,");
                    if (v.length > 1) {
                        ret += "." + v[1];
                    }
                    return ret;
                }
                //return  !value || 0 === parseFloat(value) ? '' : parseFloat(value).toFixed(2);
            },
            number3: function(value, row, index) {  
                if (!value) {
                    return "";
                } else {
                    var v = parseFloat(value).toFixed(3).split(".");
                    var ret = v[0].replace(/\d+?(?=(?:\d{3})+$)/img, "$&,");
                    if (v.length > 1) {
                        ret += "." + v[1];
                    }
                    return ret;
                }
               // return  !value || 0 === parseFloat(value) ? '' : parseFloat(value).toFixed(3);
            },
            number4: function(value, row, index) {  
                if (!value) {
                    return "";
                } else {
                    var v = parseFloat(value).toFixed(4).split(".");
                    var ret = v[0].replace(/\d+?(?=(?:\d{3})+$)/img, "$&,");
                    if (v.length > 1) {
                        ret += "." + v[1];
                    }
                    return ret;
                }
                //return  !value || 0 === parseFloat(value) ? '' : parseFloat(value).toFixed(4);
            },
            precision3: function(value, row, index) {  
                return  !value || 0 === parseFloat(value) ? '' : parseFloat(value).toFixed(3);
            },
            precision0: function(value, row, index) {  
                return  !value || 0 === parseFloat(value) ? '' : parseFloat(value).toFixed(0);
            },
            precision2: function(value, row, index) {
                return  !value || 0 === parseFloat(value) ? '' : parseFloat(value).toFixed(2);
            },
            precision4: function(value, row, index) {  
                return  !value || 0 === parseFloat(value) ? '' : parseFloat(value).toFixed(4);
            },
            checkbox: function(value, row, index) {
                return value == '1' ? '<b>√</b>' : 'x';
            },
            checkboxN: function(value, row, index) {   //没有x的
                return value == '1' ? '<b>√</b>' : '';
            },
            reverseCheckbox: function(value, row, index) {
                return value == '0' ? '<b>√</b>' : 'x';
            },
            percent:function(value,row,index){  
                return  !value  ? '' : (Math.round(value * 10000)/100).toFixed(2) + '%';
            },
            yesNo:function(value,row,index){  
                 if (value == '1'){ return "是";  
                     } else {  return "否";  
                 }  
            },
            checkbox2: function(value, row, index) {  //显示为真正chekbox的
                return "<input type='checkbox' value=" + value + (value == 1 ? " checked=true />" : " />");
            },
            datetime: function(value, row, index) {
                return value ? new Date(value).format('yyyy-MM-dd hh:mm:ss') : '';
            },
            datetimeWithoutSeconds: function(value, row, index) {
            	return value ? new Date(value).format('yyyy-MM-dd hh:mm') : '';
            },
            date: function(value, row, index) {
               // return value ? value.substr(0, 10) : "";
            	return value ? new Date(value).format('yyyy-MM-dd') : '';
            },
            thousands: function(value, row, index) {
                return (value.toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');  
            },
            numberbox: function(value, row, index) {
                return !value || 0 === parseFloat(value) ? '' : '' + value;
            }
        },
        editor: {
            checkbox: {type: 'checkbox', options: {on: '1', off: '0'}},
            checkbox2: function(options) {
                var edit = {type: 'checkbox',
                    options: {
                    	on: '1', 
                    	off: '0',
                    	onChange: options.onChange ? options.onChange : function(){}
                    }
                };
                return edit;
            },
            validatebox:function(bRequired,opts) {
            	var options={required:true===bRequired};
            	if($.isPlainObject(opts)){
            		$.extend(true,options,opts);
            	}
            	return {
                    type: 'validatebox', options: options
            	}
            },
            textbox: function(len, isrequired) {
                var edit = {type: 'validatebox',
                    options: {
                        required: isrequired,
                        validType: 'lengthb[0,' + len + ']',  //对应数据库的宽度
                        invalidMessage: '文本超出限定宽度'
                    }
                };
                return edit;
            },
            numberbox: function(len, prec,isRequired) {
                var edit =
                        {type: 'numberbox',
                            options: {
                                required: isRequired ? isRequired: false,
                                precision: prec,
                                validType: 'length[0,' + len + ']',
                                invalidMessage: '数据超出位数(含小数点):' + len
                            }
                        };
                return edit;
            }
        }
    }
 }); 
//shenhui 颜色选择器
$.extend($.fn.datagrid.defaults.editors, {
    colorpicker: {//colorpicker就是你要自定义editor的名称
        init: function (container, options) {
            // var input = $('<input class="easyuidatetimebox">').appendTo(container);
            var input = $('<input>').appendTo(container);

            input.ColorPicker({
                color: '#0000ff',
                onShow: function (colpkr) {
                    $(colpkr).fadeIn(500);
                    return false;
                },
                onHide: function (colpkr) {
                    $(colpkr).fadeOut(500);
                    return false;
                },
                onChange: function (hsb, hex, rgb) {        
                    input.css('backgroundColor', '#' + hex);
                    input.val('#' + hex);
                }
            });
            return input;
        },
        getValue: function (target) {
            return $(target).val();
        },
        setValue: function (target, value) {
            // 特殊处理, 因为在flash里使用的是0x16进制格式
            //value = value.replace(/0x/, "#");
            $(target).val(value);
            $(target).css('backgroundColor', value);
            $(target).ColorPickerSetColor(value);
        },
        resize: function (target, width) {
            var input = $(target);
            if ($.boxModel == true) {
                input.width(width - (input.outerWidth() - input.width()));
            } else {
                input.width(width);
            }
        }
    }
});




/**
 * Datagrid操作伴侣：封装大部分对datagrid的操作，直接支持代码生成器代码
 * @param {type} datagrid
 * @param {type} url
 * @returns {DatagridOperation}
 */
function DatagridOperation(_datagrid, datagridUrl, filterColumn) {
    var datagrid=_datagrid;
    var url = datagridUrl;
    var autoLogModification=false;  //操作日志记录的开关。当为true时将操作日志写入后台
    var dataNam=url;   //数据名称，用于记录操作日志
    var idFields=[];   //主键列名的字符串数组
    var andItems = [];
    var queryParams = {
        columns: filterColumn,
        andItems: $.toJSON(andItems)
    };

    var selectedIndex = undefined;  //工作变量，当前选中行。可能与_datagrid.datagrid('getSelected')不一致，用于在数据校验失败时防止换行
    var _this=this;                 //工作变量,防止this含义在函数体中的模糊含义导致程序异常.
 
    /**
     * 打开自动记录日志的开关，否则就要调用 logModification()方法主动记录了
     * @param {string} _dataNam 数据名称，用于记录操作日志
     * @param {array} _idFields 主键列名的字符串数组
     */
    this.enableAutoLogModification=function(_dataNam,_idFields){
        autoLogModification=true;
        dataNam=_dataNam ? _dataNam:(dataNam?dataNam:url);
        if($.isArray(_idFields) && _idFields.length >0){
           idFields=[].concat(_idFields);  //拷贝动作. 不知为什么  idFields=[]; idFields.concat不能改变idFields内容
        }else if(idFields.length<1){  
            if(_datagrid.datagrid('options').idField){
                idFields.push(""+_datagrid.datagrid('options').idField);
            }else{     //参数不对,还没有idField定义,只能关闭记录开关
              autoLogModification=false;
            }
        }
        return autoLogModification;
    }
    
    /**
     * 尝试强制记录日志, 并影响内部变量dataNam,idFields的值.但不改变自动记录开关的状态
     * @param {string} _dataNam 数据名称，用于在操作日志用于标识同一功能的不同数据源
     * @param {array} _idFields 主键列名的数组
     * @param {function} callback当记录成功后的回调函数
     * @return {Boolean} 如果参数错误无法记录,或者数据未改变返回false。注意返回true只能说明发送请求成功，如果确保记录成功,应当在回调函数中判断
     */
    this.logModification=function(_dataNam,_idFields,callback){
        var oldFlag=autoLogModification;
        if(!_this.enableAutoLogModification(_dataNam,_idFields)){  //借用此函数对内部变量赋值,同时测试参数的合法性
            return false;             //
        }
        autoLogModification=oldFlag;  //本方法不应真正改变自动记录开关,只能影响dataNam,idFields的设置
        if(!_this.isChanged()) {
            return false ;   //没有更改,或者更改已经提交并reload了,没有什么可记录的
        }
        $.hd.commonUtils.auditDatagridRowModification(_datagrid,dataNam,idFields,function(){
            if($.isFunction(callback)){  //进入了auditDatagridRowModification的回调函数,说明更新日志成功了
               callback();
            }
        }); 
        return true;      //auditDatagridRowModification的回调函数是异步执行的。此返回值只能说明发送请求成功，如果确保记录成功,应当在回调函数中判断
    }
    
    /**
     * 当datagrid使用OnSelect时，增加一条数据时使用。
     * @author jason<caiyj@huadong.net>
     * @type Boolean|b|Boolean
     */
    var _insert = false;
    function endEditing() {
        if (selectedIndex == undefined) {
            return true;
        }

        // fxq 2013-8-14  对比南通最新代码，删除冗余无用的代码 （combogrid无效值的校验）
        if (datagrid.datagrid('validateRow', selectedIndex)) {
            datagrid.datagrid('endEdit', selectedIndex);
            return true;
        } else {
          //$.messager.alert(INFO, INFO_INVALID, "info");//移入clickRow方法中
            return false;
        }
    }
    function _getSelectedRowIndex(){
        try {
            selectedIndex = datagrid.datagrid('getRowIndex', datagrid
                            .datagrid('getSelected'));
            if(selectedIndex < 0){
                selectedIndex = undefined;
            }
        } catch (e) {
            selectedIndex = undefined;
        }
        return selectedIndex;
    }
    this.isEditing = function() {
        var eds = datagrid.datagrid('getEditors', selectedIndex);
        if (eds != "") {
            return true;
        } else {
            return false;
        }
    };
    this.getSelectedRowIndex = _getSelectedRowIndex;
    
    this.getDagagrid=function(){
    	return datagrid;
    }
    
    this.getUrl = function() {
        return datagrid.datagrid('options').url;
    };
    this.setUrl = function(newUrl) {
        url = newUrl;
    };
    this.getOptions = function() {
        return datagrid.datagrid('options');
    };
    
    this.getQueryParams = function() {
        //在datagrid初始化前，返回本对象定义的 param， 用于初始化datagrid
        if('options' in datagrid){
            return datagrid.datagrid('options').queryParams;
        }else{
            return queryParams;
        }
    };
    this.setQueryParams = function(queryParams) {
        datagrid.datagrid('options').queryParams = queryParams;
    };
    this.getSelectedRow = function() {
        if (_getSelectedRowIndex() !== undefined) {
            return datagrid.datagrid("getRows")[selectedIndex];
        }else{
            return undefined;
        }
    };
    this.setColumns = function(columns) {
        datagrid.datagrid("options").columns = columns;
    };
    this.setToolbar = function(toolbar) {
        datagrid.datagrid("options").toolbar = toolbar;
    };
    this.clearData = function() {
        datagrid.datagrid('loadData', {total: 0, rows: []});
    };
    this.addAndItem = function(column, queryStr, operator, queryStr2) {
        $.hd.search.addAndItem(queryParams, andItems, column, queryStr, operator, queryStr2);
    };
    this.removeAndItem = function(column) {
        $.hd.search.removeAndItem(queryParams, andItems, column);
    };
    function editRow(callback) {
        datagrid.datagrid("loading");
        selectedIndex = _getSelectedRowIndex();
        if (selectedIndex == undefined) {
            datagrid.datagrid("loaded");
            $.messager.alert(INFO, INFO_EDIT, "info");
            return;
        }
        setTimeout(function() {
            datagrid.datagrid('selectRow', selectedIndex)
                    .datagrid('beginEdit', selectedIndex);
            datagridBindEnter(datagrid, selectedIndex);
            datagrid.datagrid("loaded");
            if ($.isFunction(callback)) {
                callback();
            }
        }, 10);
    }
    this.endEdit = endEditing;

    this.isInsert = function() {
        return _insert;
    };
    this.setInsert = function(b) {
        _insert = b;
    };
    this.add = function(defaultData, notEdit) {
        if (endEditing()) {
            var rowData = {};
            if (defaultData && !(defaultData instanceof jQuery.Event)) {//不传参数默认传jQuery.Event对象，已判断此种情况
                rowData = defaultData;
            }
            selectedIndex = 0;
            _insert = true;
            if (notEdit) {
                datagrid.datagrid('insertRow', {index: selectedIndex, row: rowData})
                        .datagrid('selectRow', selectedIndex);
            } else {
                datagrid.datagrid('insertRow', {index: selectedIndex, row: rowData})
                        .datagrid('selectRow', selectedIndex)
                        .datagrid('beginEdit', selectedIndex);
            }
        }else{
            $.messager.alert(INFO, INFO_INVALID, "info");
        }
    };
    this.remove = function(callback,multi) {
    	if(true!==multi){
            selectedIndex = _getSelectedRowIndex();
            if (selectedIndex == undefined) {
                $.messager.alert(INFO, "没有选择要删除的数据！", "info");
                return;
            }
            $.messager.confirm(CONFIRM, CONFIRM_DELETE, function(r) {
                if (r) {
                    datagrid.datagrid('cancelEdit', selectedIndex)
                            .datagrid('deleteRow', selectedIndex);
                    if (jQuery.isFunction(callback)) {
                        callback();
                    }
                    selectedIndex = undefined;
                }
            });
    	}else{
    		var selectedRows=datagrid.datagrid('getChecked').length > 0 ? 
    				datagrid.datagrid('getChecked') : datagrid.datagrid('getSelections');  //一般是在单选状态下通过对钩多选
    		if(selectedRows.length<1){
    			$.messager.alert(INFO, "没有选择要删除的行（通过单击各行,或者通过复选框多选）。", "info");
                return;
    		}
            $.messager.confirm(CONFIRM, "要删除选中的全部数据吗（共"+selectedRows.length+"行）?", function(r) {
                if (r) {
                	var rowIndex = _getSelectedRowIndex();
                	if(rowIndex){datagrid.datagrid('cancelEdit', selectedIndex);};
                    $.each(selectedRows.reverse(),function(i,row){  //必须反序删除，否则行号将不对
                    	var rowIndex =datagrid.datagrid('getRowIndex',row);
                    	if(rowIndex||0==rowIndex){datagrid.datagrid('deleteRow', rowIndex);};
                    });
                    
                    if (jQuery.isFunction(callback)) {
                        callback();
                    }
                    selectedIndex = undefined;
                }
            });    		
    	} //END else multi
    };
    this.edit = editRow;
    /**
     * excludeColumn 需要排除的字段列，单列可为字符串，多列为数组
     * defaultData 其他默认值
     * ifEdit true--编辑状态
     */
    this.copy = function(excludeColumn, defaultData, ifEdit) {
        selectedIndex = _getSelectedRowIndex();
        if (selectedIndex == undefined) {
            $.messager.alert(INFO, "没有选择要复制的数据！", "info");
            return;
        }
        var row = datagrid.datagrid('getSelected');
        var copyRow = {};
        if (excludeColumn instanceof Array) {
            $.each(row, function(name, value) {
                if (!excludeColumn.contains(name)) {
                    copyRow[name] = value;
                }
            });
        } else {
            $.each(row, function(name, value) {
                if (excludeColumn != name) {
                    copyRow[name] = value;
                }
            });
        }
        if(!defaultData || !$.isPlainObject(defaultData)){
            defaultData = {};  //保持兼容，防范undefined
        }
        $.each(defaultData, function(name, value) {
            copyRow[name] = value;
        });
        //datagrid.datagrid('appendRow', copyRow);
        if (ifEdit) {
        	datagrid.datagrid('insertRow', {index: 0, row: copyRow})
	    		.datagrid('selectRow', 0)
	            .datagrid('beginEdit', 0);
        } else {
        	datagrid.datagrid('insertRow', {index: 0, row: copyRow})
        		.datagrid('selectRow', 0);
        }
        selectedIndex = 0;
    };
    /**
     * 保存当前数据的方法　　fxq2013-12-28 增加‘不刷新’的选项。默认情况下才刷新
     * @param {function} callback 执行成功后的回调方法
     * @param {bool} keepData 如果为true则不保存成功后并不刷新界面
     */
    this.save = function(callback,keepData) {
        var changedData = {};
        if (endEditing()) {
            var changedRows = datagrid.datagrid('getChanges');
            if (changedRows.length > 0) {
                changedData.insertedRows = datagrid.datagrid('getChanges', 'inserted');
                changedData.updatedRows = datagrid.datagrid('getChanges', 'updated');
                changedData.deletedRows = datagrid.datagrid('getChanges', 'deleted');
              //FXQ2013-12-27压缩数据量  changedData.originalRows = datagrid.datagrid('getOrginalData');   //使用在Loader中保存的数据，而不是用datagrid('getData'),因为后者是修改后的值。
                
                var msg = "";
                if (changedData.insertedRows.length > 0) {
                    msg += "将添加" + changedData.insertedRows.length + "条数据！<br />";
                }
                if (changedData.updatedRows.length > 0) {
                    msg += "将更新" + changedData.updatedRows.length + "条数据！<br />";
                }
                if (changedData.deletedRows.length > 0) {
                    msg += "将删除" + changedData.deletedRows.length + "条数据！";
                }
                $.messager.confirm(CONFIRM, msg, function(r) {
                    if (r) {
                        realSave();
                    }
                });
            } else {
                $.messager.alert(INFO, INFO_NO_CHANGE, "info");
            }
        }else{
            $.messager.alert(INFO, INFO_INVALID, "info");   //fxq2013-9-23 存盘前校验不通过无错误提示，令用户费解
        }
                //防止选船按钮连续点击导致选船弹出两个导致冲突的问题
        function beginAction() {
            $.messager.progress({
                title : "正在保存",
                text : "正在将数据存盘，请等待(即使本提示消失后),直到有成功或失败的提示..."
            });
            setTimeout(function() {
                endAction();
            },40*1000);
        }
        function endAction() {
            $.messager.progress('close');
        }
        //FXQ2013-12-28为防止重复保存，加入ＰＲＯＧＲＥＳＳ，因此抽取了ＡＪＡＸ存盘的方法为内部函数
        function realSave(){
        	beginAction();
            $.ajax({
                url: url,      //此URL一般不同于查询的URL，在构造函数给出
                type: "POST",
                dataType: "json",
                data: $.toJSON(changedData),
                success: function(data) {
                	endAction();
                    $.hd.ezui.messager.show(data, function() { 
                        if(true===autoLogModification){
                            _this.logModification(dataNam,idFields);    //2013-11-1 FXQ 增加记录操作日志的功能
                        }
                        if(keepData){
                            //默认情况下 	keepData = undefined 会自动刷新,因此数据修改标志被清空.这要强制清空才行.
                        	datagrid.datagrid('acceptChanges'); 
                        }else{
                            datagrid.datagrid('reload');     //不必等日志记录的结果. 除了ajax调用之外,js代码还是顺序实行的,因此不用担心reload会影响记日志之前获取更改数据
                        }
                        if (jQuery.isFunction(callback)) {   //FXQ 2013-10-31 只有保存成功才执行回调! show的回调函数具有这个特性
                            callback();
                        }
                    });
                },
                error : function(XMLHttpRequest, textStatus, errorThrown) {
                    endAction();
                	$.messager.alert("发现错误", "更新后台数据失败:" 
                                              + $.hd.ezui.messager.getDetail(errorThrown), 'error');
               }
            });         
        }
    };
    this.clickRow = function(rowIndex, rowData) {
        if (rowIndex != selectedIndex) {
            if (endEditing()) {
                selectedIndex = rowIndex;
            }else{
                $.messager.alert(INFO, INFO_INVALID, "info", function(){
                    datagrid.datagrid('selectRow', selectedIndex);   //fxq:校验不通过，不允许换行
                });
            }
        }
    };

    this.selectRow = function(rowIndex, rowData) {
        selectedIndex = rowIndex;
        datagrid.datagrid('selectRow', selectedIndex);
    };

    /**
     * 设置当前row。
     * @author jason
     * @param {type} rowIndex
     * @returns {undefined}
     */
    this.setRowIndex = function(rowIndex) {
        selectedIndex = rowIndex;
    };

    this.dblClickRow = function(rowIndex, rowData) {
        if (endEditing()) {
            selectedIndex = rowIndex;
            datagrid.datagrid('selectRow', selectedIndex);
            editRow();
        }else{
            $.messager.alert(INFO, INFO_INVALID, "info", function(){
                datagrid.datagrid('selectRow', selectedIndex);
            });
        }
    };
    /**
     * 数据变更提示。
     * @author jason<caiyj@huadong.net>
     * @param {type} callback
     * @returns {undefined}
     */
    this.changedCallback = function(callback) {
        //if (endEditing()) {
            var changes = datagrid.datagrid('getChanges');
            if (changes.length > 0) {
                $.messager.confirm(CONFIRM, CONFIRM_RETRIEVE, function(r) {
                    if (r) {
                        callback();
                    }
                });
            } else {
                callback();
            }
        //}
    };
    //2013-10-16 isChanged()/load/reload方法取消endEditing判断
    this.isChanged = function() {
        //if (endEditing()) {
            var changes = datagrid.datagrid('getChanges');
            if (changes.length > 0) {
                return true;
            } else {
                return false;
            }
        //}
    };

    //此方法与reload不同，强制回到第一页
  //2013-10-16 load/reload方法取消endEditing判断，会导致校验不通过时不刷新
  //2014-8-30 load/reload方法增加查询参数，以便与easyUI的datagrid方法兼容
    this.load = function(param) {
    	if(!$.isPlainObject(param)||(param instanceof $.Event)){ //类似 $("#id").on("click", operation.load);的调用，load会被传递一个Event对象作为参数
    		param=undefined;
    	}
    	//if (endEditing()) {
            var changes = datagrid.datagrid('getChanges');
            if (changes.length > 0) {
                $.messager.confirm(CONFIRM, CONFIRM_RELOAD, function(r) {
                    if (r) {
                        selectedIndex = undefined;
                        datagrid.datagrid('load',param);
                    }
                });
            } else {
                selectedIndex = undefined;
                datagrid.datagrid('load',param);
            }
        //}
    };

    this.reload = function(param) {
    	if(!$.isPlainObject(param) ||(param instanceof  $.Event)){  //类似 $("#id").on("click", operation.reload);的调用，reload会被传递一个Event对象作为参数
    		param=undefined;
    	}
        //if (endEditing()) {
            var changes = datagrid.datagrid('getChanges');
            if (changes.length > 0) {
                $.messager.confirm(CONFIRM, CONFIRM_RELOAD, function(r) {
                    if (r) {
                        selectedIndex = undefined;
                        datagrid.datagrid('reload',param);
                    }
                });
            } else {
                selectedIndex = undefined;
                datagrid.datagrid('reload',param);
            }
        //}
    };
    this.undo = function() {
        if (endEditing()) {
            var changes = datagrid.datagrid('getChanges');
            if (changes.length > 0) {
                $.messager.confirm(CONFIRM, CONFIRM_CANCEL, function(r) {
                    if (r) {
                        datagrid.datagrid('rejectChanges');
                    }
                });
            }
        }else{
            $.messager.confirm(CONFIRM, CONFIRM_CANCEL, function(r) {
                if (r) {
                    datagrid.datagrid('rejectChanges');   //fxq: 不论是否校验通过都取消
                }
            });
        }
    };
}

/*
说明： 在使用公司统一类库后，保留对于GCTOS已有程序兼容性的代码

author:jason <fuxq@huadong.net>

Modifications:

1.1 2015-12-10 by fuxinqi: 不再使用DatagridOperation中的QueryParam参数。针对AddAndItem增加方便的快捷方法addAndItem,放入ghbase-compitable
1.0 2015-05-09 by fuxinqi: 使用新类库后，为降低GCTOS已有代码降低难度，从原extension.js分离出本文件
*
*/

if(DatagridOperation === undefined){
   alert('编程错误，ghbase-compatible.js必须在ghbase-extension.js之后引入，以便实现对已有代码的兼容');
}
//内部工作函数
function ____checkDatagridOperationStatus(_this){   
   var datagrid= _this.getDagagrid();
   if(!('datagrid' in datagrid)){
       $.messager.alert('编程警告，DatagridOperation对象中已经没有默认的queryParams参数，调用addAndItem或者removeAndItem前，datagrid必须已经初始化完毕。','error');
       return null;
   }
   var queryParams = _this.getQueryParams();
   var andItems= queryParams.andItems && ""!==queryParams.andItems ? $.evalJSON(queryParams.andItems):[];
   if(!$.isArray(andItems)){
       $.messager.alert('编程错误，设置datagrid的queryParams参数时，其andItem属性必须是一个数组，并且已经转换为JSON格式。','error');
       return null;   
   }
   return {queryParams:queryParams,andItems:andItems};
}

DatagridOperation.prototype.addAndItem = function (column, queryStr, operator, queryStr2) {
   var ok=____checkDatagridOperationStatus(this);
   if(!ok){ return; }
   $.hd.search.addAndItem(ok.queryParams, ok.andItems, column, queryStr, operator, queryStr2);
};
   
DatagridOperation.prototype.removeAndItem = function (column) {
   var ok=____checkDatagridOperationStatus(this);
   if(!ok){ return; }
   $.hd.search.removeAndItem(ok.queryParams, ok.andItems, column);
};

/**
* 判断时间大小。
* @author jason<caiyj@huadong.net>
* @param {type} begDt
* @param {type} endDt
* @returns {undefined}
*/
function ltDate(begDt, endDt) {

   if (Date.CreateDateTime(begDt) - Date.CreateDateTime(endDt) > 0) {
       return false;
   } else {
       return true;
   }
}

/**
* 数字比较
* @author jason<caiyj@huadong.net>
* @param {type} lowNum
* @param {type} hightNum
* @returns {Boolean}
*/
function ltNum(lowNum, hightNum) {
   if (lowNum > hightNum) {
       return false;
   } else {
       return true;
   }
}

//lisl2015-6-19cfd移植
$.extend($.hd, {
   util: {
       getUrlParam: function(name)
       {
           var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
           var r = window.location.search.substr(1).match(reg);
           if (r != null)
               return unescape(r[2]);
           return null;
       },
       getBillTyp: function(tradeId, inExId) {
           if (tradeId == '1' && inExId == 'I') {
               return 'WJ';
           } else if (tradeId == '1' && inExId == 'E') {
               return 'WC';
           } else if (tradeId == '2' && inExId == 'I') {
               return 'NJ';
           } else if (tradeId == '2' && inExId == 'E') {
               return 'NC';
           }
       }
   }
});


/**
*     兼容代码，ezui前端显示类辅助组件，保持与原GCTOS代码兼容
*       $.hd.ezui.messager    继承过来，减少已有程序修改
*       $.hd.ezui.numberspinner 继承过来
*       $.hd.ezui.formatter   在公司 extension.js中
*       $.hd.ezui.editor      在公司 extension.js中
*/
$.extend($.hd.ezui, {    //BY fuxinqi 2013-8-14 为了抽取独立的$.hd.commonUtils文件，将命名空间$.hd定义移到更高层
       messager: {
           bottomRight: function(msg, title, timeout, showType) {
               $.messager.show({
                   title: title ? title : '提示消息',
                   msg: msg,
                   timeout: timeout ? timeout : 2000,
                   showType: showType ? showType : 'slide',
                   height: 150
               });
           },
           /**
            * 状态栏消息。
            * @param {type} msg 消息
            * @returns {undefined}
            */
           status: function(msg) {
           	var time=new Date().format('yyyy-MM-dd hh:mm:ss');
           	try{
                   //2015-11-20 by fuxinqi 新界面的消息提示
                   $('#mainBodyMsg') .panel({title: time+" 信息： "+msg}); 
                  // $('#mainBody').layout('panel', 'south').panel({title: time+" 信息： "+msg}); //避开javascript:void(0)，并防止误读老信息
           	}catch(e){}   //在调试方式下，找不到 #mainBody
           },
           /**
            * 根据后台执行结果，在状态条提示（也可弹出提示），或者弹出对话框显示错误信息
            * @param {} data 服务器返回的信息代码（约定，第4位为1表示成功，0 表示失败）
            * @param {} callback 成功时的回调函数
            * @param {} showDialgOnSuccess 控制在成功时是否也弹出提示。默认在状态栏显示成功的信息
            */
           show: function(data, callback, showDialgOnSuccess) {  
               if (data) {
                   if (data.code && data.code.charAt(3) === '1') {  // success
                   	if(showDialgOnSuccess){
                   	    $.messager.alert("提示", data.message, "info");
                   	}else{
                   		$.hd.ezui.messager.status(data.message);
                   	}
                       if ($.isFunction(callback)) {
                           callback();
                       }
                   } else {  // error
                       var msg = "";
                       msg += "代码：" + data.code + "<br />";
                       msg += "信息：" + data.message ;
                       if (data.detail) {    //代码复用
                       	msg +=$.hd.ezui.messager.getDetail(data);
                       }
                       $.messager.alert("返回信息", msg, "warning");
                   }
               } else {
                   $.messager.alert("返回信息", "无消息！", "info");
               }
         },
         getDetail:function(data){  //以统一的方式显示返回信息和错误提示
       	  var content;
             if (data.detail) {
                 content = data.detail.replace(/\"/g, "").replace(/\'/g, "");
             }else{
           	  content=""+data;
             }
             return "<br/>详细：" + "<span title=\"" + content + "\" onClick=\"alert('" + content.replace(/\r/g, "").replace(/\n/g, "\\n") + "')\"><font color=red>点击查看</font></span>"
         },
         info: function(msg) {
             $.messager.alert("提示", msg, "info");
         }
       },
       numberspinner: {
           year: {
               required: true,
               width: 55,
               min: 2000,
               max: 3000,
               value: new Date().getFullYear()
           },
           month: {
               required: true,
               width: 40,
               min: 1,
               max: 12,
               value: new Date().getMonth() + 1
           }
       },
       dialog: {
           show: function(params) {
               var _def = {
                   title: "", // 标题
                   href: "", //'plugin/gship/shipRecordCardPlanDlg.html',
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
               if (params.href.indexOf("?") >= 0) {
                   str = "&";
               }
               params.href = params.href + str + "timestamp=" + new Date().getTime();
               $.extend(_def, params);
               if(params.buttons != undefined){
               	_def.buttons =params.buttons;
               } else if (params.callback != undefined) {
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
                           $.hd.ezui.dialog.saveHandler();
//                               $.hd.ezui.dialog.saveHandler = undefined;
                       }
                   }, {
                       text: '关闭',
                       iconCls: "icon-cancel",
                       handler: function() {
//                               $.hd.ezui.dialog.formHandler = undefined;
                           $("#mainDlg").dialog("close");//.hd.ezui.dialog.close();
                       }
                   }];
               } else if (params.isNoButtons) {
                   _def.buttons = [];
               } else {
                   _def.buttons = [{
                       text: '关闭',
                       iconCls: "icon-cancel",
                       handler: function() {
                           $("#mainDlg").dialog("close");
                       }}];

               }
               // 绑定enter,esc键。
               $(document).bind("keyup", function(event) {
                   if (event.which == 27) {
                       $("#mainDlg").dialog("options").callback = undefined;
                       $("#mainDlg").dialog("close");
                   }
//                   else if (event.which == 13) {
//                       // 回掉函数
//                       if (params.callback != undefined) {
//                           var data = $("#mainDlgDatagrid").datagrid("getSelections");
//                           if (data.length == 0) {
//                               $.hd.ezui.messager.info("请选择一条数据！");
//                           } else {
//                               params.callback(data);
//                               $("#mainDlg").dialog("options").callback = null;
//                               $("#mainDlg").dialog("close");
//                           }
//                       }
//                   }
               });
               $("#mainDlg").dialog(_def);
           },
           setValue: function(param, value) {
               var opts = $("#mainDlg").dialog("options");
               if (opts != undefined) {
                   eval("opts." + param + "=value");
               }
           },
           getValue: function(param) {
               var opts = $("#mainDlg").dialog("options");
               if (opts != undefined) {
                   var p = eval("opts." + param);
                   return p;
               } else {
                   return undefined;
               }
           },
           saveHandler: undefined,
           close: function() {
               $("#mainDlg").dialog({param1: undefined});
               $("#mainDlg").dialog("close");
           }
       }
});  //END OF $.hd.ezui      


/**
** 对queryParam的处理，与公司新类库参数约定【不兼容！】
*  为与公司新类库兼容，需要做如下替换
*     andItems --> andClause
*     orItems  --> orClause
*     columns  --> queryColumns
*/
$.extend($.hd, {
	search: {
       getItem: function(column, queryStr, operator, queryStr2) {
           var o = {};
           if (!operator) {
               o = {column: column, value: queryStr};
           } else if (!queryStr2) {
               o = {column: column, value: queryStr, operator: operator};
           } else {
               o = {column: column, value: queryStr, operator: operator, value2: queryStr2};
           }
           return o;
       },
       removeAndItem: function(queryParams, andItems, column) {
           $.each(andItems, function(i) {
               if (this.column === column) {
                   andItems.splice(i, 1);
                   return false;
               }
           });
           queryParams.andItems = $.toJSON(andItems);
       },
       addAndItem: function(queryParams, andItems, column, queryStr, operator, queryStr2) {
       	if( $.isArray(column)){  /*fxq 2014-7-21 增加对 anditems中的orItems的支持*/
       		alert("编程提示：$.hd.search.addAndItem中增加了orItems作为条件，后台代码暂不支持！请使用$.hd.search.addOrItem实现。")
       		andItems.push(column); //这里实际是PUSH进去一个orItems的数组对象
       	}else{
               var updated = false;  //是否有的元素被改变了
           	var o = this.getItem(column, queryStr, operator, queryStr2);
               $.each(andItems, function(i) {
                   if (this.column === column) {
                       andItems[i] = o;
                       updated = true;
                       return false;
                   }
               });
               if (!updated) {
                   andItems.push(o);
               }        		
       	}
           queryParams.andItems = $.toJSON(andItems);
       },
       /*fxq 2014-7-21 增加对 anditems中的orItems的支持*/
       addOrItem: function(queryParams, orItems, column, queryStr, operator, queryStr2) {
       	if(!orItems){
       		orItems=[];
       	}
           var o = this.getItem(column, queryStr, operator, queryStr2);
           var updated = false;
           $.each(orItems, function(i) {
               if (this.column === column) {
               	orItems[i] = o;
                   updated = true;
                   return false;
               }
           });
           if (!updated) {
           	orItems.push(o);
           }
           queryParams.orItems = $.toJSON(orItems);
       },
       removeOrItem: function(queryParams, orItems, column) {
           $.each(orItems, function(i) {
               if (this.column === column) {
               	orItems.splice(i, 1);
                   return false;
               }
           });
           queryParams.orItems = $.toJSON(orItems);
       }
   }
});


/**
* 遗留代码： 保存form值。
* @author jason<caiyj@huadong.net>
* @param {type} formId
* @returns {undefined}
*/
function holdFormData(formId) {
   var jFormId = $('#' + formId);
   jFormId.data("oldValue", jFormId.serialize());
}

/**
* clear form值。
* @author jason<caiyj@huadong.net>
* @param {type} formId
* @returns {undefined}
*/
function clearFormData(formId) {
   var jFormId = $('#' + formId);
   jFormId.data("oldValue", null);
}
/**
* 判断form值是否改变。
* @author jason<caiyj@huadong.net>
* @param {type} formId
* @returns {Boolean}
*/
function isFormChanged(formId) {
   var jFormId = $('#' + formId);
   if (jFormId.data("oldValue") != null && jFormId.data("oldValue") != jFormId.serialize()) {
       return true;
   } else {
       return false;
   }
}
/**
* datagrid绑定上下小键盘。
* @author jason<caiyj@huadong.net>
* @param {type} datagridId
* @returns {undefined}
*/
function datagridBindUpDown(datagridId) {
   // 页面渲染完毕初始化。
//   $.extend({},$.parser.onComplete,$('#' + datagridId).datagrid("keyCtr"););
   var d = datagridId.split(",");

   $.parser.onComplete = function() {
       $.each(d, function(i, val) {
           $('#' + val).datagrid("keyCtr");
       });
   };
}

/**
* datagrid 编辑响应回车。
* @author jason<caiyj@huadong.net>
* @param {type} datagridId
* @returns {undefined}
*/
function datagridBindEnter(datagridId, rowIndex) {
   var ed = datagridId.datagrid('getEditors', rowIndex);
   for (var i = 0; i < ed.length; i++)
   {
       var e = ed[i];
       $(e.target).bind('keyup', function(et) {
           if (et.which == 13) {
           }
       });
   }
}

/**
* datagrid 响应以上两种key事件。
* @author jason<caiyj@huadong.net>
* @param {type} datagridId
* @returns {undefined}
*/
function datagridBindKeys(datagridId) {
   datagridBindUpDown(datagridId);
   datagridBindEnter(datagridId);
}


/**
* form响应回车。放在初始化函数内。
* @author jason <caiyj@huadong.net>
* @returns {undefined}
*/
function hdInitFormKeyEnter() {
   $('body').on('keydown', 'input, select, textarea', function(e) {
       var self = $(this)
               , form = self.parents('form:eq(0)')
               , focusable
               , next
               ;
       if ('TEXTAREA' != self[0].nodeName && e.keyCode == 13) {
           focusable = form.find('input,select,textarea').filter(':visible');
           next = focusable.eq(focusable.index(this) + 1);
           if (next.length) {
               next.focus();
           } else {
//             form.submit();
           }
           return false;
       }
   });
};

/**
* 扩展datagrid标准方法，增加响应键盘(绑定小键盘)的函数。  moved here from extension.js by fuxinqi on 2013-11-3
* @author jason
* @param {type} param1
* @param {type} param2
*/
$.extend($.fn.datagrid.methods, {
   keyCtr: function(jq) {
       return jq.each(function() {
           var grid = $(this);
           grid.datagrid('getPanel').attr('tabindex', "-1").bind('keydown', function(e) {
               switch (e.keyCode) {
                   case 38: // up
                       e.preventDefault();
                       var selected = grid.datagrid('getSelected');
                       var rows = grid.datagrid('getRows');
                       if (selected) {
                           var index = grid.datagrid('getRowIndex', selected);
                           if (index > 0) {
                               grid.datagrid('selectRow', index - 1);
                           }
                       } else {
                           grid.datagrid('selectRow', rows.length - 1);
                       }
                       break;
                   case 40: // down
                       e.preventDefault();
                       var selected = grid.datagrid('getSelected');
                       if (selected) {
                           var index = grid.datagrid('getRowIndex', selected);
                           if (index < grid.datagrid('getRows').length - 1) {
                               grid.datagrid('selectRow', index + 1);
                           }
                       } else {
                           grid.datagrid('selectRow', 0);
                       }

                       break;
               }
           });
       });
   },
   keyCtrWithEdit: function(jq) {
       return jq.each(function() {
           var grid = $(this);
           grid.datagrid('getPanel').attr('tabindex', '-1').bind('keydown', function(e) {
               switch (e.keyCode) {
                   case 38: // up
                       e.preventDefault();
                       var selected = grid.datagrid('getSelected');
                       var rows = grid.datagrid('getRows');
                       if (selected) {
                           var index = grid.datagrid('getRowIndex', selected);
                           if (index > 0) {
                               grid.datagrid('endEdit', index);
                               grid.datagrid('selectRow', index - 1).datagrid('beginEdit', index - 1);
                           }
                       } else {
                           grid.datagrid('selectRow', rows.length - 1).datagrid('beginEdit', rows.length - 1);
                       }
                       break;
                   case 40: // down
                       e.preventDefault();
                       var selected = grid.datagrid('getSelected');
                       if (selected) {
                           var index = grid.datagrid('getRowIndex', selected);
                           if (index < grid.datagrid('getRows').length - 1) {
                               grid.datagrid('selectRow', index + 1).datagrid('beginEdit', index + 1);
                           }
                       } else {
                           grid.datagrid('selectRow', 0).datatrid('beginEdit', 0);
                       }
                       break;
               }
           });
       });
   }
});
$.citos = {};
/**
 * 扩展validatebox的校验规则
 * @param {type} value 当前validatebox的值
 * @param {type} param 传递给validateTyp的参数，用于控制校验行为 
 */
$.extend($.fn.validatebox.defaults.rules, {  
	//判断输入内容的字节数不超过指定范围，如lengthb[0,100]
    lengthb: {  
        validator: function(value, param){
            var len = value.replace(/[^\x00-\xff]/g, "**").length;
            return len >= param[0] && len <= param[1];  
        },  
        message: 'Please enter a value between {0} and {1}.'  
    },
    checkSpace: {
    	validator: function(value, param){
            return value.search(/[\s]/g) == -1;  
        },  
        message: '不允许输入空格'
    },
    valNumber: {
        validator: function(value, param) {
            return 1.0*value == parseFloat(value);
        },
        message: '请输入数字！'
    },
    valDate: {
        validator: function(value, param) {
            return /^(\d{4})-(\d{2})-(\d{2})$/.test(value);
        },
        message: '日期格式不正确！'
    },
    valDatetime: {
        validator: function(value, param) {
            return /^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2})$/.test(value);
        },
        message: '日期时间格式不正确！'
    },
    maxLength: {
        validator: function(value, param) {
            return value.length <= param[0];
        },
        message: '最多输入{0}个字符'
    },
    telephone: {
        validator: function(value) {
            var pattern = new RegExp(/^((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)$/);
            return pattern.exec(value);
        },
        message: '请输入有效格式的座机号码、手机号或传真'
    },
    postcode: {
        validator: function(value) {
            var pattern = new RegExp(/^[1-9]{1}(\d+){5}$/);
            return pattern.exec(value);
        },
        message: '请输入有效格式的邮政编码'
    },
    //判断名字是否重复
    isContactNamRepeat: {    
        validator: function(value,param){
        	debugger;
          var customerCod = param[0];
          //var entityName = param[1];
          //var isRepeatCode = param[2];
          var flag = true;
          $.ajax({
            type: "POST",
            url: "../webresources/login/common/contactNamIsRepeat?contactNam=" + value + "&&customerCod=" + customerCod,
            contentType: "application/json",
            dataType: "text",
            async: false,
            success: function (data) {
              if(data == 1){
                flag = true;//不重复
              } else{
                flag = false;
              }
            }
          });
          return flag; 
        },    
        message: '此联系人已经存在'
      },
    isCodeRepeat: {    
        validator: function(value,param){
          var datagridId = param[0];
          var entityName = param[1];
          var isRepeatCode = param[2];
          if(!isEmpty(datagridId)){
            var rows = $('#' + datagridId).datagrid('getChanges','inserted');
            var flag = true;
            if(rows.length > 1){
              for(var i = 0; i< rows.length; i++){
                var code = rows[i][isRepeatCode];
                for(var j = i+1; j< rows.length; j++){
                  if(value == code){
                    flag = false;
                    return;
                  }else{
                    flag = true;
                  }
                }
              }
            }
          }
          $.ajax({
            type: "POST",
            url: "../webresources/login/common/count?entityName=" + entityName + "&&code=" 
                      + isRepeatCode + "&&value=" + value,
            contentType: "application/json",
            dataType: "text",
            async: false,
            success: function (data) {
              if(data == 1){
                flag = true;
              } else{
                flag = false;
              }
            }
          });
          if(!isEmpty(datagridId)){
            if(isEmpty(rows)){
              flag = true;
            }
          }
          return flag; 
        },    
        message: '唯一键重复，请重新输入'
      },
      isSysCodeRepeat: {    
          validator: function(value,param){
            var datagridId = param[0];
            //var entityName = param[1];
            var isRepeatCode = param[1];
            var fldEng = param[2];
            if(!isEmpty(datagridId)){
              var rows = $('#' + datagridId).datagrid('getChanges','inserted');
              var flag = true;
              if(rows.length > 1){
                for(var i = 0; i< rows.length; i++){
                  var code = rows[i][isRepeatCode];
                  for(var j = i+1; j< rows.length; j++){
                    if(value == code){
                      flag = false;
                      return;
                    }else{
                      flag = true;
                    }
                  }
                }
              }
            }
            $.ajax({
              type: "POST",
              url: "../webresources/login/common/countSys?code=" + isRepeatCode + "&&value=" + value + "&&fldEng=" +fldEng,
              contentType: "application/json",
              dataType: "text",
              async: false,
              success: function (data) {
                if(data == 1){
                  flag = true;
                } else{
                  flag = false;
                }
              }
            });
            if(!isEmpty(datagridId)){
              if(isEmpty(rows)){
                flag = true;
              }
            }
            return flag; 
          },    
          message: '唯一键重复，请重新输入'
        },
        isExportCntrRepeat: {
        	/*出口陆运和空箱进出箱号验证,因为有提空进重情况,所以需要根据workWay判断,提空进重存在两个一样的箱号*/
            validator: function(value,param){
            	var flag = true;
                var datagridId = param[0];
                var isRepeatCode = param[1];
                if(!isEmpty(datagridId)){
                  var rows = $('#' + datagridId).datagrid('getRows');
                  var editIndex= $('#' + datagridId).datagrid("options").hdEditIndex;
                  var num=0;
                  var workWay="";
                  if(rows.length > 1){
                	  workWay=rows[0].workWay;
                    for(var i = 0; i< rows.length; i++){
                      var code = rows[i][isRepeatCode];
                      if(i!=editIndex&&editIndex!=undefined&&editIndex!=null){
                    	  if(value == code){
                              num++;
                            }
                      }
                    }
                  }
                }
                if("EOFI"==workWay){
                	if(num>=2){
                		flag=false;
                	}
                }else{
                	if(num>=1){
                		flag=false;
                	}
                }
                return flag; 
              },    
              message: '箱号重复，请重新输入'
            },
});

/** 
 * 将当前日期加减n天数。 如传入字符型 "-5 " 意为将当前日期减去5天的日期 如传入字符型 "5 " 意为将当前日期加上5天后的日期
 */
Date.prototype.dateAdd = function(day,format){ 
    var now = new Date(); 
    var time = now.getTime() + 1000*60*60*24*day; 
    var date = new Date(time).format(format);
    return date; 
}
/** 
 * 获取上一个月 getPreMonth(newDate.format("yyyy-MM"))
 */
function getPreMonth(date) {  
    var arr = date.split('-');  
    var year = arr[0]; //获取当前日期的年份  
    var month = arr[1]; //获取当前日期的月份  
    var year2 = year;  
    var month2 = parseInt(month) - 1;  
    if (month2 == 0) {  
        year2 = parseInt(year2) - 1;  
        month2 = 12;  
    }  
    if (month2 < 10) {  
        month2 = '0' + month2;  
    }  
    var t2 = year2 + '-' + month2 ;  
    return t2;  
}

/*由于idev的formatter被封装不可见,因此抽出部分formatter在citos命名空间下*/
$.extend($.citos, {
    ezui: {
        formatter: {
            /**
             * @param {type} value
             * @returns {Number}
             */
            checkbox: function(value, row, index) {  //显示为真正chekbox的
                return "<input type='checkbox' disabled value=" + value + (value == 1 ? " checked=true />" : " />");
            },
            datetimeWithoutSeconds: function(value, row, index) {
                return value ? new Date(value).format('yyyy-MM-dd') : '';
            }
        }
    }
 });


/**
 * 箱号验证方法
 */
function changechar(str) {
  if ((str == "a") || (str == "A"))
    return 10;
  else if ((str == "b") || (str == "B"))
    return 12;
  else if ((str == "c") || (str == "C"))
    return 13;
  else if ((str == "d") || (str == "D"))
    return 14;
  else if ((str == "e") || (str == "E"))
    return 15;
  else if ((str == "f") || (str == "F"))
    return 16;
  else if ((str == "g") || (str == "G"))
    return 17;
  else if ((str == "h") || (str == "H"))
    return 18;
  else if ((str == "i") || (str == "I"))
    return 19;
  else if ((str == "j") || (str == "J"))
    return 20;
  else if ((str == "k") || (str == "K"))
    return 21;
  else if ((str == "l") || (str == "L"))
      return 23;
  else if ((str == "m") || (str == "M"))
      return 24;
  else if ((str == "n") || (str == "N"))
      return 25;
  else if ((str == "o") || (str == "O"))
      return 26;
  else if ((str == "p") || (str == "P"))
      return 27;
  else if ((str == "q") || (str == "Q"))
      return 28;
  else if ((str == "r") || (str == "R"))
      return 29;
  else if ((str == "s") || (str == "S"))
      return 30;
  else if ((str == "t") || (str == "T"))
      return 31;
  else if ((str == "u") || (str == "U"))
      return 32;
  else if ((str == "v") || (str == "V"))
      return 34;
  else if ((str == "w") || (str == "W"))
      return 35;
  else if ((str == "x") || (str == "X"))
      return 36;
  else if ((str == "y") || (str == "Y"))
      return 37;
  else if ((str == "z") || (str == "Z"))
      return 38;
  else
      return -1000;
}


function getCntr(strcntr) {
	  var flag = true;
	  var num = new Array(10)
	  for (i = 0; i < 11; i++) {
	    num[i] = 0;
	  }
	  test = strcntr;//prompt("请输入需校验的集装箱编码","◎◎◎◎×××××××")
	  len = test.length;
	  if (len != 11) {
	    //alert("请重新输入11位的集装箱编码！");
	    flag = false;
	  }
	  else {
	    exp = /^[A-Za-z]{4}\d{7}$/g;
	    if (!exp.test(test))
	    {
	      // alert("集装箱编码格式不正确，前四位应为字母，后七位为数字，请重新输入！");
	      flag = false;
	    }

	    left = test.substr(0, 4);
	    right = test.substr(4, 7);
	    testnum = test.substr(10, 1);

	    char1 = test.substr(0, 1);
	    char2 = test.substr(1, 1);
	    char3 = test.substr(2, 1);
	    char4 = test.substr(3, 1);
	    //箱号字头
	    num[0] = changechar(char1);
	    num[1] = changechar(char2);
	    num[2] = changechar(char3);
	    num[3] = changechar(char4);

	    //序列号
	    num[4] = test.substr(4, 1);
	    num[5] = test.substr(5, 1);
	    num[6] = test.substr(6, 1);
	    num[7] = test.substr(7, 1);
	    num[8] = test.substr(8, 1);
	    num[9] = test.substr(9, 1);
	    //校验数字
	    num[10] = test.substr(10, 1);
	    sum = num[0] + num[1] * 2 + num[2] * 4 + num[3] * 8 + num[4] * 16 + num[5] * 32 + num[6] * 64 + num[7] * 128 + num[8] * 256 + num[9] * 512;
	    result = sum % 11;
	    if (result != num[10])
	    {
	      //alert("校验码错误！正确的校验码为:" + result);
	      flag = false;
	    }
	  }
	  return flag;
	}


/**
 *扩展combobox,非法录入的时候清空
 */
$.extend($.fn.combobox.defaults, {
  mustMatch : true,
  onHidePanel : function() {
    var m = $(this).combobox('options').mustMatch;
    if (m) {
      var v = $(this).combobox('getValue');
      var valueField = $(this).combobox('options').valueField;
      var data = $(this).combobox('getData');
      var match = false;
      for (var i=0; i<data.length; i++) {
        if (data[i][valueField]==v) {
          match = true;
          break;
        }
      }
      if (!match) {
        $(this).combobox('clear');
      } 
    }
    var on = $(this).combobox('options').onhidePanel;
    if ($.isFunction(on)) {
      on();
    }
  }
});
    

/**
* 封装条件查询弹出框,因为单击按钮需要区分打开关闭状态所以需要在页面加一个标志。典型代码如下
* @param {type} id
* @param {type} width
* @param {type} height
* @returns {undefined}
*/
// $.hd.commonDialogs.conditionQueryDialog=function(id,width,height,flag){
//    if(flag){
//            $("#"+id.id+"").dialog({
//                    noheader:true,
//                    closable:true,
//                    resizable : true,
//                    width: width,
//                    border:false,
//                    collapsible:true,
//                    inline:true,
//                    height: height,
//                    left:$('#main').width()-width,
//                    top: $('#main').offset().top,
//                    modal: false
//                });
//    }else{
//            $("#"+id.id+"").dialog('close');
//    }
// };