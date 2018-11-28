<meta charset="UTF-8">
<div id="PortCntrToolBar1486946776099" style="padding-top: 0px;">
    <div style="float:left;">
<!--         <shiro:hasPermission name="webresources:login:PortCntr:add"> -->
<!--             <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a> -->
<!--         </shiro:hasPermission> -->
<!--         <shiro:hasPermission name="webresources:login:PortCntr:update"> -->
<!--             <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a> -->
<!--         </shiro:hasPermission> -->
<!--         <shiro:hasPermission name="webresources:login:PortCntr:delete"> -->
<!--             <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a> -->
<!--         </shiro:hasPermission> -->
<!--         <shiro:hasPermission name="webresources:login:PortCntr:save"> -->
<!--             <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a> -->
<!--         </shiro:hasPermission> -->
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        &nbsp;
    </div>
        <input class="easyui-searchbox" id="PortCntrSearchbox1486946776099"/>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<div id="PortCntrDialog1486946776099"   style="display:none"></div>
<table id="PortCntrDatagrid1486946776099" style="height:100%"></table>
<!-- end Datagrid -->

<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#PortCntrDialog1486946776099");
        var dg = $("#PortCntrDatagrid1486946776099");
        // buttons
        // 增加。
        $("#PortCntrToolBar1486946776099 a[iconCls='icon-add']").on("click", function () {
            $("#PortCntrDialog1486946776099").show();
            HdUtils.dialog.show({height: 600,width:1000, title: dialogTitleAddF, href: "../login/sys/portcntr/port_cntr_detail.jsp", isSaveHandler: true});
            HdUtils.dialog.setValue({data: {type: "ADD"},dataGrid:dg});          
        });
        // 编辑。
        $("#PortCntrToolBar1486946776099 a[iconCls='icon-edit']").on("click", function () {
            $("PortCntrDialog1486946776099").show();
            var selectRow = $("#PortCntrDatagrid1486946776099").datagrid("getSelected");
            if (selectRow == undefined) {
                HdUtils.messager.info("请选择一条记录");
            } else {
                HdUtils.dialog.setValue({data:selectRow,dataGrid:dg});
                HdUtils.dialog.show({height: 600,width:1000,title: dialogTitleEditF, href: "../login/sys/portcntr/port_cntr_detail.jsp", isSaveHandler: true});
            }
        });
        // 删除。
        $("#PortCntrToolBar1486946776099 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/PortCntr/save"});
        });
        // 保存。
        $("#PortCntrToolBar1486946776099 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/PortCntr/save"});
        });
        // 刷新。
        $("#PortCntrToolBar1486946776099 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#PortCntrSearchbox1486946776099").val();
        	builder.set("q", value);
        	 dg.datagrid("load");
        });
        var builder = new HdEzuiQueryParamsBuilder();
        // searchbox
        $("#PortCntrSearchbox1486946776099").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "cntr,cntrSizCod,cntrTypCod,efMark,cntrCorpCod,cntrOperCod,onPowerMark,tradeMark,cntrClass,fumigateMark,inspectionStat,companyCod");
                dg.datagrid("load");
            }});
        // datagrid
        $("#PortCntrDatagrid1486946776099").datagrid({
        	striped:true,
            url: "../webresources/login/PortCntr/find",
            queryParams: builder.build(),
            method: "POST",
            autoLoad:false,
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#PortCntrToolBar1486946776099",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "cntrVisitId",
                        title: '<font color="red">箱到港ID</font>',
                        multiSort: true,
                        halign: "center",
                        hidden: true,
                        sortable: true
                    },
                    {
                        field: "cntrVisitNo",
                        title: "箱到港编号",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cntr",
                        title: '<font color="red">箱号</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "currentStat",
                        title: "当前状态",
                        multiSort: true,
                        halign: "center",
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'CURRENT_STAT', code: value});
                            return list.length > 0 ? list[0].name : "";
                        },
                        /* editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({fieldCod: 'CURRENT_STAT'}, {required: false})
                        }, */
                        sortable: true
                    },
                    {
                        field: "cySlotNo",
                        title: "箱位",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cyBlockNo",
                        title: "堆场编号",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cyBayNo",
                        title: "堆场贝号",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cyRowNo",
                        title: "堆场排号",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cyTierNo",
                        title: "堆场层号",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cntrIso",
                        title: "箱ISO代码",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cntrSizCod",
                        title: '<font color="red">箱尺寸代码</font>',
                        multiSort: true,
                        halign: "center",
                        /* formatter: function (value, row, index) {
                            return row.sbcCntrSizNam;
                        }, */
                        sortable: true
                    },
                    {
                        field: "cntrTypCod",
                        title: '<font color="red">箱类型代码</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "efMark",//TODO
                        title: '<font color="red">空重标志</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "lclMark",
                        title: "拼箱标志",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                        sortable: true
                    },
                    {
                        field: "cntrCorpCod",
                        title: '<font color="red">箱公司代码</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cntrOperCod",
                        title: '<font color="red">箱代理代码</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cntrGrossWgt",
                        title: "箱毛重",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cntrRealWgt",
                        title: "称重重量",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cntrTareWgt",
                        title: "箱皮重",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cntrVgmWgt",
                        title: "VGM重量",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "sealNo1",
                        title: "铅封号1",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "sealNo2",
                        title: "铅封号2",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "sealNo3",
                        title: "铅封号3",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "sealNo4",
                        title: "铅封号4",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "dangMark",
                        title: '危险品标志',
                        multiSort: true,
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                        halign: "center",
                        align:"center",
                        sortable: true
                    },
                    {
                        field: "dangClass",
                        title: "危险品等级",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "undgNo",
                        title: "国际危规号",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "reefMark",
                        title: '冷藏标志',
                        multiSort: true,
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                        halign: "center",
                        align:"center",
                        sortable: true
                    },
                    {
                        field: "tempUnit",
                        title: "温度单位",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "setTemp",
                        title: "设定温度",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "curTemp",
                        title: "当前温度",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "minTemp",
                        title: "最低温度",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "maxTemp",
                        title: "最高温度",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "ventilation",
                        title: "通风量",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "humidity",
                        title: "湿度",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "oogMark",
                        title: '超限标志',
                        multiSort: true,
                        halign: "center",
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                	    align:"center",
                        sortable: true
                    },
                    {
                        field: "oogLeft",
                        title: "左超",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "oogRight",
                        title: "右超",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "oogFront",
                        title: "前超",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "oogBack",
                        title: "后超",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "oogHigh",
                        title: "超高",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "damMark",
                        title: '残损标志',
                        multiSort: true,
                        halign: "center",
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                	    align:"center",
                        sortable: true
                    },
                    {
                        field: "bundleMark",
                        title: "折叠标志",
                        multiSort: true,
                        halign: "center",
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                	    align:"center",
                        sortable: true
                    },
                    {
                        field: "bundleCntr",
                        title: "折叠主箱号",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "bundleCntrVisitNo",
                        title: "折叠主箱到港编号",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "onPowerMark",//TODO
                        title: '<font color="red">通电状态</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "tradeMark",//TODO
                        title: '<font color="red">贸易性质</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "ieMark",//TODO
                        title: "进出口标志",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "loadPortCod",
                        title: "装货港代码",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "discPortCod",
                        title: "卸货港代码",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "destPortCod",
                        title: "目的港代码",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "billNo",
                        title: "提单号",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "bookingNo",
                        title: "订舱号",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cntrClass",//TODO
                        title: '<font color="red">流向类别</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "transMark",
                        title: '中转标志',
                        multiSort: true,
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                	    align:"center",
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "transTyp",//TODO
                        title: "中转类型",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "customsRelsMark",
                        title: '海关放行标志',
                        multiSort: true,
                        halign: "center",
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                	    align:"center",
                        sortable: true
                    },
                    {
                        field: "ciqRelsMark",
                        title: '国检放行标志',
                        multiSort: true,
                        halign: "center",
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                	    align:"center",
                        sortable: true
                    },
                    {
                        field: "lockMark",
                        title: '锁扣标志',
                        multiSort: true,
                        halign: "center",
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                	    align:"center",
                        sortable: true
                    },
                    {
                        field: "inPortTim",
                        title: "进港时间",
                        multiSort: true,
                        halign: "center",
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "inTransportMod",//TODO
                        title: "进港类别",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "inVisitNo",
                        title: "进港明细",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "inCyTim",
                        title: "落场时间",
                        multiSort: true,
                        halign: "center",
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "outCyTim",
                        title: "出场时间",
                        multiSort: true,
                        halign: "center",
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "outPortTim",
                        title: "出港时间",
                        multiSort: true,
                        halign: "center",
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "outTransportMod",//TODO
                        title: "出港类别",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "outVisitNo",
                        title: "出港明细",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "chkMark",
                        title: '验箱标志',
                        multiSort: true,
                        halign: "center",
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                	    align:"center",
                        sortable: true
                    },
                    {
                        field: "ptiMark",
                        title: 'PTI检测标志',
                        multiSort: true,
                        halign: "center",
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                	    align:"center",
                        sortable: true
                    },
                    {
                        field: "fumigateMark",
                        title: '熏蒸标志',
                        multiSort: true,
                        halign: "center",
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                	    align:"center",
                        sortable: true
                    },
                    {
                        field: "inspectionStat",//TODO
                        title: '<font color="red">查验状态</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cargoCod",
                        title: "货物代码",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cargoDescribe",
                        title: "货物描述",
                        multiSort: true,
                        halign: "center",
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
                        field: "companyCod",//TODO
                        title: '<font color="red">公司代码</font>',
                        multiSort: true,
                        halign: "center",
                        /* formatter:function(val,row,idx){
                        	return row.cnCompanyNam;
                        }, */
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
                ]],onDblClickCell: function (index) {
                    var selectRow = $("#PortCntrDatagrid1486946776099").datagrid("getSelected");
                    HdUtils.dialog.setValue({data: selectRow,dataGrid:dg});
                    HdUtils.dialog.show({height: 600,width:1000, title: dialogTitleEditF, href: "../login/sys/portcntr/port_cntr_detail.jsp", isSaveHandler: true});
                }});
        $("#PortCntrDatagrid1486946776099").datagrid("hdGetColumnNames");
    });
</script>
