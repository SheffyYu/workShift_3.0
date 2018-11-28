<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="YardMapToolBar1486627371215">
    <div>
        <span style="float:right;">
            <input class="easyui-searchbox" id="YardMapSearchbox1486627371215"/>
        </span>
        <shiro:hasPermission name="webresources:login:YardMap:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:YardMap:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:YardMap:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:YardMap:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        &nbsp;
    </div>
</div>
<div id="YardMapDialog1486627371215"   style="display:none"></div>
<table id="YardMapDatagrid1486627371215" style="height:100%"></table>
<!-- end Datagrid -->
<div id="chart-dlg">
    <div id="chart"></div>
</div>
<div id="chart-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#chart-dlg').dialog('close')">关闭</a>
</div>

<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var diog = $("#YardMapDialog1486627371215");
        var dg = $("#YardMapDatagrid1486627371215");
        // buttons
        // 增加。
        $("#YardMapToolBar1486627371215 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");            
        });
        // 编辑。
        $("#YardMapToolBar1486627371215 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        });
        // 删除。
        $("#YardMapToolBar1486627371215 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/YardMap/save"});
        });
        // 保存。
        $("#YardMapToolBar1486627371215 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/YardMap/save"});
        });
        // 刷新。
        $("#YardMapToolBar1486627371215 a[iconCls='icon-reload']").on("click", function () {
            dg.datagrid("hdReload");
        });
        dg.datagrid({
        	onDblClickCell: function (index) {
            	dg.datagrid("hdEdit");
            }
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        // searchbox
        $("#YardMapSearchbox1486627371215").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "mapNo,companyCod");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#YardMapDatagrid1486627371215").datagrid({
        	striped:true,
            url: "../webresources/login/YardMap/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            autoLoad:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#YardMapToolBar1486627371215",
            fit: true,
            fitColumns: false,
            columns: [[
                
                    /* {
                        field: "mapId",
                        title: '<font color="red">堆场布局图ID</font>',
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: true, validType: 'maxLength[36]'}},
                        sortable: true
                    }, */
                    {
                        field: "mapNo",
                        title: '<font color="red">堆场布局图编号</font>',
                        multiSort: true,
                        halign: "center",
                        editor: {type: "uppercasebox", options: {required: true, validType: 'maxLength[36]'}},
                        sortable: true
                    },
                    {
                        field: "mapUrl",
                        title: "堆场布局图URL",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[200]'}},
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[1000]'}},
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "companyCod",
                        title: '<font color="red">公司代码</font>',
                        multiSort: true,
                        editor: {
                            type: 'combogrid',
                            options: HdUtils.code.companyId({
                                parentId: '#YardMapDatagrid1486627371215',
                                width: 80,
                                fieldMapping: {
                                	companyCod: 'companyCod',
                                	cnCompanyNam: 'cnCompanyNam'
                                },
                                required: true
                            })
                        },
                        formatter:function(val,row,idx){
                        	return row.cnCompanyNam;
                        },
                        halign: "center",
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
                        formatter: $.hd.ezui.formatter.datetime,
                        multiSort: true,
                        halign: "center",
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
                        formatter: $.hd.ezui.formatter.datetime,
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                ]]});
        $("#YardMapDatagrid1486627371215").datagrid("hdGetColumnNames");
    });
</script>

