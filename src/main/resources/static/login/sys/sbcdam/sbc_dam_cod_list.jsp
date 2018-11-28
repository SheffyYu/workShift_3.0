<meta charset="UTF-8">
<div id="SbcDamCodToolBar1427420966140" style="padding-top: 0px;">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:login:SbcDamCod:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcDamCod:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcDamCod:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcDamCod:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcDamCod:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
    </div>
    <input class="easyui-searchbox" id="SbcDamCodSearchbox1427420966140"/>
 </div>
<table id="SbcDamCodDatagrid1427420966140" style="height:100%"></table>
<script type="text/javascript">
    $(document).ready(function() {
        var dg = $("#SbcDamCodDatagrid1427420966140");
        // buttons
        // 增加。
        $("#SbcDamCodToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcDamCodToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
        });
        // 删除。
        $("#SbcDamCodToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
        	 dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcDamCod/save"});
        });
        // 保存。
        $("#SbcDamCodToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcDamCod/save"});
        });
        // 刷新。
        $("#SbcDamCodToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
        	var value=$("#SbcDamCodSearchbox1427420966140").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("damCod","desc");
        $("#SbcDamCodSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "damCod,cnDamNam,enDamNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcDamCodDatagrid1427420966140").datagrid({
        	striped:true,
            url: "../webresources/login/SbcDamCod/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            //autoLoad:false,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcDamCodToolBar1427420966140",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
					{
                        field: "damCod",
                        title: '<font color="red">残损代码</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcDamCodDatagrid1427420966140","SbcDamCod","damCod"]','length[1,10]']}},
                    },
                    {
                        field: "enDamNam",
                        title: "残损英文名称",
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:160,
					    editor: {type: "validatebox", options: {required: false,validType: 'length[0,100]'}}
                    },
                    {
                        field: "cnDamNam",
                        title: '<font color="red">残损中文名称</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:140,
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
                        title: '系统标识',
                        multiSort: true,
                        align: "center",
                        width:80,
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    },  */                               
                    {
                        field: "abandonedMark",
                        title: '作废标志',
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
                        width:260,
					    editor: {type: "validatebox", options: {required: false,validType: 'length[1,1000]'}}
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
                	}
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                }             
        });
        $("#SbcDamCodDatagrid1427420966140").datagrid("hdGetColumnNames");
    });
</script>