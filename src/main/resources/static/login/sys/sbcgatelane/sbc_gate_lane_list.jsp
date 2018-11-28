<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcGateLaneToolBar1486627282418" style="padding-top: 0px;">
    <div style="float: left;">
        <shiro:hasPermission name="webresources:login:SbcGateLane:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcGateLane:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcGateLane:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcGateLane:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        &nbsp;
    </div>
    <input class="easyui-searchbox" id="SbcGateLaneSearchbox1486627282418"/>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<div id="SbcGateLaneDialog1486627282418"   style="display:none"></div>
<table id="SbcGateLaneDatagrid1486627282418" style="height:100%"></table>
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
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcGateLaneDialog1486627282418");
        var dg = $("#SbcGateLaneDatagrid1486627282418");
        
        // buttons
        // 增加。
        $("#SbcGateLaneToolBar1486627282418 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcGateLaneToolBar1486627282418 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'gateLaneCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcGateLaneToolBar1486627282418 a[iconCls='icon-remove']").on("click", function () {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcGateLane/save"});
        });
        // 保存。
        $("#SbcGateLaneToolBar1486627282418 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcGateLane/save"});
        });
        // 刷新。
        $("#SbcGateLaneToolBar1486627282418 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcGateLaneSearchbox1486627282418").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        // searchbox
        $("#SbcGateLaneSearchbox1486627282418").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "gateLaneCod,companyCod,gateLaneCod,gateLaneNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcGateLaneDatagrid1486627282418").datagrid({
        	striped:true,
            url: "../webresources/login/SbcGateLane/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            //autoLoad:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcGateLaneToolBar1486627282418",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "gateLaneId",
                        title: '<font color="red">闸口通道ID</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "companyCod",
                        title: '<font color="red">公司代码</font>',
                        multiSort: true,
                        halign: "center",
                        editor: {
                            type: 'combogrid',
                            options: HdUtils.code.companyId({
                                parentId: '#SbcGateLaneDatagrid1486627282418',
                                width: 80,
                                fieldMapping: {
                                	companyCod: 'companyCod',
                                	cnCompanyNam: 'cnCompanyNam'
                                },
                                required: true
                            })
                        },
                        sortable: true
                    },
                    {
                        field: "gateLaneCod",
                        title: '<font color="red">闸口通道代码</font>',
                        multiSort: true,
                        halign: "center",
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcGateLaneDatagrid1486627282418","SbcGateLane","gateLaneCod"]','length[1,10]']}},
                        sortable: true
                    },
                    {
                        field: "gateLaneNam",
                        title: '<font color="red">闸口通道名称</font>',
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required:true,validType: 'length[1,100]'}},
                        sortable: true
                    },
                    {
                        field: "ioTyp",
                        title: '<font color="red">进出类别</font>',
                        multiSort: true,
                        halign: "center",
                        formatter: function(value) {
                            if ("I" == value) {
                                return "进闸口";
                            }
                            else if ("O" == value) {
                                return "出闸口";
                            }else if ("X" == value) {
                                return "其他";
                            }
                        },
                        editor: {type: 'combobox',
                            options: {
                                valueField: 'value',
                                textField: 'label',
                                data: [{
                                        label: '进闸口',
                                        value: 'I'
                                    }, {
                                        label: '出闸口',
                                        value: 'O'
                                    },{
                                    	label: '其他',
                                        value: 'X'
                                    }],
                                required: true
                            }}, 
                        width: 100,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,1000]'}},
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
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
                    dg.datagrid('getEditor', {index: selectIdx, field: 'gateLaneCod'}).target.prop('disabled', true);
                }  
        });
        $("#SbcGateLaneDatagrid1486627282418").datagrid("hdGetColumnNames");
    });
</script>

