<meta charset="UTF-8">
<div id="SbcDamSeverityToolBar1427420966140" style="padding-top: 0px;">
   <div style="float:left;">
        <shiro:hasPermission name="webresources:sys:SbcDamSeverity:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcDamSeverity:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcDamSeverity:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcDamSeverity:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcDamSeverity:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
    </div>
    <input class="easyui-searchbox" id="SbcDamSeveritySearchbox1427420966140"/>
    </div>
<table id="SbcDamSeverityDatagrid1427420966140" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function() {
        var dg = $("#SbcDamSeverityDatagrid1427420966140");
        
        // buttons
        // 增加。
        $("#SbcDamSeverityToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcDamSeverityToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
        });
        // 删除。
        $("#SbcDamSeverityToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcDamSeverity/save"});
        });
        // 保存。
        $("#SbcDamSeverityToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcDamSeverity/save"});
        });
        // 刷新。
        $("#SbcDamSeverityToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
        	var value=$("#SbcDamSeveritySearchbox1427420966140").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("damSeverityCod","desc");
        // searchbox
        $("#SbcDamSeveritySearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "damSeverityCod,cnSeverityNam,enSeverityNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcDamSeverityDatagrid1427420966140").datagrid({
        	striped:true,
            url: "../webresources/login/SbcDamSeverity/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            //autoLoad:false,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcDamSeverityToolBar1427420966140",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
					{
                        field: "damSeverityCod",
                        title: '<font color="red">残损程度代码</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcDamSeverityDatagrid1427420966140","SbcDamSeverity","damSeverityCod"]','length[1,10]']}},
                    },
                    {
                        field: "enSeverityNam",
                        title: "残损程度英文名称",
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:120,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,100]'}}
                    },
                    {
                        field: "cnSeverityNam",
                        title: '<font color="red">残损程度中文名称</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:120,
                        editor: {type: "validatebox", options: {required: true,validType: 'length[1,100]'}}
                    },
                    {
                        field: "sorter",
                        title: "排序编号",
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:80,
					    editor: {type: "numberbox", options: {required: false,validType: 'length[0,5]'}}
                    },
                    /* {
                        field: "sysMark",
                        title: "系统标识",
                        multiSort: true,
                        align: "center",
                        width:80,
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    },  */                               
                    {
                        field: "abandonedMark",
                        title: "作废标志",
                        multiSort: true,
                        align: "center",
                        width:80,
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        sortable: true,
					    editor: {type: "validatebox", options: {required: false,validType: 'length[0,1000]'}},
					    width:180
                    },
                    {
                        field: "insAccount",
                        title: "创建人",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
               	    {               	    
                	    field:"insTimestamp",
                	    title:"创建时间",
                	    multiSort:true,
                	    halign:"center",
                	    width:140,
                	    formatter: $.hd.ezui.formatter.datetime,
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
                	    width:140,
                	    formatter: $.hd.ezui.formatter.datetime,
                	    sortable:true
                	}
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                }             
        });
        $("#SbcDamSeverityDatagrid1427420966140").datagrid("hdGetColumnNames");
    });
</script>