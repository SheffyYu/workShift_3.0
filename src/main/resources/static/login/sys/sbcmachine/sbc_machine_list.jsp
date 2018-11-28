<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcMachineToolBar1486627282418" style="padding-top: 0px;">
<!--     <div style="float:left;"> -->
<!--         <shiro:hasPermission name="webresources:sys:SbcMachine:update"> -->
<!--             <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a> -->
<!--         </shiro:hasPermission> -->
<!--         <shiro:hasPermission name="webresources:sys:SbcMachine:delete"> -->
<!--             <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a> -->
<!--         </shiro:hasPermission> -->
<!--         <shiro:hasPermission name="webresources:sys:SbcMachine:save"> -->
<!--             <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a> -->
<!--         </shiro:hasPermission> -->
<!--         <shiro:hasPermission name="webresources:sys:SbcMachine:refresh"> -->
<!--             <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a> -->
<!--         </shiro:hasPermission> -->
<!--         </div> -->
        <input class="easyui-searchbox" id="SbcMachineSearchbox1486627282418"/>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<table id="SbcMachineDatagrid1486627282418" style="height:100%"></table>
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcMachineDialog1486627282418");
        var dg = $("#SbcMachineDatagrid1486627282418");
        // buttons
        // 增加。
        //$("#SbcMachineToolBar1486627282418 a[iconCls='icon-add']").on("click", function () {
        //	dg.datagrid("hdAdd");   
        //});
        // 编辑。
        $("#SbcMachineToolBar1486627282418 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	//var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            //dg.datagrid('getEditor', {index: selectIdx, field: 'machCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcMachineToolBar1486627282418 a[iconCls='icon-remove']").on("click", function () {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcMachine/save"});
        });
        // 保存。
        $("#SbcMachineToolBar1486627282418 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcMachine/save"});
        });
        // 刷新。
        $("#SbcMachineToolBar1486627282418 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcMachineSearchbox1486627282418").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
        // searchbox
        $("#SbcMachineSearchbox1486627282418").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "machCod,companyCod");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcMachineDatagrid1486627282418").datagrid({
        	striped:true,
            url: "../webresources/login/SbcMachine/find",
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
            toolbar: "#SbcMachineToolBar1486627282418",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
						    checkbox: true
					},
                    {
                        field: "machId",
                        title: '机械ID',
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
                        width:80,
                        editor: {
                            type: 'combogrid',
                            options: HdUtils.code.companyId({
                                parentId: '#SbcMachineDatagrid1486627282418',
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
                        field: "machCod",
                        title: '<font color="red">机械代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox", options: {required:true, validType: ['isCodeRepeat["SbcMachineDatagrid1486627282418","SbcMachine","machCod"]','length[1,10]']}},
                        sortable: true
                    },
                    {
                        field: "machTypCod1",
                        title: '机械类型代码1',
                        multiSort: true,
                        halign: "center",
                        width:90,
                        editor: {type: "uppercasebox", options: {required:false,validType: 'length[1,10]'}},
                        sortable: true
                    },
                    {
                        field: "machTypCod2",
                        title: '机械类型代码2',
                        multiSort: true,
                        halign: "center",
                        width:90,
                        editor: {type: "uppercasebox", options: {required:false,validType: 'length[1,10]'}},
                        sortable: true
                    },
                    {
                        field: "machNam",
                        title: "机械名称",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "validatebox", options: {required:false,validType: 'length[1,100]'}},
                        sortable: true
                    },                    
                    {
                        field: "machUse",
                        title: "机械用途",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({fieldCod: 'MACH_USE'}, {required: false})
                        },
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'MACH_USE', code: value});
                            return list.length > 0 ? list[0].name : "";
                        },
                        sortable: true
                    },
                    {
                        field: "machTareWgt",
                        title: "机械净重",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "numberbox", options: {precision:2,required:false,validType: 'length[2,10]'}},
                        sortable: true
                    },
                    {
                        field: "machLoad",
                        title: "机械负荷",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox", options: {required:false,validType: 'length[1,40]'}},
                        sortable: true
                    },
                    {
                        field: "workScope",
                        title: "机械幅度",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox", options: {required:false,validType: 'length[1,40]'}},
                        sortable: true
                    },
                    {
                        field: "othData",
                        title: "其他属性数据",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox", options: {required:false,validType: 'length[1,2000]'}},
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
                        width:180,
                        editor: {type: "uppercasebox", options: {required:false,validType: 'length[1,1000]'}},
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
                ]]
                });
        $("#SbcMachineDatagrid1486627282418").datagrid("hdGetColumnNames");
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

