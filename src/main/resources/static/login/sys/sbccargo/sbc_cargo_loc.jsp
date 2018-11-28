<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcCargoLocToolBar1486693873364" style="padding-top: 0px;">
    <div style="float:left;" >
        <shiro:hasPermission name="webresources:login:SbcCargoLoc:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcCargoLoc:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcCargoLoc:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcCargoLoc:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
    </div>
     <input class="easyui-searchbox" id="SbcCargoLocSearchbox1486693873364"/>
</div>
<table id="SbcCargoLocDatagrid1486693873364" style="height:100%"></table>
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcCargoLocDialog1486693873364");
        var dg = $("#SbcCargoLocDatagrid1486693873364");
        // buttons
        // 增加。
        $("#SbcCargoLocToolBar1486693873364 a[iconCls='icon-add']").on("click", function () { 
        	dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcCargoLocToolBar1486693873364 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        });
        // 删除。
        $("#SbcCargoLocToolBar1486693873364 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRemove");
        });
        // 保存。
        $("#SbcCargoLocToolBar1486693873364 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/cargoloc/save"});
        });
        // 刷新。
        $("#SbcCargoLocToolBar1486693873364 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcCargoLocSearchbox1486693873364").val();
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
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("cargoLocId","desc");
        // searchbox
        $("#SbcCargoLocSearchbox1486693873364").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "cargoLocCod,cargoLocNam,companyCod");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#SbcCargoLocDatagrid1486693873364").datagrid({
        	striped:true,
            url: "../webresources/login/cargoloc/find",
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
            toolbar: "#SbcCargoLocToolBar1486693873364",
            fit: true,
            fitColumns: false,
            columns: [[
                
                    {
                        field: "cargoLocId",
                        title: '货物货位ID',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "cargoLocCod",
                        title:"货物货位代码",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required:true, validType: ['isCodeRepeat["SbcCargoLocDatagrid1486693873364","SbcCargoLoc","cargoLocCod"]','maxLength[10]']}},
                        sortable: true
                    },
                    {
                        field: "cargoLocNam",
                        title: "货物货位名称",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required:true,validType: 'length[0,20]'}},
                        sortable: true
                    },
                    {
                        field: "cargoYardCod",
                        title: "货物库场代码",
                        multiSort: true,
                        halign: "center",
                        editor: {type: 'combogrid',
                            options: HdUtils.code.sbcCargoYard({
                                parentId: '#SbcCargoLocDatagrid1486693873364',
                            
                                fieldMapping: {
                                	cargoYardCod: 'cargoYardCod',
                                	cargoYardNam: 'cargoYardNam'
                                },
                                required: true
                            })
                        }
                    },
                    {
                        field: "cargoZoneCod",
                        title: "库场区域代码",
                        multiSort: true,
                        halign: "center",
                        editor: {type: 'combogrid',
                            options: HdUtils.code.sbcCargoYard({
                                parentId: '#SbcCargoLocDatagrid1486693873364',
                            
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
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox, 
                        width: 100,
                        sortable: true
                    }, */
                    {
                        field: "abandonedMark",
                        title: '作废标志',
                        multiSort: true,
                        halign: "center",
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox, 
                        width: 100,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required:false}},
                        sortable: true,
                        hidden: true
                       
                    },
                    {
                        field: "companyCod",
                        title: "公司代码",
                        multiSort: true,
                        halign: "center",
                        editor: {type: 'combogrid',
                            options: HdUtils.code.companyId({
                                parentId: '#SbcCargoLocDatagrid1486693873364',
                            
                                fieldMapping: {
                                	companyCod: 'companyCod',
                                	cnCompanyNam: 'cnCompanyNam'
                                },
                                required: true
                            })
                        }
                      
                    },
                    {
                        field: "insAccount",
                        title: "创建人",
                        multiSort: true,
                        halign: "center",
                       // editor: {type: "validatebox", options: {required:true}},
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: "创建时间",
                        multiSort: true,
                        halign: "center",
                        formatter: HdUtils.formatter.date,
                       // editor: {type: "validatebox", options: {required:true}},
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: "更新人",
                        multiSort: true,
                        halign: "center",
                        //editor: {type: "validatebox", options: {required:true}},
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: "更新时间",
                        multiSort: true,
                        halign: "center",
                        formatter: HdUtils.formatter.date,
                        //editor: {type: "validatebox", options: {required:true}},
                        sortable: true
                    },
                ]]});
        $("#SbcCargoLocDatagrid1486693873364").datagrid("hdGetColumnNames");
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

