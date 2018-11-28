<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcCargoYardToolBar1486693784384" style="padding-top: 0px;">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:login:SbcCargoYard:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcCargoYard:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcCargoYard:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcCargoYard:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
       <input class="easyui-searchbox" id="SbcCargoYardSearchbox1486693784384"/>
    </div>
</div>
<table id="SbcCargoYardDatagrid1486693784384" style="height:100%"></table>
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcCargoYardDialog1486693784384");
        var dg = $("#SbcCargoYardDatagrid1486693784384");
        $("#SbcCargoYardToolBar1486693784384 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcCargoYardToolBar1486693784384 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        });
        // 删除。
        $("#SbcCargoYardToolBar1486693784384 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRemove");
        });
        // 保存。
        $("#SbcCargoYardToolBar1486693784384 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/cargoyard/save"});
        });
        // 刷新。
        $("#SbcCargoYardToolBar1486693784384 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcCargoYardSearchbox1486693784384").val();
        	builder.set("q", value);
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
        $("#SbcCargoYardSearchbox1486693784384").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "cargoYardCod,cargoYardNam,companyCod");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#SbcCargoYardDatagrid1486693784384").datagrid({
        	striped:true,
            url: "../webresources/login/cargoyard/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            //autoLoad:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
    	    sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcCargoYardToolBar1486693784384",
            fit: true,
            fitColumns: false,
            columns: [[
                
                    {
                        field: "cargoYardId",
                        title: '货物库场ID',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "cargoYardCod",
                        title: "货物库场代码",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required:true, validType: ['isCodeRepeat["SbcCargoYardDatagrid1486693784384","SbcCargoYard","cargoYardCod"]','maxLength[10]']}},
                        sortable: true
                    },
                    {
                        field: "cargoYardNam",
                        title: "货物库场名称",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required:true}},
                        sortable: true
                    },
                    {
                        field: "cargoZoneCod",
                        title: "库场区域代码",
                        multiSort: true,
                        halign: "center",
                        editor: {type: 'combogrid',
                            options: HdUtils.code.sbcCargoYard({
                                parentId: '#SbcCargoYardDatagrid1486693784384',
                            
                                fieldMapping: {
                                	cargoZoneCod: 'cargoZoneCod',
                                	cargoZoneNam: 'cargoZoneNam'
                                },
                                required: true
                            })
                        }
                    },
                    /* {
                        field: "sysMark",
                        title: '系统标识',
                        multiSort: true,
                        halign: "center",
                        formatter: function(value) {
                            if ("0" == value) {
                                return "非系统数据";
                            }
                            else if ("1" == value) {
                                return "系统数据";
                            }             
                        },
                        editor: {type: 'combobox',
                            options: {
                                valueField: 'value',
                                textField: 'label',
                                data: [{
                                        label: '非系统数据',
                                        value: '0'
                                    }, {
                                        label: '系统数据',
                                        value: '1'
                                    }],
                                required: true
                            }}, 
                        width: 100,
                        sortable: true
                    }, */
                    {
                        field: "abandonedMark",
                        title: '作废标志',
                        multiSort: true,
                        halign: "center",
                        formatter: function(value) {
                            if ("0" == value) {
                                return "正常";
                            }
                            else if ("1" == value) {
                                return "废弃";
                            }
                          
                        },
                        editor: {type: 'combobox',
                            options: {
                                valueField: 'value',
                                textField: 'label',
                                data: [{
                                        label: '正常',
                                        value: '0'
                                    }, {
                                        label: '废弃',
                                        value: '1'
                                    }],
                                required: true
                            }}, 
                        width: 100,
                        sortable: true
                    },
                    {
                        field: "companyCod",
                        title: "公司代码",
                        multiSort: true,
                        halign: "center",
                        editor: {type: 'combogrid',
                            options: HdUtils.code.companyId({
                                parentId: '#SbcCargoYardDatagrid1486693784384',
                            
                                fieldMapping: {
                                	companyCod: 'companyCod',
                                	cnCompanyNam: 'cnCompanyNam'
                                },
                                required: true
                            })
                        }
                      
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required:false}},
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: "创建人",
                        multiSort: true,
                        halign: "center",
                        //editor: {type: "validatebox", options: {required:true}},
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: "创建时间",
                        multiSort: true,
                        halign: "center",
                        formatter: HdUtils.formatter.date,
                        //editor: {type: "validatebox", options: {required:true}},
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: "更新人",
                        multiSort: true,
                        halign: "center",
                        formatter: HdUtils.formatter.date,
                        //editor: {type: "validatebox", options: {required:true}},
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: "更新时间",
                        multiSort: true,
                        halign: "center",
                        //editor: {type: "validatebox", options: {required:true}},
                        sortable: true
                    },
                ]]});
        $("#SbcCargoYardDatagrid1486693784384").datagrid("hdGetColumnNames");
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

