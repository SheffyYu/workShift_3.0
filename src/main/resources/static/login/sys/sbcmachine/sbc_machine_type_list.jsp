<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcMachineTypeToolBar1427420966140"  style="padding-top: 0px;">
      <div style="float:left" >      
     <shiro:hasPermission name="webresources:login:SbcMachineType:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcMachineType:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcMachineType:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcMachineType:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcMachineType:find">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission> 
        &nbsp; 
    </div>
      <input class="easyui-searchbox" id="SbcMachineTypeSearchbox1427420966140"/>
 </div>               
        <table id="SbcMachineTypeDatagrid1427420966140" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function() {       
    	var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcMachineTypeDialog1486627282418");
        var dg = $("#SbcMachineTypeDatagrid1427420966140");
        // buttons
        // 增加。
        $("#SbcMachineTypeToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcMachineTypeToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'machTypCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcMachineTypeToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
        	 dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcMachineType/save"});
        });
        // 保存。
        $("#SbcMachineTypeToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcMachineType/save"});
        });
        // 刷新。
        $("#SbcMachineTypeToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
        	var value=$("#SbcMachineTypeSearchbox1427420966140").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        // 返回后台参数。
//        var queryParams = {
//            builder: builder.build(),
//            queryColumns: {}
//        };
        // searchbox
        $("#SbcMachineTypeSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "machTypCod,machTypNam,machClass");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcMachineTypeDatagrid1427420966140").datagrid({
        	striped:true,
            url: "../webresources/login/SbcMachineType/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            //autoLoad:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcMachineTypeToolBar1427420966140",
            fit: true,
            fitColumns: false,
            columns: [[
   					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "machTypCod",
                        title: '<font color="red">机械类型代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox", options: {required: true,validType: ['isCodeRepeat["SbcMachineTypeDatagrid1427420966140","SbcMachineType","machTypCod"]','length[1,10]']}},
                        sortable: true
                    },
                    {
                        field: "machTypNam",
                        title: '<font color="red">机械类型名称</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "validatebox", options: {required: true,validType: 'length[1,100]'}},
                        sortable: true
                    },
                    {
                        field: "machClass",
                        title: '<font color="red">机械分类</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({fieldCod: 'MACH_CLASS'}, {required: false})
                        },
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'MACH_CLASS', code: value});
                            return list.length > 0 ? list[0].name : "";
                        },
                        sortable: true
                    },
                    {
                        field: "machUse",
                        title: "机械用途",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({fieldCod: 'MACH_USE'}, {required: false})
                        },
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'MACH_USE', code: value});
                            return list.length > 0 ? list[0].name : "";
                        },
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注",
                        multiSort: true,
                        halign: "center",
                        width:180,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,1000]'}},
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: "创建人",
                        multiSort: true,
                        width:80,
                        halign: "center",
                        sortable: true
                    },
               	    {               	    
                	    field:"insTimestamp",
                	    title:"创建时间",
                	    multiSort:true,
                	    halign:"center",
                	    formatter: $.hd.ezui.formatter.datetime,
                	    width:140,
                	    sortable:true
               		},
               	    {
                	    
                	    field:"updAccount",
                	    title:"更新人",
                	    multiSort:true,
                	    halign:"center",
                	    width:80,
                	    sortable:true
               		},
               	    {
                	    
                	    field:"updTimestamp",
                	    title:"更新时间",
                	    multiSort:true,
                	    halign:"center",
                	    formatter: $.hd.ezui.formatter.datetime,
                	    width:140,
                	    sortable:true
                	},
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
                    dg.datagrid('getEditor', {index: selectIdx, field: 'machTypCod'}).target.prop('disabled', true);
                } 
        });
        $("#SbcMachineTypeDatagrid1427420966140").datagrid("hdGetColumnNames");
    });
</script>