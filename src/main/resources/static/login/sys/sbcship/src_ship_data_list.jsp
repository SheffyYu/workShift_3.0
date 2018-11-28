<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SrcShipDataToolBar1486627322931" style="padding-top: 0px;">
 <div style="float:left;">
 <shiro:hasPermission name="webresources:sys:SrcShipData:update"> 
     <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a> 
 </shiro:hasPermission> 
 <shiro:hasPermission name="webresources:sys:SrcShipData:save"> 
     <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a> 
  </shiro:hasPermission> 
  </div>
    <input class="easyui-searchbox" id="SrcShipDataSearchbox1486627322931"/>
</div>
<table id="SrcShipDataDatagrid1486627322931" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SrcShipDataDialog1486627322931");
        var dg = $("#SrcShipDataDatagrid1486627322931");
        // 编辑。
        $("#SrcShipDataToolBar1486627322931 a[iconCls='icon-edit']").on("click", function () {
        	console.log(dg);
        	 //dg.datagrid("hdEdit");
        });
        // 保存。
        $("#SrcShipDataToolBar1486627322931 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SrcShipData/save"});
        });
        // 刷新。
        $("#SrcShipDataToolBar1486627322931 a[iconCls='icon-reload']").on("click", function () {
            var value=$("#SrcShipDataSearchbox1486627322931").val();
            builder.set("q", value);
            dg.datagrid("load");
        });
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 50;
        builder.setOrderByClause("shipDataId","desc");
        // searchbox
        $("#SrcShipDataSearchbox1486627322931").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns","shipCod,cnShipNam,enShipNam,shipCall,shipTypCod");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SrcShipDataDatagrid1486627322931").datagrid({
            striped:true,
            url: "../webresources/login/SrcShipData/find",
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
            pageSize: 50,
            toolbar: "#SrcShipDataToolBar1486627322931",
            fit: true,
            fitColumns: false,
            columns: [[
                        {
                            field: "ck",
                            checkbox: true
                        },
                       {
                           field: "shipDataId",
                           title: '船舶ID',
                           multiSort: true,
                           halign: "center",
                           sortable: true,
                           hidden: true
                       },
                       {
                           field: "shipCod",
                           title: '船舶代码',
                           multiSort: true,
                           halign: "center",
                           width:80,
                           //editor: {type: "validatebox", options: {required:true}},
                           sortable: true
                       },
                       {
                           field: "cnShipNam",
                           title: "船舶中文名称",
                           multiSort: true,
                           halign: "center",
                           width:100,
                           //editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "enShipNam",
                           title: "船舶英文名称",
                           multiSort: true,
                           halign: "center",
                           //editor: {type: "validatebox", options: {required:false}},
                           sortable: true,
                           hidden: true
                       },
                       {
                           field: "shortNam",
                           title: "船舶简称",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           sortable: true,
                           hidden: true
                       },
                       {
                           field: "shipCall",
                           title: '船舶呼号',
                           multiSort: true,
                           halign: "center",
                           width:120,
                           editor: {type: "validatebox", options: {required:false}},
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
                           field: "shipMmsi",
                           title: "船舶MMSI",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },
                       {
                           field: "countryCod",
                           title: "所属国家",
                           multiSort: true,
                           halign: "center",
                           align: "center",
                           width:70,
                           formatter: function (value, row, index) {
                               return row.cnCountryNam;
                           }, 
                           //editor: {type: "validatebox", options: {required:false}},
                           sortable: true
                       },

                       {
                           field: "linerMark",
                           title: "班轮标识",
                           multiSort: true,
                           halign: "center",
                           align: "center",
                           width:70,
                           formatter: $.hd.ezui.formatter.checkbox2,
                           sortable: true
                          
                       },
                       {
                           field: "shipGrossWgt",
                           title: "总吨位",
                           multiSort: true,
                           halign: "center",
                           width:70,
                           sortable: true
                       },
                       {
                           field: "shipNetWgt",
                           title: "净吨位",
                           multiSort: true,
                           halign: "center",
                           width:70,
                           sortable: true
                       },
                       {
                           field: "shipDeadWgt",
                           title: "载重吨",
                           multiSort: true,
                           halign: "center",
                           width:70,
                           sortable: true
                       },
                       {
                           field: "shipLength",
                           title: "船长",
                           multiSort: true,
                           halign: "center",
                           width:70,
                           sortable: true
                       },
                       {
                           field: "shipWidth",
                           title: "船宽",
                           multiSort: true,
                           halign: "center",
                           width:70,
                           sortable: true
                       },
                       {
                           field: "shipHigh",
                           title: "船高",
                           multiSort: true,
                           halign: "center",
                           width:70,
                           sortable: true
                       },
                       {
                           field: "shipSpeed",
                           title: "船速",
                           multiSort: true,
                           halign: "center",
                           width:70,
                           sortable: true
                       },
                       {
                           field: "shipTypCod",
                           title: '船舶类型',
                           multiSort: true,
                           halign: "center",
//                            editor: {
//                                type: "combobox",
//                                options: HdUtils.code.scode({fieldCod: 'SHIP_TYP_COD'}, {required: false})
//                            },
                           formatter: function (value) {
                               if (value === null || value === '')
                                   return;
                               var list = HdUtils.global.scode.query({fieldCod: 'SHIP_TYP_COD', code: value});
                               return list.length > 0 ? list[0].name : "";
                           },
                           width:70,
                           sortable: true
                       },
                       {
                           field: "buildDte",
                           title: "建造日",
                           multiSort: true,
                           halign: "center",
                           width:90,
                           formatter: HdUtils.formatter.date,
                           sortable: true
                       },
                       {
                           field: "totalTeu",
                           title: "总TEU",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           sortable: true
                       },
                       {
                           field: "bayNum",
                           title: "贝数",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           sortable: true
                       },
                       {
                           field: "hatchNum",
                           title: "舱口数",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           sortable: true
                       },
                       {
                           field: "lidNum",
                           title: "舱盖数",
                           multiSort: true,
                           halign: "center",
                           width:80,
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
                           sortable: true
                       },
                       {
                           field: "insTimestamp",
                           title: "创建时间",
                           multiSort: true,
                           halign: "center",
                           width:140,
                           formatter: HdUtils.formatter.datetime,
//                            editor: {type: "datetimebox", options: {required:true}},
                           sortable: true
                       },
                       {
                           field: "updAccount",
                           title: "更新人",
                           multiSort: true,
                           halign: "center",
                           width:80,
                           sortable: true
                       },
                       {
                           field: "updTimestamp",
                           title: "更新时间",
                           multiSort: true,
                           halign: "center",
                           width:140,
                           formatter: HdUtils.formatter.datetime,
                           sortable: true
                       },
                   ]],
                   onDblClickCell: function (index) {
                	   dg.datagrid("hdEdit");
                      
                   }
        });
    });
</script>