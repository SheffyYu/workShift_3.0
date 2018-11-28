<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcLockReasonToolBar1486627282418" style="padding-top: 0px;">
	<div style="float:left;">
        <shiro:hasPermission name="webresources:login:SbcLockReason:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcLockReason:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcLockReason:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcLockReason:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcLockReason:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
         &nbsp;
    </div>
    <input class="easyui-searchbox" id="SbcLockReasonSearchbox1486627282418"/>
</div>
<table id="SbcLockReasonDatagrid1486627282418" style="height:100%"></table>

<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var dg = $("#SbcLockReasonDatagrid1486627282418");
        // buttons
        // 增加。
        $("#SbcLockReasonToolBar1486627282418 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcLockReasonToolBar1486627282418 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'lockReasonCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcLockReasonToolBar1486627282418 a[iconCls='icon-remove']").on("click", function () {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcLockReason/save"});
        });
        // 保存。
        $("#SbcLockReasonToolBar1486627282418 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcLockReason/save"});
        });
        // 刷新。
        $("#SbcLockReasonToolBar1486627282418 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcLockReasonSearchbox1486627282418").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("lockReasonId","desc");
        // searchbox
        $("#SbcLockReasonSearchbox1486627282418").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "lockReasonCod,lockTypCod,lockReasonNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcLockReasonDatagrid1486627282418").datagrid({
        	striped:true,
            url: "../webresources/login/SbcLockReason/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            sortOrder: 'desc',
            //autoLoad:false,
            sortName: 'updTimestamp',
            remoteSort:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcLockReasonToolBar1486627282418",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "lockReasonId",
                        title: '<font color="red">锁扣原因ID</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "lockReasonCod",
                        title: '<font color="red">锁定原因代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcLockReasonDatagrid1486627282418","SbcLockReason","lockReasonCod"]','length[1,10]']}},
                        sortable: true
                    },
                    {
                        field: "lockReasonNam",
                        title: '<font color="red">锁扣原因名称</font>',
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor: {type: "validatebox", options: {required:true,validType: 'length[1,100]'}},
                        sortable: true
                    },
                    {
                        field: "lockTypCod",
                        title: '<font color="red">锁扣类型代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        formatter: function(value) {
                        	if("CY"==value){
                        		return "锁场";
                        	}
                        	else if("CN"==value){
                        		return "锁箱"
                        	}
                        },
                        editor: {type: 'combobox',
                            options: {
                                valueField: 'value',
                                textField: 'label',
                                data: [{
                                        label: '锁场',
                                        value: 'CY'
                                    }, {
                                        label: '锁箱',
                                        value: 'CN'
                                    }],
                                required: true
                            }}, 
                        width: 100,
                        sortable: true
                    },
                    {
                        field: "sorter",
                        title: "排序编号",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "numberbox", options: {required:false,validType: 'length[0,5]'}},
                        sortable: true
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
                    }, */
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
                        editor: {type: "validatebox", options: {required:false,validType: 'length[1,1000]'}},
                        sortable: true,
                        width:180
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
                	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
                    dg.datagrid('getEditor', {index: selectIdx, field: 'lockReasonCod'}).target.prop('disabled', true);
                }  
        });
        $("#SbcLockReasonDatagrid1486627282418").datagrid("hdGetColumnNames");
    });
</script>

