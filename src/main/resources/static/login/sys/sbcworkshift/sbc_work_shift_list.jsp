<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcWorkShiftToolBar1486698273591" style="padding-top: 0px;">
        <div style="float:left;">
           <!--  <input class="easyui-searchbox" id="SbcWorkShiftSearchbox1486698273591"/>
        </span> -->
        <shiro:hasPermission name="webresources:login:SbcWorkShift:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcWorkShift:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcWorkShift:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcWorkShift:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </div>
        <input class="easyui-searchbox" id="SbcWorkShiftSearchbox1486698273591"/>
</div>
<div id="SbcWorkShiftDialog1486698273591"   style="display:none"></div>
<table id="SbcWorkShiftDatagrid1486698273591" style="height:100%"></table>
<script type="text/javascript">
    $(document).ready(function () {
        var diog = $("#SbcWorkShiftDialog1486698273591");
        var dg = $("#SbcWorkShiftDatagrid1486698273591");
        // buttons
        // 增加。
        $("#SbcWorkShiftToolBar1486698273591 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");          
        });
        // 编辑。
        $("#SbcWorkShiftToolBar1486698273591 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        });
        // 删除。
        $("#SbcWorkShiftToolBar1486698273591 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcWorkShift/save"});
        });
        // 保存。
        $("#SbcWorkShiftToolBar1486698273591 a[iconCls='icon-save']").on("click", function () {
        	/*var changedData = {};
        	var insertDatas = dg.datagrid('getChanges','inserted');
        	var ed = dg.datagrid('getEditor', {index:0,field:'beginTim'});
        	var dfs = $(ed.target).datetimebox('getValue');
        	alert("---"+dfs);
        	var aa = {};
        	aa.beginTim = '8:00';
        	aa.endTim = '10:00';
        	insertDatas.push(aa);*/
        	//alert("---"+JSON.stringify(insertDatas));
        	dg.datagrid("hdSave", {url: "../webresources/login/SbcWorkShift/save"});
        });
        // 刷新。
        $("#SbcWorkShiftToolBar1486698273591 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcWorkShiftSearchbox1486698273591").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("workShiftId","desc");
        // 返回后台参数。
