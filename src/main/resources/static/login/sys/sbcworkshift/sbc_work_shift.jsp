
<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcWorkShiftToolBar1486698273591" style="padding-top: 0px;">
        <span style="float:right;">
            <input class="easyui-searchbox" id="SbcWorkShiftSearchbox1486698273591"/>
        </span>
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
        &nbsp;
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<div id="SbcWorkShiftDialog1486698273591"   style="display:none"></div>
<table id="SbcWorkShiftDatagrid1486698273591" style="height:100%"></table>

<!-- 脚本控制 -->
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
            dg.datagrid("hdSave", {url: "../webresources/login/SbcWorkShift/save"});
        });
        // 刷新。
        $("#SbcWorkShiftToolBar1486698273591 a[iconCls='icon-reload']").on("click", function () {
        	dg.datagrid("hdReload");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
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
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            rownumbers: true,
            pageSize: 20,
            //autoLoad:false,
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
                        halign: "center",
                        editor: {type: "validatebox", options: {required: true, validType: 'maxLength[5]'}},
                        sortable: true
                    },
                    {
                        field: "endTim",
                        title: '<font color="red">结束时间，例如：16:00</font>',
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: true, validType: 'maxLength[5]'}},
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

