<meta charset="UTF-8">
<div id="SbcBerthToolBar1486710197888" style="padding-top: 0px;">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:login:SbcBerth:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcBerth:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcBerth:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcBerth:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
    </div>
            <input class="easyui-searchbox" id="SbcBerthSearchbox1486710197888"/>

</div>
<table id="SbcBerthDatagrid1486710197888" style="height:100%"></table>
<!-- end Datagrid -->
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcBerthDialog1486710197888");
        var dg = $("#SbcBerthDatagrid1486710197888");
        // buttons
        // 增加。
        $("#SbcBerthToolBar1486710197888 a[iconCls='icon-add']").on("click", function () {
            $("#SbcBerthDialog1486710197888").show();
            HdUtils.dialog.show({height: 400,width:800, title: dialogTitleAddF, href: "../login/sys/sbcberth/sbc_berth_detail.html", isSaveHandler: true});
            HdUtils.dialog.setValue({data: {type: "ADD"},dataGrid:dg});          
        });
        // 编辑。
        $("#SbcBerthToolBar1486710197888 a[iconCls='icon-edit']").on("click", function () {
            $("SbcBerthDialog1486710197888").show();
            var selectRow = $("#SbcBerthDatagrid1486710197888").datagrid("getSelected");
            if (selectRow == undefined) {
                HdUtils.messager.info("请选择一条记录");
            } else {
                HdUtils.dialog.setValue({data:selectRow,dataGrid:dg});
                HdUtils.dialog.show({height: 400,width:800, title: dialogTitleAddF, href: "../login/sys/sbcberth/sbc_berth_detail.html", isSaveHandler: true});
            }
        });
        // 删除。
        $("#SbcBerthToolBar1486710197888 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcBerth/save"});
        });
        // 保存。
        $("#SbcBerthToolBar1486710197888 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcBerth/save"});
        });
        // 刷新。
        $("#SbcBerthToolBar1486710197888 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcBerthSearchbox1486710197888").val();
        	builder.set("q", value);
        	 dg.datagrid("load");
        });

        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("berthId","desc");
        // searchbox
        $("#SbcBerthSearchbox1486710197888").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "berthCod,berthNam,cargoKinds,capacity,length,berthStat,beginPosition,endPosition,companyCod");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcBerthDatagrid1486710197888").datagrid({
        	striped:true,
            url: "../webresources/login/SbcBerth/find",
            queryParams: builder.build(),
            method: "POST",
            //autoLoad:false,
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcBerthToolBar1486710197888",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "berthId",
                        title: '<font color="red">泊位ID</font>',
                        multiSort: true,
                        halign: "center",
                        hidden:true,
                        sortable: true
                    },
                    {
                        field: "berthCod",
                        title: '<font color="red">泊位代码</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "berthNam",
                        title: '<font color="red">泊位名称</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cargoKinds",
                        title: "主要货种",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "capacity",
                        title: "吞吐能力(万吨/年)",
                        multiSort: true,
                        align: "right",
                        formatter:$.hd.ezui.formatter.precision1,
                        sortable: true
                    },
                    {
                        field: "length",
                        title: '<font color="red">泊位长度</font>',
                        multiSort: true,
                        align: "right",
                        formatter:$.hd.ezui.formatter.precision2,
                        sortable: true
                    },
                    {
                        field: "heigh",
                        title: "泊位高度",
                        multiSort: true,
                        align: "right",
                        formatter:$.hd.ezui.formatter.precision2,
                        sortable: true
                    },
                    {
                        field: "designDepth",
                        title: "设计水深",
                        multiSort: true,
                        align: "right",
                        formatter:$.hd.ezui.formatter.precision2,
                        sortable: true
                    },
                    {
                        field: "realDepth",
                        title: "实际水深",
                        multiSort: true,
                        align: "right",
                        formatter:$.hd.ezui.formatter.precision2,
                        sortable: true
                    },
                    {
                        field: "startDte",
                        title: "投入使用日期",
                        multiSort: true,
                        formatter: $.hd.ezui.formatter.datetime,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "moorDirection",
                        title: "船舶停靠方向",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "sorter",
                        title: "排序编号",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "anchorMark",
                        title: "锚地标志",
                        multiSort: true,
                        formatter: $.hd.ezui.formatter.checkbox2,
                        halign: "center",
                        align:"center",
                        sortable: true
                    },
                    {
                        field: "structTypCod",
                        title: "泊位结构类型",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "serveTypCod",
                        title: "泊位服务类别",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "berthTypCod",
                        title: "用途分类",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "yearCargoWgt",
                        title: "货物年通过能力(万吨)",
                        multiSort: true,
                        align: "right",
                        formatter:$.hd.ezui.formatter.precision3,
                        sortable: true
                    },
                    {
                        field: "yearCntrWgt",
                        title: "集装箱年通过能力(万TEU)",
                        multiSort: true,
                        align: "right",
                        formatter:$.hd.ezui.formatter.precision3,
                        sortable: true
                    },
                    {
                        field: "yearPassWgt",
                        title: "乘客年通过能力(万人)",
                        multiSort: true,
                        align: "right",
                        formatter:$.hd.ezui.formatter.precision3,
                        sortable: true
                    },
                    {
                        field: "yearVehicleWgt",
                        title: "车辆年通过能力(万辆)",
                        multiSort: true,
                        align: "right",
                        formatter:$.hd.ezui.formatter.precision3,
                        sortable: true
                    },
                    {
                        field: "berthStat",
                        title: '<font color="red">泊位状态</font>',
                        multiSort: true,
                        halign: "center",
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'BERTH_STAT', code: value});
                            return list.length > 0 ? list[0].name : "";
                        },
                        sortable: true
                    },
                    {
                        field: "beginPosition",
                        title: '<font color="red">起始位置(米)</font>',
                        multiSort: true,
                        align: "right",
                        formatter:$.hd.ezui.formatter.precision2,
                        sortable: true
                    },
                    {
                        field: "endPosition",
                        title: '<font color="red">结束位置(米)</font>',
                        multiSort: true,
                        align: "right",
                        formatter:$.hd.ezui.formatter.precision2,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "companyCod",
                        title: '<font color="red">公司代码</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: '<font color="red">创建人</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: '<font color="red">创建时间</font>',
                        multiSort: true,
                        halign: "center",
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: '<font color="red">更新人</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: '<font color="red">更新时间</font>',
                        multiSort: true,
                        halign: "center",
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                ]],
                onDblClickCell: function (index) {
                	dg.datagrid('selectRow',index);
                    var selectRow = $("#SbcBerthDatagrid1486710197888").datagrid("getSelected");
                    HdUtils.dialog.setValue({data: selectRow,type:"EDIT",dataGrid:dg});
                    HdUtils.dialog.show({height: 400,width:800, title: dialogTitleAddF, href: "../login/sys/sbcberth/sbc_berth_detail.html", isSaveHandler: true});
                }});
        $("#SbcBerthDatagrid1486710197888").datagrid("hdGetColumnNames");
    });
</script>


