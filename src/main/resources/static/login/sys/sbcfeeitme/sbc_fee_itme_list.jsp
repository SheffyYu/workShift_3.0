
<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcFeeItmeToolBar1486627282418" style="padding-top: 0px;">
    <div style="float:left">          
        <shiro:hasPermission name="webresources:sys:SbcFeeItme:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcFeeItme:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcFeeItme:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcFeeItme:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>    
        &nbsp;  
    </div>
    <input class="easyui-searchbox" id="SbcFeeItmeSearchbox1486627282418"/>
</div>
<table id="SbcFeeItmeDatagrid1486627282418" style="height:100%"></table>
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcFeeItmeDialog1486627282418");
        var dg = $("#SbcFeeItmeDatagrid1486627282418");
        // buttons
        // 增加。
        $("#SbcFeeItmeToolBar1486627282418 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcFeeItmeToolBar1486627282418 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        });
        // 删除。
        $("#SbcFeeItmeToolBar1486627282418 a[iconCls='icon-remove']").on("click", function () {
        	 dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcFeeItme/save"});
        });
        // 保存。
        $("#SbcFeeItmeToolBar1486627282418 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcFeeItme/save"});
        });
        // 刷新。
        $("#SbcFeeItmeToolBar1486627282418 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcFeeItmeSearchbox1486627282418").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("feeItemId","desc");
        // searchbox
        $("#SbcFeeItmeSearchbox1486627282418").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "feeItemCod,cnFeeItemNam,enFeeItemNam,measureUnit");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcFeeItmeDatagrid1486627282418").datagrid({
        	striped:true,
            url: "../webresources/login/SbcFeeItme/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            //autoLoad:false,
            remoteSort:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcFeeItmeToolBar1486627282418",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "feeItemId",
                        title: '费用项目ID',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "feeItemCod",
                        title: '<font color="red">费用项目代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                      //  editor: {type: "validatebox", options: {required:true}},
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcFeeItmeDatagrid1486627282418","SbcFeeItme","feeItemCod"]','length[1,10]']}},
                        sortable: true
                    },
                    {
                        field: "enFeeItemNam",
                        title: "费用英文名称",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor: {type: "uppercasebox", options: {required:false,validType: 'length[0,100]'}},
                        sortable: true
                    },
                    {
                        field: "cnFeeItemNam",
                        title: "中文费用名称",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,60]'}},
                        sortable: true
                    },
                    {
                        field: "measureUnit",
                        title: "计量单位",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,20]'}},
                        sortable: true
                    },
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
                        width:180,
                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,1000]'}},
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: '创建人',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: '创建时间',
                        multiSort: true,
                        halign: "center",
                        width:140,
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: '更新人',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: '更新时间',
                        multiSort: true,
                        halign: "center",
                        width:140,
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                }
        });
        $("#SbcFeeItmeDatagrid1486627282418").datagrid("hdGetColumnNames");
    });
</script>

