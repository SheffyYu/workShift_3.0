/* 
 说明： 对treeGrid组件进行扩展的代码，包含combgrid编辑，类似DatagridOperation的TreeGridOperation类等
 
 Modifications:

 1.1 2018-08-19 by fuxinqi: 代码重构，抽取treeGrid相关的代码，单独形成本文件。于20日调试完毕
 1.0 2018-08-18 by lisl : 针对‘组织机构附加信息维护’功能，使用treegid编辑书写系列代码，封装treeCombogrid组件
 */

/**
 *  对treegrid增加autoLoad属性并覆盖datagridloader的默认行为，解决atagrid的BUG。
 *  对GET操作无影响，对POST操作，以JSON格式传送数据（原来参数被URL-ENCODE,导致服务端接受失败）
 *  相关说明见 datagrid的loader重载，以及 commonUtils包的 $.hd.commonUtils.jsonLoadWithPost对象
 *  
 * author 傅新奇
 * on 2013-11-21
 */

/**
 *  发现treegrid控件没支持类似datagrid的load和reload方法
 *  在测试中发现，pagination控件根据输入的页数可以直接获取数据库中当前指定页的内容。于是想到了，
 *  treegrid的重加载可以通过自动触发pagination控件页数输入框的keydown事件来实现，
 *  而查询即可通过先设置treegrid options的queryParams属性来实现查询信息的设置然后加载第一页信息就可以了。
 */

$.extend($.fn.treegrid.defaults, {
    loader: function(param, successCallback, errorCallback) {
        var opts = $(this).treegrid("options");
        return $.hd.commonUtils.jsonLoadWithPost(opts,param, successCallback, errorCallback);
    }
});

 /**
 * 扩展treegrid的函数集合，按条件加载数据
 * @param {jquery Object} jq 选中的datagrid的集合
 * @param {object} param 方法参数，这里是检索参数 
 */
$.extend($.fn.treegrid.methods, {
    load: function(jq, param) {
        var treegrid = jq;
        var opts=treegrid.treegrid('options');
        var qParams=$.extend(true,{},opts.queryParams,param);   
        treegrid.treegrid('options').queryParams = qParams;
        if(true==opts.pagination){  //分页的情况，先加载第一页
            autoLoad(treegrid.treegrid("getPager"),1);
        }else{  //FXQ 不分页则加载所有数据，正好弥补了autoLoad方法的缺陷
            $.hd.commonUtils.jsonLoadWithPost(opts,qParams, 
                function(data){
                    treegrid.treegrid('loadData',data);  //成功则装载数据
                }, 
                function(a,b,c,d,e,f){
                        //var msg=[].slice.apply(arguments); msg.join(':');   //将错误提示信息转化为数组，但仍含有对象，不合适
                    $.hd.ezui.messager.show({code:'0x101111111', message:'树形数据加载失败', detail: 'treeGrid（不分页）调用后台ajax出错,参数='+$.toJSON(qParams)+",mesage="+$.toJSON(arguments)});
                }
            );
        }
        /** 
         * 自动触发分页的加载操作 
         * @param pager  各个控件对应的pagination组件 
         */  
        function autoLoad(pager,pageNumber){  
            var event = jQuery.Event("keydown");//模拟一个键盘事件          
            event.keyCode = 13;//keyCode=13是回车  
            pager.find('input.pagination-num').val(pageNumber); //设置跳转页为当前指定页面  
            pager.find('input.pagination-num').trigger(event);  
        }  
    }
});

 /**
 * 重新定义treegrid的combogrid组件，实现下拉编辑，对应字段自动赋值
 * （由于$.fn.treegrid.defaults.editors默认使用$.fn.datagrid.defaults.editors，如果不覆盖，在取消编辑赋值时会导致错误）
 * author 李双林、傅新奇
 */
