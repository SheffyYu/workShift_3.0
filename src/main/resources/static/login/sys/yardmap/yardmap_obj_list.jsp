<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="YardMapObjToolBar1486627371215">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:login:YardMapObj:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:YardMapObj:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:YardMapObj:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:YardMapObj:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        &nbsp;
    </div>
    <input class="easyui-searchbox" id="YardMapObjSearchbox1486627371215"/>
</div>
<div id="YardMapObjDialog1486627371215"   style="display:none"></div>
<table id="YardMapObjDatagrid1486627371215" style="height:100%"></table>
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
        var diog = $("#YardMapObjDialog1486627371215");
        var dg = $("#YardMapObjDatagrid1486627371215");
        // buttons
        // 增加。
        $("#YardMapObjToolBar1486627371215 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");          
        });
        // 编辑。
        $("#YardMapObjToolBar1486627371215 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        });
        // 删除。
        $("#YardMapObjToolBar1486627371215 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/YardMapObj/save"});
        });
        // 保存。
        $("#YardMapObjToolBar1486627371215 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/YardMapObj/save"});
        });
        // 刷新。
        $("#YardMapObjToolBar1486627371215 a[iconCls='icon-reload']").on("click", function () {
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
        $("#YardMapObjSearchbox1486627371215").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "mapNo,layerNo,objTyp,objNo,companyCod");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#YardMapObjDatagrid1486627371215").datagrid({
        	striped:true,
            url: "../webresources/login/YardMapObj/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            sortOrder: 'desc',
            autoLoad:false,
            sortName: 'updTimestamp',
            remoteSort:false,
            singleSelect: true,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#YardMapObjToolBar1486627371215",
            fit: true,
            fitColumns: false,
            columns: [[
                
                    /* {
                        field: "objId",
                        title: '<font color="red">堆场地图图元ID</font>',
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: true, validType: 'maxLength[36]'}},
                        sortable: true
                    }, */
                    {
                        field: "companyCod",
                        title: '<font color="red">公司代码</font>',
                        multiSort: true,
                        halign: "center",
                        editor: {
                            type: 'combogrid',
                            options: HdUtils.code.companyId({
                                parentId: '#YardMapObjDatagrid1486627371215',
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
                        sortable: true
                    },
                    {
                        field: "mapNo",
                        title: '<font color="red">堆场布局图编号</font>',
                        editor: {type: "uppercasebox", options: {required: true, validType: 'maxLength[36]'}},
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "layerNo",
                        title: '<font color="red">堆场布局图图层编号</font>',
                        editor: {type: "uppercasebox", options: {required: true, validType: 'maxLength[36]'}},
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "seqNo",
                        title: "序号",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "numberbox", options: {required: false, validType: 'maxLength[8]'}},
                        sortable: true
                    },
                    {
                        field: "objTyp",
                        title: '<font color="red">图元类型</font>',
                        editor: {type: "uppercasebox", options: {required: true, validType: 'maxLength[20]'}},
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "objNo",
                        title: '<font color="red">图元编号</font>',
                        editor: {type: "uppercasebox", options: {required: true, validType: 'maxLength[40]'}},
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "posData",
                        title: "位置信息",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[2000]'}},
                        sortable: true
                    },
                    {
                        field: "othData",
                        title: "其他属性",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[2000]'}},
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
                        multiSort: true,
                        formatter: $.hd.ezui.formatter.datetime,
                        halign: "center",
                        sortable: true
                    },
                ]]});
        $("#YardMapObjDatagrid1486627371215").datagrid("hdGetColumnNames");
    });
</script>