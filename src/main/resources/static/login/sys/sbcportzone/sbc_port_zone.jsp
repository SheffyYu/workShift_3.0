<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcPortZoneToolBar1488260400700" style="padding-top: 0px;">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:login:SbcPortZone:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcPortZone:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcPortZone:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcPortZone:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcPortZone:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
        &nbsp;
    </div>
        <input class="easyui-searchbox" id="SbcPortZoneSearchbox1488260400700"/>
</div>
<table id="SbcPortZoneDatagrid1488260400700" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dg = $("#SbcPortZoneDatagrid1488260400700");
        // buttons
        // 增加。
        $("#SbcPortZoneToolBar1488260400700 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcPortZoneToolBar1488260400700 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
        	dg.datagrid('getEditor', {index: selectIdx, field: 'portZoneCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcPortZoneToolBar1488260400700 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcPortZone/save"});
        });
        // 保存。
        $("#SbcPortZoneToolBar1488260400700 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcPortZone/save"});
        });
        // 刷新。
        $("#SbcPortZoneToolBar1488260400700 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcPortZoneSearchbox1488260400700").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("portZoneId","desc");
        builder.setOrderByClause("updTimestamp", "desc");
        // 返回后台参数。
        // searchbox
        $("#SbcPortZoneSearchbox1488260400700").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "portZoneCod,cnPortZoneNam,enPortZoneNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcPortZoneDatagrid1488260400700").datagrid({
        	striped:true,
            url: "../webresources/login/SbcPortZone/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            //autoLoad:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcPortZoneToolBar1488260400700",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "portZoneId",
                        title: '<font color="red">港区代码ID</font>',
                        multiSort: true,
                        halign: "center",
                        hidden: true,
                        sortable: true
                    },
                    {
                        field: "portZoneCod",
                        title: '<font color="red">港区代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true,validType:['isCodeRepeat["SbcPortZoneDatagrid1488260400700","SbcPortZone","portZoneCod"]','length[1,20]']}},
                        sortable: true
                    },
                    {
                        field: "enPortZoneNam",
                        title: "英文港区名称",
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:"uppercasebox",options:{required:false,validType: 'length[0,60]'}},
                        sortable: true
                    },

                    {
                        field: "cnPortZoneNam",
                        title: "中文港区名称",
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:"validatebox",options:{required:false,validType: 'length[0,60]'}},
                        sortable: true
                    },
                    /* {
                        field: "sysMark",
                        title: '系统标识',
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:80,
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                        sortable: true
                    }, */
                    {
                        field: "abandonedMark",
                        title: '作废标志',
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:80,
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        editor:{type:"validatebox",options:{required:false,validType: 'length[0,1000]'}},
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
                onDblClickCell: function (index) {
                	dg.datagrid("hdEdit");
                	dg.datagrid('getEditor', {index: index, field: 'portZoneCod'}).target.prop('disabled', true);
                }});
        $("#SbcPortZoneDatagrid1488260400700").datagrid("hdGetColumnNames");
    });
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