$.extend($.fn.datagrid.defaults.editors, {
    combogridInTreegrid: { //FXQ 2015-9-17根据treegrid源代码，treegrid在编辑时还是使用$(this).datagrid('beginEdit', id)因此只好改名 0819 参照datagrid的combogrid制作用于treegrid的combogrid
        init: function(container, options) {
            var input = $('<input type="text" class="datagrid-editable-input">').appendTo(container);
            input.combogrid(options);
            var grid=input.combogrid('grid');
            //设置标志，防止此combogrid被destroy后，再继续渲染而出错
            var oldMethod=grid.datagrid('options').onLoadSuccess;
            grid.datagrid('options').onLoadSuccess=function(data){
                    var isDestroying=grid.datagrid('options').___isEditorDestroying;   //见destroy方法
                    if((undefined===isDestroying||true!==isDestroying) && $.isFunction(oldMethod)){
                            oldMethod.call(grid,data);
                    }
            };
            var oldLoader=grid.datagrid('options').loader;   //此方法已经被ezui的ComboGrid的代码实现
            grid.datagrid('options').loader=function(param,onsuccess,onerror){
                var isDestroying=grid.datagrid('options').___isEditorDestroying;   //见destroy方法
                if((undefined===isDestroying||true!==isDestroying) && $.isFunction(oldLoader)){
                        oldLoader.call(grid,param,onsuccess,onerror);
                }else{
                        grid.datagrid('options').view={};
                }
            };    	        	
           
            return input;
        },   
        destroy: function(target) {   //FXQ 2013-8-14  延迟销毁combogrid（防止内嵌datagrid报错的问题)
            var subDatagrid = $(target).combogrid('grid');
            var opts=subDatagrid.datagrid('options');
            var mapping = opts.mapping;
            var changes = subDatagrid.datagrid('getSelected');
            if (changes !== null && mapping !== undefined && mapping.parent !== undefined && mapping.fields !== undefined && opts.___oldRow !== undefined) {
                var row =  opts.___oldRow; // =$(mapping.parent).treegrid('find',mapping.oldId);
                $.each(mapping.fields, function(key, value) {
                    eval("(row." + key + "=changes." + value + ")");
                });
            } 

            //fxq防范内嵌的datagrid找不到 $(id) 导致$.data(jq[0], "datagrid").options报错
            var grid=$(target).combogrid('grid');
            //设置标志，防止此后combogrid的数据再渲染而出错
            grid.datagrid('options').___isEditorDestroying=true;
            $(target).combogrid('destroy');
        },
        getValue: function(target) {
            return $(target).combogrid('getValue');
        },
        setValue: function(target, value) {
            var options = $(target).combogrid('grid').datagrid('options');
            if (options.mapping !== undefined && options.mapping.parent !== undefined) {
                var parent = $(options.mapping.parent);
                var rowSlected = parent.treegrid('getSelected');
                options.___oldRow = rowSlected;  //先保存下来，在destroy中进行对应字段赋值
            }
            if (value == "null") {
                $(target).combogrid('setValue', ""); //防范空值的变形
            } else {
                $(target).combogrid('setValue', value);
            }
        },
        resize: function(target, width) {
            $(target).combogrid('resize', width);
        }
    }
});

/**
 * Treegrid操作伴侣：封装大部分对treegrid的操作，参照了DatrgridOperation
 * @param {type} _treegrid 要操作的treegrid对象
 * @param {String} _updateUrl 存盘要用到的url
 * @returns {DatagridOperation}
 */