//        var queryParams = {
//            builder: builder.build(),
//            queryColumns: {}
//        };
        // searchbox
        $("#SbcWorkShiftSearchbox1486698273591").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "beginTim,endTim");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#SbcWorkShiftDatagrid1486698273591").datagrid({
        	striped:true,
            url: "../webresources/login/SbcWorkShift/find",
            queryParams: builder.build(),
            method: "POST",
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            autoLoad:false,
            pageSize: 20,
            toolbar: "#SbcWorkShiftToolBar1486698273591",
            fit: true,
            fitColumns: false,
            columns: [[
                
                    /* {
                        field: "workShiftId",
                        title: '<font color="red">班次ID</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    }, */
                    {
                        field: "beginTim",
                        title: '<font color="red">开始时间，例如：08:00</font>',
                        multiSort: true,
                        halign: "center",  //formatter:myformatter,parser:myparser
                        editor: {type: "validatebox", options: {required: true,missingMessage:'输入格式为08:00',validType:"mstime"}},
                        //editor: {type: "datetimebox", options: {required: true,formatter:myformatter,parser:myparser}},
                        sortable: true
                    },
                    { //   / 00:00  /  /^[0-2][0-9][:][0-6][0-9]$/
                        field: "endTim",
                        title: '<font color="red">结束时间，例如：16:00</font>',
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: true, missingMessage:'输入格式为08:00',validType: 'maxLength[5]'}},
                        //editor: {type: "datetimebox", options: {required: true,formatter:myformatter,parser:myparser}},
                        sortable: true
                    },
                    {
                        field: "sorter",
                        title: "排序编号",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "numberbox", options: {required: false, validType: 'maxLength[5]'}},
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[1000]'}},
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: '创建人',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: '创建时间',
                        multiSort: true,
                        halign: "center",
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: '更新人',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: '更新时间',
                        multiSort: true,
                        halign: "center",
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                ]],
                onDblClickCell: function (index) {
                	dg.datagrid("hdEdit");
                }});
        $("#SbcWorkShiftDatagrid1486698273591").datagrid("hdGetColumnNames");
        
    });
 
    $.extend($.fn.validatebox.defaults.rules, {    
        mstime: {    
            validator: function(value,param){    
            	///^[0-2][0-9][:][0-6][0-9]$/
            	 var pattern = new RegExp(/^[0-2][0-9][:][0-6][0-9]$/);
                 return pattern.exec(value);  
            },    
            message: '输入格式错误'   
        }    
    });  
    $.extend($.fn.datagrid.defaults.editors, {
        /*datetimebox2: {// datetimebox就是你要自定义editor的名称
            init: function (container, options) {
                var input = $('<input class="easyui-datetimebox">').appendTo(container);
                return input.datetimebox({
                    formatter: function (date) {
                    	var y = date.getFullYear();
                		var m = date.getMonth()+1;
                		var d = date.getDate();
                		var h = date.getHours();
                		var min = date.getMinutes();
                		//alert("--"+d+"---"+h);
                		//return  y+'年'+(m<10?('0'+m):m)+'月'+(d<10?('0'+d):d)+'日'+(h<10?('0'+h):h)+'点';
                		return h+":"+min;
                    },
                    parser:function(s){
                    	//var reg=/[\u4e00-\u9fa5]/  //利用正则表达式分隔
                		var ss = (s.split(':'));
                		var date = new Date();
                		var y = date.getFullYear();
                		var m = date.getMonth();
                		var d = date.getDate();
                		var h = parseInt(ss[0],10);
                		var min = parseInt(ss[1],10);
                		
                		if (!isNaN(y) && !isNaN(m) && !isNaN(d) && !isNaN(h)&&!isNaN(min)){
                			var dd = new Date(y,m-1,d,h,min);
                			//alert(dd);
                			return dd;
                		} else {
                			var ddd = new Date();
                			return ddd;
                		}
                    }
                });
            },
            getValue: function (target) {
            	//alert("getvalue");
                return $(target).parent().find('input.combo-value').val();
            },
            setValue: function (target, value) {
            	//alert("setvalue");
                $(target).datetimebox("setValue", value);
            },
            resize: function (target, width) {
                var input = $(target);
                if ($.boxModel == true) {
                    input.width(width - (input.outerWidth() - input.width()));
                } else {
                    input.width(width);
                }
            }
        }*/
        datetimebox2: {
            init: function(container, options) {
                var input = $('<input class="easyui-datetimebox">').appendTo(container);
                return input.datetimebox({
                    formatter: function(date) {
                        return new Date(date).format("hh:mm:ss");
                    }, parser:function(s){
                    	//var reg=/[\u4e00-\u9fa5]/  //利用正则表达式分隔
                		var ss = (s.split(':'));
                		var date = new Date();
                		var y = date.getFullYear();
                		var m = date.getMonth();
                		var d = date.getDate();
                		var h = parseInt(ss[0],10);
                		var min = parseInt(ss[1],10);
                		var s = parseInt(ss[2],10);
                		if (!isNaN(y) && !isNaN(m) && !isNaN(d) && !isNaN(h)&&!isNaN(min)){
                			var dd = new Date(y,m-1,d,h,min,s);
                			//alert(dd);
                			return dd;
                		} else {
                			var ddd = new Date();
                			return ddd;
                		}
                    }
                });
            },
            getValue: function(target) {
                return new Date($(target).parent().find('input.combo-value').val()).getTime();
            },
            setValue: function(target, value) {
                if (value != null && value != "") {
                    $(target).datetimebox("setValue", new Date(value).format("hh:mm:ss"));
                }
            },
            resize: function(target, width) {
                var input = $(target);
                if ($.boxModel === true) {
                    input.width(width - (input.outerWidth() - input.width()));
                } else {
                    input.width(width);
                }
            }
        }
    });
    
   
	function myformatter(date){
		var y = date.getFullYear();
		var m = date.getMonth()+1;
		var d = date.getDate();
		var h = date.getHours();
		var min = date.getMinutes();
		alert("--"+d+"---"+h);
		//return  y+'年'+(m<10?('0'+m):m)+'月'+(d<10?('0'+d):d)+'日'+(h<10?('0'+h):h)+'点';
		return h+":"+min;
	} 
	function myparser(s){
		//var reg=/[\u4e00-\u9fa5]/  //利用正则表达式分隔
		var ss = (s.split(':'));
		var date = new Date();
		var y = date.getFullYear();
		var m = date.getMonth();
		var d = date.getDate();
		var h = parseInt(ss[0],10);
		var min = parseInt(ss[1],10);
		if (!isNaN(y) && !isNaN(m) && !isNaN(d) && !isNaN(h)&&!isNaN(min)){
			return new Date(y,m-1,d,h,min);
		} else {
			return new Date();
		}
	}
    
    function createChart() {
        $("#chart-dlg").dialog({
            title: '生成图表',
            width: 800,
            height: 500,
            padding: 10,
            iconCls: 'icon-save',
            buttons: '#chart-buttons',
            maximizable: true
        });
        var divId = 'chart';
        var type = $("#chart-type").combobox("getValue");
        var s = new ShapeBase();
        s.show("xxx", divId, type);//XXX是查询数据的方法路径
    }
</script>