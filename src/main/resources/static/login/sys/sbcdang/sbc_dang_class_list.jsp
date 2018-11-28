<meta charset="UTF-8">
<div id="SbcDangClassToolBar1427420966140" style="padding-top: 0px;">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:login:SbcDangClass:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcDangClass:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcDangClass:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcDangClass:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcDangClass:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
    </div>
    <input class="easyui-searchbox" id="SbcDangClassSearchbox1427420966140"/>
</div>
<table id="SbcDangClassDatagrid1427420966140" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function() {
        var dg = $("#SbcDangClassDatagrid1427420966140");
        // buttons
        // 增加。
        $("#SbcDangClassToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcDangClassToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
        	 dg.datagrid("hdEdit");
             var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
             dg.datagrid('getEditor', {index: selectIdx, field: 'dangClass'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcDangClassToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcDangClass/save"});
        });
        // 保存。
        $("#SbcDangClassToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcDangClass/save"});
        });
        // 刷新。
        $("#SbcDangClassToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
        	var value=$("#SbcDangClassSearchbox1427420966140").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("dangClass","desc");
        // searchbox
        $("#SbcDangClassSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "dangClass,dangClassNam,undgNos");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcDangClassDatagrid1427420966140").datagrid({
        	striped:true,
            url: "../webresources/login/SbcDangClass/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            //autoLoad:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcDangClassToolBar1427420966140",
            fit: true,
            fitColumns: false,
            sortOrder: 'desc',
	        sortName: 'updTimestamp',
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},   
					{
                        field: "dangClass",
                        title: '<font color="red">危险品等级</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcDangClassDatagrid1427420966140","SbcDangClass","dangClass"]','length[1,5]']}},
                    },
                    {
                        field: "dangClassNam",
                        title: "危险品等级名称",
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:140,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,50]'}}
                    },
                    {
                        field: "undgNos",
                        title: "际危规号范围",
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:100,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,50]'}}
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
                        width:240,
					    editor: {type: "validatebox", options: {required: false,validType: 'length[0,1000]'}}
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
                    dg.datagrid('getEditor', {index: index, field: 'dangClass'}).target.prop('disabled', true);
                }             
        });
        $("#SbcDangClassDatagrid1427420966140").datagrid("hdGetColumnNames");
    });
</script>