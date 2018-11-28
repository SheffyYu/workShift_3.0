
<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="YardMapLayerToolBar1486630275833">
    <div  style="float:left;">
        <shiro:hasPermission name="webresources:login:YardMapLayer:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:YardMapLayer:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:YardMapLayer:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:YardMapLayer:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        &nbsp;
    </div>
     <input class="easyui-searchbox" id="YardMapLayerSearchbox1486630275833"/>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<div id="YardMapLayerDialog1486630275833"   style="display:none"></div>
<table id="YardMapLayerDatagrid1486630275833" style="height:100%"></table>
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
        var diog = $("#YardMapLayerDialog1486630275833");
        var dg = $("#YardMapLayerDatagrid1486630275833");
        // buttons
        // 增加。
        $("#YardMapLayerToolBar1486630275833 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");         
        });
        // 编辑。
        $("#YardMapLayerToolBar1486630275833 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        });
        // 删除。
        $("#YardMapLayerToolBar1486630275833 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/YardMapLayer/save"});
        });
        // 保存。
        $("#YardMapLayerToolBar1486630275833 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/YardMapLayer/save"});
        });
        // 刷新。
        $("#YardMapLayerToolBar1486630275833 a[iconCls='icon-reload']").on("click", function () {
            dg.datagrid("hdReload");
        });
        dg.datagrid({
        	onDblClickCell: function (index) {
            	dg.datagrid("hdEdit");
            }
        });
        var builder = new HdEzuiQueryParamsBuilder();
        $("#YardMapLayerSearchbox1486630275833").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "mapNo,layerNo,seqNo,companyCod");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#YardMapLayerDatagrid1486630275833").datagrid({
        	striped:true,
            url: "../webresources/login/YardMapLayer/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            autoLoad:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#YardMapLayerToolBar1486630275833",
            fit: true,
            fitColumns: false,
            columns: [[
                
                    /* {
                        field: "layerId",
                        title: '<font color="red">堆场布局图图层ID</font>',
                        multiSort: true,
                        editor: {type: "validatebox", options: {required: true, validType: 'maxLength[36]'}},
                        halign: "center",
                        sortable: true
                    }, */
                    {
                        field: "mapNo",
                        title: '<font color="red">堆场布局图编号</font>',
                        multiSort: true,
                        editor: {type: "uppercasebox", options: {required: true, validType: 'maxLength[36]'}},
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "layerNo",
                        title: '<font color="red">堆场布局图图层编号</font>',
                        multiSort: true,
                        halign: "center",
                        editor: {type: "uppercasebox", options: {required: true, validType: 'maxLength[36]'}},
                        sortable: true
                    },
                    {
                        field: "seqNo",
                        title: '<font color="red">序号</font>',
                        multiSort: true,
                        editor: {type: "numberbox", options: {required: false, validType: 'maxLength[8]'}},
                        halign: "center",
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
                        field: "companyCod",
                        title: '<font color="red">公司代码</font>',
                        multiSort: true,
                        halign: "center",
                        editor: {
                            type: 'combogrid',
                            options: HdUtils.code.companyId({
                                parentId: '#YardMapLayerDatagrid1486630275833',
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
        $("#YardMapLayerDatagrid1486630275833").datagrid("hdGetColumnNames");
    });
</script>

