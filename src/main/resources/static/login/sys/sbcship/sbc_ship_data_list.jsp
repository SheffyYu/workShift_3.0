<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcShipDataToolBar1486627322931" style="padding-top: 0px;">
<!--     <div style="float:left;"> -->
<!--         <shiro:hasPermission name="webresources:sys:SbcShipData:add"> -->
<!--             <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a> -->
<!--         </shiro:hasPermission> -->
<!--         <shiro:hasPermission name="webresources:sys:SbcShipData:update"> -->
<!--             <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a> -->
<!--         </shiro:hasPermission> -->
<!--         <shiro:hasPermission name="webresources:sys:SbcShipData:delete"> -->
<!--             <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a> -->
<!--         </shiro:hasPermission> -->
<!--         <shiro:hasPermission name="webresources:sys:SbcShipData:save"> -->
<!--             <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a> -->
<!--         </shiro:hasPermission> -->
<!--             <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a> -->
<!--     </div> -->
    <input class="easyui-searchbox" id="SbcShipDataSearchbox1486627322931"/>
</div>
<table id="SbcShipDataDatagrid1486627322931" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcShipDataDialog1486627322931");
        var dg = $("#SbcShipDataDatagrid1486627322931");
        // buttons
        // 增加。
        $("#SbcShipDataToolBar1486627322931 a[iconCls='icon-add']").on("click", function () {
            $("#SbcShipDataDialog1486627322931").show();
            HdUtils.dialog.show({height: 470,width:850, title: dialogTitleAddF, href: "../login/sys/sbcship/SbcShipDataForm.html", isSaveHandler: true});
            HdUtils.dialog.setValue({data: {type: "ADD"},dataGrid:dg});          
        });
        // 编辑。
        $("#SbcShipDataToolBar1486627322931 a[iconCls='icon-edit']").on("click", function () {
            $("SbcShipDataDialog1486627322931").show();
            var selectRow= $("#SbcShipDataDatagrid1486627322931").datagrid("getSelected");
            if (selectRow == undefined) {
                HdUtils.messager.info("请选择一条记录");
            } else {
                HdUtils.dialog.setValue({data:selectRow,dataGrid:dg});
                HdUtils.dialog.show({height: 470,width:850,title: dialogTitleEditF, href: "../login/sys/sbcship/SbcShipDataForm.html", isSaveHandler: true});
               // HdUtils.dialog.setValue({data:selectRow, type:'EDIT', dataGrid:dg});
            }
        });
        // 删除。
        $("#SbcShipDataToolBar1486627322931 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcShipData/save"});
        });
        // 保存。
        $("#SbcShipDataToolBar1486627322931 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcShipData/save"});
        });
        // 刷新。
        $("#SbcShipDataToolBar1486627322931 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcShipDataSearchbox1486627322931").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        /* dg.datagrid({
            onDblClickCell: function (index) {
            	dg.datagrid('selectRow',index);
                var selectRow = $("#SbcShipDataDatagrid1486627322931").datagrid("getSelected");
                HdUtils.dialog.setValue({data: selectRow,dataGrid:dg});
                HdUtils.dialog.show({height: 520,width:950, title: dialogTitleEditF, href: "../sys/sbcship/SbcShipDataForm.html", isSaveHandler: true});
            }
        }); */
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("shipDataId","desc");
        // searchbox
        $("#SbcShipDataSearchbox1486627322931").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns","shipCod,cnShipNam,enShipNam,shipCall,shipTypCod");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcShipDataDatagrid1486627322931").datagrid({
        	striped:true,
            url: "../webresources/login/SbcShipData/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            //autoLoad:false,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcShipDataToolBar1486627322931",
            fit: true,
            fitColumns: false,
            columns: [[
						{
						    field: "ck",
						    checkbox: true
						},
                       {
                           field: "shipDataId",
                           title: '<font color="red">船舶ID</font>',
                           multiSort: true,
                           halign: "center",
                           sortable: true,
                           hidden: true
                       },
                       {
                           field: "shipCod",
                           title: '<font color="red">船舶代码</font>',
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:true}},
                           sortable: true
                       },
                       {
                           field: "cnShipNam",
                           title: "船舶中文名称",
                           multiSort: true,
                           halign: "center",
                           width:100,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "enShipNam",
                           title: "船舶英文名称",
                           multiSort: true,
                           halign: "center",
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true,
                           hidden: true
                       },
                       {
                           field: "shortNam",
                           title: "船舶简称",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true,
                           hidden: true
                       },
                       {
                           field: "shipCall",
                           title: '<font color="red">船舶呼号</font>',
                           multiSort: true,
                           halign: "center",
                           width:120,
                           editor: {type: "validatebox", options: {required:true}},
                           sortable: true
                       },
                       {
                           field: "shipImo",
                           title: "船舶IMO",
                           multiSort: true,
                           halign: "center",
                           width:120,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                          
                       },
                       {
                           field: "shipMmst",
                           title: "船舶MMST",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "countryCod",
                           title: "所属国家代码",
                           multiSort: true,
                           halign: "center",
                           width:80,
/*                            formatter: function (value, row, index) {
           	                   return row.cnCountryNam;
           	               }, */
                           //editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "shipCorpCod",
                           title: "船公司代码",
                           multiSort: true,
                           halign: "center",
                           width:80,
/*                            formatter: function (value, row, index) {
           	                   return row.cnCompanyNam;
           	               }, */
                           //editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "shipAgentCod",
                           title: "船代理代码",
                           multiSort: true,
                           halign: "center",
                           width:80,
/*                            formatter: function (value, row, index) {
           	                   return row.cnCompanyNam;
           	               }, */
                           //editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "shipServiceCod",
                           title: "航线代码",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                          
                       },
                       {
                           field: "linerMark",
                           title: "班轮标识",
                           multiSort: true,
                           halign: "center",
                           align: "center",
                           width:80,
                           editor: $.hd.ezui.editor.checkbox,
                   	       formatter: $.hd.ezui.formatter.checkbox2,
                           sortable: true
                          
                       },
                       {
                           field: "shipGrossWgt",
                           title: "总吨位",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "shipNetWgt",
                           title: "净吨位",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "shipDeadWgt",
                           title: "载重吨",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "shipLength",
                           title: "船长",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "shipWidth",
                           title: "船宽",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "shipHigh",
                           title: "船高",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "shipSpeed",
                           title: "船速",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "shipTypCod",
                           title: '<font color="red">船舶类型</font>',
                           multiSort: true,
                           halign: "center",
                           editor: {
                               type: "combobox",
                               options: HdUtils.code.scode({fieldCod: 'SHIP_TYP_COD'}, {required: false})
                           },
                           formatter: function (value) {
                               if (value === null || value === '')
                                   return;
                               var list = HdUtils.global.scode.query({fieldCod: 'SHIP_TYP_COD', code: value});
                               return list.length > 0 ? list[0].name : "";
                           },
                           width:80,
                           sortable: true
                       },
                       {
                           field: "buildDte",
                           title: "建造日",
                           multiSort: true,
                           halign: "center",
                           width:90,
                           formatter: HdUtils.formatter.date,
                           editor: {type: "datetimebox", options: {required: false}},
                           sortable: true
                       },
                       {
                           field: "totalTeu",
                           title: "总TEU",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "bayNum",
                           title: "贝数",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "hatchNum",
                           title: "舱口数",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "lidNum",
                           title: "舱盖数",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
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
                           width:120,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true,
                           hidden: true
                          
                       },
                       {
                           field: "insAccount",
                           title: "创建人",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:true}},
                           sortable: true
                       },
                       {
                           field: "insTimestamp",
                           title: "创建时间",
                           multiSort: true,
                           halign: "center",
                           width:140,
                           formatter: HdUtils.formatter.datetime,
                           editor: {type: "datetimebox", options: {required:true}},
                           sortable: true
                       },
                       {
                           field: "updAccount",
                           title: "更新人",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:true}},
                           sortable: true
                       },
                       {
                           field: "updTimestamp",
                           title: "更新时间",
                           multiSort: true,
                           halign: "center",
                           width:140,
                           formatter: HdUtils.formatter.datetime,
                           editor: {type: "datetimebox", options: {required:true}},
                           sortable: true
                       },
                   ]],
                   onDblClickCell: function (index) {
                	   dg.datagrid('selectRow',index);
                       var selectRow = dg.datagrid("getSelected");
                       HdUtils.dialog.setValue({data: selectRow,dataGrid:dg});
                       HdUtils.dialog3.show({height: 420,width:730, title: dialogTitleEditF, href: "../login/sys/sbcship/SbcShipDataForm.html",isSaveHandler:false});
                   }
        });
    });
</script>