function TreegridOperation(_treegrid, _updateUrl) {
    var theTreeGrid=_treegrid;
    var updateUrl = _updateUrl;

    var selectedId = undefined;  //工作变量，当前选中行ID。在onClickRow赋值，变量值滞后于getSelected，从而实现对原来选中行的处理等 
    var _this=this;              //工作变量,防止this含义在函数体中的模糊含义导致程序异常.
    
    /**
     * 
     * @returns {domUtils@call;findParentByTagName.parentNode.rowIndex|start.parentNode.rowIndex|
     * @returns {start.parentNode.rowIndex|Number|undefined|domUtils@call;findParentByTagName.parentNode.rowIndex|rowId}Number|undefined|rowId|@exp;cell@pro;parentNode@pro;rowIndex|@exp;rowIndex}
     */
    this.getSelectedId=function(){
        return selectedId;
    };
    
    //工作方法，根据row数据得到其ID
    function getRowId(row){
        if(!row){
            return undefined;
        }
        var idField=theTreeGrid.treegrid('options').idField;
        return row[idField];
    };
    
    /**
     * 得到当前选中行
     */
    this.getSelectedRow=function(){
        return theTreeGrid.treegrid('getSelect');
    };
    
    /**
     * 在onClickRow事件中调用本方法！
     * @param {type} rowData 当前行数据
     */
    this.clickRow = function(rowData) {
        var newId=getRowId(rowData);
        if(rowData && newId!=undefined && newId != selectedId) {
            if (_this.endEdit()) {
                selectedId = newId;
            }else{
                $.messager.alert(INFO, INFO_INVALID, "info", function(){
                    theTreeGrid.treegrid('select', selectedId);   //fxq:校验不通过，不允许换行
                });
            }
        }
    };

    /**
     * 根据行ID选中某行
     * @param {type} rowId 要选中的行的ID
     * @returns {undefined}
     */
    this.selectRow = function(rowId) {
        if (_this.endEdit()) {
            selectedId = rowId;
            theTreeGrid.treegrid('select', selectedId);
        }else{
            $.messager.alert(INFO, INFO_INVALID, "info", function(){
                theTreeGrid.treegrid('select', selectedId);   //fxq:校验不通过，不允许换行
            });
        }   
    };
 
    /**
     * 
     * @returns {Boolean} 取消编辑状态
     */
    this.endEdit =function () {
        if (selectedId == undefined) {
            return true;
        }

        if(theTreeGrid.treegrid('validateRow', selectedId)) {
            theTreeGrid.treegrid('endEdit', selectedId);
            return true;
        } else {
            $.messager.alert(INFO, INFO_INVALID, "info");//移入clickRow方法中
            return false;
        }
    };
    
    //是否在编辑
    this.isEditing = function() {
        var eds = theTreeGrid.treegrid('getEditors', selectedId);
        if (eds != "") {
            return true;
        } else {
            return false;
        }
    };
    
    //给定的Treegrid
    this.getTreegrid=function(){
    	return theTreeGrid;
    };
    
    //查询数据的URL
    this.getQueryUrl = function() {
        return theTreeGrid.treegrid('options').url;
    };
    
    //更新数据的URL
    this.getUpdateUrl = function() {
        return updateUrl ;
    };
    
    //设置更新数据的URL
    this.setUpdateUrl = function(newUrl) {
        updateUrl = newUrl;
    };
    
    this.getOptions = function() {
        return theTreeGrid.treegrid('options');
    };
    
    //查询参数
    this.getQueryParams = function() {
        //在datagrid初始化前，返回本对象定义的 param， 用于初始化datagrid
        if('treegrid' in theTreeGrid){
            return theTreeGrid.treegrid('options').queryParams;
        }else{
            return undefined;
        }
    };
    
    //清空数据
    this.clearData = function() {
        theTreeGrid.treegrid('loadData', []);
    };
    
    //开始编辑一行
    this.edit=function(callback) {
        theTreeGrid.treegrid("loading");
        if (selectedId == undefined) {
            theTreeGrid.treegrid("loaded");
            $.messager.alert(INFO, INFO_EDIT, "info");
            return;
        }
        setTimeout(function() {
            theTreeGrid.treegrid('select', selectedId)
                    .treegrid('beginEdit', selectedId);
            theTreeGrid.treegrid("loaded");
            if ($.isFunction(callback)) {
                callback();
            }
        }, 10);
    };
   
    //工作方法，将数据列表中的 children, state等字段删除，防止影响后台数据存盘
    function removeTreeDispAttrs(list){
        var idField=theTreeGrid.treegrid('options').idField;
        var treeField=theTreeGrid.treegrid('options').treeField;
        $.each(list,function(i,row){
            if(row.children){
                delete row.children;
            }
            if(row.state){
                delete row.state;
            }
            if('id'!==idField && row.id){
                delete row.id;
            }
            if('text'!==treeField && row.text){
                delete row.text;
            }
        });
    }
   
    /**
     * 保存当前数据的方法　 
     * @param {function} callback 执行成功后的回调方法
     */
    this.save = function(callback) {
       var changedData = {};
       if (_this.endEdit()) {
           var changedRows = theTreeGrid.treegrid('getChanges');
           if (changedRows.length > 0) {
                changedData.insertedRows = theTreeGrid.treegrid('getChanges', 'inserted'); removeTreeDispAttrs(changedData.insertedRows);
                changedData.updatedRows = theTreeGrid.treegrid('getChanges', 'updated');   removeTreeDispAttrs(changedData.updatedRows);
                changedData.deletedRows = theTreeGrid.treegrid('getChanges', 'deleted');   removeTreeDispAttrs(changedData.deletedRows);
   
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
            } //end if changedRows.length > 0
          }else{
            $.messager.alert(INFO, INFO_NO_CHANGE, "info");   //fxq2013-9-23 存盘前校验不通过无错误提示，令用户费解
        } //END IF endEditing
  
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
                url: updateUrl,      //此URL一般不同于查询的URL，在构造函数给出
                type: "POST",
                dataType: "json",
                data: $.toJSON(changedData),
                success: function(data) {
                	endAction();
                        $.hd.ezui.messager.show(data, function() { 
                           if ($.isFunction(callback)) {   //FXQ 2013-10-31 只有保存成功才执行回调! show的回调函数具有这个特性
                                callback();
                           }
                           theTreeGrid.treegrid('acceptChanges');
                           theTreeGrid.treegrid('load');     //不必等日志记录的结果. 除了ajax调用之外,js代码还是顺序实行的,因此不用担心reload会影响记日志之前获取更改数据
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
    
    this.isChanged = function() {
        var changes = theTreeGrid.treegrid('getChanges');
        if (changes.length > 0) {
            return true;
        } else {
            return false;
        }
    };

    //取消最近修改
    this.undo=function(){
        var changes = theTreeGrid.treegrid('getChanges');
        if (changes.length > 0) {
            $.messager.confirm(CONFIRM, CONFIRM_CANCEL, function(r) {
                if (r) {
                    theTreeGrid.treegrid('rejectChanges');
                    theTreeGrid.treegrid('load');  //使用reload不能显示数据
                }
            });
        }
    };
   
    //重新加载所有数据 
    this.load = function(param) {
    	if(!$.isPlainObject(param)||(param instanceof $.Event)){ //类似 $("#id").on("click", operation.load);的调用，load会被传递一个Event对象作为参数
            param=undefined;
    	}
        var changes = theTreeGrid.treegrid('getChanges');
        if (changes.length > 0) {
            $.messager.confirm(CONFIRM, CONFIRM_RELOAD, function(r) {
                if (r) {
                    selectedId = undefined;
                    theTreeGrid.treegrid('load',param);
                }
            });
        } else {
            selectedId = undefined;
            theTreeGrid.treegrid('load',param);
        }
    };
    
    return this;
}